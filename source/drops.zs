
class MultiSpawner : Actor {
	default {
		+noblockmap
		+nosector
		+nogravity
		+thruactors
	}
	override void PostBeginPlay() {
		DoSpawn();
	}
	void DoSpawn() {
		DropItem iter;
		DropItem curr;
		iter = GetDropItems();
		while (iter != null) {
			double rng = random(0, 359);
			double rx = cos(rng);
			double ry = sin(rng);
			let npos = pos + (rx, ry, 0);
			let act = Spawn(iter.name, npos);
			act.vel += (rx, ry, 0);
			iter = iter.next;
		}
	}
}

class M16Spawner : MultiSpawner {
	default {
		DropItem "M16_AssaultRifle";
		DropItem "B556Mag";
		DropItem "B556Mag";
	}
}
