
class BasePistol : BaseStandardRifle {

	action state GetMagStatePistol() {
		if (invoker.magazineGetAmmo() > 0) {
			return ResolveState("SpawnMag");
		}
		return ResolveState("SpawnNoMag");
		
	}

	override void DrawSightPicture(HDStatusBar sb, HDWeapon hdw, HDPlayerPawn hpl, bool sightbob, vector2 bob, double fov, bool scopeview, actor hpc, string whichdot) {

		PlayerInfo info = players[hpl.playernumber()];
		BHDWeapon basicWep = BHDWeapon(hdw);

		vector2 scc;
		vector2 bobb=bob*1.6;
		double dotoff = max(abs(bob.x), abs(bob.y));

		int cx,cy,cw,ch;
		[cx,cy,cw,ch]=screen.GetClipRect();

		if(hpl.player.getpsprite(PSP_WEAPON).frame == 1){
			//sb.SetClipRect(-40 + bob.x, -5 + bob.y, 20, 14, sb.DI_SCREEN_CENTER );
			scc=(0.8,0.9);
			bobb.y=clamp(bobb.y*1.1-3,-10,10);
		}else{
			//sb.SetClipRect(-8 + bob.x, -4 + bob.y, 16, 10, sb.DI_SCREEN_CENTER);
			scc=(0.7,0.7);
			bobb.y=clamp(bobb.y,-8,8);
		}

		sb.drawImage(getFrontSightImage(hpl), getFrontSightOffsets() + bobb * 3, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, alpha: 0.9 - dotoff * 0.3, scale: scc);

		//sb.SetClipRect(cx,cy,cw,ch);
		sb.drawimage(getBackSightImage(hpl), getBackSightOffsets() + bob, sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, scale:scc);

		//sb.drawImage("calib", (0, 0), sb.DI_SCREEN_CENTER | sb.DI_ITEM_CENTER, alpha: 0.3);


	}




	states {
		ShootGun:
			#### A 0 {
				if (invoker.fireMode() > 0) {
					A_SetTics(invoker.bROF);
				}
			}
			#### A 1 {
				if (invoker.brokenChamber() || (!invoker.chambered() && invoker.magazineGetAmmo() < 1)) {
					return ResolveState("Nope");
				}
				else if (!invoker.chambered()) {
					return ResolveState("Chamber_Manual");
				}
				else {
					A_Overlay(invoker.bLayerGun, "LayerGunFire");
					A_Overlay(-500, "Flash");
					A_WeaponReady(WRF_NONE);
					if (invoker.weaponStatus[I_AUTO] >= 2) {
						invoker.weaponStatus[I_AUTO]++;
					}
					return ResolveState(NULL);
				}

			}
			#### B 1;
			#### B 0 {
				return ResolveState("Chamber");
			}


		UnloadChamber:
			#### A 1 Offset(-3, 34);
			#### A 1 Offset(-9, 39);
			#### A 3 Offset(-19, 44) ;//A_MuzzleClimb(frandom(-.4, .4), frandom(-.4, .4));
			#### B 2 Offset(-16, 42) {
				//A_MuzzleClimb(frandom(-.4, .4), frandom(-.4, .4));
				if (invoker.chambered() && !invoker.brokenChamber()) {
					A_StartSound(invoker.BboltBackwardSound, CHAN_WEAPON, CHANF_OVERLAP);
					A_SpawnItemEx(invoker.BAmmoClass, 0, 0, 20, random(4, 7), random(-2, 2), random(-2, 1), 0, SXF_NOCHECKPOSITION);
					invoker.WeaponStatus[I_FLAGS] &= ~F_CHAMBER;
					//A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
				}
				else {
					invoker.weaponStatus[I_FLAGS] &= ~F_CHAMBER_BROKE;
					invoker.weaponStatus[I_FLAGS] &= ~F_CHAMBER;
					A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
					A_SpawnItemEx("DeformedAmmo", 0, 0, 20, random(4, 7), random(-2, 2), random(-2, 1), 0, SXF_NOCHECKPOSITION);
				}
				return ResolveState("ReloadEnd");
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
				//A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				//A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
				//A_StartSound(invoker.bClickSound, CHAN_WEAPON);
				A_StartSound(invoker.bUnloadSound, CHAN_WEAPON);
				return ResolveState(NULL);
			}
			#### A 4 Offset(0, 40) {
				//A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				//A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
				
			}
			#### A 20 offset(0, 44) {
				
				int inMag = invoker.magazineGetAmmo();
				if (inMag > (invoker.bMagazineCapacity + 1)) {
					inMag %= invoker.bMagazineCapacity;
				}

				invoker.weaponStatus[I_MAG] = -1;
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
			#### A 2 Offset(0, 44);
			#### A 2 Offset(0, 43);
			#### A 8 Offset(0, 35) A_StartSound(invoker.bLoadSound, CHAN_WEAPON);
			#### A 2 Offset(0, 43);
			#### A 1 Offset(0, 44) {
				let magRef = HDMagAmmo(FindInventory(invoker.bMagazineClass));
				if (magRef) {
					invoker.weaponStatus[I_MAG] = magRef.TakeMag(true);
				}
				return ResolveState("ReloadEnd");
			}

		Chamber_Manual:
			#### C 0 { 
				if (invoker.chambered() || invoker.magazineGetAmmo() <= -1) {
					return ResolveState("Nope");
				}
				return ResolveState(NULL);
			}
			#### C 3 Offset(-1, 36) A_WeaponBusy();
			#### D 3 Offset(-1, 40) {
				int ammo = invoker.magazineGetAmmo();
				if (!invoker.chambered() && ammo % 999 > 0) {
					if (ammo > invoker.bMagazineCapacity) {
						invoker.weaponStatus[I_MAG] = invoker.bMagazineCapacity - 1;
					}
					else {
						invoker.magazineAddAmmo(-1);
					}
					invoker.setChamber();
					return ResolveState(NULL);
				}
				//console.printf("noping");
				return ResolveState("Nope");
			}
			#### E 3 offset(-1, 46) {
				A_Overlay(invoker.bLayerGun, "LayerGunBolt");
			}
			#### D 3 offset(0, 36) {
				A_StartSound(invoker.bBoltForwardSound, CHAN_WEAPON, CHANF_OVERLAP);
			}
			#### A 0 offset(0, 34) {
				return ResolveState("Nope");
			}


		ReloadEnd:
			#### A 2 Offset(0, 39);
			#### A 1 Offset(0, 37); // A_MuzzleClimb(frandom(0.2, -2.4), frandom(-0.2, -1.4));
			#### A 0 A_CheckCookoff();
			#### A 1 Offset(0, 34);
			#### A 0 {
				return ResolveState("Chamber_Manual");
			}

	}
	
}