function SetupHUD() {
	if (Game.GameStateIs(DOTA_GameState.DOTA_GAMERULES_STATE_GAME_IN_PROGRESS)) {
		const hud = $.GetContextPanel().FindAncestor("DotaHud");
		const hideAllChildren = (node) => {
			node.style.visibility = "collapse";
			for (const child of node.Children()) {
				child.style.visibility = "collapse";
				hideAllChildren(child);
			}
		}

		const hideDefaultElements = () => {
			hideAllChildren(hud.FindChildTraverse("StatBranch"))
			hideAllChildren(hud.FindChildTraverse("StatBranchDrawer"))
			hideAllChildren(hud.FindChildTraverse("level_stats_frame"))
			hideAllChildren(hud.FindChildTraverse("GridBasicsTab"))
			hideAllChildren(hud.FindChildTraverse("GridNeutralsTab"))
			hideAllChildren(hud.FindChildTraverse("TormentorTimerContainer"))
			hideAllChildren(hud.FindChildTraverse("inventory_neutral_craft_holder"))
			hideAllChildren(hud.FindChildTraverse("RoshanTimerContainer"))
			hideAllChildren(hud.FindChildTraverse("GlyphScanContainer"))

			$.DispatchEvent("Activated", hud.FindChildTraverse("GridUpgradesTab"), "mouse")

			$.Schedule(5, () => {
				hideDefaultElements()
			})
		}
		hideDefaultElements()
	}
}

(function () {
	GameEvents.Subscribe("game_rules_state_change", () => {
		$.Schedule(1, SetupHUD)
	});
})();

// Uncomment any of the following lines in order to disable that portion of the default UI

GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_AGHANIMS_STATUS, false);
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, false );     			//Heroes and team score at the top of the HUD.
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, false );      	//Lefthand flyout scoreboard.
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_PANEL, false );     		//Hero actions UI.
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_MINIMAP, false );     		//Minimap.
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_PANEL, false );      	//Entire Inventory UI
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_SHOP, false );     		//Shop portion of the Inventory. 
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_ITEMS, false );      	//Player items.
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_QUICKBUY, false );     	//Quickbuy.
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_COURIER, false );      	//Courier controls.
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_PROTECT, false );      	//Glyph.
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_GOLD, false );     		//Gold display.
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_SHOP_SUGGESTEDITEMS, false );      //Suggested items shop panel.
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_TEAMS, false );     //Hero selection Radiant and Dire player lists.
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_GAME_NAME, false ); //Hero selection game mode name display.
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_CLOCK, false );     //Hero selection clock.
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_MENU_BUTTONS, false );     	//Top-left menu buttons in the HUD.
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ENDGAME, false );      			//Endgame scoreboard.    
//GameUI.SetDefaultUIEnabled( DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_BAR_BACKGROUND, false );     	//Top-left menu buttons in the HUD.

// These lines set up the panorama colors used by each team (for game select/setup, etc)
GameUI.CustomUIConfig().team_colors = {}
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_GOODGUYS] = "#3dd296;";
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_BADGUYS] = "#F3C909;";
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_1] = "#c54da8;";
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_2] = "#FF6C00;";
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_3] = "#3455FF;";
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_4] = "#65d413;";
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_5] = "#815336;";
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_6] = "#1bc0d8;";
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_7] = "#c7e40d;";
GameUI.CustomUIConfig().team_colors[DOTATeam_t.DOTA_TEAM_CUSTOM_8] = "#8c2af4;";
