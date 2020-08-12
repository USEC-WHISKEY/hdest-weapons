
class BaseRPG : BHDWeapon {

	override void DrawHUDStuff(HDStatusBar sb,HDWeapon hdw,HDPlayerPawn hpl){
		BHDWeapon basicWep = BHDWeapon(hdw);
		if (sb.hudLevel == 1) {
			int nextMag = sb.GetNextLoadMag(HDMagAmmo(hpl.findInventory(basicWep.bMagazineClass)));
			sb.DrawImage(basicWep.bMagazineSprite, (-46, -3), sb.DI_SCREEN_CENTER_BOTTOM, scale: (basicWep.BAmmoHudScale, basicWep.BAmmoHudScale));
			sb.DrawNum(hpl.CountInv(basicWep.bMagazineClass), -43, -8, sb.DI_SCREEN_CENTER_BOTTOM);
		}
		if (basicWep.chambered()) {
			sb.DrawWepDot(-16, -10, (3, 1));
			//ammoBarAmt++;
		}
		//sb.DrawNum(ammoBarAmt, -16, -22, sb.DI_SCREEN_CENTER_BOTTOM | sb.DI_TEXT_ALIGN_RIGHT, Font.CR_RED);
	}

	override double WeaponBulk() {
		// Yugh, what to do here
		return bWeaponBulk + (weaponStatus[I_FLAGS] & F_CHAMBER) ? ((c_rpg_case_bulk + c_rpg_charge_bulk) / 2) : 0; //      (mgg < 0 ? 0 : (loadedMagBulk + mgg * loadedRoundBulk));
	}

	override void PostBeginPlay() {
		super.PostBeginPlay();
		if (!spawnEmpty && weaponStatus[I_MAG] > 0) {
			weaponStatus[I_FLAGS] |= F_CHAMBER;
		}

		//weaponStatus[I_MAG]--;
		// This bugs if you're carrying multiple rifles, need to check it out?
	}

	states {

		MagOut:
			#### A 4;
			#### A 8 {
				if (invoker.weaponStatus[I_FLAGS] & F_UNLOAD_ONLY || !CountInv(invoker.bMagazineClass)) {
					return ResolveState("ReloadEnd");
				}
				return ResolveState("LoadMag");
			}

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
				invoker.weaponStatus[I_FLAGS] &= ~F_CHAMBER;
				invoker.weaponStatus[I_MAG] = -1;
				return ResolveState("MagOut");
			}


		Reload:
			#### A 0 {
				invoker.weaponStatus[I_FLAGS] &= ~F_UNLOAD_ONLY;
				if (!invoker.brokenChamber() && invoker.magazineGetAmmo() != -1 && !(invoker.weaponstatus[I_FLAGS] & F_UNLOAD_ONLY)) {
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

		FireAlt:
		AltFire:
			#### A 1;
			Goto Nope;

		user4:
		Unload:
			#### A 0 {
				invoker.weaponStatus[I_FLAGS] |= F_UNLOAD_ONLY;
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

				
				let rkt=gyrogrenade(spawn("HDHEAT",(
					pos.xy,
					pos.z+HDWeapon.GetShootOffset(
						self,invoker.barrellength,
						invoker.barrellength-HDCONST_SHOULDERTORADIUS
					)
				),ALLOW_REPLACE));
				A_ChangeVelocity(-cos(pitch) / 4, 0, 0, CVF_RELATIVE);
				invoker.addHeat(60);
				rkt.angle = angle;
				rkt.target = self;
				rkt.master = self;
				rkt.pitch = pitch;
				rkt.primed=false;
				rkt.isrocket=true;
				
				//A_StartSound("weapons/rpg/fire",CHAN_AUTO);
				//A_StartSound("weapons/rockboom",CHAN_AUTO);

				A_StartSound(invoker.BFireSound, CHAN_AUTO, CHANF_OVERLAP);
				A_StartSound(invoker.BClickSound, CHAN_AUTO, CHANF_OVERLAP);
				//A_StartSound("weapons/rpg/whoosh",CHAN_AUTO, CHANF_OVERLAP);

				invoker.unchamber();
				invoker.weaponStatus[I_MAG] = -1;
				return ResolveState("LightDone");
			}


		LoadMag:
			#### A 12 {
				let magRef = HDMagAmmo(FindInventory(invoker.bMagazineClass));
				if (!magRef) {
					return ResolveState("ReloadEnd");
				}

				if (magRef.mags[0] == 0) {
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