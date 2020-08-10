
class BaseStandardRifle : BHDWeapon {

}

class BaseAltRifle : BHDWeapon {

	property BAltMagClass: BAltMagClass;
	string bAltMagClass;

	property BAltMagPicture: BAltMagPicture;
	string bAltMagPicture;

	override void DrawHUDStuff(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl) {
		BaseAltRifle basicWep = BaseAltRifle(hdw);
		if (sb.hudLevel == 1) {
			int nextMag = sb.GetNextLoadMag(HDMagAmmo(hpl.findInventory(basicWep.bMagazineClass)));
			sb.DrawImage(basicWep.bMagazineSprite, (-46, -3), sb.DI_SCREEN_CENTER_BOTTOM, scale: (2, 2));
			sb.DrawNum(hpl.CountInv(basicWep.bMagazineClass), -43, -8, sb.DI_SCREEN_CENTER_BOTTOM);
		}
		if (bShowFireMode) {
			sb.drawwepcounter(hdw.weaponstatus[I_AUTO], -22, -10, "RBRSA3A7", "STFULAUT", "STBURAUT" );
		}
		int ammoBarAmt = clamp(basicWep.magazineGetAmmo() % 100, 0, basicWep.bMagazineCapacity);
		sb.DrawWepNum(ammoBarAmt, basicWep.bMagazineCapacity);
		if (basicWep.chambered()) {
			sb.DrawWepDot(-16, -10, (3, 1));
			ammoBarAmt++;
		}
		//sb.DrawNum(ammoBarAmt, -16, -22, sb.DI_SCREEN_CENTER_BOTTOM | sb.DI_TEXT_ALIGN_RIGHT, Font.CR_RED);

		sb.drawImage(basicWep.bAltMagPicture, (-62, -4), SB.DI_SCREEN_CENTER_BOTTOM, scale: (0.6, 0.6));
		sb.drawNum(hpl.CountInv(basicWep.bAltMagClass), -56, -8, sb.DI_SCREEN_CENTER_BOTTOM);
	}

	override string gethelptext(){
		return
		WEPHELP_FIRE.."  Shoot\n"
		..WEPHELP_RELOAD.."  Reload mag\n"
		..WEPHELP_UNLOAD.."  Release mag \\ Unchamber\n"
		..WEPHELP_ALTRELOAD.."  Reload Grenade\n"
		..WEPHELP_ALTFIRE..("  Rifle/GL mode\n")
		..WEPHELP_MAGMANAGER;
	}

	override void DropOneAmmo(int amt){
		if(owner){
			amt = clamp(amt, 1, 10);
			if (owner.CountInv(bAmmoClass)) {
				owner.A_DropInventory(bAmmoClass, amt * bMagazineCapacity);
			}
			else {
				double angchange=(weaponstatus[0]&ZM66F_NOLAUNCHER)?0:-10;
				if(angchange)owner.angle-=angchange;
				owner.A_DropInventory(BMagazineClass, amt);
				if(angchange){
					owner.angle+=angchange*2;
					owner.A_DropInventory(bAltMagClass, amt);
					owner.angle-=angchange;
				}
			}
		}
	}


	States {

		AltFire:
			---- A 1 offset(0, 34) {
				invoker.weaponStatus[I_FLAGS] ^= F_GL_MODE;
				invoker.airburst = 0;
				A_SetCrosshair(21);
				A_SetHelpText();
			}
			---- A 0 {
				return ResolveState("Nope");
			}

		Fire:
			---- A 0 {
				if (invoker.weaponStatus[I_FLAGS] & F_GL_MODE) {
					return ResolveState("FireAlt");
				}
				return ResolveState(NULL);
			}
			Goto super::fire;

		FireAlt:
			---- A 0 {
				if (!(invoker.weaponStatus[I_FLAGS] & I_GRENADE)) {
					return ResolveState("Nope");
				}
				return ResolveState(NULL);
			}
			---- A 2;
			---- A 3 A_GunFlash("AltFlash");
			---- A 0 {
				return ResolveState("Nope");
			}

		AltFlash:
			---- A 0 A_JumpIf(invoker.weaponStatus[I_FLAGS] & I_GRENADE, 1);
			Stop;
			---- A 2 {
				A_FireHDGL();
				invoker.weaponStatus[I_FLAGS] &= ~I_GRENADE;
				A_StartSound("weapon/grenadeshot", CHAN_WEAPON);
				A_ZoomRecoil(0.95);
			}
			---- A 2 A_MuzzleClimb(0, 0, 0, 0, -1.2, -3, -1, -2.8);
			Stop;

		AltReload:
			---- A 0 {
				invoker.weaponStatus[I_FLAGS] &= ~F_UNLOAD_ONLY;
				if (!(invoker.weaponStatus[I_FLAGS] & I_GRENADE) && CountInv(invoker.bAltMagClass)) {
					return ResolveState("UnloadAlt");
				}
				return ResolveState("Nope");
			}

		UnloadAlt:
			---- A 0 {
				A_SetCrosshair(21);
				A_MuzzleClimb(-0.3, -0.3);
			}
			---- A 2 offset(0, 34);
			---- A 1 offset(4, 38) {
				A_MuzzleClimb(-0.3, -0.3);
			}
			---- A 2 offset(8, 48) {
				A_StartSound("weapons/grenopen", CHAN_WEAPON, CHANF_OVERLAP);
				A_MuzzleClimb(-0.3, -0.3);
				if (invoker.weaponstatus[I_FLAGS] & I_GRENADE) {
					A_StartSound("weapons/grenreload", CHAN_WEAPON);
				}
			}
			---- A 10 offset(10, 49) {
				if (!(invoker.weaponstatus[I_FLAGS] & I_GRENADE)) {
					if (!(invoker.weaponStatus[I_FLAGS] & F_UNLOAD_ONLY)) {
						A_SetTics(3);
						return;
					}
				}

				invoker.weaponStatus[I_FLAGS] &= ~I_GRENADE;
				if (!PressingUnload() || A_JumpIfInventory(invoker.bAltMagClass, 0, "null")) {
					A_SpawnItemEx(
						invoker.bAltMagClass, 
						cos(pitch) * 10,
						0,
						height - 10 - 10 * sin(pitch),
						vel.x,
						vel.y,
						vel.z,
						0,
						SXF_ABSOLUTEMOMENTUM | SXF_NOCHECKPOSITION | SXF_TRANSFERPITCH);
				}
				else {
					A_StartSound("weapons/pocket", CHAN_WEAPON, CHANF_OVERLAP);
					A_GiveInventory("HDRocketAmmo", 1);
					A_MuzzleClimb(frandom(0.8, -0.2), frandom(0.4, -0.2));
				}
			}
			---- A 0 A_JumpIf(invoker.weaponStatus[I_FLAGS] & F_UNLOAD_ONLY, "areloadend");

		LoadAlt:
			---- A 4 offset(10, 50) A_StartSound("weapons/pocket", CHAN_WEAPON, CHANF_OVERLAP);
			---- AAA 2 offset(10, 50) A_MuzzleClimb(frandom(-0.2, 0.8), frandom(-0.2, 0.4));
			---- A 10 offset(8, 50) {
				A_TakeInventory(invoker.bAltMagClass, 1, TIF_NOTAKEINFINITE);
				invoker.weaponStatus[I_FLAGS] |= I_GRENADE;
				A_StartSound("weapon/grenreload", CHAN_WEAPON);
			}

		AReloadEnd:
			---- A 4 offset(4, 44) A_StartSound("weapons/grenopen", CHAN_WEAPON);
			---- A 1 offset(0, 40);
			---- A 1 offset(0, 34) A_MuzzleClimb(frandom(-2.4, 0.2), frandom(-1.4, 0.2));
			---- A 0 {
				return ResolveState("Nope");
			}

		user4:
		Unload:
			#### A 0 {
				invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
				if (invoker.weaponstatus[I_FLAGS] & F_GL_MODE && invoker.weaponStatus[I_FLAGS] & I_GRENADE) {
					return ResolveState("UnloadAlt");
				}
				else if (invoker.weaponstatus[I_FLAGS] & F_GL_MODE) {
					return ResolveState("Nope");
				}	

				if (invoker.magazineGetAmmo() >= 0) {
					return ResolveState("UnloadMag");
				}
				else if (invoker.chambered() || invoker.brokenChamber()) {
					return ResolveState("UnloadChamber");
				}
				else {
					return ResolveState("Nope");
				}
			}

	}
}




class BaseGLRifle : BaseAltRifle {

	override void InitializeWepStats (bool idfa) {
		super.InitializeWepStats(idfa);
		weaponStatus[I_FLAGS] |= I_GRENADE;
	}

	override void LoadoutConfigure(string input) {
		super.LoadoutConfigure(input);
		weaponStatus[I_FLAGS] |= I_GRENADE;
	}

	override void DrawHUDStuff(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl) {
		super.DrawHUDStuff(sb, hdw, hpl);
		if (hdw.weaponStatus[I_FLAGS] & F_GL_MODE) {
			int ab=hdw.airburst;
			sb.drawnum(ab,
				-30,-22,sb.DI_SCREEN_CENTER_BOTTOM|sb.DI_TEXT_ALIGN_RIGHT,
				ab?Font.CR_WHITE:Font.CR_DARKGRAY
			);
			sb.drawwepdot(-30,-42+min(16,ab/10),(4,1));
			sb.drawwepdot(-30,-26,(1,16));
			sb.drawwepdot(-32,-26,(1,16));
		}
		if(hdw.weaponstatus[I_FLAGS] & I_GRENADE)
			sb.drawwepdot(-16,-13,(4,2.6));
	}

	override void DrawSightPicture(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl, bool sightbob, vector2 bob, double fov, bool scopeview, actor hpc, string whichdot) {
		if (hdw.weaponStatus[I_FLAGS] & F_GL_MODE) {
			sb.drawgrenadeladder(hdw.airburst, bob);
		}
		else {
			super.DrawSightPicture(sb, hdw, hpl, sightbob, bob, fov, scopeview, hpc, whichdot);
		}
	}	

	override double WeaponBulk() {
		return super.WeaponBulk() + (weaponStatus[I_FLAGS] & I_GRENADE ? c_rocket_load_bulk : 0.0);
	}

}

