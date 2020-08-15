
class HDScoutSpawner : IdleDummy {
	states {
		spawn:
			TNT1 A 0 {
				Actor newGuy = Spawn("VulcanetteGuy", pos, ALLOW_REPLACE);
			}
			Stop;
	}
}

class BScout : HumanoidBase {

	default {
		obituary "%o was taken down by a scout.";
		hitobituary "%s was smacked around by a scout.";
		painchance 120;
		speed 12;
		seesound "";
		painsound "grunt/pain";
		deathsound "grunt/death";
		activesound "";

		HumanoidBase.hWeaponClass "B_MP5";
		HumanoidBase.hBulletClass "HDB_9";
		HumanoidBase.hMaxMag 30;
		HumanoidBase.hMagazineClass "B9mm_MP5K_MAG";
		HumanoidBase.hSpentClass "HDSpent9mm";
		HumanoidBase.hFireSound "weapons/mp5/fire";
	}
	
	states {
		spawn:
			GREB A 0 nodelay;
			Goto Super::Spawn2;

		Dead:
			#### K 3 canraise { 
				if(abs(vel.z) < 2.) frame++; 
			}
			#### L 5 canraise { 
				if(abs(vel.z) >=2.) 
					return ResolveState("Dead");
				return ResolveState(NULL);
			}
			Wait;
	}

}