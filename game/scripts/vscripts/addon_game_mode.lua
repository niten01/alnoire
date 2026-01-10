-- Generated from template

if GameMode == nil then
	GameMode = class({})
end

function Precache(context)
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = GameMode()
	GameRules.AddonTemplate:InitGameMode()
end

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
	GameRules:GetGameModeEntity():SetCustomGameForceHero("dragon_knight")

	LinkLuaModifier(
		"modifier_model",
		"modifiers/modifier_model", -- path under scripts/vscripts, without .lua
		LUA_MODIFIER_MOTION_NONE
	)



	CustomGameEventManager:RegisterListener("dialogue_choice", function(_, args)
		GameMode:OnDialogueChoice(args)
	end)

	ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(GameMode, "OnStateChange"), GameMode)
	ListenToGameEvent("dota_unit_event", Dynamic_Wrap(GameMode, "OnUnitEvent"), GameMode)
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(GameMode, "OnNPCSpawned"), self)
end

function GameMode:OnNPCSpawned(keys)
  local unit = EntIndexToHScript(keys.entindex)

  if not unit or unit:IsNull() then return end
  if not unit:IsRealHero() then return end

  if unit.bLevelModelInit then return end
  unit.bLevelModelInit = true

  unit:AddNewModifier(unit, nil, "modifier_model", { duration = -1 })
end

function GameMode:OnUnitEvent(e)
	print(e)
end

function GameMode:OnStateChange()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		-- Start test dialogue for everyone after game begins
		-- self:SpawnStoryNPC(Vector(0, 0, 3))
		-- GameMode:StartDialogueForAll("intro")
	end
end

-- Evaluate the state of the game
function GameMode:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		-- print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end

-- Minimal dialogue graph (hardcoded for now)
local DIALOGUE = {
	intro = {
		speaker = "Shopkeeper",
		text = "Welcome. Looking for something?",
		choices = {
			{ id = "buy", text = "Show me your wares.", next = "buy" },
			{ id = "bye", text = "Not now.",            next = nil },
		}
	},
	buy = {
		speaker = "Shopkeeper",
		text = "Shop not implemented yet (but the UI works!).",
		choices = {
			{ id = "back", text = "Back.",  next = "intro" },
			{ id = "bye",  text = "Leave.", next = nil },
		}
	}
}

function GameMode:SpawnStoryNPC(pos)
	local npc = CreateUnitByName(
		"npc_dota_creature_gnoll_assassin",
		pos,
		true,
		nil,
		nil,
		DOTA_TEAM_NEUTRALS
	)

	npc:SetIdleAcquire(false)
	npc:SetAcquisitionRange(0)
	npc:SetForwardVector(Vector(1, 0, 0))

	npc:AddNewModifier(npc, nil, "modifier_invulnerable", {})
	npc:AddNewModifier(npc, nil, "modifier_phased", {})

	table.insert(self.npcs, npc)

	-- Start proximity polling
	-- self:StartNPCProximityThink(npc, 275)
end

function GameMode:StartDialogueForAll(startNode)
	for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:IsValidPlayerID(playerID) and PlayerResource:GetPlayer(playerID) then
			GameMode:ShowDialogueNode(playerID, startNode)
		end
	end
end

function GameMode:ShowDialogueNode(playerID, nodeId)
	local player = PlayerResource:GetPlayer(playerID)
	if not player then return end

	local node = DIALOGUE[nodeId]
	if not node then return end

	GameMode.dialogueState[playerID] = nodeId

	-- Send only what the UI needs (speaker/text/choices)
	CustomGameEventManager:Send_ServerToPlayer(player, "dialogue_show", {
		speaker = node.speaker,
		text = node.text,
		-- sound = "your_vo_event_name_here", -- planned VO hook
		choices = node.choices
	})
end

function GameMode:HideDialogue(playerID)
	local player = PlayerResource:GetPlayer(playerID)
	if not player then return end
	GameMode.dialogueState[playerID] = nil
	CustomGameEventManager:Send_ServerToPlayer(player, "dialogue_hide", {})
end

function GameMode:OnDialogueChoice(args)
	-- args includes: PlayerID, choice
	local playerID = args.PlayerID
	local choiceId = args.choice

	if playerID == nil then return end
	if choiceId == "__close" then
		GameMode:HideDialogue(playerID)
		return
	end

	local nodeId = GameMode.dialogueState[playerID]
	if not nodeId then return end

	local node = DIALOGUE[nodeId]
	if not node then return end

	local picked = nil
	for _, c in pairs(node.choices or {}) do
		if c.id == choiceId then
			picked = c
			break
		end
	end
	if not picked then return end

	if picked.next == nil then
		GameMode:HideDialogue(playerID)
		return
	end

	GameMode:ShowDialogueNode(playerID, picked.next)
end
