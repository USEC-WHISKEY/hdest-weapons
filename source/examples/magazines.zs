
class B556Mag : HDMagAmmo{
	default{
		hdmagammo.maxperunit 30;
		hdmagammo.roundtype "B556Ammo";
		hdmagammo.roundbulk ENC_556_LOADED;
		hdmagammo.magbulk ENC_556MAG_EMPTY;
		hdpickup.refid B_556_MAG_REFID;
		tag "5.56x45mm magazine";
		inventory.pickupmessage "Picked up a 5.56x45mm NATO STANAG magazine.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt) {
		return "M4RCA0", "BB56A7A3", "B556Ammo", 1.7;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_M4");
		itemsthatusethis.push("B_M4_M203");
	}

	states{
		spawn:
			M4RC A -1;
			stop;
		spawnempty:
			M4RC B -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}
}

class B556MagEmpty:IdleDummy{
	override void postbeginplay(){
		super.postbeginplay();
		HDMagAmmo.SpawnMag(self,"B556Mag",0);
		destroy();
	}
}

class BM249Mag : HDMagAmmo {
	default{
		hdmagammo.maxperunit 200;
		hdmagammo.roundtype "B556Ammo";
		hdmagammo.roundbulk ENC_556_LOADED;
		hdmagammo.magbulk ENC_556MAG_EMPTY;
		hdpickup.refid B_MF249_MAG_REFID;
		tag "5.56x45mm 200 round pouch";
		inventory.pickupmessage "Picked up a 5.56x45mm 200 Round NATO STANAG magazine.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "M24CA0", "BB56A7A3", "B556Ammo", 1.7;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_M249");
	}

	states{
		spawn:
			M24C A -1;
			stop;
		spawnempty:
			M24C B -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}
}

class BM249MagEmpty:IdleDummy{
	override void postbeginplay(){
		super.postbeginplay();
		HDMagAmmo.SpawnMag(self,"BM249Mag",0);
		destroy();
	}
}

class B9mm_MP5K_MAG : HDMagAmmo {
	default{
		hdmagammo.maxperunit 30;
		hdmagammo.roundtype "HDPistolAmmo";
		hdmagammo.roundbulk ENC_556_LOADED;
		hdmagammo.magbulk ENC_556MAG_EMPTY;
		hdpickup.refid B_MP5_MAG_REFID;
		tag "MP5 Magazine";
		inventory.pickupmessage "Picked up a MP5 magazine.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "MP5CA0", "PBRSA0", "HDPistolAmmo", 1.7;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_MP5");
		itemsthatusethis.push("B_MP5_M203");
	}

	states{
		spawn:
			MP5C A -1;
			stop;
		spawnempty:
			MP5C B -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}
}

class BFauxDrum : HDMagAmmo {
	default {
		hdmagammo.maxperunit 20;
		hdmagammo.roundtype "HDShellAmmo";
		hdmagammo.roundbulk ENC_556_LOADED;
		hdmagammo.magbulk ENC_556MAG_EMPTY;
		hdpickup.refid B_FAUX_DRUM_REFID;
		tag "Fauxtech Origin 12 Drum";
		inventory.pickupmessage "Picked up a Fauxtech Origin 12 drum.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "FOSCA0", "SHL1A0", "HDShellAmmo", 1.7;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("b_FauxtechOrigin");
	}

	states{
		spawn:
			FOSC A -1;
			stop;
		spawnempty:
			FOSC B -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}

}


class b762_m14_mag : HDMagAmmo {
	default {
		HDMagAmmo.MaxPerUnit 20;
		HDMagAmmo.RoundType "B762x51Ammo";
		HDMagAmmo.RoundBulk ENC_776_LOADED;
		HDMagAmmo.MagBulk ENC_776MAG_EMPTY;
		tag "7.62x51mm magazine";
		hdpickup.refid B_M14_MAG_REFID;
		inventory.pickupmessage "Picked up a 7.62x51mm NATO magazine.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "M14CA0", "BF76A3A7", "B762x51Ammo", 1.7;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("b_m14");
	}

	states{
		spawn:
			M14C A -1;
			stop;
		spawnempty:
			M14C B -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}
}

class GlockMagazine : HDMagAmmo {
	default{
		hdmagammo.maxperunit 15;
		hdmagammo.roundtype "HDPistolAmmo";
		hdmagammo.roundbulk ENC_762_LOADED;
		hdmagammo.magbulk ENC_762MAG_EMPTY;
		hdpickup.refid B_GLOCK_MAG_REFID;
		tag "Glock magazine";
		inventory.pickupmessage "Picked up a Glock magazine.";
		scale 0.8;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "GLKCA0", "PBRSA0", "HDPistolAmmo", 1.7;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("b_Glock");
	}

	states{
		spawn:
			GLKC A -1;
			stop;
		spawnempty:
			GLKC B -1{
				brollsprite = true;
				brollcenter = true;
				roll = randompick(0, 0, 0, 0, 2, 2, 2, 2, 1, 3) * 90;
			}
			stop;
	}
}

class BryanHeat : GyroGrenade {
	states {
		spawn:
			RPGR A 0 nodelay { 
				primed = true; 
			}
			Goto SpawnRocket;
	}
}




class BRpgRocket : HDMagAmmo {
	default{
		hdmagammo.maxperunit 1;
		hdmagammo.roundtype "HEATAmmo";
		hdmagammo.roundbulk ENC_762_LOADED;
		hdmagammo.magbulk ENC_762MAG_EMPTY;
		hdpickup.refid B_RPG_ROCKET_REFID;
		tag "RPG Rocket";
		inventory.pickupmessage "Picked up a RPG rocket.";
		scale 0.3;
	}

	override string,string,name,double getmagsprite(int thismagamt){
		return "RPGRA6A4", "ROCKA0", "HEATAmmo", 0.8;
	}

	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_RPGLauncher");
	}

	states{
		spawn:
			RPGR A -1;
			stop;
		spawnempty:
			RPGR B -1;
			stop;
	}
}
