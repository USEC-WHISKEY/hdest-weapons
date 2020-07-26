
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
		if(!(hdw.weaponstatus[I_FLAGS] & F_NO_FIRE_SELECT)) {
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
	}
}




class BaseGLRifle : BaseAltRifle {

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

}


















// WIP
class BaseBoltRifle : BaseStandardRifle {

	action void A_ChamberGrit(int amt,bool onlywhileempty=false){
		int ibg = invoker.weaponstatus[I_GRIME];
		if(!random(0,4)) {
			ibg++;
		}
		invoker.weaponstatus[I_GRIME] = ibg;
	}

	States {
		
		User4:
		Unload:
			#### B 1 offset(0, 34);
			#### B 1 offset(2, 36);
			#### C 1 offset(4, 40);
			#### C 2 offset(8, 42) {
				A_MuzzleClimb(-frandom(0.4, 0.8), frandom(0.4, 1.4));
				A_StartSound("weapons/rifleclick2", 8);
			}
			#### D 4 offset(14, 46) {
				A_MuzzleClimb(-frandom(0.4, 0.8), frandom(0.4, 1.4));
				A_StartSound("weapons/rifleload", 8);
			}

		UnloadLoop:
			#### E 4 offset(3, 41) {
				if (invoker.weaponStatus[I_MAG] < -1) {
					return ResolveState("UnloadDone");
				}
				else {
					A_StartSound("weapons/rifleclick2", 8);
					invoker.weaponStatus[I_MAG]--;
					if (invoker.weaponStatus[I_MAG] > -1) {
						if (A_JumpIfInventory(invoker.bMagazineClass, 0, "null")) {
							A_SpawnItemEx(
								invoker.BAmmoClass,
								cos(pitch) * 8,
								0,
								height - 7 - sin(pitch) * 8,
								cos(pitch) * cos(angle - 40) * 1 + vel.x,
								cos(pitch) * sin(angle - 40) * 1 + vel.y,
								-sin(pitch) * 1 + vel.z,
								0,
								SXF_ABSOLUTEMOMENTUM | SXF_NOCHECKPOSITION | SXF_TRANSFERPITCH
							);
						}
						else {
							A_GiveInventory(invoker.bAmmoClass, 1);
						}
					}
					else if (invoker.weaponStatus[I_MAG] == -1 && invoker.chambered()) {
						invoker.unchamber();
						invoker.weaponStatus[I_FLAGS] &= ~F_EMPTY_CHAMBER;
						if (A_JumpIfInventory(invoker.bMagazineClass, 0, "null")) {
							A_SpawnItemEx(
								invoker.BAmmoClass,
								cos(pitch) * 8,
								0,
								height - 7 - sin(pitch) * 8,
								cos(pitch) * cos(angle - 40) * 1 + vel.x,
								cos(pitch) * sin(angle - 40) * 1 + vel.y,
								-sin(pitch) * 1 + vel.z,
								0,
								SXF_ABSOLUTEMOMENTUM | SXF_NOCHECKPOSITION | SXF_TRANSFERPITCH
							);
						}
						else {
							A_GiveInventory(invoker.bAmmoClass, 1);
						}
					}
					return ResolveState(NULL);
				}
			}
			#### E 2 offset(2, 42);
			#### E 0 {
				if (pressingreload() || pressingfire() || pressingaltfire() || pressingzoom()) {
					return ResolveState("UnloadDone");
				}
				return ResolveState("UnloadLoop");
			}

		UnloadDone:
			#### D 2 offset(2, 42) A_StartSound("weapons/rifleclick2", 8);
			#### C 3 offset(3, 41);
			#### A 1 offset(4, 40);
			#### A 1 offset(2, 36);
			#### A 1 offset(0, 34);
			goto ready;

		ShootGun:
			#### A 1 {
				if (invoker.brokenChamber() || invoker.chamberFired() || (!invoker.chambered() && invoker.magazineGetAmmo() < 1)) {
					return ResolveState("Nope");
				}
				else if (!invoker.chambered()) {
					return ResolveState("Nope");
				}
				else {
					A_Overlay(0, "Flash");
					A_WeaponReady(WRF_NONE);
					if (invoker.weaponStatus[I_AUTO] >= 2) {
						invoker.weaponStatus[I_AUTO]++;
					}
					return ResolveState(NULL);
				}

			}
			#### B 1;
			#### B 0 {
				return ResolveState("Ready");
			}

		AltFire:
			#### A 1 offset(0, 34) A_WeaponBusy();
			#### A 1 {
				if (invoker.magazineGetAmmo() < 0) {
					return ResolveState("Nope");
				}
				return ResolveState(NULL);
			}
			#### A 2 offset(2, 36);
			#### A 1 offset(4, 38);
			#### A 1 offset(0, 34);
			#### A 0 A_ChamberGrit(randompick(0, 0, 0, 0, -1, 1, 2), true);
			#### A 0 A_Refire("chamber");
			#### A 0 {
				return ResolveState("Ready");
			}

		Chamber:
			#### C 2;
			#### D 5;
			#### D 0 Offset(0, 32) {
				A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON, CHANF_OVERLAP);
				if (!invoker.magazineHasAmmo() < 0) {
					return ResolveState("nope");
				}

				if (invoker.magazineGetAmmo() % 100 > 0) {
					if (invoker.magazineGetAmmo() == invoker.bMagazineCapacity) {
						invoker.weaponStatus[I_MAG] = invoker.bMagazineCapacity;
					}
					invoker.weaponStatus[I_MAG] += -1;
					if (invoker.chambered()) {
						double fc = max(pitch * 0.01, 5);
						double cosp = cos(pitch);
						A_SPawnItemEx(
							invoker.bAmmoClass,
							cosp * 6, 
							5, 
							height - 8 - sin(pitch) * 6,
							cosp * -2,
							1,
							2 - sin(pitch),
							0,
							SXF_NOCHECKPOSITION | SXF_TRANSFERPITCH);
					}
					invoker.setChamber();
				}
				else {
					invoker.weaponStatus[I_MAG] = min(invoker.magazineGetAmmo(), 0);
					A_StartSound(invoker.bChamberSound, CHAN_WEAPON, CHANF_OVERLAP);
					if (invoker.chambered()) {
						double fc = max(pitch * 0.01, 5);
						double cosp = cos(pitch);
						A_SPawnItemEx(
							invoker.bAmmoClass,
							cosp * 6, 
							5, 
							height - 8 - sin(pitch) * 6,
							cosp * -2,
							1,
							2 - sin(pitch),
							0,
							SXF_NOCHECKPOSITION | SXF_TRANSFERPITCH);
					}
					invoker.unchamber();
				}

				if (BrokenRound()) {
					return ResolveState("Jam");
				}
				A_WeaponReady(WRF_NOFIRE);
				return ResolveState(NULL);
			}
			#### E 0 {
				double fc = max(pitch * 0.01, 5);
				double cosp = cos(pitch);
				if (invoker.chamberFired()) {
					invoker.weaponStatus[I_FLAGS] &= ~F_EMPTY_CHAMBER;
					A_SPawnItemEx(
						invoker.EjectShellClass,
						cosp * 6, 
						5, 
						height - 8 - sin(pitch) * 6,
						cosp * -2,
						1,
						2 - sin(pitch),
						0,
						SXF_NOCHECKPOSITION | SXF_TRANSFERPITCH);
				}

			}
			#### E 2 A_CheckCookoff();

		AltHold:
			#### E 1 A_WeaponReady(WRF_NOFIRE);
			#### E 1 {
				A_ClearRefire();
				bool eww = invoker.weaponstatus[I_GRIME] > 10;
				bool chempty = invoker.magazineGetAmmo() < 0;
				if(pressingunload()){
					if (chempty) {
						return resolvestate("AltHoldClean");
					} else {
						invoker.weaponstatus[I_FLAGS] |= F_UNLOAD_ONLY; // BOSSF_UNLOADONLY;
						return resolvestate("LoadChamber");
					}
				}else if(pressingreload()) {
					if(!chempty) {
						invoker.weaponstatus[I_FLAGS] |= F_UNLOAD_ONLY; // BOSSF_UNLOADONLY;
						return resolvestate("LoadChamber");
					} 
					else if(countinv(invoker.bAmmoClass)) {
						invoker.weaponstatus[I_FLAGS] &= ~F_UNLOAD_ONLY; //~BOSSF_UNLOADONLY;
						return resolvestate("LoadChamber");
					}
				}
				if(pressingaltfire())return resolvestate("AltHold");
				return resolvestate("AltHoldEnd");
			}

		AltHoldEnd:
			#### E 0 A_StartSound(invoker.bBoltForwardSound, 8);
			#### D 4 A_WeaponReady(WRF_NOFIRE);
			#### C 2 offset(2, 36) {
				A_WeaponReady(WRF_NOFIRE);
			}
			#### A 0 {
				return ResolveState("Ready");
			}

		ReloadEnd:
			#### A 2 Offset(-11, 39);
			#### A 1 Offset(-8, 37) A_MuzzleClimb(frandom(0.2, -2.4), frandom(-0.2, -1.4));
			#### A 0 A_CheckCookoff();
			#### A 1 Offset(-3, 34);
			#### A 0 {
				return ResolveState("Ready");
			}

		UnloadMag:
			#### A 1 Offset(0, 33);
			#### A 1 Offset(-3, 34);
			#### A 1 Offset(-8, 37);
			#### A 2 Offset(-11, 39) {
				if (invoker.magazineGetAmmo() < 0) {
					return ResolveState("MagOut");
				}
				if (invoker.brokenChamber()) {
					invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
				}
				A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
				A_StartSound(invoker.bClickSound, CHAN_WEAPON);
				return ResolveState(NULL);
			}
			#### A 4 Offset(-12, 40) {
				A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
				A_StartSound(invoker.bLoadSound, CHAN_WEAPON);
			}
			#### A 20 offset(-14, 44) {
				int inMag = invoker.magazineGetAmmo();
				if (inMag > (invoker.bMagazineCapacity + 1)) {
					inMag %= invoker.bMagazineCapacity;
				}

				invoker.weaponStatus[I_MAG] = 0;
				if (!PressingUnload() && !PressingReload() || A_JumpIfInventory(invoker.bMagazineClass, 0, "null")) {
					HDMagAmmo.SpawnMag(self, invoker.bMagazineClass, inMag);
					A_SetTics(1);
				}
				else {
					HDMagAmmo.GiveMag(self, invoker.bMagazineClass, inMag);
					A_StartSound("weapons/pocket", CHAN_WEAPON);
				}
				return ResolveState("MagOut");
			}

		Flash:
			TNT1 A 1 {
				if (!(invoker.barrelClass is "BaseFlashAttachment") && !(invoker.barrelClass is "BaseSilencerAttachment")) {
					A_Light1();
					HDFlashAlpha(-16);
				}

				bool silenced = invoker.barrelClass is "BaseSilencerAttachment";
				string sound = silenced ? invoker.bSFireSound : invoker.bFireSound;

				A_StartSound(sound, CHAN_WEAPON, CHANF_OVERLAP);
				A_ZoomRecoil(max(0.95, 1. -0.05 * invoker.fireMode()));
				double burn = max(invoker.heatAmount(), invoker.boreStretch()) * 0.01;
				HDBulletActor.FireBullet(self, invoker.bBulletClass, spread: burn > 1.2 ? burn : 0);
				A_MuzzleClimb(
					-frandom(0.1,0.1), -frandom(0,0.1),
					-0.2,              -frandom(0.3,0.4),
					-frandom(0.4,1.4), -frandom(1.3,2.6)
				);
				invoker.addHeat(random(3, 5));
				invoker.weaponStatus[I_FLAGS] |= F_EMPTY_CHAMBER;
				invoker.unchamber();

				double fc = max(pitch * 0.01, 5);
				double cosp = cos(pitch);

				A_AlertMonsters();
			}
			TNT1 A 0 { 
				return ResolveState("LightDone");
			}

	}

	bool chamberFired() const {
		return weaponStatus[I_FLAGS] & F_EMPTY_CHAMBER;
	}

}
