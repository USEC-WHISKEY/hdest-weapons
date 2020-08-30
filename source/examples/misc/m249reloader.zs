
class B_M249_Reloader : AutoReloadingThingy{
	default{
		//$Category "Weapons/Hideous Destructor"
		//$Title "7.76mm Auto-Reloader"
		//$Sprite "RLDRA0"

		+weapon.wimpy_weapon
		+inventory.invbar
		+hdweapon.fitsinbackpack
		inventory.pickupsound "misc/w_pkup";
		inventory.pickupmessage "You got the M249 pouch reloading machine!";
		scale 0.5;
		hdweapon.refid "r04";
		tag "M249 pouch reloading machine";
	}
	override double gunmass(){return 0;}
	override double weaponbulk(){
		return 20*amount;
	}
	override string,double getpickupsprite(){return "BRLAA0",1.;}

	ui int emptyCount(HDPlayerPawn hpl) {
		HDMagAmmo mag = HDMagAmmo(hpl.FindInventory("Bm249Mag"));
		if (!mag) {
			return 0;
		}
		int cnt = 0;
		for (int i = 0; i < mag.amount; i++) {
			if (mag.mags[i] == 0) {
				cnt++;
			}
		}
		return cnt;
	}

	void A_Churg(){
		A_StartSound("crafting/motor/ready",8);
		A_StartSound("crafting/motor",9);
		vel.z+=randompick(-2,2);
		//vel.xy+=(frandom(-0.3,0.3),frandom(-0.3,0.3));
	}

	override void DrawHUDStuff(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl){
		vector2 bob=hpl.hudbob*0.3;

		int brass = emptyCount(hpl);
		int fourm=hpl.countinv("B556Ammo");

		double lph=(brass && fourm>=4) ? 1. : 0.6;

		sb.drawimage("B56RA0",(0,-64)+bob,
			sb.DI_SCREEN_CENTER_BOTTOM|sb.DI_ITEM_CENTER,
			alpha:lph,scale:(2,2)
		);
		sb.drawimage("M24CB0",(-30,-64)+bob,
			sb.DI_SCREEN_CENTER_BOTTOM|sb.DI_ITEM_CENTER|sb.DI_ITEM_RIGHT,
			alpha:lph,scale:(2.5,2.5)
		);
		sb.drawimage("BB56A7A3",(30,-64)+bob,
			sb.DI_SCREEN_CENTER_BOTTOM|sb.DI_ITEM_CENTER|sb.DI_ITEM_LEFT,
			alpha:lph,scale:(1.9,4.7)
		);
		
		sb.drawstring(
			sb.psmallfont,""..brass,(-30,-54)+bob,
			sb.DI_TEXT_ALIGN_RIGHT|sb.DI_SCREEN_CENTER_BOTTOM,
			fourm?Font.CR_GOLD:Font.CR_DARKGRAY,alpha:lph
		);
		sb.drawstring(
			sb.psmallfont,""..fourm,(30,-54)+bob,
			sb.DI_TEXT_ALIGN_LEFT|sb.DI_SCREEN_CENTER_BOTTOM,
			fourm?Font.CR_LIGHTBLUE:Font.CR_DARKGRAY,alpha:lph
		);
	}
	override string gethelptext(){
		return
		WEPHELP_FIRE.."  Assemble rounds\n"
		..WEPHELP_UNLOAD.."+"..WEPHELP_USE.."  same"
		;
	}
	override bool AddSpareWeapon(actor newowner){return AddSpareWeaponRegular(newowner);}
	override hdweapon GetSpareWeapon(actor newowner,bool reverse,bool doselect){return GetSpareWeaponRegular(newowner,reverse,doselect);}
	states{
	select0:
		TNT1 A 0 A_Raise(999);
		wait;
	deselect0:
		TNT1 A 0 A_Lower(999);
		wait;
	ready:
		TNT1 A 1 A_WeaponReady(WRF_ALLOWUSER3|WRF_ALLOWUSER4);
		goto readyend;
	fire:
		TNT1 A 0 A_CheckItems(true);
		goto ready;
	hold:
		TNT1 A 1;
		TNT1 A 0 A_Refire("hold");
		goto ready;
	user3:
		---- A 0{
			if(countinv("HD7mMag"))
				A_MagManager("HD7mMag");
			else if(countinv("HD7mClip"))
				A_MagManager("HD7mMag");
			else A_SelectWeapon("PickupManager");
		}
		goto ready;
	user4:
	unload:
		TNT1 A 1 A_CheckItems(pressinguse());
		goto ready;
	spawn:
		B56R A -1 nodelay A_JumpIf(
			invoker.makinground
			&&invoker.brass>0
			&&invoker.powders>=0,
		"chug");
		stop;
	chug:
		---- AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 3{
			invoker.A_Churg();
		}
		---- A 10{
			let pouch = BM249Mag(Actor.Spawn("BM249Mag", invoker.pos));
			pouch.SyncAmount();
			pouch.mags[0] = invoker.brass;
			pouch.vel += (
				random(-1, 1),
				random(-1, 1),
				random(1, 3)
			);
			invoker.brass = 0;
			invoker.powders = 0;
		}
		---- A 0 A_Jump(256,"spawn");
	}

	action void A_CheckItems(bool anyotherconditions){
		HDMagAmmo mag = HDMagAmmo(invoker.owner.FindInventory("BM249Mag"));
		if (!mag) {
			return;
		}

		int deleteIndex = -1;
		for (int i = 0; i < mag.amount; i++) {

			if (mag.mags[i] == 0) {
				deleteIndex = i;
				break;
			}
		}

		if (deleteIndex == -1) {
			return;
		}

		mag.LowestToLast();
		mag.TakeMag(false);

		if (invoker.owner.CountInv("B556Ammo") >= 1) {
			invoker.makinground = true;
			invoker.brass = invoker.owner.CountInv("B556Ammo");
			invoker.powders = 30;
			A_TakeInventory("B556Ammo", 200);
			dropinventory(invoker);
		}

	}

}