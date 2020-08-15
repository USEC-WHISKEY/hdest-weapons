
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
	}
	
	states {
		spawn:
			ASGZ A 0 nodelay;
			Goto Super::Spawn2;
	}

}