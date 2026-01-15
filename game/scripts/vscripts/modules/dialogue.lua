Dialogue = Dialogue or class {}

--[[
-- Dialogue nodes file format:
-- entries = {
--   npc_someone = {
--       questID = {
--           { status = "ACTIVE", start="node_id", stepIdx=5 (optional) },
---          ...
--       }, ...
--   }, ...
-- }
-- nodes = {{
--   id = "node_id"
--   speakerName = "npc a",
--   speakerNPC = "npc_someone"
--   text = "Hello",
--   choices = {
--     {
--       next = "next_node_id",
--       text = "Choice text",
--       actions = {
--         quest_end = { {questID = "q_quest_01"}, ... },
--         quest_start = { {questID = "q_quest_02"}, ... }
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

function Dialogue:Init(game)
  self.game = game
  self.playerDialogueState = {}
  local dialogues = require('data.dialogues')
  self.entryPoints = dialogues.entries
  self.dialogueGraph = dialogues.nodes

  CustomGameEventManager:RegisterListener("dialogue_choice", bind(self.OnDialogueChoice, self))
  CustomGameEventManager:RegisterListener("query_update", bind(self.OnQueryUpdate, self))
end

function Dialogue:StartDialogueForAll(startNode)
  for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
    if PlayerResource:IsValidPlayerID(playerID) and PlayerResource:GetPlayer(playerID) then
      self:ShowDialogueNode(playerID, startNode)
    end
  end
  OnDialogueStartEvent({
    startNode = startNode
  })
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
    speaker = node.speakerName,
    text = node.text,
    choices = node.choices
  })
end

function Dialogue:HideDialogue(playerID)
  local player = PlayerResource:GetPlayer(playerID)
  if not player then return end
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

function Dialogue:GetAvailableDialogueNodeID(playerID, unitName)
  local entries = self.entryPoints[unitName]
  if not entries or TableLength(entries) == 0 then return nil end

  local matches = {}
  for questID, conditions in pairs(entries) do
    local questState = self.game.modules.quest:GetQuestState(playerID, questID)
    if not questState then goto continue end
    for _, condition in ipairs(conditions) do
      if questState.status == condition.status and
          (not condition.stepIdx or condition.stepIdx == questState.stepIdx) then
        table.insert(matches, condition.start)
      end
    end
    ::continue::
  end

  local len = TableLength(matches)
  if len == 0 then
    return nil
  elseif len > 1 then
    local text = "[???] Ambiguoes dialogue for NPC: " .. unitName .. ". Matched nodes: "
    for _, id in ipairs(matches) do
      text = text .. id .. "; "
    end
    print(text)
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
  local dialogue = self:GetAvailableDialogueNodeID(playerID, unit:GetUnitName())
  if dialogue then
    self:StartDialogueForAll(dialogue)
  end

  OnUnitInteractEvent({ playerID = playerID, unit = unit })
end

return Dialogue
