
class BaseShotgun : BaseStandardRifle {
	
	states {

		UnloadChamber:
			#### A 1 Offset(-3, 34);
			#### A 1 Offset(-9, 39);
			#### A 3 Offset(-19, 44) ;//A_MuzzleClimb(frandom(-.4, .4), frandom(-.4, .4));
			#### B 2 Offset(-16, 42) {
				//A_MuzzleClimb(frandom(-.4, .4), frandom(-.4, .4));
				if (invoker.chambered() && !invoker.brokenChamber()) {
					A_SpawnItemEx(invoker.BAmmoClass, 0, 0, 20, random(4, 7), random(-2, 2), random(-2, 1), 0, SXF_NOCHECKPOSITION);
					invoker.WeaponStatus[I_FLAGS] &= ~F_CHAMBER;
				}
				else {
					invoker.weaponStatus[I_FLAGS] &= ~F_CHAMBER_BROKE;
					invoker.weaponStatus[I_FLAGS] &= ~F_CHAMBER;
					A_StartSound(invoker.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
					A_SpawnItemEx("DeformedShell", 0, 0, 20, random(4, 7), random(-2, 2), random(-2, 1), 0, SXF_NOCHECKPOSITION);
				}
				return ResolveState("ReloadEnd");
			}
	
		Flash:
			TNT1 A 0 {
				if (!(invoker.barrelClass is "BaseFlashAttachment") && !(invoker.barrelClass is "BaseSilencerAttachment")) {
					let psp = player.FindPSprite(-1000);
					if (psp) {
						psp.sprite = GetSpriteIndex("FLSHA0");
						psp.frame = random(5, 8);
					}
				}
			}
			
			#### # 1 Bright {
				if (!(invoker.barrelClass is "BaseFlashAttachment") && !(invoker.barrelClass is "BaseSilencerAttachment")) {
					A_Light1();
					HDFlashAlpha(-16);
				}

				bool silenced = invoker.barrelClass is "BaseSilencerAttachment";
				string sound = silenced ? invoker.bSFireSound : invoker.bFireSound;

				A_StartSound(sound, CHAN_WEAPON, CHANF_OVERLAP);
				A_ZoomRecoil(max(0.95, 1. -0.05 * invoker.fireMode()));
				double burn = max(invoker.heatAmount(), invoker.boreStretch()) * 0.01;
				//HDBulletActor.FireShell(self, invoker.bBulletClass, spread: burn > 1.2 ? burn : 0);
				//HDSHellCLasses.FireShell(self, 0, )
				//A_FireHDShotgun(0, 0, invoker.barrelLength, true);

				HDBulletActor.FireBullet(self, "HDB_wad");
				let p = HDBulletActor.FireBullet(self, invoker.bBulletClass, spread: random(-10, 20), speedfactor: 1.0, amount: 15);
				double muzzleMul = 1.0;
				if (invoker.weaponstatus[I_AUTO] == 1) {
					muzzleMul = 1.8;
				}
				A_MuzzleClimb(
					-frandom(0.1,0.1), -frandom(0,0.1),
					-0.2,              -frandom(0.3,0.4),
					frandom(invoker.BRecoilXLow, invoker.BRecoilXHigh) * muzzleMul, 
					-frandom(invoker.BRecoilYLow, invoker.BRecoilYHigh) * muzzleMul
				);
				//invoker.addHeat(random(3, 5));
				invoker.unchamber();

				double fc = max(pitch * 0.01, 5);
				double cosp = cos(pitch);

				// Todo: Make it not constantly be in your face 
				//       create property to spawn this bullet
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

				A_AlertMonsters();
			}
			#### # 0 { 
				return ResolveState("LightDone");
			}
	}
}