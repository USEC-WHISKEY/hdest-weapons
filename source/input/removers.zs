class BSilencerRemover : Inventory {
	default {
		Inventory.MaxAmount 1;
		Inventory.Icon "SL56E0";
		tag "Silencer Remover";
	}

	override bool Use(bool pickup) {
		PlayerInfo info = players[owner.playerNumber()];
		if (info.readyWeapon && info.readyWeapon is "BHDWeapon") {
			BHDWeapon weapon = BHDWeapon(info.readyWeapon);
			if (weapon.attachmentBusy) {
				return false;
			}
			if (weapon.getBarrelSerialID() > 0) {
				info.mo.GiveInventory(weapon.barrelClass, 1);
				owner.player.SetPSprite(PSP_WEAPON, info.readyWeapon.FindState("BarrelAttachmentRemove"));
			}
		}
		return false;
	}

	States {
		Spawn:
			SL56 E -1;
			Stop;
		
	}
}

class BScopeRemover : Inventory {
	default {
		Inventory.MaxAmount 1;
		Inventory.Icon "SCOPD0";
		tag "Scope Remover";
	}

	override bool Use(bool pickup) {
		PlayerInfo info = players[owner.playerNumber()];
		if (info.readyWeapon && info.readyWeapon is "BHDWeapon") {
			BHDWeapon weapon = BHDWeapon(info.readyWeapon);
			if (weapon.attachmentBusy) {
				return false;
			}
			if (weapon.getScopeSerialID() > 0) {
				info.mo.GiveInventory(weapon.scopeClass, 1);
				owner.player.SetPSprite(PSP_WEAPON, info.readyWeapon.FindState("ScopeAttachmentRemove"));
			}
		}
		return false;
	}

	States {
		Spawn:
			SCOP D -1;
			Stop;
		
	}
}

class BMiscRemover : Inventory {
	default {
		Inventory.MaxAmount 1;
		Inventory.Icon "FLMRD";
		tag "Scope Remover";
	}

	override bool Use(bool pickup) {
		PlayerInfo info = players[owner.playerNumber()];
		if (info.readyWeapon && info.readyWeapon is "BHDWeapon") {
			BHDWeapon weapon = BHDWeapon(info.readyWeapon);
			if (weapon.attachmentBusy) {
				return false;
			}
			if (weapon.getMiscSerialID() > 0) {
				info.mo.GiveInventory(weapon.miscClass, 1);
				owner.player.SetPSprite(PSP_WEAPON, info.readyWeapon.FindState("MiscAttachmentRemove"));
			}
		}
		return false;
	}

	States {
		Spawn:
			FLMR D -1;
			Stop;
		
	}
}