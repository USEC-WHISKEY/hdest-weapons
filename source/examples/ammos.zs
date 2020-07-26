
class B556Ammo : BRoundAmmo {
	default {
		tag "5.56x45mm round";
		hdpickup.refid "b56";
		hdpickup.bulk ENC_556;
	}
	override string pickupmessage(){
		return "Picked up a stray 5.56x45mm round.";
	}
}

class B556Brass : BRoundShell {
	default {
		tag "5.56 brass";
		HDPickUp.RefId "B556Brass";
		HdPickup.Bulk 1;
		Inventory.PickupMessage "Picked up some 5.56x45mm brass.";
	}
}

class B556Spent : BRoundSpent {
	default {
		BRoundSpent.ShellClass "B556Brass";
		HDUPK.PickupType "B556Brass";
		HDUPK.PickupMessage "Picked up some 5.56x45mm brass.";
	}
}

class BRPGRocketAmmo : BRoundAmmo {
	default {
		tag "RPG Rocket Ammo";
		hdpickup.bulk ENC_556;
	}
	override string pickupmessage() {
		return "Picked up an RPG rocket";
	}
	states(actor) {
		spawn:
			RPGR A -1;
			stop;
	}
}


class B762x51Ammo : BRoundAmmo {
	default {
		tag "7.62x51mm round";
		HDPickup.RefId "b75";
		HDPickup.Bulk ENC_762;
		Inventory.icon "BF76A3A7";
	}
	override string pickupmessage(){
		return "Picked up a stray 7.62x51mm round.";
	}
	states {
		spawn:
			BF76 A -1;
			stop;
	}
}

class B762x51Brass : BRoundShell {
	default {
		tag "7.62x51mm brass";
		HDPickup.RefId "B762x51Casing";
		HDPickup.Bulk 1;
		Inventory.PickupMessage "Picked up some 7.62x51mm brass.";
	}
	states {
		spawn:
			BB76 A -1;
			Stop;
	}	
}

class B762x51Spent : BRoundSpent {
	default {
		BRoundSpent.ShellClass "B762x51Brass";
		HDUPK.PickupType "B762x51Brass";
		HDUPK.PickupMessage "Picked up some 7.62x51 brass.";
	}

	states {
		spawn:
			BB76 A 2 {
				angle+=45;
				if(floorz==pos.z&&!vel.z)A_Countdown();
			}
			Wait;

		death:
			BB76 A -1 {
				actor p=spawn(invoker.shellClass,self.pos,ALLOW_REPLACE);
				p.vel = self.vel;
				p.vel.xy*=3;
				p.angle=angle;
				if(p.vel!=(0,0,0)){
					p.A_FaceMovementDirection();
					p.angle+=90;
				}
				destroy();
			}
			Stop;

	}
}





class B762Ammo : BRoundAmmo {
	default {
		tag "7.62x39mm round";
		hdpickup.refid "b76";
		hdpickup.bulk ENC_762;
	}
	override string pickupmessage(){
		return "Picked up a stray 7.62x39mm round.";
	}
}

class B762Brass : BRoundShell {
	default {
		tag "7.62x39mm brass";
		HDPickUp.RefId "B762Casing";
		HdPickup.Bulk 1;
		Inventory.PickupMessage "Picked up some 7.62x39mm brass.";
	}
}

class B762Spent : BRoundSpent {
	default {
		BRoundSpent.ShellClass "B762Brass";
		HDUPK.PickupType "B762Brass";
		HDUPK.PickupMessage "Picked up some 7.62x39mm brass.";
	}
}








class B792Ammo : BRoundAmmo {
	default {
		tag "7.92x57mm round";
		hdpickup.refid "b79";
		hdpickup.bulk ENC_762;
	}
	override string pickupmessage() {
		return "Picked up a stray 7.92x57mm round.";
	}
}

class B792Brass : BRoundShell {
	default {
		tag "7.92x57mm brass";
		HdPickup.RefId "B792Casing";
		HdPickup.Bulk 1;
		Inventory.PickupMessage "Picked up some 7.92x57mm brass";
	}
}

class B792Spent : BRoundSpent {
	default {
		BRoundSpent.ShellClass "B792Brass";
		HDUPK.PickupType "B792Brass";
		HDUPK.PickupMessage "Picked up some 7.92x57mm brass";
	}
}




