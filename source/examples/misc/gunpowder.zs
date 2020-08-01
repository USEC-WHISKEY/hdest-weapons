
class B_GunPowder : BRoundAmmo {
	default {
		tag "Black powder";
		hdpickup.bulk 1;
		Inventory.Icon "BBBGA0";
	}
	override string pickupmessage(){
		return "Picked up gun powder.";
	}
	states {
		spawn:
			BBBG A -1;
			stop;
	}
	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_BulletAssembler");
	}
}

class B_GunPowderBag : HDUPK {
	default {
		hdupk.amount 90;
		hdupk.pickupsound "weapons/pocket";
		hdupk.pickupmessage "Picked up some gun powder.";
		hdupk.pickuptype "B_GunPowder";
	}
	states{
	spawn:
		BBBG B -1;
	}
}



class B_556Ball : BRoundAmmo {
	default {
		tag "5.56mm ball";
		hdpickup.bulk 1;
		Inventory.Icon "B56TA0";
	}
	override string pickupmessage(){
		return "Picked up a 5.56mm ball.";
	}
	states {
		spawn:
			B56T A -1;
			stop;
	}
	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_BulletAssembler");
	}
}

class B_762Ball : BRoundAmmo {
	default {
		tag "7.62mm ball";
		hdpickup.bulk 1;
		Inventory.Icon "B76TA0";
	}
	override string pickupmessage(){
		return "Picked up a 7.62mm ball.";
	}
	states {
		spawn:
			B76T A -1;
			stop;
	}
	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_BulletAssembler");
	}
}



class B_Lead : BRoundAmmo {
	default {
		tag "Lead";
		hdpickup.bulk 1;
		Inventory.Icon "BBBGC0";
	}
	override string pickupmessage() {
		return "Picked up lead.";
	}
	states {
		spawn:
			BBBG C -1;
			Stop;
	}
	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_BallCrafter");
	}
}

class B_LeadRock : HDUPK {
	default {
		hdupk.amount 50;
		hdupk.pickupsound "weapons/pocket";
		hdupk.pickupmessage "Picked up a bunch of lead?";
		hdupk.pickuptype "B_Lead";
	}
	states{
	spawn:
		BBBG D -1;
	}
}



class B_Brass : BRoundAmmo {
	default {
		tag "Brass";
		hdpickup.bulk 1;
		Inventory.Icon "BBBGE0";
	}
	override string pickupmessage() {
		return "Picked up brass sheet.";
	}
	states {
		spawn:
			BBBG E -1;
			Stop;
	}
	override void GetItemsThatUseThis() {
		itemsthatusethis.push("B_BallCrafter");
		itemsthatusethis.push("B_CaseCrafter");
	}
}

class B_BrassSheets : HDUPK {
	default {
		hdupk.amount 50;
		hdupk.pickupsound "weapons/pocket";
		hdupk.pickupmessage "Picked up a bunch of brass sheets?";
		hdupk.pickuptype "B_brass";
	}
	states{
	spawn:
		BBBG F -1;
	}
}