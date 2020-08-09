
class AttachmentMenu : GenericMenu {
	
	int choice;
	Font fnt;
	Font bigfnt;
	TextureID cursorTex;

	override void Init (Menu parent) {
		super.Init(parent);
		fnt = Font.GetFont("smallfont");
		bigfnt = Font.GetFont("Bigfont");
		cursorTex = TexMan.checkForTexture("STCFN062", TexMan.Type_Sprite);
		choice = 0;
		DontDim = True;
		PlayerInfo info = players[consoleplayer];
		BHDWeapon weapon = BHDWeapon(info.readyWeapon);
		menuactive = Menu.OnNoPause;
	}

	override bool MenuEvent (int mkey, bool fromController) {
		if (mkey == MKEY_BACK) {
			return super.MenuEvent(mkey, fromController);
		}
		else if (mkey == MKEY_UP) {
			choice--;
			if (choice == -1) {
				choice = 3;
			}
			return false;
		}
		else if (mkey == MKEY_DOWN) {
			choice++;
			if (choice == 4) {
				choice = 0;
			}
			return false;
		}
		else if (mkey == MKEY_ENTER) {
			// Remove Attachment
			PlayerInfo info = players[consoleplayer];
			BHDWeapon weapon = BHDWeapon(info.readyWeapon);
			HDPlayerPawn hpp = HDPlayerPawn(info.mo);
			switch (choice) {
				case 0:
					if (weapon.barrelClass) {
						AttachmentManager.SendNetworkEvent("removeattachment:barrel");
					}
					else {
						return false;
					}
					break;
				case 1:
					if (weapon.scopeClass) {
						AttachmentManager.SendNetworkEvent("removeattachment:scope");
					}
					else {
						return false;
					}
					break;
				case 2:
					if (weapon.miscClass) {
						AttachmentManager.SendNetworkEvent("removeattachment:misc");
					}
					else {
						return false;
					}
			}
			return super.MenuEvent(MKEY_BACK, fromController);
		}
		else {
			return false;
		}
	}

	override bool MouseEvent(int type, int x, int y) {
		//console.printf("%i %i %i", type, x, y);
		return false;
	}

	void DrawWeapon(PlayerInfo info, BHDWeapon weapon) {
		TextureID wepTex = TexMan.checkForTexture(weapon.BSpriteWithMag, TexMan.Type_Sprite);
		screen.DrawTexture(wepTex, false, 30, 40, DTA_320x200, 1, DTA_CenterOffset, 1);
		let weaponTag = GetDefaultByType((Class<BHDWeapon>)(weapon.getClass())).GetTag();
		screen.DrawText(fnt, Font.CR_CYAN, 30, 40, "Weapon", DTA_320x200, 1);
		screen.DrawText(fnt, Font.CR_WHITE, 90, 40, weaponTag, DTA_320x200, 1);
	}

	void DrawBarrel(PlayerInfo info, BHDWeapon weapon) {
		let clr = Font.CR_BLACK;
		if (weapon.barrelClass) {
			let barrelTag = GetDefaultByType((Class<BaseAttachment>)(weapon.barrelClass)).GetTag();
			screen.DrawText(fnt, Font.CR_WHITE, 90, 60, barrelTag, DTA_320x200, 1);

			let barrelIcon = GetDefaultByType((Class<BaseAttachment>)(weapon.barrelClass)).Icon;
			screen.DrawTexture(barrelIcon, false, 30, 60, DTA_320x200, 1, DTA_CenterOffset, 1);
			clr = Font.CR_RED;
		}
		else {
			screen.DrawText(fnt, Font.CR_BLACK, 90, 60, "N/A", DTA_320x200, 1);
		}
		screen.DrawText(fnt, clr, 32, 60, "Muzzle", DTA_320x200, 1);
	}

	void DrawScope(PlayerInfo info, BHDWeapon weapon) {
		let clr = Font.CR_BLACK;
		if (weapon.scopeClass) {
			let scopeTag = GetDefaultByType((Class<BaseAttachment>)(weapon.scopeClass)).GetTag();
			screen.DrawText(fnt, Font.CR_WHITE, 90, 80, scopeTag, DTA_320x200, 1);

			let scopeIcon = GetDefaultByType((Class<BaseAttachment>)(weapon.scopeClass)).Icon;
			screen.DrawTexture(scopeIcon, false, 30, 80, DTA_320x200, 1, DTA_CenterOffset, 1);
			clr = Font.CR_RED;
		}
		else {
			screen.DrawText(fnt, Font.CR_BLACK, 90, 80, "N/A", DTA_320x200, 1);
		}
		screen.DrawText(fnt, clr, 40, 80, "Sight", DTA_320x200, 1);
	}

	void DrawMisc(PlayerInfo info, BHDWeapon weapon) {
		let clr = Font.CR_BLACK;
		if (weapon.miscClass) {
			let miscTag = GetDefaultByType((Class<BaseAttachment>)(weapon.miscClass)).GetTag();
			screen.DrawText(fnt, Font.CR_WHITE, 90, 100, miscTag, DTA_320x200, 1);

			let miscIcon = GetDefaultByType((Class<BaseAttachment>)(weapon.miscClass)).Icon;
			screen.DrawTexture(miscIcon, false, 30, 100, DTA_320x200, 1, DTA_CenterOffset, 1);
			clr = Font.CR_RED;
		}
		else {
			screen.DrawText(fnt, Font.CR_BLACK, 90, 100, "N/A", DTA_320x200, 1);
		}
		screen.DrawText(fnt, clr, 51, 100, "Misc", DTA_320x200, 1);
	}

	void DrawOptions(PlayerInfo info, BHDWeapon weapon) {

		if (weapon.barrelClass) {
			screen.DrawText(fnt, Font.CR_WHITE, 10, 130, "Detach muzzle", DTA_320x200, 1);
		} 
		else {
			screen.DrawText(fnt, Font.CR_BLACK, 10, 130, "No muzzle attachment", DTA_320x200, 1);
		}

		if (weapon.scopeClass) {
			screen.DrawText(fnt, Font.CR_WHITE, 10, 140, "Detach sight", DTA_320x200, 1);
		}
		else {
			screen.DrawText(fnt, Font.CR_BLACK, 10, 140, "No sight attachment", DTA_320x200, 1);
		}

		if (weapon.miscClass) {
			screen.DrawText(fnt, Font.CR_WHITE, 10, 150, "Detach misc", DTA_320x200, 1);
		}
		else {
			screen.DrawText(fnt, Font.CR_BLACK, 10, 150, "No misc attachment", DTA_320x200, 1);
		}

		screen.DrawText(fnt, Font.CR_RED, 10, 160, "Close", DTA_320x200, 1);


		let ypos = (choice * 10) + 130;
		screen.DrawTexture(cursorTex, false, 3, ypos, DTA_320x200, 1);
	}

	override void Drawer() {
		PlayerInfo info = players[consoleplayer];
		BHDWeapon weapon = BHDWeapon(info.readyWeapon);
		HDPlayerPawn hpp = HDPlayerPawn(info.mo);
		if (!weapon) {
			console.printf("Active weapon does not support attachments.");
			close();
			return;
		}

		if (weapon.attachmentBusy) {
			console.printf("Cannot open attachment menu at this time.");
			close();
			return;
		}

		let blackTex = TexMan.checkForTexture("blackdot", TexMan.Type_Sprite);
		screen.drawTexture(blackTex, false, 160, 100, DTA_320x200, 1, DTA_CenterOffset, 1, DTA_DestWidth, 5000, DTA_DestHeight, 5000, DTA_Alpha, 0.3);
		screen.DrawText(bigfnt, Font.CR_BLACK, 50, 10, "Attachment Manager", DTA_320x200, 1);

		DrawWeapon(info, weapon);
		DrawBarrel(info, weapon);
		DrawScope(info, weapon);
		DrawMisc(info, weapon);
		DrawOptions(info, weapon);

		super.Drawer();
	}


}