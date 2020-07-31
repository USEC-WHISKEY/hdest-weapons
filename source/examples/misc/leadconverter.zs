
class B_BallCrafter : HDWeapon {
	default {
		+Weapon.Wimpy_Weapon
		+Inventory.Invbar
		+HDWeapon.FitsInBackpack
		inventory.pickupsound "misc/w_pkup";
		inventory.pickupmessage "You got the M249 pouch reloading machine!";
		scale 0.5;
		hdweapon.refid "r04";
		tag "M249 pouch reloading machine";
	}

	override double gunMass() { return 0; }
	override double weaponBulk() { return 20 * amount; }
	override string,double getpickupsprite(){
		return "BRLAA0",1.;
	}
}