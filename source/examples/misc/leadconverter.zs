
class B_BallCrafter : HDWeapon {
	default {
		+Weapon.Wimpy_Weapon
		+Inventory.Invbar
		+HDWeapon.FitsInBackpack
		inventory.pickupsound "misc/w_pkup";
		inventory.pickupmessage "You got the ball crafter.";
		scale 0.5;
		hdweapon.refid "bcr";
		tag "Ball crafter";
	}

	override double gunMass() { return 0; }
	override double weaponBulk() { return 20 * amount; }
	override string,double getpickupsprite(){
		return "BNCHA0",1.;
	}

	int mode;

	override void DrawHUDStuff(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl){
		vector2 bob=hpl.hudbob*0.3;
		sb.drawString(sb.psmallfont, "Ball crafter", (0, -10) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_GOLD);

		int leadNeeded = 2;
		int brassNeeded = 1;

		if (mode == 0) {
			sb.drawString(sb.psmallfont, "Mode: 5.56mm", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_RED);
		}
		else {
			sb.drawString(sb.psmallfont, "Mode: 7.62mm", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_GREEN);
			leadNeeded = 3;
			brassNeeded = 2;
		}

		let leadCount = hpl.CountInv("B_Lead");
		let brassCount = hpl.CountInv("B_Brass");

		sb.drawString(sb.psmallfont, ""..leadNeeded, (-25, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);
		sb.drawString(sb.psmallfont, ""..brassNeeded, (15, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);

		sb.drawImage("BBBGC0", (-20, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER);
		sb.drawImage("BBBGE0", (20, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER);

		sb.drawString(sb.psmallfont, ""..leadCount, (-25, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, leadCount >= leadNeeded ? Font.CR_GREEN : Font.CR_DARKGRAY);
		sb.drawString(sb.psmallfont, ""..brassCount, (15, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, brassCount >= brassNeeded ? Font.CR_GREEN : Font.CR_DARKGRAY);

	}

	override string gethelptext(){
		return
		WEPHELP_FIRE.."  Assemble rounds\n"
		..WEPHELP_UNLOAD.."+"..WEPHELP_USE.."  same"
		;
	}

	override bool AddSpareWeapon(actor newowner){
		return AddSpareWeaponRegular(newowner);
	}

	override hdweapon GetSpareWeapon(actor newowner, bool reverse, bool doselect){
		return GetSpareWeaponRegular(newowner, reverse, doselect);
	}

	states {
		select0:
			TNT1 A 0 A_Raise(999);
			wait;
		deselect0:
			TNT1 A 0 A_Lower(999);
			wait;

		Ready:
			TNT1 A 1 A_WeaponReady(WRF_ALLOWUSER3 | WRF_ALLOWUSER4);
			Goto ReadyEnd;

		Fire:
			TNT1 A 7 {
				int leadNeeded = 2;
				int brassNeeded = 1;
				string ballClass = "B_556Ball";
				if (invoker.mode == 1) {
					leadNeeded = 3;
					brassNeeded = 2;
					ballClass = "B_762Ball";
				}

				int leadCount = invoker.owner.CountInv("B_Lead");
				int brassCount = invoker.owner.CountInv("B_Brass");
				if (leadCount >= leadNeeded && brassCount >= brassNeeded) {
					A_StartSound("crafting/motor", CHAN_WEAPON, CHANF_OVERLAP);
					A_SpawnItemEx(ballClass, 10, 0, height - 12, 0, 0, 0);
					invoker.owner.TakeInventory("B_Lead", leadNeeded);
					invoker.owner.TakeInventory("B_Brass", brassNeeded);
					if (invoker.mode == 1) {
						A_SetTics(10);
					}
				}
			}
			Goto Ready;

		AltFire:
			TNT1 A 1 {
				invoker.mode = invoker.mode == 0 ? 1 : 0;
			}

		Switched:
			TNT1 A 0 A_Refire();
			Goto Ready;

		Hold:
			TNT1 A 1;
			TNT1 A 0 A_Refire("Hold");

		User3:
			---- A 0 {
				A_SelectWeapon("PickupManager");
			}
			Goto Ready;

		User4:
			---- A 0 {

			}
			Goto Ready;

		Spawn:
			BNCH A -1;
			Stop;
	}

}



class B_CaseCrafter : HDWeapon {
	default {
		+Weapon.Wimpy_Weapon
		+Inventory.Invbar
		+HDWeapon.FitsInBackpack
		inventory.pickupsound "misc/w_pkup";
		inventory.pickupmessage "You got the case crafter.";
		scale 0.5;
		hdweapon.refid "ccr";
		tag "Case crafter";
	}

	override double gunMass() { return 0; }
	override double weaponBulk() { return 20 * amount; }
	override string,double getpickupsprite(){
		return "BNCHB0",1.;
	}

	int mode;

	override void DrawHUDStuff(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl){
		vector2 bob=hpl.hudbob*0.3;
		sb.drawString(sb.psmallfont, "Case crafter", (0, -10) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_GOLD);

		int brassNeeded = 2;
		if (mode == 0) {
			sb.drawString(sb.psmallfont, "Mode: 5.56x45mm", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_RED);
		}
		else {
			sb.drawString(sb.psmallfont, "Mode: 7.62x51mm", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_GREEN);
			brassNeeded = 3;
		}

		let brassCount = hpl.CountInv("B_Brass");

		sb.drawString(sb.psmallfont, ""..brassNeeded, (0, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);
		sb.drawImage("BBBGE0", (0, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER);
		sb.drawString(sb.psmallfont, ""..brassCount, (0, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, brassCount >= brassNeeded ? Font.CR_GREEN : Font.CR_DARKGRAY);

	}

	override string gethelptext(){
		return
		WEPHELP_FIRE.."  Assemble rounds\n"
		..WEPHELP_UNLOAD.."+"..WEPHELP_USE.."  same"
		;
	}

	override bool AddSpareWeapon(actor newowner){
		return AddSpareWeaponRegular(newowner);
	}

	override hdweapon GetSpareWeapon(actor newowner, bool reverse, bool doselect){
		return GetSpareWeaponRegular(newowner, reverse, doselect);
	}

	states {
		select0:
			TNT1 A 0 A_Raise(999);
			wait;
		deselect0:
			TNT1 A 0 A_Lower(999);
			wait;

		Ready:
			TNT1 A 1 A_WeaponReady(WRF_ALLOWUSER3 | WRF_ALLOWUSER4);
			Goto ReadyEnd;

		Fire:
			TNT1 A 7 {
				int brassNeeded = 2;
				string caseClass = "B556Brass";
				if (invoker.mode == 1) {
					brassNeeded = 3;
					caseClass = "B762x51Brass";
				}

				int brassCount = invoker.owner.CountInv("B_Brass");
				if (brassCount >= brassNeeded) {
					A_StartSound("crafting/motor", CHAN_WEAPON, CHANF_OVERLAP);
					A_SpawnItemEx(caseClass, 10, 0, height - 12, 0, 0, 0);
					invoker.owner.TakeInventory("B_Brass", brassNeeded);
					if (invoker.mode == 1) {
						A_SetTics(10);
					}
				}
			}
			Goto Ready;

		AltFire:
			TNT1 A 1 {
				invoker.mode = invoker.mode == 0 ? 1 : 0;
			}

		Switched:
			TNT1 A 0 A_Refire();
			Goto Ready;

		Hold:
			TNT1 A 1;
			TNT1 A 0 A_Refire("Hold");

		User3:
			---- A 0 {
				A_SelectWeapon("PickupManager");
			}
			Goto Ready;

		User4:
			---- A 0 {

			}
			Goto Ready;

		Spawn:
			BNCH B -1;
			Stop;
	}

}


class B_BulletAssembler : HDWeapon {
	default {
		+Weapon.Wimpy_Weapon
		+Inventory.Invbar
		+HDWeapon.FitsInBackpack
		inventory.pickupsound "misc/w_pkup";
		inventory.pickupmessage "You got the bullet assembler.";
		scale 0.5;
		hdweapon.refid "asm";
		tag "Bullet Assembler";
	}

	override double gunMass() { return 0; }
	override double weaponBulk() { return 20 * amount; }
	override string,double getpickupsprite(){
		return "BNCHC0",1.;
	}

	int mode;

	override void DrawHUDStuff(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl){
		vector2 bob=hpl.hudbob*0.3;
		sb.drawString(sb.psmallfont, "Bullet Assembler", (0, -10) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_GOLD);

		int powderRequired = 2;

		int powderCount = hpl.countinv("B_GunPowder");
		int cases = 0;
		int balls = 0;
		string caseClass = "B556Brass";
		string ballClass = "B_556Ball";
		string caseSprite = "BF56A7A3";
		string ballSprite = "B56TA0";


		if (mode == 1) {
			powderRequired = 3;
			caseClass = "B762x51Brass";
			caseSprite = "BB76A3A7";
			ballClass = "B_762Ball";
			ballSprite = "B76TA0";
			sb.drawString(sb.psmallfont, "Mode: 7.62x51mm", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_GREEN);
		}
		else {
			sb.drawString(sb.psmallfont, "Mode: 5.56x45mm", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_RED);
		}

		sb.drawString(sb.psmallfont, "1", (-30, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);
		sb.drawString(sb.psmallfont, ""..powderRequired, (0, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);
		sb.drawString(sb.psmallfont, "1", (30, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);
		
		sb.drawImage(caseSprite, (-30, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, scale: (3, 3));
		sb.drawImage("BBBGA0", (0, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER);
		sb.drawImage(ballSprite, (30, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER);

		int caseCount = hpl.countinv(caseClass);
		int ballCount = hpl.countinv(ballClass);

		sb.drawString(sb.psmallfont, ""..caseCount, (-30, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, caseCount >= 1 ? Font.CR_GREEN : Font.CR_DARKGRAY);
		sb.drawString(sb.psmallfont, ""..powderCount, (0, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, caseCount >= 1 ? Font.CR_GREEN : Font.CR_DARKGRAY);
		sb.drawString(sb.psmallfont, ""..ballCount, (30, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, caseCount >= 1 ? Font.CR_GREEN : Font.CR_DARKGRAY);
	}

	override string gethelptext(){
		return
		WEPHELP_FIRE.."  Assemble rounds\n"
		..WEPHELP_UNLOAD.."+"..WEPHELP_USE.."  same"
		;
	}

	override bool AddSpareWeapon(actor newowner){
		return AddSpareWeaponRegular(newowner);
	}

	override hdweapon GetSpareWeapon(actor newowner, bool reverse, bool doselect){
		return GetSpareWeaponRegular(newowner, reverse, doselect);
	}

	states {
		select0:
			TNT1 A 0 A_Raise(999);
			wait;
		deselect0:
			TNT1 A 0 A_Lower(999);
			wait;

		Ready:
			TNT1 A 1 A_WeaponReady(WRF_ALLOWUSER3 | WRF_ALLOWUSER4);
			Goto ReadyEnd;

		Fire:
			TNT1 A 7 {

				int powderRequired = 2;
				int powderCount = invoker.owner.countinv("B_GunPowder");
				int cases = 0;
				int balls = 0;
				string caseClass = "B556Brass";
				string ballClass = "B_556Ball";
				string caseSprite = "BF56A7A3";
				string ballSprite = "B56TA0";
				string bulletClass = "B556Ammo";
				if (invoker.mode == 1) {
					powderRequired = 3;
					caseClass = "B762x51Brass";
					caseSprite = "BB76A3A7";
					ballClass = "B_762Ball";
					ballSprite = "B76TA0";
					bulletClass = "B762x51Ammo";
				}

				int caseCount = invoker.owner.countinv(caseClass);
				int ballCount = invoker.owner.countinv(ballClass);

				if (caseCount >= 1 && ballCount >= 1 && powderCount >= powderRequired) {
					A_StartSound("crafting/motor", CHAN_WEAPON, CHANF_OVERLAP);
					A_SpawnItemEx(bulletClass, 10, 0, height - 12, 0, 0, 0);
					invoker.owner.TakeInventory(caseClass, 1);
					invoker.owner.TakeInventory(ballClass, 1);
					invoker.owner.TakeInventory("B_GunPowder", powderRequired);
					if (invoker.mode == 1) {
						A_SetTics(10);
					}
				}
			}
			Goto Ready;

		AltFire:
			TNT1 A 1 {
				invoker.mode = invoker.mode == 0 ? 1 : 0;
			}

		Switched:
			TNT1 A 0 A_Refire();
			Goto Ready;

		Hold:
			TNT1 A 1;
			TNT1 A 0 A_Refire("Hold");

		User3:
			---- A 0 {
				A_SelectWeapon("PickupManager");
			}
			Goto Ready;

		User4:
			---- A 0 {

			}
			Goto Ready;

		Spawn:
			BNCH C -1;
			Stop;
	}

}

class B_RocketAssembler : HDWeapon {
	default {
		+Weapon.Wimpy_Weapon
		+Inventory.Invbar
		+HDWeapon.FitsInBackpack
		inventory.pickupsound "misc/w_pkup";
		inventory.pickupmessage "You got the rocket assembler.";
		scale 0.5;
		hdweapon.refid "rsm";
		tag "Rocket Assembler";
	}

	override double gunMass() { return 0; }
	override double weaponBulk() { return 20 * amount; }
	override string,double getpickupsprite(){
		return "BNCHD0",1.;
	}


	override void DrawHUDStuff(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl){
		vector2 bob=hpl.hudbob*0.3;
		sb.drawString(sb.psmallfont, "Rocket Assembler", (0, -10) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_GOLD);

		/*
		int powderRequired = 5;
		int powderCount = hpl.countinv("B_GunPowder");


		int cases = 0;
		int balls = 0;
		string caseClass = "B556Brass";
		string ballClass = "B_556Ball";
		string caseSprite = "BF56A7A3";
		string ballSprite = "B56TA0";


		if (mode == 1) {
			powderRequired = 3;
			caseClass = "B762x51Brass";
			caseSprite = "BB76A3A7";
			ballClass = "B_762Ball";
			ballSprite = "B76TA0";
			sb.drawString(sb.psmallfont, "Mode: 5.56x45mm", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_GREEN);
		}
		else {
			sb.drawString(sb.psmallfont, "Mode: 7.62x45mm", (0, 0) + bob, sb.DI_SCREEN_CENTER | sb.DI_TEXT_ALIGN_CENTER, Font.CR_RED);
		}

		sb.drawString(sb.psmallfont, "1", (-30, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);
		sb.drawString(sb.psmallfont, ""..powderRequired, (0, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);
		sb.drawString(sb.psmallfont, "1", (30, 25) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, Font.CR_LIGHTBLUE);
		
		sb.drawImage(caseSprite, (-30, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, scale: (3, 3));
		sb.drawImage("BBBGA0", (0, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER);
		sb.drawImage(ballSprite, (30, 40) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER);

		int caseCount = hpl.countinv(caseClass);
		int ballCount = hpl.countinv(ballClass);

		sb.drawString(sb.psmallfont, ""..caseCount, (-30, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, caseCount >= 1 ? Font.CR_GREEN : Font.CR_DARKGRAY);
		sb.drawString(sb.psmallfont, ""..powderCount, (0, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, caseCount >= 1 ? Font.CR_GREEN : Font.CR_DARKGRAY);
		sb.drawString(sb.psmallfont, ""..ballCount, (30, 55) + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, caseCount >= 1 ? Font.CR_GREEN : Font.CR_DARKGRAY);
		*/
	}

	override string gethelptext(){
		return
		WEPHELP_FIRE.."  Assemble rounds\n"
		..WEPHELP_UNLOAD.."+"..WEPHELP_USE.."  same"
		;
	}

	override bool AddSpareWeapon(actor newowner){
		return AddSpareWeaponRegular(newowner);
	}

	override hdweapon GetSpareWeapon(actor newowner, bool reverse, bool doselect){
		return GetSpareWeaponRegular(newowner, reverse, doselect);
	}

	states {
		select0:
			TNT1 A 0 A_Raise(999);
			wait;
		deselect0:
			TNT1 A 0 A_Lower(999);
			wait;

		Ready:
			TNT1 A 1 A_WeaponReady(WRF_ALLOWUSER3 | WRF_ALLOWUSER4);
			Goto ReadyEnd;

		Fire:
			TNT1 A 7 {
				/*
				int powderRequired = 2;
				int powderCount = invoker.owner.countinv("B_GunPowder");
				int cases = 0;
				int balls = 0;
				string caseClass = "B556Brass";
				string ballClass = "B_556Ball";
				string caseSprite = "BF56A7A3";
				string ballSprite = "B56TA0";
				string bulletClass = "B556Ammo";
				if (invoker.mode == 1) {
					powderRequired = 3;
					caseClass = "B762x51Brass";
					caseSprite = "BB76A3A7";
					ballClass = "B_762Ball";
					ballSprite = "B76TA0";
					bulletClass = "B762x51Ammo";
				}

				int caseCount = invoker.owner.countinv(caseClass);
				int ballCount = invoker.owner.countinv(ballClass);

				if (caseCount >= 1 && ballCount >= 1 && powderCount >= powderRequired) {
					A_StartSound("crafting/motor", CHAN_WEAPON, CHANF_OVERLAP);
					A_SpawnItemEx(bulletClass, 10, 0, height - 12, 0, 0, 0);
					invoker.owner.TakeInventory(caseClass, 1);
					invoker.owner.TakeInventory(ballClass, 1);
					invoker.owner.TakeInventory("B_GunPowder", powderRequired);
					if (invoker.mode == 1) {
						A_SetTics(10);
					}
				}
				*/
			}
			Goto Ready;

		Switched:
			TNT1 A 0 A_Refire();
			Goto Ready;

		Hold:
			TNT1 A 1;
			TNT1 A 0 A_Refire("Hold");

		User3:
			---- A 0 {
				A_SelectWeapon("PickupManager");
			}
			Goto Ready;

		User4:
			---- A 0 {

			}
			Goto Ready;

		Spawn:
			BNCH D -1;
			Stop;
	}

}