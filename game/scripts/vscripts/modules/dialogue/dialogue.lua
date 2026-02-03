Dialogue = Dialogue or {}

--[[
-- Dialogue nodes file format:
-- entries = {
    node_id = {
      { type = "quest", questID = "q_quest_01", status = QuestStatus.ACTIVE, stepIdx = 2  },
      { type = "flag", flagName = "firstMet", value = true  },
    },
--   ...
-- }
-- nodes = {
--   node_id = {
--   speakerName = "npc a",
--   speakerNPC = "npc_someone"
--   text = "Hello",
--   choices = {
--     {
--       next = "next_node_id",
--       text = "Choice text",
--       actions = {
--         { type = "quest_end", questID = "q_quest_01" },
--         { type = "quest_start", questID = "q_quest_02" },
--         ...
--       }
--     }, ...
--   }
-- }, ... }
--]]


local OnDialogueChoiceEvent = CreateGameEvent 'OnDialogueChoice'
local OnDialogueStartEvent = CreateGameEvent 'OnDialogueStart'
local OnDialogueEndEvent = CreateGameEvent 'OnDialogueEnd'
local OnUnitInteractEvent = CreateGameEvent 'OnUnitInteract'

function Dialogue:Init()
  DebugPrint("[ALNOIRE] Initializing dialogues ")
  self.playerDialogueState = {}
  local dialogues = require('data.dialogues')
  self.entryPoints = dialogues.entries
  self.dialogueGraph = dialogues.nodes

  CustomGameEventManager:RegisterListener("dialogue_choice", bind(self.OnDialogueChoice, self))
  CustomGameEventManager:RegisterListener("query_update", bind(self.OnQueryUpdate, self))
  GameEvents:OnCancelLethalDamage(bind(self.OnCancelLethalDamage, self))

  ChatCommand:LinkCommand("-dialogueclose", function(event)
    self:HideDialogue(event.playerID)
  end)

  DebugPrint("[ALNOIRE] Loaded " ..
    TableLength(self.dialogueGraph) .. " dialogue nodes with " .. TableLength(self.entryPoints) .. " entry points.")
end

function Dialogue:StartDialogueForPlayer(playerID, startNodeID)
  if not self.dialogueGraph[startNodeID] then return end

  self:TrySetFirstMet(startNodeID)

  local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
  if not hero then
    error("No barebones assigned hero")
  end

  CenterCameraOnUnit(playerID, hero)
  hero:AddNewModifier(nil, nil, "modifier_dialogue_player", { duration = -1 })

  self:ShowDialogueNode(playerID, startNodeID)

  OnDialogueStartEvent({
    playerID = playerID,
    startNode = startNodeID
  })
end

function Dialogue:TrySetFirstMet(startNodeID)
  local node = self.dialogueGraph[startNodeID]
  if not node.npc then return end
  local data = EntityData:ByName(node.npc)
  if not data then
    data = EntityData:AddEntity("npc", node.npc, {})
  end

  data.first_met_cur_act = true;
  data.first_met_cur_global = true;
end

function Dialogue:ShowDialogueNode(playerID, nodeID)
  local player = PlayerResource:GetPlayer(playerID)
  if not player then
    print("??? Could not show dialogue node - invalid player ID")
    return
  end

  local node = self.dialogueGraph[nodeID]
  if not node then
    print("??? Could not show dialogue node - invalid node ID")
    return
  end

  self.playerDialogueState[playerID] = nodeID

  CustomGameEventManager:Send_ServerToPlayer(player, "dialogue_show", {
    speaker = node.speaker,
    text = node.text,
    choices = node.choices
  })
end

function Dialogue:HideDialogue(playerID)
  local player = PlayerResource:GetPlayer(playerID)
  if not player then return end
  local hero = player:GetAssignedHero()
  hero:RemoveModifierByName("modifier_dialogue_player")
  self.playerDialogueState[playerID] = nil
  CustomGameEventManager:Send_ServerToPlayer(player, "dialogue_hide", {})
end

function Dialogue:GetNode(nodeID)
  return self.dialogueGraph[nodeID]
end

function Dialogue:GetPlayerNodeID(playerID)
  return self.playerDialogueState[playerID]
end

function Dialogue:GetPlayerCurrentNode(playerID)
  return self:GetNode(self:GetPlayerNodeID(playerID))
end

local ConditionEval = require('modules.dialogue.condition_evaluator')
function Dialogue:GetDialogueNodeBestMatchEntrypoint(playerID, premetConditions)
  local matches = {}
  for nodeID, entrypoint in pairs(self.entryPoints) do
    entrypoint.nodeID = nodeID
    if ConditionEval.CheckConditions(playerID, nodeID, entrypoint.conditions, premetConditions) then
      table.insert(matches, entrypoint)
    end
  end

  if TableLength(matches) == 0 then
    return nil
  end

  table.sort(matches, function(e1, e2) return e1.priority > e2.priority end)

  if TableLength(matches) > 1 and matches[1].priority == matches[2].priority then
    local text = "[???] Ambiguous dialogue. Matched nodes: "
    print(text)
    for _, e in ipairs(matches) do
      PrintTable(e, 2)
      print("-----------")
    end
    Notifications:TopToAll({ text = text, duration = 10000 })
  end

  return matches[1]
end

function Dialogue:OnDialogueChoice(_, args)
  -- args includes: PlayerID, choiceLuaIndex
  local playerID = args.PlayerID
  local choiceLuaIndex = args.choiceLuaIndex

  if playerID == nil then return end

  local node = self:GetPlayerCurrentNode(playerID)
  if not node then return end

  local choice = node.choices[choiceLuaIndex]
  if not choice then return end

  OnDialogueChoiceEvent({
    playerID = playerID,
    oldNode = self:GetPlayerCurrentNode(playerID),
    newNode = self:GetNode(choice.next),
    choice = choice
  })
  if choice.actions then
    for _, action in ipairs(choice.actions) do
      Actions:HandleAction(playerID, action)
    end
  end

  -- end dialogue
  if choice.next == nil then
    OnDialogueEndEvent({
      playerID = playerID,
      lastNode = self:GetPlayerCurrentNode(playerID),
      choice = choice
    })
    self:HideDialogue(playerID)
    return
  end

  self:ShowDialogueNode(playerID, choice.next)
end

function Dialogue:OnCancelLethalDamage(params)
  if not IsServer() then return end

  local startDialogue = function(playerID)
    local entrypoint = self:GetDialogueNodeBestMatchEntrypoint(playerID,
      { { type = "beat", beat = params.unit:GetUnitName() } })
    if not entrypoint then return false end
    self:StartDialogueForAll(entrypoint.nodeID)
    return true
  end

  local playerID = params.attackerPlayerID
  if playerID then
    startDialogue(playerID)
  else
    for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
      if PlayerResource:IsValidPlayer(playerID) and PlayerResource:GetPlayer(playerID) then
        if startDialogue(playerID) then break end
      end
    end
  end
end

function Dialogue:OnQueryUpdate(_, args)
  if not IsServer() then return end

  local unitIndex = args.unitIndex
  local playerID = args.PlayerID

  if not playerID or not unitIndex or unitIndex == -1 then return end

  ---@type CDOTA_BaseNPC?
  local unit = EntIndexToHScript(unitIndex)
  if not unit or unit:IsNull() then return end


  local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
  if not hero or hero:IsNull() then return end

  if unit:GetRangeToUnit(hero) > INTERACTION_RADIUS then return end

  -- interact
  local entrypoint = self:GetDialogueNodeBestMatchEntrypoint(playerID,
    { { type = "interact", interact = unit:GetUnitName() } })
  if entrypoint then
    PlayerResource:ResetSelection(playerID)
    self:StartDialogueForPlayer(playerID, entrypoint.nodeID)
  end

  OnUnitInteractEvent({ playerID = playerID, unit = unit })
end

return Dialogue
