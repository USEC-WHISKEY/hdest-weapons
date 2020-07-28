
class B_M16_Flashlight : BaseMiscAttachment {
	default {
		BaseAttachment.MountId "NATO_RAILS";
		BaseAttachment.SerialId B_FLASHLIGHT_ID;
		BaseAttachment.BaseSprite "FLMR";
		BaseAttachment.BaseFrame 0;
		BaseMiscAttachment.OnSprite "FLMR";
		BaseMiscAttachment.OnFrame 1;
		BaseMiscAttachment.EventClass "B_Flashlight_Event";
		HDPickup.Bulk 1;
		HDPickup.RefId "gfl";
		Tag "Flashlight";
		Inventory.Icon "MISPA0";
		Inventory.PickupMessage "Picked up a flashlight mount";
	}

	States {
		Spawn:
			MISP A -1;
			Stop;

		OverlayImage:
			FLMR A -1;
			FLMR B -1;
			Stop;
	}
}


class FlashSpotLight : SpotLight {

	int playerOwner;

	double pitchTarget;
	double pitchNow;
	double pitchDirection;

	double prev;
	double bTarget;
	double bNow;
	double bDirection;

	void adjustPitch() {
		pitchNow += pitchDirection;
		if (pitchDirection > 0 && pitchNow > pitchTarget) {
			pitchNow = pitchTarget;
		}
		else if (pitchDirection < 0 && pitchNow < pitchTarget) {
			pitchNow = pitchTarget;
		}
	}

	void setLightTarget(double target) {
		if (target < bTarget) {
			bDirection = 1;
		}
		else if (target > bTarget) {
			bDirection = -1;
		}
		bTarget = target * -1;
	}

	void adjustLightTarget() {
		bNow += bDirection;
		if (bDirection > 0 && bNow > bTarget) {
			bNow = bTarget;
		}
		else if (bDirection < 0 && bNow < bTarget) {
			bNow = bTarget;
		}
	}

	override void BeginPlay() {
		playerOwner = -1;
	}

	override void Tick() {
		if (playerOwner > -1) {
			PlayerInfo info = players[playerOwner];
			if (!info.mo) {
				return;
			}
			//console.printf("pointer %p %s", info.readyWeapon, info.readyWeapon.getClassName());
			HDPlayerPawn ply = HDPlayerPawn(info.mo);
			BHDWeapon weapon = BHDWeapon(info.readyWeapon);
			if (info.mo) {
				if (weapon && !weapon.miscActive) {
					self.destroy();
					return;
				}
				bool isbhd = info.readyWeapon is "BHDWeapon";
				bool isnull = info.readyWeapon is "NullWeapon";
				if (!isbhd) {
					if (!isnull) {
						self.destroy();
						return;
					}
				}

				let newPos = info.mo.pos + (0, 0, info.mo.height);
				newPos.z -= (ply.hudbob.y / 2.0);
				SetOrigin(newPos, true);
				A_SetAngle(info.mo.angle - ply.hudbob.x, SPF_INTERPOLATE);

				if (info.cmd.buttons & BT_SPEED) {
					pitchDirection = 1;
					pitchTarget = 30;
					adjustPitch();
				}
				else {
					pitchDirection = -5;
					pitchTarget = 0;
					adjustPitch();
				}
				A_SetPitch(info.mo.pitch + pitchNow, SPF_INTERPOLATE);
			}
		}
		super.tick();
	}

}

class FlashLightManager : EventHandler {

	Array<FlashSpotLight> spotLights;

	override void OnRegister() {
		for (int i = 0; i < 8; i++) {
			spotLights.push(null);
		}
	}

	override void WorldTick() {
		for (int i = 0; i < 8; i++) {
			PlayerInfo info = players[i];
			if (!info.mo) continue;
			SpotLight light = spotLights[i];
			BHDWeapon weapon = BHDWeapon(info.readyWeapon);
			if (!light && weapon && weapon.miscActive) {
				weapon.miscActive = false;
			}
		}
	}


	void createLight(BHDWeapon weapon, PlayerPawn player) const {
		let newPos = player.pos + (0, 0, 48);
		let light = FlashSpotLight(player.Spawn("FlashSpotLight", player.pos));
		light.playerOwner = player.PlayerNumber();
		spotLights[player.PlayerNumber()] = light;
		light.args[0] = 205;
		light.args[1] = 221;
		light.args[2] = 238;
		light.args[3] = 512;
		light.SpotOuterAngle = 40;
	}

	void destroyLight(BHDWeapon weapon, PlayerPawn player) const {
		SpotLight light = spotLights[player.PlayerNumber()];
		if (light) {
			light.destroy();
		}
	}

	void destLight(int index) const {
		SpotLight light = spotLights[index];
		if (light) {
			light.destroy();
		}
	}

}

class B_Flashlight_Event : BaseMiscAttachmentEvent {

	override bool onUsed(Class<BaseMiscAttachment> cls, BHDWeapon weapon, PlayerPawn player) {
		// Toggles On or off image, depending
		super.onUsed(cls, weapon, player);
		FlashLightManager mgr = FlashLightManager(EventHandler.Find("FlashLightManager"));
		weapon.A_StartSound(weapon.bClickSound, CHAN_WEAPON, CHANF_OVERLAP);
		if (weapon.miscActive) {
			mgr.createLight(weapon, player);
		}
		else {
			mgr.destroyLight(weapon, player);
		}
		return true;
	}

}
