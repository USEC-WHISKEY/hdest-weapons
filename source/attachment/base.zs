

class BaseAttachment : HDPickup {
	property MountId: mountId;
	string mountId; 

	property SerialId: serialId;
	meta int serialId;

	property SpriteOffsetX: spriteOffsetX;
	property SpriteOffsetY: spriteOffsetY;
	double spriteOffsetX;
	double spriteOffsetY;

	property BaseSprite: baseSprite;
	string baseSprite;

	property BaseFrame: baseFrame;
	int baseFrame;

	default {
		+HDPickup.FitsInBackpack
		BaseAttachment.SerialId -1;
	}

	override bool Use(bool pickup) {
		if (owner.player.readyWeapon && owner.player.readyWeapon is "BHDWeapon") {
			BHDWeapon wep = BHDWeapon(owner.player.readyWeapon);
			bool blocked = Blocked(wep);
			if (blocked) {
				console.printf("Failed to attach.");
				owner.player.SetPSprite(PSP_WEAPON, owner.player.readyWeapon.FindState("Nope"));
				return false;
			}

			bool attached = CanAttach(wep, owner.player.mo);

			
			if (!attached) {
				console.printf("Failed to attach.");
				owner.player.SetPSprite(PSP_WEAPON, owner.player.readyWeapon.FindState("Nope"));
			}
			else {
				wep.lastRef = self;
				//console.printf("wtf %p %p", wep, wep.lastRef);
				owner.player.SetPSprite(PSP_WEAPON, owner.player.readyWeapon.FindState("AttachmentStart"));
				return false;
			}
			return false;
			
		}
		else {
			console.printf("Incompatible weapon.");
			return false;
		}
	}

	virtual bool AttemptAttach(BHDWeapon weapon, PlayerPawn player) {
		return false;
	}

	virtual bool CanAttach(BHDWeapon weapon, PlayerPawn Player) {
		return false;
	}

	virtual void ClearAttachment(BHDWeapon weapon, PlayerPawn player) {

	}

	virtual bool Blocked(BHDWeapon weapon) {
		return false;
	}

	// Overrides for users
	virtual void OnAttach(BHDWeapon weapon, PlayerPawn pawn) {}
	virtual void OnDettach(BHDWeapon weapon, PlayerPawn pawn) {}

}

class BaseBarrelAttachment : BaseAttachment {
	property Length: Length;
	double length;

	override bool CanAttach(BHDWeapon weapon, PlayerPawn player) {
		AttachmentManager mgr = AttachmentManager(EventHandler.find("AttachmentManager"));
		if (weapon.bBarrelMount != self.MountId) {
			console.printf("\cgFailed to attach barrel. Attachment is incompatible.");
			return false;
		}
		return true;
	}

	override void ClearAttachment(BHDWeapon weapon, PlayerPawn player) {
		if (weapon.barrelClass) {
			player.GiveInventory(weapon.barrelClass.getClassName(), 1);
		}
		weapon.setBarrelSerialID(0);
		weapon.barrelClass = null;
		weapon.useBarrelOffsets = false;
		weapon.barrelOffsets = (0, 0);
	}

	override bool AttemptAttach(BHDWeapon weapon, PlayerPawn player) {
		AttachmentManager mgr = AttachmentManager(EventHandler.find("AttachmentManager"));
		if (weapon.bBarrelMount != self.MountId) {
			console.printf("\cgFailed to attach barrel. Attachment is incompatible.");
			return false;
		}

		if (weapon.getBarrelSerialID() > 0) {
			PlayerInfo info = players[owner.playerNumber()];
			owner.player.SetPSprite(PSP_WEAPON, info.readyWeapon.FindState("BarrelAttachmentRemove"));
			player.GiveInventory(weapon.barrelClass, 1);
			OnDettach(weapon, player);
		}
		weapon.setBarrelSerialID(self.serialId);
		weapon.barrelClass = getClass();

		let offsetIndex = mgr.barrelOffsetIndex(weapon, getClass());
		if (offsetIndex > -1) {
			Vector2 pos = mgr.getBarrelOffset(offsetIndex);
			weapon.useBarrelOffsets = true;
			weapon.barrelOffsets = pos;
		}
		else {
			weapon.useBarrelOffsets = false;
			weapon.barrelOffsets = (0, 0);
		}

		onAttach(weapon, player);
		return true;
	}

}

class BaseSilencerAttachment : BaseBarrelAttachment {}
class BaseFlashAttachment : BaseBarrelAttachment {}

class BaseSightAttachment : BaseAttachment {

	property UseWeaponIron: useWeaponIron;
	bool useWeaponIron;

	property BackImage: backImage;
	string backImage;
	property FrontImage: frontImage;
	string frontImage;
	property FrontOffX: frontOffX;
	property FrontOffY: frontOffY;
	property BackOffX: BackOffX;
	property BackOffY: BackOffY;
	double frontoffx;
	double frontoffy;
	double backoffx;
	double backoffy;
	property DotThreshold: dotThreshold;
	meta int dotThreshold;

	property bFrontAltImage: bfrontAltImage;
	property bBackAltImage: bbackAltImage;
	string bfrontAltImage;
	string bbackAltImage;

	property ScopeShaderTexture: scopeShaderTexture;
	property ScopeShaderX: scopeShaderX;
	property ScopeShaderY: scopeShaderY;
	string scopeShaderTexture;
	double scopeShaderX;
	double scopeShaderY;

	default {
		BaseSightAttachment.DotThreshold 6;
		BaseSightAttachment.bfrontAltImage "";
		BaseSightAttachment.bbackAltImage "";
	}

	override void ClearAttachment(BHDWeapon weapon, PlayerPawn player) {
		if (weapon.scopeClass) {
			player.GiveInventory(weapon.scopeClass.getClassName(), 1);
		}
		weapon.setScopeSerialID(0);
		weapon.scopeClass = null;
		weapon.useScopeOffsets = false;
		weapon.scopeOffsets = (0, 0);
	}

	override bool CanAttach(BHDWeapon weapon, PlayerPawn player) {
		AttachmentManager mgr = AttachmentManager(EventHandler.find("AttachmentManager"));
		if (weapon.bScopeMount != self.MountId) {
			console.printf("\cgFailed to attach sight. Attachment is incompatible.");
			return false;
		}
		return true;
	}

	override bool AttemptAttach(BHDWeapon weapon, PlayerPawn player) {
		AttachmentManager mgr = AttachmentManager(EventHandler.find("AttachmentManager"));
		if (weapon.bScopeMount != self.MountId) {
			console.printf("\cgFailed to attach sight. Attachment is incompatible.");
			return false;
		}

		if (weapon.getScopeSerialID() > 0) {
			player.GiveInventory(weapon.scopeClass, 1);
		}
		weapon.setScopeSerialID(self.serialID);
		weapon.scopeClass = getClass();

		let offsetIndex = mgr.scopeOffsetIndex(weapon, getClass());
		if (offsetIndex > -1) {
			Vector2 pos = mgr.getScopeOffset(offsetIndex);
			weapon.useScopeOffsets = true;
			weapon.scopeOffsets = pos;
		}
		else {
			weapon.useScopeOffsets = false;
			weapon.scopeOffsets = (0, 0);
		}
		onAttach(weapon, player);
		return true;
	}
}

class BaseScopeAttachment : BaseSightAttachment {


	default {
		BaseScopeAttachment.ZoomFactor 10;
	}

	property ScopeImage: scopeImage;
	string scopeImage;

	property SightImage: sightImage;
	string sightImage;

	property XScaleCam: xscalecam;
	property YScaleCam: yscalecam;
	property XPosCam: xposcam;
	property YPosCam: yposcam;
	double xscalecam, yscalecam, xposcam, yposcam;

	property ScaledWidth: scaledWidth;
	double scaledWidth;

	property XClipCam: xclipcam;
	property YClipCam: yclipcam;
	double xclipcam, yclipcam;

	property ScopeHoleX: scopeholex;
	property ScopeHoleY: scopeholey;
	property ScopeScaleX: scopescalex;
	property ScopeScaleY: scopescaley;
	double scopeholex, scopeholey, scopescalex, scopescaley;

	property ScopeImageX: scopeimagex;
	property ScopeImageY: scopeimagey;
	property ScopeImageScaleX: scopeimagescalex;
	property ScopeImageScaleY: scopeimagescaley;
	double scopeimagex, scopeimagey, scopeimagescalex, scopeimagescaley;

	property ScopeBackX: scopeBackX;
	property ScopeBackY: scopeBackY;
	double scopeBackX;
	double scopeBackY;

	property ZoomFactor : zoomFactor;
	double zoomFactor;


}

class BaseMiscAttachment : BaseAttachment {

	property OnSprite: OnSprite;
	string onSprite;

	property OnFrame: OnFrame;
	int onFrame;

	property EventClass: eventClass;
	string eventClass;

	override bool CanAttach(BHDWeapon weapon, PlayerPawn player) {
		AttachmentManager mgr = AttachmentManager(EventHandler.find("AttachmentManager"));
		if (weapon.bMiscMount != self.MountId) {
			console.printf("\cgFailed to attach misc. Attachment is incompatible.");
			return false;
		}
		return true;
	}

	override void ClearAttachment(BHDWeapon weapon, PlayerPawn player) {
		if (weapon.miscClass) {
			player.GiveInventory(weapon.miscClass.getClassName(), 1);
		}
		weapon.setMiscSerialID(0);
		weapon.miscClass = null;
		weapon.useMiscOffsets = false;
		weapon.miscOffsets = (0, 0);
	}

	override bool AttemptAttach(BHDWeapon weapon, PlayerPawn player) {
		AttachmentManager mgr = AttachmentManager(EventHandler.find("AttachmentManager"));
		if (weapon.bMiscMount != self.MountId) {
			console.printf("\cgFailed to attach misc. Attachment is incompatible.");
			return false;
		}

		if (weapon.getMiscSerialID() > 0) {
			player.GiveInventory(weapon.miscClass, 1);
			OnDettach(weapon, player);
		}
		weapon.setMiscSerialID(self.serialId);
		weapon.miscClass = getClass();

		let offsetIndex = mgr.miscOffsetIndex(weapon, getClass());
		if (offsetIndex > -1) {
			Vector2 pos = mgr.getMiscOffset(offsetIndex);
			weapon.useMiscOffsets = true;
			weapon.miscOffsets = pos;
		}
		else {
			weapon.useScopeOffsets = false;
			weapon.miscOffsets = (0, 0);
		}

		onAttach(weapon, player);
		return true;
	}

	static bool UsedHook(Class<BaseMiscAttachment> cls, BHDWeapon weapon, PlayerPawn player) {
		string evt = GetDefaultByType(cls).EventClass;
		BaseMiscAttachmentEvent inst = null;
		if (evt != "") {
			inst = BaseMiscAttachmentEvent(new (evt));
		}
		else {
			inst = new ("BaseMiscAttachmentEvent");
		}
		if (inst == null) {
			return false;
		}
		return inst.onUsed(cls, weapon, player);
	}

}

class BaseMiscAttachmentEvent {
	// Default behavior is this class is called to goggle the switch on the weapon
	// it does nothing though. To add behavior on used, inherit this class and override this function
	virtual bool onUsed(Class<BaseMiscAttachment> cls, BHDWeapon weapon, PlayerPawn player) {
		weapon.toggleMisc();
		return true;
	}

}



class BaseChokeAttachment : BaseBarrelAttachment {
	property CLow: clow;
	property Chigh: chigh;
	double clow;
	double chigh;
	default {
		BaseChokeAttachment.Clow -10;
		BaseChokeAttachment.CHigh 20;
	}
}
