
class B_M4 : BaseStandardRifle {

	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            4;
		weapon.slotpriority          1;
		inventory.pickupsound        "misc/w_pkup";
		inventory.pickupmessage      "You got the M4.";
		scale                        0.7;
		weapon.bobrangex             0.22;
		weapon.bobrangey             0.9;
		obituary                     "%o was assaulted by %k.";
		tag                          "M4";
		inventory.icon               "M4RPA0";
		BHDWeapon.BFlashSprite       "FLSHA0";
		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_556";
		BHDWeapon.BAmmoClass         "B556Ammo";
		BHDWeapon.BMagazineClass     "B556Mag";
		BHDWeapon.BGunMass           6.2;
		BHDWeapon.BCookOff           30;
		BHDWeapon.BHeatLimit         255;
		BHDWeapon.BSpriteWithMag     "M4RPC0";
		BHDWeapon.BSpriteWithoutMag  "M4RPD0";
		BHDWeapon.BSpriteWithFrame    0;
		BHDWeapon.BSpriteWithoutFrame 1;
		BHDWeapon.BMagazineSprite    "M4RCA0";
		BHDWeapon.BWeaponBulk        90;
		BHDWeapon.BMagazineBulk      15;
		BHDWeapon.BBulletBulk        1;
		BHDWeapon.BMagazineCapacity  30;
		BHDWeapon.BarrelLength       25;
		BHDWeapon.BarrelWidth        1;
		BHDWeapon.BarrelDepth        3;
		
		BHDWeapon.BFireSound         "weapons/m4/fire";
		BHDWeapon.BSFireSound        "weapons/m4/silentfire";
		BHDWeapon.BChamberSound      "weapons/m4/chamber";
		BHDWeapon.BBoltForwardSound  "weapons/m4/boltback";
		BHDWeapon.BBoltBackwardSound "weapons/m4/boltforward";
		BHDWeapon.BClickSound        "weapons/m4/click";
		BHDWeapon.BLoadSound         "weapons/m4/clipinsert";
		BHDWeapon.BUnloadSound       "weapons/m4/clipeject";

		BHDWeapon.BROF               0.5;
		BHDWeapon.BBackOffsetX       -7;
		BHDWeapon.BBackOffsetY       40;
		BHDWeapon.BFrontSightImage   "m16iron";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      22;
		BHDWeapon.BSilentOffsetX     0;
		BHDWeapon.BSilentOffsetY     0;
		BHDWeapon.bBarrelMount       "556_NATO_BARREL";
		BHDWeapon.bScopeMount        "NATO_RAILS";
		BHDWeapon.bMiscMount         "NATO_RAILS";
		BHDWeapon.EjectShellClass    "B556Spent";
		hdweapon.refid               B_M4_REFID;

		BHDWeapon.BAltFrontSightImage "am4";
		BHDWeapon.BAltBackSightImage "";

		BHDWeapon.BLayerSight  104;
		BHDWeapon.bLayerRHand  105;
		BHDWeapon.bLayerGunBack -99;
	}

	states {
		Spawn:
			M4RP A 0 GetMagState();
			Goto Super::Spawn;
		
		SpawnMag:
			TNT1 A 0 {
				if (invoker.scopeClass) {
					if (invoker.scopeClass is "B_M4_CarrySight") {
						if (invoker.barrelClass && invoker.miscClass) {
							return ResolveState("CarryhandleBarrelMisc");
						}
						else if (invoker.barrelClass) {
							return ResolveState("CarryhandleBarrel");
						}
						else if (invoker.miscClass) {
							return ResolveState("CarryhandleMisc");
						}
						return ResolveState("Carryhandle");
					}
					else if (invoker.scopeClass is "B_M4_RearSight" || invoker.scopeClass is "B_Faux_Sight") {
						if (invoker.barrelClass && invoker.miscClass) {
							return ResolveState("LowsightBarrelMisc");
						}
						else if (invoker.barrelClass) {
							return ResolveState("LowsightBarrel");
						}
						else if (invoker.miscClass) {
							return ResolveState("LowsightMisc");
						}
						return ResolveState("Lowsight");
					}
					else {
						if (invoker.barrelClass && invoker.miscClass) {
							return ResolveState("OtherBarrelMisc");
						}
						else if (invoker.barrelClass) {
							return ResolveState("OtherBarrel");
						}
						else if (invoker.miscClass) {
							return ResolveState("OtherMisc");
						}
						return ResolveState("Other");
					}	
				}
				else if (invoker.barrelClass && invoker.miscClass) {
					return ResolveState("BarrelMisc");
				}
				else if (invoker.barrelClass) {
					return ResolveState("Barrel");
				}
				else if (invoker.miscClass) {
					return ResolveState("Misc");
				}
				return ResolveState(NULL);
			}
			M4PA A -1;
			Goto HDWeapon::Spawn;

		CarryhandleBarrelMisc:
			M4PA O -1;
			Goto HDWeapon::Spawn;

		CarryhandleBarrel:
			M4PA M -1;
			Goto HDWeapon::Spawn;

		CarryhandleMisc:
			M4PA K -1;
			Goto HDWeapon::Spawn;

		Carryhandle:
			M4PA I -1;
			Goto HDWeapon::Spawn;

		LowsightBarrelMisc:
			M4PA W -1;
			Goto HDWeapon::Spawn;

		LowsightBarrel:
			M4PA U -1;
			Goto HDWeapon::Spawn;

		LowsightMisc:
			M4PA S -1;
			Goto HDWeapon::Spawn;

		Lowsight:
			M4PA Q -1;
			Goto HDWeapon::Spawn;

		OtherBarrelMisc:
			M4PB E -1;
			Goto HDWeapon::Spawn;

		OtherBarrel:
			M4PB C -1;
			Goto HDWeapon::Spawn;

		OtherMisc:
			M4PB A -1;
			Goto HDWeapon::Spawn;

		Other:
			M4PA Y -1;
			Goto HDWeapon::Spawn;

		BarrelMisc:
			M4PA G -1;
			Goto HDWeapon::Spawn;

		Barrel:
			M4PA E -1;
			Goto HDWeapon::Spawn;

		Misc:
			M4PA C -1;
			Goto HDWeapon::Spawn;

		SpawnNoMag:
			TNT1 A 0 {
				if (invoker.scopeClass) {
					if (invoker.scopeClass is "B_M4_CarrySight") {
						if (invoker.barrelClass && invoker.miscClass) {
							return ResolveState("CarryhandleBarrelMiscEmpty");
						}
						else if (invoker.barrelClass) {
							return ResolveState("CarryhandleBarrelEmpty");
						}
						else if (invoker.miscClass) {
							return ResolveState("CarryhandleMiscEmpty");
						}
						return ResolveState("CarryhandleEmpty");
					}
					else if (invoker.scopeClass is "B_M4_RearSight" || invoker.scopeClass is "B_Faux_Sight") {
						if (invoker.barrelClass && invoker.miscClass) {
							return ResolveState("LowsightBarrelMiscEmpty");
						}
						else if (invoker.barrelClass) {
							return ResolveState("LowsightBarrelEmpty");
						}
						else if (invoker.miscClass) {
							return ResolveState("LowsightMiscEmpty");
						}
						return ResolveState("LowsightEmpty");
					}
					else {
						if (invoker.barrelClass && invoker.miscClass) {
							return ResolveState("OtherBarrelMiscEmpty");
						}
						else if (invoker.barrelClass) {
							return ResolveState("OtherBarrelEmpty");
						}
						else if (invoker.miscClass) {
							return ResolveState("OtherMiscEmpty");
						}
						return ResolveState("OtherEmpty");
					}	
				}
				else if (invoker.barrelClass && invoker.miscClass) {
					return ResolveState("BarrelMiscEmpty");
				}
				else if (invoker.barrelClass) {
					return ResolveState("BarrelEmpty");
				}
				else if (invoker.miscClass) {
					return ResolveState("MiscEmpty");
				}
				return ResolveState(NULL);
			}
			M4PA B -1;
			Goto HDWeapon::Spawn;

		CarryhandleBarrelMiscEmpty:
			M4PA P -1;
			Goto HDWeapon::Spawn;

		CarryhandleBarrelEmpty:
			M4PA N -1;
			Goto HDWeapon::Spawn;

		CarryhandleMiscEmpty:
			M4PA L -1;
			Goto HDWeapon::Spawn;

		CarryhandleEmpty:
			M4PA J -1;
			Goto HDWeapon::Spawn;

		LowsightBarrelMiscEmpty:
			M4PA X -1;
			Goto HDWeapon::Spawn;

		LowsightBarrelEmpty:
			M4PA V -1;
			Goto HDWeapon::Spawn;

		LowsightMiscEmpty:
			M4PA T -1;
			Goto HDWeapon::Spawn;

		LowsightEmpty:
			M4PA R -1;
			Goto HDWeapon::Spawn;

		OtherBarrelMiscEmpty:
			M4PB F -1;
			Goto HDWeapon::Spawn;

		OtherBarrelEmpty:
			M4PB D -1;
			Goto HDWeapon::Spawn;

		OtherMiscEmpty:
			M4PB B -1;
			Goto HDWeapon::Spawn;

		OtherEmpty:
			M4PA Z -1;
			Goto HDWeapon::Spawn;

		BarrelMiscEmpty:
			M4PA H -1;
			Goto HDWeapon::Spawn;

		BarrelEmpty:
			M4PA F -1;
			Goto HDWeapon::Spawn;

		MiscEmpty:
			M4PA D -1;
			Goto HDWeapon::Spawn;

		LayerGun:
			M4RG A 1;
			Loop;

		LayerGunFire:
			M4RG B 1;
			Goto LayerGun;

		LayerGunBolt:
			M4RG E 3 A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
			Goto LayerGun;

		LayerReloadHands:
			M4RH A 0;
			Goto Super::LayerReloadHands;

		LayerDefaultSight:
			TNT1 A 1;
			Loop;

		UnloadChamber:
			#### A 0 {
				A_Overlay(invoker.bLayerRHand, "PullBolt");
			}
			Goto Super::UnloadChamber;

		PullBolt:
			M4RH A 2;
			M4RH B 2;
			TNT1 A 0 {
				A_Overlay(invoker.bLayerGun, "GunPullBolt");
			}
			M4RH C 3; //A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
			M4RH B 3; //A_StartSound(invoker.bBoltForwardSound, CHAN_WEAPON);
			M4RH A 3;
			Stop;

		GunPullBolt:
			M4RG E 3 A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
			Goto LayerGun;
	}

	override string, double GetPickupSprite() {
		if(magazineGetAmmo() > -1) {
			if (scopeClass) {
				if (scopeClass is "B_M4_CarrySight") {
					if (barrelClass && miscClass) {
						return "M4PAO0", 1.;
					}
					else if (barrelClass) {
						return "M4PAM0", 1.;
					}
					else if (miscClass) {
						return "M4PAK0", 1.;
					}
					return "M4PAI0", 1.;
				}
				else if (scopeClass is "B_M4_RearSight" || scopeClass is "B_Faux_Sight") {
					if (barrelClass && miscClass) {
						return "M4PAW0", 1.;
					}
					else if (barrelClass) {
						return "M4PAU0", 1.;
					}
					else if (miscClass) {
						return "M4PAS0", 1.;
					}
					return "M4PAQ0", 1.;
				}
				else {
					if (barrelClass && miscClass) {
						return "M4PBE0", 1.;
					}
					else if (barrelClass) {
						return "M4PBC0", 1.;
					}
					else if (miscClass) {
						return "M4PBA0", 1.;
					}
					return "M4PAY0", 1.;
				}	
			}
			else if (barrelClass && miscClass) {
				return "M4PAG0", 1.;
			}
			else if (barrelClass) {
				return "M4PAE0", 1.;
			}
			else if (miscClass) {
				return "M4PAC0", 1.;
			}
			return "M4PAA0", 1.;
		}
		else {
			if (scopeClass) {
				if (scopeClass is "B_M4_CarrySight") {
					if (barrelClass && miscClass) {
						return "M4PAP0", 1.;
					}
					else if (barrelClass) {
						return "M4PAN0", 1.;
					}
					else if (miscClass) {
						return "M4PAL0", 1.;
					}
					return "M4PAJ0", 1.;
				}
				else if (scopeClass is "B_M4_RearSight" || scopeClass is "B_Faux_Sight") {
					if (barrelClass && miscClass) {
						return "M4PAX0", 1.;
					}
					else if (barrelClass) {
						return "M4PAV0", 1.;
					}
					else if (miscClass) {
						return "M4PAT0", 1.;
					}
					return "M4PAR0", 1.;
				}
				else {
					if (barrelClass && miscClass) {
						return "M4PBF0", 1.;
					}
					else if (barrelClass) {
						return "M4PBD0", 1.;
					}
					else if (miscClass) {
						return "M4PBB0", 1.;
					}
					return "M4PAZ0", 1.;
				}	
			}
			else if (barrelClass && miscClass) {
				return "M4PAH0", 1.;
			}
			else if (barrelClass) {
				return "M4PAF0", 1.;
			}
			else if (miscClass) {
				return "M4PAD0", 1.;
			}
			return "M4PAB0", 1.;
		}
	}
}


class B_M4_M203 : BaseGLRifle {

	default {
		+hdweapon.fitsinbackpack
		weapon.selectionorder        20;
		weapon.slotnumber            4;
		weapon.slotpriority          2;
		inventory.pickupsound        "misc/w_pkup";
		inventory.pickupmessage      "You got the M4 M203.";
		scale                        0.7;
		weapon.bobrangex             0.22;
		weapon.bobrangey             0.9;
		obituary                     "%o was assaulted by %k.";
		tag                          "M4 M203";
		inventory.icon               "M4PCA0";
		BHDWeapon.BFlashSprite       "FLSHA0";
		BHDWeapon.BHeatDrain         12;
		BHDWeapon.BBulletClass       "HDB_556";
		BHDWeapon.BAmmoClass         "B556Ammo";
		BHDWeapon.BMagazineClass     "B556Mag";
		BHDWeapon.BGunMass           6.2;
		BHDWeapon.BCookOff           30;
		BHDWeapon.BHeatLimit         255;
		BHDWeapon.BSpriteWithMag     "M4PCC0";
		BHDWeapon.BSpriteWithoutMag  "M4PCD0";
		BHDWeapon.BSpriteWithFrame    0;
		BHDWeapon.BSpriteWithoutFrame 1;
		BHDWeapon.BMagazineSprite    "M4RCA0";
		BHDWeapon.BWeaponBulk        90;
		BHDWeapon.BMagazineBulk      15;
		BHDWeapon.BBulletBulk        1;
		BHDWeapon.BMagazineCapacity  30;
		BHDWeapon.BarrelLength       25;
		BHDWeapon.BarrelWidth        1;
		BHDWeapon.BarrelDepth        3;
		
		BHDWeapon.BFireSound         "weapons/m4/fire";
		BHDWeapon.BSFireSound        "weapons/m4/silentfire";
		BHDWeapon.BChamberSound      "weapons/m4/chamber";
		BHDWeapon.BBoltForwardSound  "weapons/m4/boltback";
		BHDWeapon.BBoltBackwardSound "weapons/m4/boltforward";
		BHDWeapon.BClickSound        "weapons/m4/click";
		BHDWeapon.BLoadSound         "weapons/m4/clipinsert";
		BHDWeapon.BUnloadSound       "weapons/m4/clipeject";

		BHDWeapon.BROF               0.5;
		BHDWeapon.BBackOffsetX       -7;
		BHDWeapon.BBackOffsetY       40;
		BHDWeapon.BFrontSightImage   "m16iron";
		BHDWeapon.BFrontOffsetX      0;
		BHDWeapon.BFrontOffsetY      22;
		BHDWeapon.BSilentOffsetX     0;
		BHDWeapon.BSilentOffsetY     0;
		BHDWeapon.bBarrelMount       "556_NATO_BARREL";
		BHDWeapon.bScopeMount        "NATO_RAILS";
		BHDWeapon.bMiscMount         "NATO_RAILS";
		BHDWeapon.EjectShellClass    "B556Spent";
		hdweapon.refid               B_M4M203_REFID;

		BaseAltRifle.bAltMagClass    "HDRocketAmmo";
		BaseAltRifle.BAltMagPicture  "ROQPA0";

		BHDWeapon.BAltFrontSightImage "am4";
		BHDWeapon.BAltBackSightImage "";

		BHDWeapon.BLayerSight  104;
		BHDWeapon.bLayerRHand  105;
		BHDWeapon.bLayerGunBack -99;
	}

	states {
		Spawn:
			M4PC A 0 GetMagState();
			Goto Super::Spawn;
		
		SpawnMag:
			TNT1 A 0 {
				if (invoker.scopeClass) {
					if (invoker.scopeClass is "B_M4_CarrySight") {
						if (invoker.barrelClass && invoker.miscClass) {
							return ResolveState("CarryhandleBarrelMisc");
						}
						else if (invoker.barrelClass) {
							return ResolveState("CarryhandleBarrel");
						}
						else if (invoker.miscClass) {
							return ResolveState("CarryhandleMisc");
						}
						return ResolveState("Carryhandle");
					}
					else if (invoker.scopeClass is "B_M4_RearSight" || invoker.scopeClass is "B_Faux_Sight") {
						if (invoker.barrelClass && invoker.miscClass) {
							return ResolveState("LowsightBarrelMisc");
						}
						else if (invoker.barrelClass) {
							return ResolveState("LowsightBarrel");
						}
						else if (invoker.miscClass) {
							return ResolveState("LowsightMisc");
						}
						return ResolveState("Lowsight");
					}
					else {
						if (invoker.barrelClass && invoker.miscClass) {
							return ResolveState("OtherBarrelMisc");
						}
						else if (invoker.barrelClass) {
							return ResolveState("OtherBarrel");
						}
						else if (invoker.miscClass) {
							return ResolveState("OtherMisc");
						}
						return ResolveState("Other");
					}	
				}
				else if (invoker.barrelClass && invoker.miscClass) {
					return ResolveState("BarrelMisc");
				}
				else if (invoker.barrelClass) {
					return ResolveState("Barrel");
				}
				else if (invoker.miscClass) {
					return ResolveState("Misc");
				}
				return ResolveState(NULL);
			}
			M4PC A -1;
			Goto HDWeapon::Spawn;

		CarryhandleBarrelMisc:
			M4PC O -1;
			Goto HDWeapon::Spawn;

		CarryhandleBarrel:
			M4PC M -1;
			Goto HDWeapon::Spawn;

		CarryhandleMisc:
			M4PC K -1;
			Goto HDWeapon::Spawn;

		Carryhandle:
			M4PC I -1;
			Goto HDWeapon::Spawn;

		LowsightBarrelMisc:
			M4PC W -1;
			Goto HDWeapon::Spawn;

		LowsightBarrel:
			M4PC U -1;
			Goto HDWeapon::Spawn;

		LowsightMisc:
			M4PC S -1;
			Goto HDWeapon::Spawn;

		Lowsight:
			M4PC Q -1;
			Goto HDWeapon::Spawn;

		OtherBarrelMisc:
			M4PD E -1;
			Goto HDWeapon::Spawn;

		OtherBarrel:
			M4PD C -1;
			Goto HDWeapon::Spawn;

		OtherMisc:
			M4PD A -1;
			Goto HDWeapon::Spawn;

		Other:
			M4PC Y -1;
			Goto HDWeapon::Spawn;

		BarrelMisc:
			M4PC G -1;
			Goto HDWeapon::Spawn;

		Barrel:
			M4PC E -1;
			Goto HDWeapon::Spawn;

		Misc:
			M4PC C -1;
			Goto HDWeapon::Spawn;

		SpawnNoMag:
			TNT1 A 0 {
				if (invoker.scopeClass) {
					if (invoker.scopeClass is "B_M4_CarrySight") {
						if (invoker.barrelClass && invoker.miscClass) {
							return ResolveState("CarryhandleBarrelMiscEmpty");
						}
						else if (invoker.barrelClass) {
							return ResolveState("CarryhandleBarrelEmpty");
						}
						else if (invoker.miscClass) {
							return ResolveState("CarryhandleMiscEmpty");
						}
						return ResolveState("CarryhandleEmpty");
					}
					else if (invoker.scopeClass is "B_M4_RearSight" || invoker.scopeClass is "B_Faux_Sight") {
						if (invoker.barrelClass && invoker.miscClass) {
							return ResolveState("LowsightBarrelMiscEmpty");
						}
						else if (invoker.barrelClass) {
							return ResolveState("LowsightBarrelEmpty");
						}
						else if (invoker.miscClass) {
							return ResolveState("LowsightMiscEmpty");
						}
						return ResolveState("LowsightEmpty");
					}
					else {
						if (invoker.barrelClass && invoker.miscClass) {
							return ResolveState("OtherBarrelMiscEmpty");
						}
						else if (invoker.barrelClass) {
							return ResolveState("OtherBarrelEmpty");
						}
						else if (invoker.miscClass) {
							return ResolveState("OtherMiscEmpty");
						}
						return ResolveState("OtherEmpty");
					}	
				}
				else if (invoker.barrelClass && invoker.miscClass) {
					return ResolveState("BarrelMiscEmpty");
				}
				else if (invoker.barrelClass) {
					return ResolveState("BarrelEmpty");
				}
				else if (invoker.miscClass) {
					return ResolveState("MiscEmpty");
				}
				return ResolveState(NULL);
			}
			M4PC B -1;
			Goto HDWeapon::Spawn;

		CarryhandleBarrelMiscEmpty:
			M4PC P -1;
			Goto HDWeapon::Spawn;

		CarryhandleBarrelEmpty:
			M4PC N -1;
			Goto HDWeapon::Spawn;

		CarryhandleMiscEmpty:
			M4PC L -1;
			Goto HDWeapon::Spawn;

		CarryhandleEmpty:
			M4PC J -1;
			Goto HDWeapon::Spawn;

		LowsightBarrelMiscEmpty:
			M4PC X -1;
			Goto HDWeapon::Spawn;

		LowsightBarrelEmpty:
			M4PC V -1;
			Goto HDWeapon::Spawn;

		LowsightMiscEmpty:
			M4PC T -1;
			Goto HDWeapon::Spawn;

		LowsightEmpty:
			M4PC R -1;
			Goto HDWeapon::Spawn;

		OtherBarrelMiscEmpty:
			M4PD F -1;
			Goto HDWeapon::Spawn;

		OtherBarrelEmpty:
			M4PD D -1;
			Goto HDWeapon::Spawn;

		OtherMiscEmpty:
			M4PD B -1;
			Goto HDWeapon::Spawn;

		OtherEmpty:
			M4PC Z -1;
			Goto HDWeapon::Spawn;

		BarrelMiscEmpty:
			M4PC H -1;
			Goto HDWeapon::Spawn;

		BarrelEmpty:
			M4PC F -1;
			Goto HDWeapon::Spawn;

		MiscEmpty:
			M4PC D -1;
			Goto HDWeapon::Spawn;

		LayerGun:
			M4RG A 1;
			Loop;

		LayerGunFire:
			M4RG B 1;
			Goto LayerGun;

		LayerGunBolt:
			M4RG E 3 A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
			Goto LayerGun;

		LayerReloadHands:
			M4RH A 0;
			Goto Super::LayerReloadHands;

		LayerDefaultSight:
			TNT1 A 1;
			Loop;

		UnloadChamber:
			#### A 0 {
				A_Overlay(invoker.bLayerRHand, "PullBolt");
			}
			Goto Super::UnloadChamber;

		PullBolt:
			M4RH A 2;
			M4RH B 2;
			TNT1 A 0 {
				A_Overlay(invoker.bLayerGun, "GunPullBolt");
			}
			M4RH C 2; //A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
			M4RH B 2; //A_StartSound(invoker.bBoltForwardSound, CHAN_WEAPON);
			M4RH A 2;
			Stop;

		GunPullBolt:
			M4RG E 3 A_StartSound(invoker.bBoltBackwardSound, CHAN_WEAPON);
			Goto LayerGun;
	}
	
	override string, double GetPickupSprite() {
		if(magazineGetAmmo() > -1) {
			if (scopeClass) {
				if (scopeClass is "B_M4_CarrySight") {
					if (barrelClass && miscClass) {
						return "M4PCO0", 1.;
					}
					else if (barrelClass) {
						return "M4PCM0", 1.;
					}
					else if (miscClass) {
						return "M4PCK0", 1.;
					}
					return "M4PCI0", 1.;
				}
				else if (scopeClass is "B_M4_RearSight" || scopeClass is "B_Faux_Sight") {
					if (barrelClass && miscClass) {
						return "M4PCW0", 1.;
					}
					else if (barrelClass) {
						return "M4PCU0", 1.;
					}
					else if (miscClass) {
						return "M4PCS0", 1.;
					}
					return "M4PCQ0", 1.;
				}
				else {
					if (barrelClass && miscClass) {
						return "M4PDE0", 1.;
					}
					else if (barrelClass) {
						return "M4PDC0", 1.;
					}
					else if (miscClass) {
						return "M4PDA0", 1.;
					}
					return "M4PCY0", 1.;
				}	
			}
			else if (barrelClass && miscClass) {
				return "M4PCG0", 1.;
			}
			else if (barrelClass) {
				return "M4PCE0", 1.;
			}
			else if (miscClass) {
				return "M4PCC0", 1.;
			}
			return "M4PCA0", 1.;
		}
		else {
			if (scopeClass) {
				if (scopeClass is "B_M4_CarrySight") {
					if (barrelClass && miscClass) {
						return "M4PCP0", 1.;
					}
					else if (barrelClass) {
						return "M4PCN0", 1.;
					}
					else if (miscClass) {
						return "M4PCL0", 1.;
					}
					return "M4PCJ0", 1.;
				}
				else if (scopeClass is "B_M4_RearSight" || scopeClass is "B_Faux_Sight") {
					if (barrelClass && miscClass) {
						return "M4PCX0", 1.;
					}
					else if (barrelClass) {
						return "M4PCV0", 1.;
					}
					else if (miscClass) {
						return "M4PCT0", 1.;
					}
					return "M4PCR0", 1.;
				}
				else {
					if (barrelClass && miscClass) {
						return "M4PDF0", 1.;
					}
					else if (barrelClass) {
						return "M4PDD0", 1.;
					}
					else if (miscClass) {
						return "M4PDB0", 1.;
					}
					return "M4PCZ0", 1.;
				}	
			}
			else if (barrelClass && miscClass) {
				return "M4PCH0", 1.;
			}
			else if (barrelClass) {
				return "M4PCF0", 1.;
			}
			else if (miscClass) {
				return "M4PCD0", 1.;
			}
			return "M4PCB0", 1.;
		}
	}
}






