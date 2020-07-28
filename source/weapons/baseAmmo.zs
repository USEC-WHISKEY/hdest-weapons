class BRoundAmmo : HDRoundAmmo {
	
	default {
		+Inventory.IgnoreSkill
		+HDPickup.cheatnogive
		+HDPickup.multipickup
		xscale 1;
		yscale 1;
		Inventory.icon "RCLSA3A7";
	}

	override void splitpickup(){
		int amm = min(amount, random(4, 26));
		while(amount > amm) {
			int ld = min(amount, random(4, 26));
			actor a = spawn(self.getClassName(), pos);
			a.vel += vel + (frandom(-1,1), frandom(-1,1), frandom(-1,1));
			a.angle = frandom(0, 360);
			inventory(a).amount = ld;
			amount -= ld;
		}
		if(amount < 1){
			destroy();
			return;
		}
	}

	states(actor) {
		spawn:
			RCLS A -1;
			stop;
	}

}

class BRoundShell : HDAmmo {
	default {
		+inventory.ignoreskill
		+forcexybillboard
		+cannotpush
		+hdpickup.multipickup
		+hdpickup.cheatnogive
		height 16;
		radius 8;
		XScale 1;
		YScale 1;
	}
	states {
		spawn:
			RBRS A -1;
			Stop;
	}	
}

class BRoundSpent : HDUPK {

	property ShellClass: shellClass;
	string shellClass;

	default {
		+Missile
		+HDUPK.multipickup
		Height 4;
		Radius 2;
		BounceType "Doom";
		bouncesound "misc/casing";
		xscale 1;
		yscale 1;
		maxstepheight 0.6;
	}

	override void postbeginplay(){
		super.postbeginplay();
		A_ChangeVelocity(frandom(-3,3), frandom(-0.4,0.4), 0, CVF_RELATIVE);
	}

	states {
		spawn:
			RBRS A 2 {
				angle+=45;
				if(floorz==pos.z&&!vel.z)A_Countdown();
			}
			Wait;

		death:
			RBRS A -1 {
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













class BBulletActor : HDBulletActor {
	override actor Puff(){
		//TODO: virtual actor puff(textureid hittex,bool reverse=false){}
			//flesh: bloodsplat
			//fluids: splash
			//anything else: puff and add bullet hole

		if(max(abs(pos.x),abs(pos.y))>32000)return null;
		double sp=speed*speed*mass*0.00001;
		if(sp<50)return null;
		let aaa=HDBulletPuff(spawn("HDBulletPuff",pos));
		if(aaa){
			aaa.angle=angle;aaa.pitch=pitch;
			aaa.stamina=int(sp*0.01);
			aaa.scarechance=20-int(sp*0.001);
			aaa.scale=(1.,1.)*(0.4+0.05*aaa.stamina);
		}
		return aaa;
	}
}