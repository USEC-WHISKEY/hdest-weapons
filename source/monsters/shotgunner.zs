
class BShotgunner : ShotgunHumanoidBase {

	default {
		obituary "%o was taken down by a shotgunner.";
		hitobituary "%s was smacked around by a shotgunner.";
		painchance 120;
		speed 8;
		seesound "";
		painsound "grunt/pain";
		deathsound "grunt/death";
		activesound "";

		HumanoidBase.hWeaponClass "b_FauxtechOrigin";
		HumanoidBase.hBulletClass "HDB_00";
		HumanoidBase.hMaxMag 20;
		HumanoidBase.hMagazineClass "BFauxDrum";
		HumanoidBase.hSpentClass "HDSpentShell";
		HumanoidBase.hFireSound "weapons/fauxtech/fire";
		HumanoidBase.hSilentFireSound "weapons/fauxtech/silentfire";
	}

	override void initializeAttachments() {
		// Random Silencer
		if (!random(0, 2)) {
			silenced = true;
			silId = B_FOS_SILENCER_ID;
			silClass = mgr.getBarrelClass(B_FOS_SILENCER_ID);
		}

		sightId = B_FAUX_SIGHT_ID;
		sightClass = mgr.getScopeClass(B_FAUX_SIGHT_ID);
	}
	
	states {
		spawn:
			ASGZ A 0 nodelay;
			Goto Super::Spawn2;
	}

}