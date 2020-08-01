
class Level1Warrior : Actor {

	default {
		mass 100;
		radius 30;
		height 72;
		speed 8;
		health 9999999999;
		Monster;
		+FLOORCLIP
	}
	
	override void PostBeginPlay() {
		super.PostBeginPlay();
	}

	override bool Used (Actor user) {
		return true;
	}

	States {
		Spawn:
			LV1W A 10 A_Look;
			Loop;
		See:
			LV1W AAAAAAAA 5 A_Chase;
			Loop;
		Missile:
		Pain:
		Death:
		XDeath:
		Raise:
			LV1W A -1;
			Stop;
	}
}

class Level1Target : Actor {

	default {
		mass 100;
		radius 30;
		height 72;
		speed 8;
		health 9999999999;
		Monster;
		PainChance 256;
		+FLOORCLIP
	}


	override void PostBeginPlay() {
		super.PostBeginPlay();
	}

	override bool Used (Actor user) {
		return true;
	}

	States {
		Spawn:
			LV1T A 1;
			Loop;
		Missile:
		Pain:
			LV1T BCBCBCBCBC 5;
			Goto Spawn;
		Death:
		XDeath:
		Raise:
			LV1W A -1;
			Stop;


	}

}

