
class PlayerEvents : EventHandler {

	override void PlayerEntered(PlayerEvent e) {
		PlayerPawn pawn = players[e.PlayerNumber].mo;
		if (pawn) {
			pawn.GiveInventoryType("MiscAttachmentInput");
			pawn.GiveInventoryType("BSilencerRemover");
			pawn.GiveInventoryType("BScopeRemover");
			pawn.GiveInventoryType("BMiscRemover");
		}
	}

	bool alreadyReplaced;

	bool rollCheck() {
		int rnggo = random(0, 100);
		return rnggo >= 50;
	}

	void replaceAll(ReplaceEvent e) {
		if (e.Replacee is "ZM66Random") {
			if (b_spawn_empty_mags == 1)
				e.Replacement = "B_M4_Empty";
			else
				e.Replacement = "M4_Random_Giver";
		}
		else if (e.Replacee is "ZM66AssaultRifle" || e.Replacee is "ZM66Regular" || e.Replacee is "ZM66Semi" || e.Replacee is "ZM66Irregular") {
			if (b_spawn_empty_mags == 1) 
				e.Replacement = "B_M4_Empty";
			else
				e.Replacement = "M4_Random_Noammo_Giver";
		}
		else if (e.Replacee is "HD4mMag" || e.Replacee is "HDDirtyMagazine") {
			if (b_spawn_empty_mags == 1)
				e.Replacement = "B556MagEmpty2";	
			else
				e.Replacement = "B556Mag";
		}
		else if (e.Replacee is "HD4mmMagEmpty") {
			e.Replacement = "B556MagEmpty";	
		}
		else if (e.Replacee is "HDRL") {
			if (b_spawn_empty_mags == 1)
				e.Replacement = "B_RPG_Empty";
			else
				e.Replacement = "B_RPGLauncher";
		}
		else if (e.Replacee is "HEATAmmo") {
			e.Replacement = "BRpgRocket";
		}
		// Pistol
		else if (e.Replacee is "HDPistol" || e.Replacee is "HDAutoPistol") {
			if (b_spawn_empty_mags == 1)
				e.Replacement = "B_GLock_Empty";
			else
				e.Replacement = "Glock_Random_Noammo_Giver";
		}
		else if (e.Replacee is "HD9mMag30") {
			if (b_spawn_empty_mags == 1)
				e.Replacement = "BMp5MagEmpty2";
			else
				e.Replacement = "B9mm_MP5K_MAG";
		}
		else if (e.Replacee is "HD9mMag15") {
			if (b_spawn_empty_mags == 1)
				e.Replacement = "BGlockMagEmpty2";
			else
				e.Replacement = "GlockMagazine";
		}
		// Mp5
		else if (e.Replacee is "HDSMG") {
			if (b_spawn_empty_mags == 1)
				e.Replacement = "b_mp5_empty";
			else
				e.Replacement = "mp5_random_noammo_giver";
		}
		// Liberator
		else if (e.Replacee is "LiberatorRifle" || e.Replacee is "LiberatorNoBullpupNoGL" || e.Replacee is "LiberatorNoBullpup" || e.Replacee is "LiberatorNoGL") {
			if (b_spawn_empty_mags == 1) 
				e.Replacement = "B_M14_Empty";
			else
				e.Replacement = "M14_random_noammo_giver";
		}
		else if (e.Replacee is "LiberatorRandom") {
			if (b_spawn_empty_mags == 1) 
				e.Replacement = "B_M14_Empty";
			else
				e.Replacement = "M14_random_giver";
		}
		else if (e.Replacee is "HD7mMag") {
			if (b_spawn_empty_mags == 1)
				e.Replacement = "B762MagEmpty2";
			else
				e.Replacement = "b762_m14_mag";
		}
		// Chaingun
		else if (e.Replacee is "ChaingunReplaces") {
			if (b_spawn_empty_mags == 1)
				e.Replacement = "B_M249_Empty";
			else
				e.Replacement = "M249_Random_Giver";
		}
		// Shotgun
		else if (e.Replacee is "ShotgunReplaces" || e.Replacee is "SSGReplaces") {
			if (b_spawn_empty_mags == 1) 
				e.Replacement = "B_Fauxtech_Empty";
			else
				e.Replacement = "fauxtech_random_noammo_giver";
		}
		else if (e.Replacee is "ShellBoxPickup") {
			if (b_spawn_empty_mags == 1)
				e.Replacement = "BFauxDrumEmpty";
			else
				e.Replacement = "BFauxDrum";
		}
		else if (e.Replacee is "HDAmBox") {
			if (rollcheck()) {
				if (b_spawn_raw_resources == 1) {
					if (rollcheck()) {
						e.Replacement = "BAmBox";
					}
					else {
						e.Replacement = "BResourceBox";
					}
				}
				else {
					e.Replacement = "BAmBox";
				}
			}
		}
		else if (e.Replacee is "ClipMagPickup" || e.Replacee is "ClipBoxPickup") {
			e.Replacement = "RandomBryanPickup";
		}
		else if (e.Replacee is "DERPBot") {
			e.Replacement = "TDerpBot";
		}
		else if (e.Replacee is "DERPUsable") {
			e.Replacement = "TDERPUsable";
		}
		else if (e.Replacee is "EnemyDERP") {
			e.Replacement = "EnemyTDERP";
		}
		else if (e.Replacee is "DERPDead") {
			e.Replacement = "TDERPDead";
		}
		else if (e.Replacee is "HERPBot") {
			e.Replacement = "THerpBot";
		}
		else if (e.Replacee is "HERPUsable") {
			e.Replacement = "THERPUsable";
		}
		else if (e.Replacee is "EnemyHERP") {
			e.Replacement = "EnemyTHERP";
		}
		else if (e.Replacee is "BrokenHERP") {
			e.Replacement = "BrokenTHERP";
		}
	}

	int ticks;

	override void WorldLoaded(WorldEvent e) {
		// I'm assuming CheckReplacement is called before the world is fully loaded?
		alreadyReplaced = true;
	}

	override void WorldThingSpawned(WorldEvent e) {
		if (e.thing is "HDRocketAmmo") {
			HDRocketAmmo rkt = HDRocketAmmo(e.thing);
			rkt.itemsthatusethis.push("B_M4_M203");
			rkt.itemsthatusethis.push("B_MP5_M203");
		}
		else if (e.thing is "HDBattery") {
			HDBattery bat = HDBattery(e.thing);
			bat.itemsthatusethis.push("THERPUsable");
			bat.itemsthatusethis.push("TDERPUsable");
		}
		else if (e.thing is "HDPistolAmmo") {
			HDPistolAmmo b9m = HDPistolAmmo(e.thing);
			b9m.itemsthatusethis.push("B_GLock");
			b9m.itemsthatusethis.push("B_MP5");
		}
		else if (e.thing is "HDShellAmmo") {
			HDShellAmmo shl = HDShellAmmo(e.thing);
			shl.itemsthatusethis.push("b_FauxtechOrigin");
		}
		else if (e.thing is "HEATAmmo") {
			HEATAmmo het = HEATAmmo(e.thing);
			het.itemsthatusethis.push("B_RPGLauncher");
		}

		// Barrels spawn raw resources if resource mode on
		if (b_spawn_raw_resources == 1) {
			//console.printf("spawn thing %s", e.thing.getClassName());

			if (e.thing is "HDBarrel") {

				HDBarrel bar = HDBarrel(e.thing);
				int moreRng = random(0, 100) > 50;

				if (moreRng) {
					int rng = random(1, 30);
					for (int i = 0; i < rng; i++) {
						let pickup = RandomSmallResourcePickup.Spawn("RandomSmallResourcePickup", e.thing.pos);
						pickup.vel += (
							random(-5, 5),
							random(-5, 5),
							random(2, 20)
						);
					}
				}
				else {
					int benchRng = random(0, 100);
					if (benchRng < 25) {
						let bench = Actor.Spawn("RandomCraftingBench", e.thing.pos);
						bench.vel += (
							random(-2, 2),
							random(-2, 2),
							random(2, 4)
						);
					}
					else {
						int rng = random(1, 2);
						for (int i = 0; i < rng; i++) {
							let pickup = RandomSmallResourcePickup.Spawn("RandomResourcePickup", e.thing.pos);
							pickup.vel += (
								random(-2, 2),
								random(-2, 2),
								random(2, 4)
							);
						}
					}
				}

			}
		}
	}

	override void CheckReplacement(ReplaceEvent e) {
		if (B_Replace_Type == 5) {
			replaceAll(e);
		}
		else if (B_Replace_Type == 6 && alreadyReplaced == false) {
			replaceAll(e);
		}
	}

	void createLight(PlayerPawn pl) {
		let lightnPos = pl.pos + (0, 0, 48);
		lightNear = PointLight(Actor.Spawn("PointLight", lightnPos));
		lightNear.args[0] = 100;
		lightNear.args[1] = 100;
		lightNear.args[2] = 100;
		lightNear.args[3] = 48;

		let lightcPos = pl.pos + (0, 0, 0);
		lightCone = SpotLight(Actor.Spawn("SpotLight", lightcPos));
		lightCone.args[0] = 255;
		lightCone.args[1] = 255;
		lightCone.args[2] = 255;
		lightCone.args[3] = 512;
		lightCone.SpotInnerAngle = 1;
		lightCone.SpotOuterAngle = 35;
	}

	void adjustPosition(int index) {
		PlayerInfo info = players[index];
		PlayerPawn pawn = info.mo;
		if (pawn) {
			lightNear.setXYZ(pawn.pos + (0, 0, 16));
			lightCone.setXYZ(pawn.pos + (0, 0, 48));
			lightCone.angle = pawn.angle;
			lightCone.pitch = pawn.pitch;
		}
	}

	void checkPlayer(int index) {
		PlayerInfo info = players[index];
		PlayerPawn pawn = info.mo;
		if (!pawn) {
			return;
		}

		if (info.ReadyWeapon is "BHDWeapon") {
			BHDWeapon wep = BHDWeapon(info.ReadyWeapon);
			if (wep.flashlight && wep.flashlightOn) {
				if (!lightNear) {
					createLight(pawn);
				}
				adjustPosition(index);
			}
			else {
				if (lightNear) {
					lightNear.destroy();
					lightCone.destroy();
				}
			}
		}
	}

	override void WorldTick() {
		super.WorldTick();

		checkPlayer(0);
	}

	PointLight lightNear;
	SpotLight lightCone;



}