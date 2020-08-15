
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
	}
	
	states {
		spawn:
			RANG A 0 nodelay;
			Goto Super::Spawn2;
	}

}