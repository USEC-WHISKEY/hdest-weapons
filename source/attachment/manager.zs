
class Offset : Actor {
	property WeaponClass: weaponClass;
	property WeaponOverlay: weaponOverlay;
	property OffX: offx;
	property OffY: offy;
	string weaponClass;
	string weaponOverlay;
	int offx;
	int offy;
}

class BarrelOffset : Offset {}
class MiscOffset : Offset {}
class ScopeOffset : Offset {}

class AttachmentManager : EventHandler {

	Array<Class<BaseBarrelAttachment> > barrelAttachments;
	Array<Class<BaseMiscAttachment> > miscAttachments;
	Array<Class<BaseSightAttachment> > scopeAttachments;

	Array<Class<BarrelOffset> > barrelOffsets;
	Array<Class<ScopeOffset> > scopeOffsets;
	Array<Class<MiscOffset> > miscOffsets;

	// what was I thinking
	Vector2 origin;
	Weapon curr;
	Weapon prev;

	override void NetworkProcess (ConsoleEvent e) {
		let player = players[e.Player].mo;
		if (player) {
			Array<string> command;
			e.Name.Split(command, ":");
			if (command.size() != 2) {
				return;
			}

			if (command[0] == "removeattachment") {
				if (command[1] == "scope") {
					player.UseInventory(player.FindInventory("BScopeRemover"));
					player.GiveInventoryType("BScopeRemover");
				}
				else if (command[1] == "misc") {
					player.UseInventory(player.FindInventory("BMiscRemover"));
					player.GiveInventoryType("BMiscRemover");
				}
				else if (command[1] == "barrel") {
					player.UseInventory(player.FindInventory("BSilencerRemover"));
					player.GiveInventoryType("BSilencerRemover");
				}
			}
		}


	}

	override void WorldThingDied(WorldEvent e) {
		if (e.thing is "PlayerPawn") {
			PlayerPawn player = PlayerPawn(e.thing);
			//player.A_ClearOverlays(LAYER_BARREL, LAYER_BARREL);
			//player.A_ClearOverlays(LAYER_SCOPE, LAYER_SCOPE);
			//player.A_ClearOverlays(LAYER_MISC, LAYER_MISC);

			PlayerInfo info = players[player.PlayerNumber()];
			if (info.readyWeapon && info.readyWeapon is "BHDWeapon") {
				BHDWeapon wep = BHDWeapon(info.readyWeapon);
				//wep.scopeClass = null;
				//wep.setScopeSerialId(0);
				//wep.setBarrelSerialId(0);
				//wep.setMiscSerialId(0);
				//player.A_ClearOverlays(-1000, 1000);
				//player.A_ClearOverlays(LAYER_BARREL, LAYER_BARREL);
				//player.A_ClearOverlays(LAYER_SCOPE, LAYER_SCOPE);
				//player.A_ClearOverlays(LAYER_MISC, LAYER_MISC);
			}
		}
	}

	override void WorldTick() {



		for(int i = 0; i < 8; i++) {
			PlayerInfo info = players[i];
			PlayerPawn pawn = info.mo;
			if (!pawn) {
				return;
			}

			if (!(info.readyWeapon is "BHDWeapon")) {
				info.mo.A_OverlayOffset(LAYER_BARREL, 999, 999);
				return;
			}

			if (info.readyWeapon is "BHDWeapon") {
				BHDWeapon weapon = BHDWeapon(info.readyWeapon);

				if (weapon.barrelClass) {
					if (!pawn.CountInv("BSilencerRemover")) {
						pawn.GiveInventoryType("BSilencerRemover");
					}
				}
				else {
					if (pawn.CountInv("BSilencerRemover")) {
						pawn.TakeInventory("BSilencerRemover", 1);
					}
				}

				if (weapon.scopeClass) {
					if (!pawn.CountInv("BScopeRemover")) {
						pawn.GiveInventoryType("BScopeRemover");
					}
				}
				else {
					if (pawn.CountInv("BScopeRemover")) {
						pawn.TakeInventory("BScopeRemover", 1);
					}
				}

				if (weapon.miscClass) {
					if (!pawn.CountInv("BMiscRemover")) {
						pawn.GiveInventoryType("BMiscRemover");
					}
				}
				else {
					if (pawn.CountInv("BMiscRemover")) {
						pawn.TakeInventory("BMiscRemover", 1);
					}
				}

			}
			else {
				if (pawn.CountInv("BSilencerRemover")) {
					pawn.TakeInventory("BSilencerRemover", 1);
				}
			}

		}


	}

	override void OnRegister() {

		origin = (0, 0);

		// Loop once over actor classes to find Attachment classes
		int count = AllClasses.Size();
		Class<BaseBarrelAttachment> isUsed = null;
		for (int i = 0; i < count; i++) {

			let next = AllClasses[i];
			if (!(next is "BaseAttachment")) {
				if (next is "BarrelOffset") {
					let barrelOffRef = (Class<BarrelOffset>)(next);
					barrelOffsets.push(barrelOffRef);
				}
				else if (next is "ScopeOffset") {
					let scopeOffRef = (Class<ScopeOffset>)(next);
					scopeOffsets.push(scopeOffRef);
				}
				else if (next is "MiscOffset") {
					let miscOffRef = (Class<MiscOffset>)(next);
					miscOffsets.push(miscOffRef);
				}
				continue;
			}

			let serialId = GetDefaultByType((Class<BaseAttachment>)(next)).SerialId;
			if (serialId > 0) {
				if (next is "BaseBarrelAttachment") {
					let barrelref = (Class<BaseBarrelAttachment>)(next);
					if (getBarrelClass(serialId)) {
						// Crashes on death
						//console.printf("Failed to register attachment %s. SerialID for barrel already in use by.", next.getClassName(), isUsed.getClassName());
					}
					else { 
						barrelAttachments.push(barrelref);
					}
				}
				else if (next is "BaseMiscAttachment") {
					let miscRef = (Class<BaseMiscAttachment>)(next);
					if (getMiscClass(serialId)) {

					}
					else {
						miscAttachments.push(miscRef);
					}
					// todo
				}
				else if (next is "BaseSightAttachment") {
					let scopeRef = (Class<BaseSightAttachment>)(next);
					if (getScopeClass(serialId)) {
						// Crashes on death
						//console.printf("Failed to register attachment %s. SerialID for scope already in use by.", next.getClassName(), isUsed.getClassName());
					}
					else { 
						scopeAttachments.push(scopeRef);
					}
				}
			}
		}

	}

	int scopeOffsetIndex(BHDWeapon weapon, Class<BaseSightAttachment> scopecls) {
		int count = scopeOffsets.size();
		for (int i = 0; i < count; i++) {
			let next = scopeOffsets[i];
			let gname = GetDefaultByType((Class<Offset>)(next)).weaponClass;
			let aname = GetDefaultByType((Class<Offset>)(next)).weaponOverlay;
			if (gname == weapon.getClassName() && aname == scopecls.getClassName()) {
				return i;
			}
		}
		return -1;
	}

	Vector2 getScopeOffset(int i) {
		let next = scopeOffsets[i];
		let x = GetDefaultByType((Class<Offset>)(next)).offx;
		let y = GetDefaultByType((Class<Offset>)(next)).offy;
		return (x, y);
	}



	int miscOffsetIndex(BHDWeapon weapon, Class<BaseMiscAttachment> scopecls) {
		int count = miscOffsets.size();
		for (int i = 0; i < count; i++) {
			let next = miscOffsets[i];
			let gname = GetDefaultByType((Class<Offset>)(next)).weaponClass;
			let aname = GetDefaultByType((Class<Offset>)(next)).weaponOverlay;
			if (gname == weapon.getClassName() && aname == scopecls.getClassName()) {
				return i;
			}
		}
		return -1;
	}

	Vector2 getMiscOffset(int i) {
		let next = miscOffsets[i];
		let x = GetDefaultByType((Class<Offset>)(next)).offx;
		let y = GetDefaultByType((Class<Offset>)(next)).offy;
		return (x, y);
	}

	int barrelOffsetIndex(BHDWeapon weapon, Class<BaseBarrelAttachment> barrelcls) {
		int count = barrelOffsets.size();
		for (int i = 0; i < count; i++) {
			let next = barrelOffsets[i];
			let gunName = GetDefaultByType((Class<Offset>)(next)).weaponClass;
			let scopeName = GetDefaultByType((Class<Offset>)(next)).weaponOverlay;
			if (gunName == weapon.getClassName() && scopeName == barrelcls.getClassName()) {
				return i;
			}
		}
		return -1;
	}

	Vector2 getBarrelOffset(int i) {
		let next = barrelOffsets[i];
		let x = GetDefaultByType((Class<Offset>)(next)).offx;
		let y = GetDefaultByType((Class<Offset>)(next)).offy;
		return (x, y);
	}

	Class<BaseMiscAttachment> getMiscClass (int serialId) {
		int count = miscAttachments.Size();
		for (int i = 0; i < count; i++) {
			let next = miscAttachments[i];
			if (next) {
				let n_serialId = GetDefaultByType((Class<BaseAttachment>)(next)).SerialId;
				if (n_serialId == serialId) {
					Class<BaseMiscAttachment> cast = (Class<BaseMiscAttachment>)(next);
					return cast;
				}
			}
		}
		return null;
	}

	Class<BaseSightAttachment> getScopeClass (int serialId) {
		int count = scopeAttachments.Size();
		for (int i = 0; i < count; i++) {
			let next = scopeAttachments[i];
			if (next) {
				let n_serialId = GetDefaultByType((Class<BaseAttachment>)(next)).SerialId;
				if (n_serialId == serialId) {
					Class<BaseSightAttachment> cast = (Class<BaseSightAttachment>)(next);
					return cast;
				}
			}
		}
		return null;
	}

	Class<BaseBarrelAttachment> getBarrelClass (int serialId) {
		int count = barrelAttachments.Size();
		for (int i = 0; i < count; i++) {
			let next = barrelAttachments[i];
			if (next) {
				let n_serialId = GetDefaultByType((Class<BaseAttachment>)(next)).SerialId;
				if (n_serialId == serialId) {
					Class<BaseBarrelAttachment> cast = (Class<BaseBarrelAttachment>)(next);
					return cast;
				}
			}
		}
		return null;
	}
	
}