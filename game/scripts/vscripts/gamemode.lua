if GameMode == nil then
    DebugPrint("[BAREBONES] Creating barebones game mode")
    GameMode = class({})
end

require('libraries.animations')
require('libraries.event')
require('libraries.functional')

require('internal.gameevents')
require('internal.eventrouter')

require('modifiers.linker')

require('modules.spawn')

local OnInitGameModeEvent = CreateGameEvent('OnInitGameMode')
function GameMode:InitGameMode()
    print("Template addon is loaded.")

    GameMode.dialogueState = {}
    GameMode.npcs = {}
    GameMode.nearCooldown = {}

    GameRules:EnableCustomGameSetupAutoLaunch(true)
    GameRules:SetCustomGameSetupAutoLaunchDelay(0)
    GameRules:SetHeroSelectionTime(0)
    GameRules:SetStrategyTime(0)
    GameRules:SetShowcaseTime(0)
    GameRules:SetPreGameTime(0)
    GameRules:SetPostGameTime(5)
    GameRules:GetGameModeEntity():SetThink("OnThink", GameMode, "GlobalThink", 2)
    GameRules:GetGameModeEntity():SetCustomGameForceHero("npc_dota_hero_sanya")

    -- LinkLuaModifier(
    --     "modifier_model",
    --     "modifiers/modifier_model",
    --     LUA_MODIFIER_MOTION_NONE
    -- )

    CustomGameEventManager:RegisterListener("dialogue_choice", function(_, args)
        GameMode:OnDialogueChoice(args)
    end)

    ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(GameMode, "OnGameRulesStateChange"), GameMode)
    ListenToGameEvent("npc_spawned", Dynamic_Wrap(GameMode, "OnAnyNPCSpawned"), self)

    OnInitGameModeEvent()
end

function GameMode:OnThink()
    if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        -- print( "Template addon script is running." )
    elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
        return nil
    end
    return 1
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

local OnNPCSpawnedEvent = CreateGameEvent('OnNPCSpawned')
function GameMode:OnNPCSpawned(keys)
    local unit = EntIndexToHScript(keys.entindex)

    if not unit or unit:IsNull() then return end
    if not unit:IsRealHero() then return end

    if unit.bLevelModelInit then return end
    unit.bLevelModelInit = true

    -- unit:AddNewModifier(unit, nil, "modifier_model", { duration = -1 })
    -- AttachCustomWearable(unit, "models/heroes/dragon_knight_persona/dk_persona_weapon_full.vmdl")

    OnNPCSpawnedEvent(keys)
end

local OnHeroSpawnedEvent = CreateGameEvent('OnHeroSpawned')
function GameMode:OnHeroSpawned(keys)
    DebugPrint("[BAREBONES] NPC Spawned")
    DebugPrintTable(keys)
    OnHeroSpawnedEvent(keys)
end

local OnGameInProgressEvent = CreateGameEvent('OnGameInProgress')
function GameMode:OnGameInProgress(keys)
    InitModule(SpawnManager)

    OnGameInProgressEvent(keys)
end

function InitModule(module)
    if module == nil then
        return
    end

    if module.initialized == true then
        print("Module " ..
            tostring(module.moduleName) ..
            " is already initialized and there was an attempt to initialize it again -> preventing")
        return
    end

    local status, err = pcall(function() --luacheck: ignore status
        module:Init()
        module.initialized = true
    end)
    if err then
        local info = debug.getinfo(2, "Sl")
        print("Script Runtime Error: " .. info.source:sub(2) .. ":" .. info.currentline .. ": " .. err)
        print(debug.traceback())
        print('Failed to init module!!!')
    end
end
