
class BRanger : HumanoidBase {

	default {
		obituary "%o was taken down by a ranger.";
		hitobituary "%s was smacked around by a ranger.";
		painchance 120;
		speed 11;
		seesound "";
		painsound "grunt/pain";
		deathsound "grunt/death";
		activesound "";

		HumanoidBase.hWeaponClass "B_M14";
		HumanoidBase.hBulletClass "HDB_762x51";
		HumanoidBase.hMaxMag 20;
		HumanoidBase.hMagazineClass "b762_m14_mag";
		HumanoidBase.hSpentClass "B762x51Spent";
		HumanoidBase.hFireSound "weapons/m14/fire";
		HumanoidBase.hSilentFireSound "weapons/m14/silentfire";
	}

	override void initializeAttachments() {
		// Random Silencer
		if (!random(0, 2)) {
			silenced = true;
			silId = B_762_SILENCER_ID;
			silClass = mgr.getBarrelClass(B_762_SILENCER_ID);
		}

		// Random ACOG or magnified scope
		if (!random(0, 2)) {
			sightId = B_ACOG_RED_ID;
			sightClass = mgr.getScopeClass(B_ACOG_RED_ID);
		}
		else if (!random(0, 2)) {
			sightId = B_SCOPE_10X_ID;
			sightClass = mgr.getScopeClass(B_SCOPE_10X_ID);
		}
	}
	
	states {
		spawn:
			RANG A 0 nodelay;
			Goto Super::Spawn2;
	}

}