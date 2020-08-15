

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
	}
	
	states {
		spawn:
			RAVW A 0 nodelay;
			Goto Super::Spawn2;
	}

}