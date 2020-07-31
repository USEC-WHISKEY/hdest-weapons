
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

	void replaceHalf(ReplaceEvent e) {
		if (e.Replacee is "ZM66Random") {
			if (rollCheck())
				e.Replacement = "M4_Random_Giver";
		}
		else if (e.Replacee is "ZM66AssaultRifle" || e.Replacee is "ZM66Regular" || e.Replacee is "ZM66Semi") {
			if (rollCheck())
				e.Replacement = "M4_Random_Noammo_Giver";
		}
		else if (e.Replacee is "HD4mMag") {
			if (rollCheck())
				e.Replacement = "B556Mag";
		}
		else if (e.Replacee is "HDRL") {
			e.Replacement = "B_RPGLauncher";
		}
		// Pistol
		else if (e.Replacee is "HDPistol" || e.Replacee is "HDAutoPistol") {
			if (rollCheck())
				e.Replacement = "Glock_Random_Noammo_Giver";
		}
		else if (e.Replacee is "HD9mMag30") {
			if (rollCheck())
				e.Replacement = "B9mm_MP5K_MAG";
		}
		else if (e.Replacee is "HD9mMag15") {
			if (rollCheck())
				e.Replacement = "GlockMagazine";
		}
		// Mp5
		else if (e.Replacee is "HDSMG") {
			if (rollCheck())
				e.Replacement = "mp5_random_noammo_giver";
		}
		// Liberator
		else if (e.Replacee is "LiberatorRifle" || e.Replacee is "LiberatorNoBullpupNoGL" || e.Replacee is "LiberatorNoBullpup" || e.Replacee is "LiberatorNoGL") {
			if (rollCheck())
				e.Replacement = "M14_random_noammo_giver";
		}
		else if (e.Replacee is "LiberatorRandom") {
			if (rollCheck())
				e.Replacement = "M14_random_giver";
		}
		else if (e.Replacee is "HD7mMag") {
			if (rollCheck())
				e.Replacement = "b762_m14_mag";
		}
		// Chaingun
		else if (e.Replacee is "ChaingunReplaces") {
			if (rollCheck())
				e.Replacement = "M249_Random_Giver";
		}
		// Shotgun
		else if (e.Replacee is "ShotgunReplaces" || e.Replacee is "SSGReplaces") {
			if (rollCheck())
				e.Replacement = "fauxtech_random_noammo_giver";
		}
		else if (e.Replacee is "ShellBoxPickup") {
			if (rollCheck())
				e.Replacement = "BFauxDrum";
		}
		//
		else if (e.Replacee is "HDAmBox") {
			if (rollcheck()) {
				if (rollcheck()) {
					e.Replacement = "BAmBox";
				}
				else {
					e.Replacement = "BResourceBox";
				}
			}
		}
		else if (e.Replacee is "ClipMagPickup" || e.Replacee is "ClipBoxPickup") {
			if (rollCheck())
				e.Replacement = "RandomBryanPickup";
		}
		else if (e.Replacee is "DERPBot") {
			if (rollCheck())
			e.Replacement = "TDerpBot";
		}
		else if (e.Replacee is "DERPUsable") {
			if (rollCheck())
			e.Replacement = "TDERPUsable";
		}
		else if (e.Replacee is "EnemyDERP") {
			if (rollCheck())
			e.Replacement = "EnemyTDERP";
		}
		else if (e.Replacee is "DERPDead") {
			if (rollCheck())
			e.Replacement = "TDERPDead";
		}

		else if (e.Replacee is "HERPBot") {
			if (rollCheck())
			e.Replacement = "THerpBot";
		}
		else if (e.Replacee is "HERPUsable") {
			if (rollCheck())
			e.Replacement = "THERPUsable";
		}
		else if (e.Replacee is "EnemyHERP") {
			if (rollCheck())
			e.Replacement = "EnemyTHERP";
		}
		else if (e.Replacee is "BrokenHERP") {
			if (rollCheck())
			e.Replacement = "BrokenTHERP";
		}
	}

	void replaceAll(ReplaceEvent e) {
		if (e.Replacee is "ZM66Random") {
			e.Replacement = "M4_Random_Giver";
		}
		else if (e.Replacee is "ZM66AssaultRifle" || e.Replacee is "ZM66Regular" || e.Replacee is "ZM66Semi" || e.Replacee is "ZM66Irregular") {
			
			e.Replacement = "M4_Random_Noammo_Giver";
		}
		else if (e.Replacee is "HD4mMag" || e.Replacee is "HDDirtyMagazine") {
			
			e.Replacement = "B556Mag";
		}
		else if (e.Replacee is "HD4mmMagEmpty") {
			e.Replacement = "B556MagEmpty";	
		}
		else if (e.Replacee is "HDRL") {
			e.Replacement = "B_RPGLauncher";
		}
		// Pistol
		else if (e.Replacee is "HDPistol" || e.Replacee is "HDAutoPistol") {
			e.Replacement = "Glock_Random_Noammo_Giver";
		}
		else if (e.Replacee is "HD9mMag30") {
			e.Replacement = "B9mm_MP5K_MAG";
		}
		else if (e.Replacee is "HD9mMag15") {
			e.Replacement = "GlockMagazine";
		}
		// Mp5
		else if (e.Replacee is "HDSMG") {
			e.Replacement = "mp5_random_noammo_giver";
		}
		// Liberator
		else if (e.Replacee is "LiberatorRifle" || e.Replacee is "LiberatorNoBullpupNoGL" || e.Replacee is "LiberatorNoBullpup" || e.Replacee is "LiberatorNoGL") {
			e.Replacement = "M14_random_noammo_giver";
		}
		else if (e.Replacee is "LiberatorRandom") {
			e.Replacement = "M14_random_giver";
		}
		else if (e.Replacee is "HD7mMag") {
			e.Replacement = "b762_m14_mag";
		}
		// Chaingun
		else if (e.Replacee is "ChaingunReplaces") {
			e.Replacement = "M249_Random_Giver";
		}
		// Shotgun
		else if (e.Replacee is "ShotgunReplaces" || e.Replacee is "SSGReplaces") {
			e.Replacement = "fauxtech_random_noammo_giver";
		}
		else if (e.Replacee is "ShellBoxPickup") {
			e.Replacement = "BFauxDrum";
		}
		else if (e.Replacee is "HDAmBox") {
			if (rollcheck()) {
				if (rollcheck()) {
					e.Replacement = "BAmBox";
				}
				else {
					e.Replacement = "BResourceBox";
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