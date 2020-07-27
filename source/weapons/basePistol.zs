
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

		if(hpl.player.getpsprite(PSP_WEAPON).frame>=2){
			//sb.SetClipRect(-40 + bob.x, -5 + bob.y, 20, 14, sb.DI_SCREEN_CENTER );
			scc=(0.7,0.8);
			bobb.y=clamp(bobb.y*1.1-3,-10,10);
		}else{
			//sb.SetClipRect(-8 + bob.x, -4 + bob.y, 16, 10, sb.DI_SCREEN_CENTER);
			scc=(0.8,0.8);
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
			#### A 1;
			#### B 0 {
				return ResolveState("Chamber");
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
				A_StartSound(invoker.bClickSound, CHAN_WEAPON);
				return ResolveState(NULL);
			}
			#### A 4 Offset(0, 40) {
				//A_SetPitch(pitch - 0.3, SPF_INTERPOLATE);
				//A_SetAngle(angle - 0.3, SPF_INTERPOLATE);
				
			}
			#### A 20 offset(0, 44) {
				A_StartSound(invoker.bUnloadSound, CHAN_WEAPON);
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
			#### A 1 Offset(0, 44) {
				let magRef = HDMagAmmo(FindInventory(invoker.bMagazineClass));
				if (magRef) {
					invoker.weaponStatus[I_MAG] = magRef.TakeMag(true);
					A_StartSound(invoker.bLoadSound, CHAN_WEAPON);
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

	}
	
}