if barebones == nil then
	_G.barebones = class({})
else
	DebugPrint("[BAREBONES] barebones class name is already in use, change the name if this is the first time you launch the game!")
	DebugPrint("[BAREBONES] If this is not your first time, you probably used script_reload in console.")
end

require('util')
require('libraries/timers')                      -- Core lua library
require('libraries/player_resource')             -- Core lua library
require('gamemode')                              -- Core barebones file

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
	DebugPrint("[BAREBONES] Activating ...")
	barebones:InitGameMode()
end



-- Minimal dialogue graph (hardcoded for now)
-- local DIALOGUE = {
-- 	intro = {
-- 		speaker = "Shopkeeper",
-- 		text = "Welcome. Looking for something?",
-- 		choices = {
-- 			{ id = "buy", text = "Show me your wares.", next = "buy" },
-- 			{ id = "bye", text = "Not now.",            next = nil },
-- 		}
-- 	},
-- 	buy = {
-- 		speaker = "Shopkeeper",
-- 		text = "Shop not implemented yet (but the UI works!).",
-- 		choices = {
-- 			{ id = "back", text = "Back.",  next = "intro" },
-- 			{ id = "bye",  text = "Leave.", next = nil },
-- 		}
-- 	}
-- }

-- function GameMode:SpawnStoryNPC(pos)
-- 	local npc = CreateUnitByName(
-- 		"npc_dota_creature_gnoll_assassin",
-- 		pos,
-- 		true,
-- 		nil,
-- 		nil,
-- 		DOTA_TEAM_NEUTRALS
-- 	)

-- 	npc:SetIdleAcquire(false)
-- 	npc:SetAcquisitionRange(0)
-- 	npc:SetForwardVector(Vector(1, 0, 0))

-- 	npc:AddNewModifier(npc, nil, "modifier_invulnerable", {})
-- 	npc:AddNewModifier(npc, nil, "modifier_phased", {})

-- 	table.insert(self.npcs, npc)

-- 	-- Start proximity polling
-- 	-- self:StartNPCProximityThink(npc, 275)
-- end

-- function GameMode:StartDialogueForAll(startNode)
-- 	for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
-- 		if PlayerResource:IsValidPlayerID(playerID) and PlayerResource:GetPlayer(playerID) then
-- 			GameMode:ShowDialogueNode(playerID, startNode)
-- 		end
-- 	end
-- end

-- function GameMode:ShowDialogueNode(playerID, nodeId)
-- 	local player = PlayerResource:GetPlayer(playerID)
-- 	if not player then return end

-- 	local node = DIALOGUE[nodeId]
-- 	if not node then return end

-- 	GameMode.dialogueState[playerID] = nodeId

-- 	-- Send only what the UI needs (speaker/text/choices)
-- 	CustomGameEventManager:Send_ServerToPlayer(player, "dialogue_show", {
-- 		speaker = node.speaker,
-- 		text = node.text,
-- 		-- sound = "your_vo_event_name_here", -- planned VO hook
-- 		choices = node.choices
-- 	})
-- end

-- function GameMode:HideDialogue(playerID)
-- 	local player = PlayerResource:GetPlayer(playerID)
-- 	if not player then return end
-- 	GameMode.dialogueState[playerID] = nil
-- 	CustomGameEventManager:Send_ServerToPlayer(player, "dialogue_hide", {})
-- end

-- function GameMode:OnDialogueChoice(args)
-- 	-- args includes: PlayerID, choice
-- 	local playerID = args.PlayerID
-- 	local choiceId = args.choice

-- 	if playerID == nil then return end
-- 	if choiceId == "__close" then
-- 		GameMode:HideDialogue(playerID)
-- 		return
-- 	end

-- 	local nodeId = GameMode.dialogueState[playerID]
-- 	if not nodeId then return end

-- 	local node = DIALOGUE[nodeId]
-- 	if not node then return end

-- 	local picked = nil
-- 	for _, c in pairs(node.choices or {}) do
-- 		if c.id == choiceId then
-- 			picked = c
-- 			break
-- 		end
-- 	end
-- 	if not picked then return end

-- 	if picked.next == nil then
-- 		GameMode:HideDialogue(playerID)
-- 		return
-- 	end

-- 	GameMode:ShowDialogueNode(playerID, picked.next)
-- end
