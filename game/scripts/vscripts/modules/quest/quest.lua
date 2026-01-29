Quest = Quest or {}

--[[
--  Quest format:
--  {
--    id = "q_quest_id",
--    giver = "npc_someone",
--    name = "Quest Name",
--    steps = {
--      {
          description = "some desc",
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

function Quest:Init()
  DebugPrint("[ALNOIRE] Initializing Quest module")
  self.quests = require("data.quests")

  DebugPrint("[ALNOIRE] Loaded " .. TableLength(self.quests) .. " quests")

  self.playerQuestStates = {}
  for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
    self.playerQuestStates[playerID] = PlayerQuestState(self.quests)
  end

  ChatCommand:LinkDevCommand("-queststatus", function(event, args)
    self:ShowQuestStatus(event, args)
  end)

  GameEvents:OnDialogueChoice(function(event)
    local playerID = event.playerID

    local objectives = self:GetActiveObjectivesByType(playerID, "talk")
    for questID, questObjectives in pairs(objectives) do
      for _, obj in ipairs(questObjectives) do
        if Evaluators.TalkEvaluator(questID, obj, event) then
          self:CompleteObjective(playerID, questID, obj)
        end
      end
    end

    -- quest can start here
    local allActions = event.choice.actions
    PrintTable(allActions)
    if not allActions then return end

    for _, action in ipairs(allActions) do
      self:HandleAction(playerID, action)
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
      self:UpdateQuestlog(playerID)
    end
  end
end

function Quest:UpdateQuestlog(playerID)
  local questlog = {}
  local activeStates = self.playerQuestStates[playerID]:GetActiveQuestStates()
  for questID, state in pairs(activeStates) do
    local quest = self.quests[questID]
    local activeStep = quest.steps[state.stepIdx]
    table.insert(questlog, {
      name = quest.name,
      stepDescription = activeStep.description
    })
  end
  CustomNetTables:SetTableValue("questlog", tostring(playerID), questlog)
end

function Quest:CanStartQuest(playerID, quest)
  if not quest.requiresFlag then return true end
  return self.playerQuestStates[playerID]:GetFlag(quest.requiresFlag)
end

function Quest:CompleteObjective(playerID, questID, objective)
  DebugPrint("[ALNOIRE] Objective complete: ")
  PrintTable(objective, 2)
  local state = self:GetQuestState(playerID, questID)
  if not state then return end
  local quest = self.quests[questID]
  local activeStep = quest.steps[state.stepIdx]
  if not activeStep then return end

  -- TODO mark objectives
  objective.complete = true

  local hasIncomplete = false
  for _, obj in ipairs(activeStep.objectives) do
    if not obj.complete then
      hasIncomplete = true
      break
    end
  end
  if not hasIncomplete then
    state.stepIdx = state.stepIdx + 1
    DebugPrint(state.stepIdx, TableLength(quest.steps))
    if state.stepIdx > TableLength(quest.steps) then
      self:FinishQuestForAll(questID)
    end
  end
end

function Quest:FinishQuestForAll(questID)
  if not self.quests[questID] then return end
  local quest = self.quests[questID]

  DebugPrint("[ALNOIRE] Quest complete: " .. questID)
  for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
    local state = self:GetQuestState(playerID, questID)
    if not state then goto continue end
    state.status = QuestStatus.COMPLETED
    self:UpdateQuestlog(playerID)
    OnQuestCompleteEvent({
      quest = quest
    })
    Notifications:Top(playerID, { text = "Quest complete \"" .. quest.name .. "\"", duration = 5 })
    ::continue::
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
        objectives[questID] = objectives[questID] or {}
        table.insert(objectives[questID], obj)
      end
    end
  end

  return objectives
end

function Quest:HandleAction(playerID, action)
  if action.type == "quest_start" then
    self:StartQuestForAll(action.questID)
  elseif action.type == "quest_reject" then
    local state = self.playerQuestStates[playerID]
    state.status = QuestStatus.REJECTED
  elseif action.type == "quest_end" then
    self:FinishQuestForAll(action.questID)
  end
end

function Quest:ShowQuestStatus(event, args)
  local state = self.playerQuestStates[event.playerID]
  local function printOneQuest(questID)
    DebugPrint("---------------- " .. questID .. " ----------------")
    PrintTable(state.questStates[questID])
    DebugPrint("--------------------------------")
  end

  DebugPrint("\n\nQUESTSTATUS")

  if TableLength(args) > 0 then
    printOneQuest(args[1])
    return
  end

  for questID, _ in pairs(state.questStates) do
    printOneQuest(questID)
  end
  DebugPrint("\n\n")
end

return Quest
