

class BRifleman : HumanoidBase {

	default {
		obituary "%o was taken down by a rifleman.";
		hitobituary "%s was smacked around by a rifleman.";
		painchance 120;
		speed 10;
		seesound "";
		painsound "grunt/pain";
		deathsound "grunt/death";
		activesound "";

		HumanoidBase.hWeaponClass "B_M4";
		HumanoidBase.hBulletClass "HDB_556";
		HumanoidBase.hMaxMag 30;
		HumanoidBase.hMagazineClass "B556Mag";
		HumanoidBase.hSpentClass "B556Spent";
		HumanoidBase.hFireSound "weapons/m4/fire";
		HumanoidBase.hSilentFireSound "weapons/m4/silentfire";
	}
	
	override void initializeAttachments() {
		// Random Silencer
		if (!random(0, 2)) {
			silenced = true;
			silId = B_556_SILENCER_ID;
			silClass = mgr.getBarrelClass(B_556_SILENCER_ID);
		}

		// Random Sight
		if (!random(0, 2)) {
			sightId = B_M4_CARRYHANDLE_ID;
			sightClass = mgr.getScopeClass(B_M4_CARRYHANDLE_ID);
		}
		else {
			sightId = B_M4_REARSIGHT_ID;
			sightClass = mgr.getScopeClass(B_M4_REARSIGHT_ID);
		}
	}

	states {
		spawn:
			RAVW A 0 nodelay;
			Goto Super::Spawn2;
	}

}