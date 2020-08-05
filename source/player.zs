
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
		else if (e.Replacee is "ChaingunReplaces" || e.Replacee is "Vulcanette") {
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
		alreadyReplaced = true;

		if (b_spawn_raw_resources != 1) {
			return;
		}

		ThinkerIterator allActors = ThinkerIterator.create("Actor");
		Array<Actor> decorations;
		Actor next;

		while (next = Actor(allActors.next())) {
			if (next is "HDTorchTree" || 
				next is "HDTechPillar" || 
				next is "HDTallRedColumn" || 
				next is "HDTallGreenColumn" || 
				next is "HDStalagtite" || 
				next is "HDStalagmite" || 
				next is "HDSkullColumn" || 
				next is "HDShortRedColumn" || 
				next is "HDShortGreenColumn" || 
				next is "HDHeartColumn" || 
				next is "HDFloatingSkull" || 
				next is "HDEvilEye" || 
				next is "HDBigTree" || 
				next is "HDDeadStick" || 
				next is "HDHeadCandles" || 
				next is "HDHeadsStick" || 
				next is "HDHTLkUp" || 
				next is "HDHTNoGuts" || 
				next is "HDHTSkull" || 
				next is "HDMt3NS" || 
				next is "HDMt4NS" || 
				next is "HDMt5" || 
				next is "HDMt5NS" || 
				next is "HDTwitchHang" || 
				next is "SmallBloodPool" || 
				next is "Gibs" || 
				next is "ColonGibs" || 
				next is "BrainStem" || 
				next is "ReallyDeadRifleman" || 
				next is "ReallyDeadRiflemanCrouched" ||
				next is "DeadTrilobite" ||
				next is "DeadRifleman" ||
				next is "DeadImpSpawner" ||
				next is "DeadHideousShotgunGuy" ||
				next is "DeadDemonSpawner" ||
				next is "DeadZombieStormtrooper" ||
				next is "Candlestick" ||
				next is "HDBlueTorch" ||
				next is "HDCandelabra" ||
				next is "HDColumn" ||
				next is "HDGreenTorch" ||
				next is "HDRedTorch" ||
				next is "HDShortBlueTorch" ||
				next is "HDShortGreenTorch" ||
				next is "HDShortRedTorch" ||
				next is "HDTechLamp" ||
				next is "HDTechLamp2" ||
				next is "HDBarrel") {
				decorations.push(next);
			}
		} 

		// No decorations, no spawns 
		if (decorations.size() < 2) {
			return;
		}

		Actor rngLoc1 = decorations[random(0, decorations.size() - 1)];
		Actor rngLoc2 = decorations[random(0, decorations.size() - 1)];
		while (rngLoc1 == rngLoc2) {
			rngLoc2 = decorations[random(0, decorations.size() - 1)];
		}

		let bench1 = Actor.Spawn("RandomCraftingBench", rngLoc1.pos);
		let bench2 = Actor.Spawn("RandomCraftingBench", rngLoc2.pos);
		bench1.vel += (random(-8, 8), random(-8, 8), random(8, 16));
		bench2.vel += (random(-8, 8), random(-8, 8), random(8, 16));

		// Now the resources
		int pings = random(0, decorations.size());
		for (int i = 0; i < pings; i++) {
			Actor nextDeco = decorations[random(0, decorations.size() - 1)];

			bool bigOrSmall = random(0, 100) >= 50;
			Actor thingy;
			if (bigOrSmall) {
				thingy = Actor.Spawn("RandomResourcePickup", nextDeco.pos);
			}
			else {
				thingy = Actor.SPawn("RandomSmallResourcePickup", nextDeco.pos);
			}
			if (thingy) {
				thingy.vel += (random(-8, 8), random(-8, 8), random(8, 16));
			}

		}
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