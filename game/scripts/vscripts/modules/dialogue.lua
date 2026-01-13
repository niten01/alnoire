Dialogue = Dialogue or class {}

--[[
-- Node format:
-- {
--   id = "node_id"
--   speaker = "npc a",
--   text = "Hello",
--   choices = {
--     {
--       next = "next_node_id",
--       text = "Choice text",
--       tags = {
--         "quest_start", ...
--       }
--     }, ...
--   }
-- }
--]]


local OnDialogueStateChangeEvent = CreateGameEvent 'OnDialogueChoice'
local OnDialogueEndEvent = CreateGameEvent 'OnDialogueEnd'

function Dialogue:Init(game)
  self.game = game
  self.playerDialogueState = {}
  self.dialogueGraph = LoadKeyValues("data/dialogues.txt")

  CustomGameEventManager:RegisterListener("dialogue_choice", bind(self.OnDialogueChoice, self))
end

function Dialogue:StartDialogueForAll(startNode)
  for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
    if PlayerResource:IsValidPlayerID(playerID) and PlayerResource:GetPlayer(playerID) then
      self:ShowDialogueNode(playerID, startNode)
    end
  end
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
  OnDialogueStateChangeEvent({
    playerID = playerID,
    nodeID = nodeID,
    newNode = node
  })
end

function Dialogue:OnDialogueChoice(args)
  -- args includes: PlayerID, choice
  local playerID = args.PlayerID
  local choiceID = args.choice

  if playerID == nil then return end

  local node = self:GetPlayerCurrentNode(playerID)
  if not node then return end

  local picked = nil
  for _, c in pairs(node.choices or {}) do
    if c.next == choiceID then
      picked = c
      break
    end
  end
  if not picked then return end

  -- end dialogue
  if picked.next == nil then
    self:HideDialogue(playerID)
    OnDialogueEndEvent({
      playerID = playerID,
      lastNode = picked
    })
    return
  end

  GameMode:ShowDialogueNode(playerID, picked.next)
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

return Dialogue
