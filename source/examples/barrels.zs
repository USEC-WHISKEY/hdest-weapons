class B_M16_Silencer : BaseSilencerAttachment {
	default {
		BaseBarrelAttachment.Length 2;
		BaseAttachment.MountId "556_NATO_BARREL";
		BaseAttachment.SerialId B_556_SILENCER_ID;
		BaseAttachment.BaseSprite "SL56";
		BaseAttachment.BaseFrame 0;
		HDPickup.Bulk 1;
		HDPickup.RefId "sl5";
		Tag "5.56m barrel silencer";
		Inventory.Icon "FFSLA0";
		Inventory.PickupMessage "Picked up 5.56mm silencer.";
	}

	States {
		Spawn:
			FFSL A -1;
			Stop;
		OverlayImage:
			SL56 A -1;
			Stop;
	}
	
}

class B_M14_Silencer : BaseSilencerAttachment {
	default {
		BaseBarrelAttachment.Length 2;
		BaseAttachment.MountId "762_NATO_BARREL";
		BaseAttachment.SerialId B_762_SILENCER_ID;
		BaseAttachment.BaseSprite "GLSL";
		BaseAttachment.BaseFrame 1;
		HDPickup.Bulk 1;
		HDPickup.RefId "sl7";
		Tag "7.62m barrel silencer";
		Inventory.Icon "FFSLB0";
		Inventory.PickupMessage "Picked up 7.62mm silencer.";
	}

	States {
		Spawn:
			FFSL B -1;
			Stop;
		OverlayImage:
			GLSL B -1;
			Stop;
	}
}

class B_M16_Extender : BaseFlashAttachment {
	default {
		BaseBarrelAttachment.Length 2;
		BaseAttachment.MountId "556_NATO_BARREL";
		BaseAttachment.SerialId B_556_FLASH_ID;
		BaseAttachment.BaseSprite "SL56";
		BaseAttachment.BaseFrame 1;
		HDPickup.Bulk 1;
		HDPickup.RefId "BM16SIL";
		Tag "5.56m barrel flash suppressor";
		Inventory.Icon "FFFLA0";
		Inventory.PickupMessage "Picked up 5.56m barrel flash suppressor.";
	}

	States {
		Spawn:
			FFFL A -1;
			Stop;
		OverlayImage:
			SL56 B -1;
			Stop;
	}
	
}

class GlockSilencer : BaseSilencerAttachment {
	default {
		BaseBarrelAttachment.Length 2;
		BaseAttachment.MountId "9MM_GLOCK";
		BaseAttachment.SerialId B_9MM_SILENCER_ID;
		BaseAttachment.BaseSprite "GLSL";
		BaseAttachment.BaseFrame 0;
		HDPickup.Bulk 1;
		HDPickup.RefId "sl9";
		Tag "9mm silencer";
		Inventory.Icon "NMMSA0";
		Inventory.PickupMessage "Picked up 9mm silencer.";
	}

	States {
		Spawn:
			NMMS A -1;
			Stop;
		OverlayImage:
			GLSL A -1;
			Stop;

	}
}

class FosSilencer : BaseSilencerAttachment {
	default {
		BaseBarrelAttachment.Length 2;
		BaseAttachment.MountId "FOSTECH";
		BaseAttachment.SerialId B_FOS_SILENCER_ID;
		BaseAttachment.BaseSprite "GLSL";
		BaseAttachment.BaseFrame 2;
		HDPickup.Bulk 1;
		HDPickup.RefId "slf";
		Tag "Fauxtech Origin 12 silencer";
		Inventory.Icon "UIOZA0";
		Inventory.PickupMessage "Picked up a Fauxtech Origin 12 silencer.";
	}

	States {
		Spawn:
			UIOZ A -1;
			Stop;
		OverlayImage:
			GLSL C -1;
			Stop;

	}
}
