Quest = Quest or class {}

--[[
--  Quest format:
--  {
--    id = "q_quest_id",
--    giver = "npc_someone",
--    name = "Quest Name",
--    steps = {
--      {
--        id = "q_step_01",
--        objectives = {
--          { type = "talk", npc = "npc_someone" },
--          { type = "kill", npc = "npc_someone", count = 3 },
--          ...
--        }
--      }, ...
--    }
--  }
--
--]]
local QuestStatus = require('modules.quest.quest_status')
local PlayerQuestState = require('modules.quest.quest_state')
local Evaluators = require('modules.quest.evaluators')

local OnQuestCompleteEvent = CreateGameEvent 'OnQuestComplete'

function Quest:Init(game)
  DebugPrint("[ALNOIRE] Initializing Quest module")
  self.game = game
  self.quests = require("data.quests")

  DebugPrint("[ALNOIRE] Loaded " .. TableLength(self.quests) .. " quests")

  self.playerQuestStates = {}
  for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
    self.playerQuestStates[playerID] = PlayerQuestState(self.quests)
  end

  ChatCommand:LinkDevCommand("-queststatus", Dynamic_Wrap(Quest, 'ShowQuestStatusCommand'), self)

  GameEvents:OnDialogueChoice(function(event)
    local playerID = event.playerID

    local objectives = self:GetActiveObjectivesByType(playerID, "talk")
    for _, obj in ipairs(objectives) do
      if Evaluators.TalkEvaluator(obj, event) then
        self:CompleteObjective(playerID, obj.questID)
      end
    end

    -- quest can start here
    local allActions = event.choice.actions
    if not allActions then return end
    local startActions = allActions.quest_start
    if not startActions then return end

    for _, action in ipairs(startActions) do
      self:StartQuestForAll(action.questID)
    end
  end)

  -- GameEvents:OnEntityKilled(function(event)
  --   local objectives = activeObjectivesByType("kill")
  --   for _, obj in ipairs(objectives) do
  --     if not obj.current then obj.current = 0 end
  --   end
  -- end
  -- )
end

function Quest:StartQuestForAll(questID)
  DebugPrint("[ALNOIRE] Start quest: " .. questID)
  for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
    if PlayerResource:IsValidPlayerID(playerID) and PlayerResource:GetPlayer(playerID) then
      local quest = self.quests[questID]
      if not quest then
        print("??? Invalid quest ID")
        return
      end

      self.playerQuestStates[playerID]:StartQuest(questID)
    end
  end
end

function Quest:CanStartQuest(playerID, quest)
  if not quest.requiresFlag then return true end
  return self.playerQuestStates[playerID]:GetFlag(quest.requiresFlag)
end

function Quest:CompleteObjective(playerID, questID)
  local state = self:GetQuestState(playerID, questID)
  if not state then return end
  local quest = self.quests[questID]
  local activeStep = quest.steps[state.stepIdx]
  if not activeStep then return end

  -- TODO mark objectives
  activeStep.completedObjectives = activeStep.completedObjectives + 1 or 1
  if activeStep.completedObjectives >= TableLength(activeStep.objectives) then
    state.stepIdx = state.stepIdx + 1
    if state.stepIdx > TableLength(quest.steps) then
      state.status = QuestStatus.COMPLETED
      OnQuestCompleteEvent({
        quest = quest
      })
      Notifications:Top(playerID, { text = "complete " .. questID, duration = 30 })
    end
  end
end

function Quest:GetQuestState(playerID, questID)
  return self.playerQuestStates[playerID]:GetOneQuestState(questID)
end

function Quest:GetActiveObjectivesByType(playerID, type)
  if not self.playerQuestStates[playerID] then return {} end

  local objectives = {}
  for questID, state in pairs(self.playerQuestStates[playerID]:GetActiveQuestStates()) do
    local activeStep = self.quests[questID].steps[state.stepIdx]
    for _, obj in ipairs(activeStep.objectives) do
      if obj.type == type then
        local objMod = copy(obj)
        objMod.questID = questID
        table.insert(objectives, obj)
      end
    end
  end

  return objectives
end

function Quest:ShowQuestStatusCommand(keys)
  local splitted = split(keys.text, ' ')
  local questID = splitted[2]
  local text = self:GetQuestState(keys.playerid, questID).status
  Notifications:Top(keys.playerid, { text = text, duration = 100 })
end

return Quest
