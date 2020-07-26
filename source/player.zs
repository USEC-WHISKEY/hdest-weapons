
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

	override void CheckReplacement(ReplaceEvent e) {
		if (B_Replace_Type == 2) {
			
		}
		else if (B_Replace_Type == 5) {
			// M4
			if (e.Replacee is "ZM66Random") {
				e.Replacement = "M4_Random_Giver";
			}
			else if (e.Replacee is "ZM66AssaultRifle" || e.Replacee is "ZM66Regular" || e.Replacee is "ZM66Semi") {
				e.Replacement = "M4_Random_Noammo_Giver";
			}
			else if (e.Replacee is "HD4mMag") {
				e.Replacement = "B556Mag";
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
			// RPG
			else if (e.Replacee is "HDRL") {
				e.Replacement = "Rpg_Random_Giver";
			}
			else if (e.Replacee is "HEATAmmo") {
				e.Replacement = "BRpgRocket";
			}
			// Shotgun
			else if (e.Replacee is "ShotgunReplaces" || e.Replacee is "SSGReplaces") {
				e.Replacement = "fauxtech_random_noammo_giver";
			}
			else if (e.Replacee is "ShellBoxPickup") {
				e.Replacement = "BFauxDrum";
			}
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