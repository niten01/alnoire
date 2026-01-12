BAREBONES_VERSION = "2.1.1"

-- Selection library (by Noya) provides player selection inspection and management from server lua
require('libraries/selection')

-- settings.lua is where you can specify many different properties for your game mode and is one of the core barebones files.
require('settings')
-- events.lua is where you can specify the actions to be taken when any event occurs and is one of the core barebones files.
require('events')
-- filters.lua
require('filters')

require('libraries.animations')
require('libraries.event')
require('libraries.functional')

require('internal.gameevents')
require('internal.eventrouter')

require('modifiers.linker')

require('modules.spawn')

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function barebones:OnAllPlayersLoaded()
	DebugPrint("[BAREBONES] All Players have loaded into the game.")
end

--[[
  This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
  gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
  is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]
function barebones:OnGameInProgress()
	DebugPrint("[BAREBONES] The game has officially begun.")

	-- If the day/night is not changed at 00:00, the following line is needed:
	GameRules:SetTimeOfDay(0.251)
end

-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function barebones:InitGameMode()
	DebugPrint("[BAREBONES] Starting to load Game Rules.")

	-- Setup rules
	GameRules:SetSameHeroSelectionEnabled(ALLOW_SAME_HERO_SELECTION)
	GameRules:SetUseUniversalShopMode(UNIVERSAL_SHOP_MODE)
	GameRules:SetHeroRespawnEnabled(ENABLE_HERO_RESPAWN)

	GameRules:SetHeroSelectionTime(HERO_SELECTION_TIME) -- THIS IS IGNORED when "EnablePickRules" is "1" in 'addoninfo.txt' !
	GameRules:SetHeroSelectPenaltyTime(HERO_SELECTION_PENALTY_TIME)

	GameRules:SetPreGameTime(PRE_GAME_TIME)
	GameRules:SetPostGameTime(POST_GAME_TIME)
	GameRules:SetShowcaseTime(SHOWCASE_TIME)
	GameRules:SetStrategyTime(STRATEGY_TIME)

	GameRules:SetTreeRegrowTime(TREE_REGROW_TIME)

	if USE_CUSTOM_HERO_LEVELS then
		GameRules:SetUseCustomHeroXPValues(true)
	end

	--GameRules:SetGoldPerTick(GOLD_PER_TICK) -- Doesn't work; Last time tested: 24.2.2020
	--GameRules:SetGoldTickTime(GOLD_TICK_TIME) -- Doesn't work; Last time tested: 24.2.2020
	GameRules:SetStartingGold(NORMAL_START_GOLD)

	if USE_CUSTOM_HERO_GOLD_BOUNTY then
		GameRules:SetUseBaseGoldBountyOnHeroes(false) -- if true Heroes will use their default base gold bounty which is similar to creep gold bounty, rather than DOTA specific formulas
	end

	GameRules:SetHeroMinimapIconScale(MINIMAP_ICON_SIZE)
	GameRules:SetCreepMinimapIconScale(MINIMAP_CREEP_ICON_SIZE)
	GameRules:SetRuneMinimapIconScale(MINIMAP_RUNE_ICON_SIZE)
	GameRules:SetFirstBloodActive(ENABLE_FIRST_BLOOD)
	GameRules:SetHideKillMessageHeaders(HIDE_KILL_BANNERS)
	GameRules:LockCustomGameSetupTeamAssignment(LOCK_TEAMS)
	
	-- TO TEST:
	--GameRules:SetAllowOutpostBonuses(true)
	--GameRules:SetEnableAlternateHeroGrids(false) -- disable alternate hero grids to be used (DOTA+, etc) useful when you have custom heroes
	GameRules:SetSuggestItemsEnabled(false)
	-- HERO BLACK LIST
	--GameRules:SetHideBlacklistedHeroes(true) -- true is hidden, false is dimmed during hero selection
	--GameRules:AddHeroIDToBlacklist(int)
	--GameRules:AddHeroToBlacklist(string)
	--GameRules:ClearHeroBlacklist()
	--GameRules:RemoveHeroFromBlacklist(string)
	--GameRules:RemoveHeroIDFromBlacklist(int)
	-- ITEM WHITE LIST
	--GameRules:SetWhiteListEnabled(true)
	--GameRules:AddItemToWhiteList(string)
	--GameRules:IsItemInWhiteList(string)
	--GameRules:RemoveItemFromWhiteList(string)

	DebugPrint("[BAREBONES] Done with setting Game Rules.")

	-- Event Hooks / Listeners
	DebugPrint("[BAREBONES] Setting Event Hooks / Listeners.")
	ListenToGameEvent('dota_player_gained_level', Dynamic_Wrap(barebones, 'OnPlayerLevelUp'), self)
	ListenToGameEvent('dota_player_learned_ability', Dynamic_Wrap(barebones, 'OnPlayerLearnedAbility'), self)
	ListenToGameEvent('entity_killed', Dynamic_Wrap(barebones, 'OnEntityKilled'), self)
	ListenToGameEvent('player_connect_full', Dynamic_Wrap(barebones, 'OnConnectFull'), self)
	ListenToGameEvent('player_disconnect', Dynamic_Wrap(barebones, 'OnDisconnect'), self)
	ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(barebones, 'OnItemPickedUp'), self)
	ListenToGameEvent('last_hit', Dynamic_Wrap(barebones, 'OnLastHit'), self)
	ListenToGameEvent('dota_rune_activated_server', Dynamic_Wrap(barebones, 'OnRuneActivated'), self)
	ListenToGameEvent('tree_cut', Dynamic_Wrap(barebones, 'OnTreeCut'), self)

	ListenToGameEvent('dota_player_used_ability', Dynamic_Wrap(barebones, 'OnAbilityUsed'), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(barebones, 'OnGameRulesStateChange'), self)
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(barebones, 'OnNPCSpawned'), self)
	ListenToGameEvent('dota_player_pick_hero', Dynamic_Wrap(barebones, 'OnPlayerPickHero'), self)
	ListenToGameEvent("player_reconnected", Dynamic_Wrap(barebones, 'OnPlayerReconnect'), self)
	ListenToGameEvent("player_chat", Dynamic_Wrap(barebones, 'OnPlayerChat'), self)

	ListenToGameEvent("dota_player_selected_custom_team", Dynamic_Wrap(barebones, 'OnPlayerSelectedCustomTeam'), self)
	ListenToGameEvent("dota_npc_goal_reached", Dynamic_Wrap(barebones, 'OnNPCGoalReached'), self)

	-- Change random seed for math.random function
	local timeTxt = string.gsub(string.gsub(GetSystemTime(), ':', ''), '0','')
	local timeNumber = tonumber(timeTxt)
	if timeNumber then
		math.randomseed(timeNumber) 
	end

	DebugPrint("[BAREBONES] Setting Filters.")

	local gamemode = GameRules:GetGameModeEntity()

	gamemode:SetExecuteOrderFilter(Dynamic_Wrap(barebones, "OrderFilter"), self)
	gamemode:SetDamageFilter(Dynamic_Wrap(barebones, "DamageFilter"), self)
	gamemode:SetModifierGainedFilter(Dynamic_Wrap(barebones, "ModifierFilter"), self)
	gamemode:SetModifyExperienceFilter(Dynamic_Wrap(barebones, "ExperienceFilter"), self)
	gamemode:SetTrackingProjectileFilter(Dynamic_Wrap(barebones, "ProjectileFilter"), self)
	gamemode:SetBountyRunePickupFilter(Dynamic_Wrap(barebones, "BountyRuneFilter"), self)
	gamemode:SetHealingFilter(Dynamic_Wrap(barebones, "HealingFilter"), self)
	gamemode:SetModifyGoldFilter(Dynamic_Wrap(barebones, "GoldFilter"), self)
	gamemode:SetItemAddedToInventoryFilter(Dynamic_Wrap(barebones, "InventoryFilter"), self)

	DebugPrint("[BAREBONES] Done with setting Filters.")

	-- Global Lua Modifiers
	-- LinkLuaModifier("modifier_custom_invulnerable", "modifiers/modifier_custom_invulnerable.lua", LUA_MODIFIER_MOTION_NONE)
	-- LinkLuaModifier("modifier_custom_passive_gold", "modifiers/modifier_custom_passive_gold_example.lua", LUA_MODIFIER_MOTION_NONE)

	print("[BAREBONES] initialized.")
	DebugPrint("[BAREBONES] Done loading the game mode!\n\n")

	-- Increase/decrease maximum item limit per hero
	Convars:SetInt('dota_max_physical_items_purchase_limit', 64)
end

-- This function is called as the first player loads and sets up the game mode parameters
function barebones:CaptureGameMode()
	local gamemode = GameRules:GetGameModeEntity()

	-- Set GameMode parameters
	gamemode:SetRecommendedItemsDisabled(RECOMMENDED_BUILDS_DISABLED)
	gamemode:SetCameraDistanceOverride(CAMERA_DISTANCE_OVERRIDE)
	gamemode:SetBuybackEnabled(BUYBACK_ENABLED)
	gamemode:SetCustomBuybackCostEnabled(CUSTOM_BUYBACK_COST_ENABLED)
	gamemode:SetCustomBuybackCooldownEnabled(CUSTOM_BUYBACK_COOLDOWN_ENABLED)
	gamemode:SetTopBarTeamValuesOverride(USE_CUSTOM_TOP_BAR_VALUES) -- Probably does nothing, but I will leave it
	gamemode:SetTopBarTeamValuesVisible(TOP_BAR_VISIBLE)

	if USE_CUSTOM_XP_VALUES then
		gamemode:SetUseCustomHeroLevels(true)
		gamemode:SetCustomXPRequiredToReachNextLevel(XP_PER_LEVEL_TABLE)
	elseif MAX_LEVEL ~= 30 then
		gamemode:SetCustomHeroMaxLevel(MAX_LEVEL) -- this is not needed if SetCustomXPRequiredToReachNextLevel is used
	end

	gamemode:SetBotThinkingEnabled(USE_STANDARD_DOTA_BOT_THINKING)
	gamemode:SetTowerBackdoorProtectionEnabled(ENABLE_TOWER_BACKDOOR_PROTECTION)

	gamemode:SetFogOfWarDisabled(DISABLE_FOG_OF_WAR_ENTIRELY)
	gamemode:SetGoldSoundDisabled(DISABLE_GOLD_SOUNDS)
	--gamemode:SetRemoveIllusionsOnDeath(REMOVE_ILLUSIONS_ON_DEATH) -- Didnt work last time I tried

	gamemode:SetAlwaysShowPlayerInventory(SHOW_ONLY_PLAYER_INVENTORY)
	--gamemode:SetAlwaysShowPlayerNames(true) -- use this when you need to hide real hero names
	gamemode:SetAnnouncerDisabled(DISABLE_ANNOUNCER)

	if FORCE_PICKED_HERO then -- FORCE_PICKED_HERO must be a string name of an existing hero, or there will be a big fat error
		gamemode:SetCustomGameForceHero(FORCE_PICKED_HERO) -- THIS WILL NOT WORK when "EnablePickRules" is "1" in 'addoninfo.txt' !
	else
		gamemode:SetDraftingHeroPickSelectTimeOverride(HERO_SELECTION_TIME)
		gamemode:SetDraftingBanningTimeOverride(0)
		if ENABLE_BANNING_PHASE then
			gamemode:SetDraftingBanningTimeOverride(BANNING_PHASE_TIME)
			GameRules:SetCustomGameBansPerTeam(5)
		end
	end

	--gamemode:SetFixedRespawnTime(FIXED_RESPAWN_TIME) -- FIXED_RESPAWN_TIME should be float
	gamemode:SetFountainConstantManaRegen(FOUNTAIN_CONSTANT_MANA_REGEN)
	gamemode:SetFountainPercentageHealthRegen(FOUNTAIN_PERCENTAGE_HEALTH_REGEN)
	gamemode:SetFountainPercentageManaRegen(FOUNTAIN_PERCENTAGE_MANA_REGEN)
	gamemode:SetLoseGoldOnDeath(LOSE_GOLD_ON_DEATH)
	gamemode:SetMaximumAttackSpeed(MAXIMUM_ATTACK_SPEED)
	gamemode:SetMinimumAttackSpeed(MINIMUM_ATTACK_SPEED)
	gamemode:SetStashPurchasingDisabled(DISABLE_STASH_PURCHASING)

	if USE_DEFAULT_RUNE_SYSTEM then
		gamemode:SetUseDefaultDOTARuneSpawnLogic(true)
	else
		-- Some runes are broken by Valve, RuneSpawnFilter also didn't work last time I tried
		for rune, spawn in pairs(ENABLED_RUNES) do
			gamemode:SetRuneEnabled(rune, spawn)
		end
		gamemode:SetBountyRuneSpawnInterval(BOUNTY_RUNE_SPAWN_INTERVAL)
		gamemode:SetPowerRuneSpawnInterval(POWER_RUNE_SPAWN_INTERVAL)
	end

	gamemode:SetUnseenFogOfWarEnabled(USE_UNSEEN_FOG_OF_WAR)
	gamemode:SetDaynightCycleDisabled(DISABLE_DAY_NIGHT_CYCLE)
	gamemode:SetKillingSpreeAnnouncerDisabled(DISABLE_KILLING_SPREE_ANNOUNCER)
	gamemode:SetStickyItemDisabled(DISABLE_STICKY_ITEM)
	gamemode:SetPauseEnabled(ENABLE_PAUSING)
	gamemode:SetCustomScanCooldown(CUSTOM_SCAN_COOLDOWN)
	gamemode:SetCustomGlyphCooldown(CUSTOM_GLYPH_COOLDOWN)
	gamemode:DisableHudFlip(FORCE_MINIMAP_ON_THE_LEFT)

	gamemode:SetFreeCourierModeEnabled(true) -- without this, passive GPM doesn't work, Thanks Valve
	--gamemode:SetUseTurboCouriers(true)
	--gamemode:SetGiveFreeTPOnDeath(false) -- disables free tp scroll on death
	--gamemode:SetTPScrollSlotItemOverride(itemname) -- replace tp scroll slot with something else
	--gamemode:SetSelectionGoldPenaltyEnabled(false) -- disables hero selection penalty

	-- TO TEST:
	--gamemode:SetAllowNeutralItemDrops(false) -- disables neutral items from dropping?
	--gamemode:SetCanSellAnywhere(true) -- global shop?
	--gamemode:SetFriendlyBuildingMoveToEnabled(true) -- maybe enables rightclicking friendly buildings without meepmeep invulnerable warning
	--gamemode:SetKillableTombstones(true) -- drops tombstone on death or useless?
	--gamemode:SetNeutralItemHideUndiscoveredEnabled(true) -- undiscovered items in the neutral item stash are hidden.
	--gamemode:SetNeutralStashTeamViewOnlyEnabled(true) -- the all neutral items tab cannot be viewed? you can't see all neutrals but only found?
	--gamemode:SetRandomHeroBonusItemGrantDisabled(false) -- enables faerie fire and mango maybe when randoming
end


local function AttachCustomWearable(hero, modelPath)
	if not IsServer() or not hero then return end

	local wearable = SpawnEntityFromTableSynchronous("prop_dynamic", {
		model = modelPath,
	})

	-- Bone-merge to hero so it follows animations like a wearable
	wearable:FollowEntity(hero, true) -- true = bone merge
	return wearable
end

-- local OnNPCSpawnedEvent = CreateGameEvent('OnNPCSpawned')
-- function GameMode:OnNPCSpawned(keys)
--     local unit = EntIndexToHScript(keys.entindex)

--     if not unit or unit:IsNull() then return end
--     if not unit:IsRealHero() then return end

--     if unit.bLevelModelInit then return end
--     unit.bLevelModelInit = true

--     -- unit:AddNewModifier(unit, nil, "modifier_model", { duration = -1 })
--     -- AttachCustomWearable(unit, "models/heroes/dragon_knight_persona/dk_persona_weapon_full.vmdl")

--     OnNPCSpawnedEvent(keys)
-- end

-- local OnHeroSpawnedEvent = CreateGameEvent('OnHeroSpawned')
-- function GameMode:OnHeroSpawned(keys)
--     DebugPrint("[BAREBONES] NPC Spawned")
--     DebugPrintTable(keys)
--     OnHeroSpawnedEvent(keys)
-- end

-- local OnGameInProgressEvent = CreateGameEvent('OnGameInProgress')
-- function GameMode:OnGameInProgress(keys)
--     InitModule(SpawnManager)

--     OnGameInProgressEvent(keys)
-- end

-- function InitModule(module)
--     if module == nil then
--         return
--     end

--     if module.initialized == true then
--         print("Module " ..
--             tostring(module.moduleName) ..
--             " is already initialized and there was an attempt to initialize it again -> preventing")
--         return
--     end

--     local status, err = pcall(function() --luacheck: ignore status
--         module:Init()
--         module.initialized = true
--     end)
--     if err then
--         local info = debug.getinfo(2, "Sl")
--         print("Script Runtime Error: " .. info.source:sub(2) .. ":" .. info.currentline .. ": " .. err)
--         print(debug.traceback())
--         print('Failed to init module!!!')
--     end
-- end
