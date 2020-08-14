
class Wobbles : HDMobMan {

	default {
		obituary "%o was taken down by a ranger.";
		hitobituary "%s was smacked around by a ranger.";
		painchance 0;
		speed 4;
		seesound "";
		painsound "grunt/pain";
		deathsound "monsters/wobbles/dead";
		activesound "monsters/wobbles/alert";
	}
	
	bool dyingAlready;

	states {

	   Spawn:
	       BKAM AAAA 1 A_Look;
	       loop;

	   See:
	       BKAM ABCD 1 A_Chase;
	       loop;

	   Missile:
	   		#### A 1 {
	   			double distance = self.Distance3DSquared(target);
	   			if (distance < (32 * 32)) {
	   				SetStateLabel("Explode");
	   			}
			}
	       goto See;

	   Pain:
	       goto See;

		falldown:
	   Death:
	   Explode:
	   	   TNT1 A 0 {
	   	   	A_StartSound("monsters/wobbles/bye", CHAN_BODY, CHANF_OVERLAP);
	   	   }
		   BKAM A 35;
		   BKAM A 5 {
		   	A_HDBlast(
				pushradius:256,
				pushamount:128,
				fullpushradius:96,
				fragradius:1024
		   	);
			DistantQuaker.Quake(self,4,35,512,10);
			A_StartSound("world/explode",CHAN_AUTO);
			A_AlertMonsters();
			actor xpl=spawn("WallChunker",self.pos-(0,0,1),ALLOW_REPLACE);
				xpl.target=target;xpl.master=master;xpl.stamina=stamina;
			xpl=spawn("HDExplosion",self.pos-(0,0,1),ALLOW_REPLACE);
				xpl.target=target;xpl.master=master;xpl.stamina=stamina;
			A_SpawnChunks("BigWallChunk",14,4,12);
			A_SpawnChunks("HDB_frag",360,300,900);
			distantnoise.make(self,"world/rocketfar");
		   }

	   XDeath:
	       BMBE M 5;
	       BMBE N 5 A_XScream;
	       BMBE O 5 A_Fall;
	       BMBE PQRST 5;
	       BMBE U -1;
	       stop;

	   Raise:
	       Stop;
	}


}