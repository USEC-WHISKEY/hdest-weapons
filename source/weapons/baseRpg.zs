
class BaseRPG : BHDWeapon {

	states {

		UnloadMag:
			#### A 1 Offset(0, 33);
			#### A 1 Offset(0, 34);
			#### A 1 Offset(0, 37);
			#### A 2 Offset(0, 39) {
				if (invoker.magazineGetAmmo() < 0) {
					return ResolveState("MagOut");
				}
				if (invoker.brokenChamber()) {
					invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
				}
				A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
				return ResolveState(NULL);
			}
			#### A 4 Offset(0, 40) {
				A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
			}
			#### A 4 offset(0, 44) {
				int inMag = invoker.magazineGetAmmo();
				if (inMag > (invoker.bMagazineCapacity + 1)) {
					inMag %= invoker.bMagazineCapacity;
				}
				
				if (invoker.chambered()) {
					HDMagAmmo.SpawnMag(self, invoker.bMagazineClass, 1);
				}
				invoker.unchamber();
				return ResolveState("MagOut");
			}


		Reload:
			#### A 0 {
				invoker.weaponStatus[I_FLAGS] &= ~F_UNLOAD_ONLY;
				if (!invoker.brokenChamber() && invoker.magazineGetAmmo() % 999 >= invoker.bMagazineCapacity && !(invoker.weaponstatus[I_FLAGS] & F_UNLOAD_ONLY)) {
					return ResolveState("Nope");
				}
				else if (invoker.magazineGetAmmo() < 0 && invoker.brokenChamber()) {
					return ResolveState("Nope");
				}
				else if (!HDMagAmmo.NothingLoaded(self, invoker.bMagazineClass)) {
					return ResolveState("UnloadMag");
				}
				return ResolveState("LoadMag");
			}

		user4:
		Unload:
			#### A 0 {
				if (invoker.chambered()) {
					return ResolveState("UnloadMag");
				}
				else {
					return ResolveState("Nope");
				}
			}

		Flash:
			TNT1 A 0;
			#### # 1 { 
				A_FireHDGL();
				A_ChangeVelocity(cos(pitch), 0, sin(pitch), CVF_RELATIVE);
				invoker.weaponstatus[RLS_SMOKE] += 50;
				invoker.unchamber();
				A_StartSound("weapons/rockignite",CHAN_AUTO);
				A_StartSound("weapons/rockboom",CHAN_AUTO);
				return ResolveState("LightDone");
			}


		LoadMag:
			#### A 12 {
				let magRef = HDMagAmmo(FindInventory(invoker.bMagazineClass));
				if (!magRef) {
					return ResolveState("ReloadEnd");
				}

				A_StartSound("weapons/pocket", CHAN_WEAPON);
				A_SetTics(10);
				return ResolveState(NULL);
			}
			#### A 8 Offset(0, 45);
			#### A 1 Offset(0, 44) {
				let magRef = HDMagAmmo(FindInventory(invoker.bMagazineClass));
				if (magRef) {
					if (magRef.amount == 0) {
						return ResolveState("Nope");
					}
					invoker.weaponStatus[I_MAG] = magRef.TakeMag(true);
				}
				return ResolveState("ReloadEnd");
			}

		ReloadEnd:
			#### A 2 Offset(0, 39);
			#### A 1 Offset(0, 37); // A_MuzzleClimb(frandom(0.2, -2.4), frandom(-0.2, -1.4));
			#### A 0 A_CheckCookoff();
			#### A 1 Offset(0, 34);
			#### A 0 {
				return ResolveState("Chamber_Manual");
			}

		Chamber_Manual:
			#### C 0 { 
				if (invoker.chambered() || invoker.magazineGetAmmo() <= -1) {
					return ResolveState("Nope");
				}
				return ResolveState(NULL);
			}
			#### C 0;
			#### C 3 Offset(0, 36) A_WeaponBusy();
			#### D 3 Offset(0, 40) {
				int ammo = invoker.magazineGetAmmo();
				if (!invoker.chambered() && ammo % 999 > 0) {
					if (ammo > invoker.bMagazineCapacity) {
						invoker.weaponStatus[I_MAG] = 0;
					}
					else {
						invoker.magazineAddAmmo(-1);
					}
					invoker.setChamber();
					return ResolveState(NULL);
				}
				return ResolveState("Nope");
			}
			#### E 3 offset(0, 46);
			#### D 3 offset(0, 36) A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
			#### A 0 offset(0, 34) {
				return ResolveState("Nope");
			}


		FinishChamber:
			#### B 1;
			#### A 0 A_CheckCookOff();
			#### A 0 A_Refire();
			#### A 0 {
				return ResolveState("Ready");
			}

		}
}