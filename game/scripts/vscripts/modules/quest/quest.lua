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

OnCancelLethalDamageEvent = CreateGameEvent 'OnCancelLethalDamage'
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

  ChatCommand:LinkDevCommand("-questreset", function(event)
    self.playerQuestStates = {}
    for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
      self.playerQuestStates[playerID] = PlayerQuestState(self.quests)
    end
    self:UpdateQuestlog(event.playerID)
  end)

  ChatCommand:LinkDevCommand("-a", function(event)
    self:EmitQuestCompleteParticles(event.playerID)
  end)

  GameEvents:OnActChange(bind(self.OnActChange, self))

  self:RegisterEvaluators()
end

function Quest:StartQuestForAll(questID)
  DebugPrint("[ALNOIRE] Start quest: " .. questID)
  self:TryRemoveExclamation(questID)
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

function Quest:RejectQuest(playerID, questID)
  DebugPrint("[ALNOIRE] Reject quest: " .. questID)
  self.playerQuestStates[playerID]:RejectQuest(questID)
end

function Quest:UpdateQuestlog(playerID)
  local questlog = {}
  local activeStates = self.playerQuestStates[playerID]:GetActiveQuestStates()
  for questID, state in pairs(activeStates) do
    local quest = self.quests[questID]
    local activeStep = quest.steps[state.stepIdx]
    table.insert(questlog, {
      name = quest.name,
      stepDescription = activeStep.description,
      questID = questID,
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

  objective.complete = true

  local hasIncomplete = false
  for _, obj in ipairs(activeStep.objectives) do
    if not obj.complete then
      hasIncomplete = true
      break
    end
  end
  if not hasIncomplete then
    self:AdvanceStep(playerID, questID)
  end

  self:UpdateQuestlog(playerID)
end

function Quest:AdvanceStep(playerID, questID)
  local state = self:GetQuestState(playerID, questID)
  local quest = self.quests[questID]
  local activeStep = quest.steps[state.stepIdx]
  DebugPrint("[ALNOIRE] Advance quest step: " .. questID .. " " .. state.stepIdx .. " -> " .. state.stepIdx + 1)

  for _, action in ipairs(activeStep.postStepActions or {}) do
    Actions:Handle(playerID, action)
  end
  state.stepIdx = state.stepIdx + 1
  if state.stepIdx > TableLength(quest.steps) then
    self:CompleteQuestForAll(questID)
  end
end

function Quest:CompleteQuestForAll(questID)
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
    self:EmitQuestCompleteParticles(playerID)
    Notifications:Top(playerID, { text = "Quest complete \"" .. quest.name .. "\"", duration = 5 })
    ::continue::
  end
end

function Quest:EmitQuestCompleteParticles(playerID)
  if not IsServer() then return end
  local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
  if not hero then return end

  local pfx = ParticleManager:CreateParticle(
    "particles/sanya_quest_complete_firework.vpcf",
    PATTACH_ABSORIGIN_FOLLOW, hero)
  ParticleManager:SetParticleControl(pfx, 0, hero:GetAbsOrigin())

  Timers:CreateTimer(10, function()
    ParticleManager:ReleaseParticleIndex(pfx)
  end)
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

function Quest:TryRemoveExclamation(questID)
  local quest = self.quests[questID]
  if quest.exclamationPfx then
    ParticleManager:DestroyParticle(quest.exclamationPfx, false)
    ParticleManager:ReleaseParticleIndex(quest.exclamationPfx)
    quest.exclamationPfx = nil
  end
end

function Quest:OnActChange()
  for questID, quest in pairs(self.quests) do
    self:TryRemoveExclamation(questID)

    if quest.showExclamation then
      if not quest.giver then
        error("Quest " .. questID .. " has no giver")
        return
      end
      for _, giverEnt in ipairs(Entities:FindAllByName(quest.giver)) do
        quest.exclamationPfx = ParticleManager:CreateParticle("particles/generic_gameplay/generic_has_quest.vpcf",
          PATTACH_CUSTOMORIGIN, giverEnt)
        local origin = giverEnt:GetAbsOrigin()
        origin.z = origin.z + 400
        local fwd = Vector(0, -1, 0)
        ParticleManager:SetParticleControlTransform(quest.exclamationPfx, 0, origin, VectorToAngles(fwd))
        break
      end
    end
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

function Quest:RegisterEvaluators()
  local function ForEachActiveObjectiveOfType(playerID, type, fn)
    local objectives = self:GetActiveObjectivesByType(playerID, type)
    for questID, questObjectives in pairs(objectives) do
      for _, obj in ipairs(questObjectives) do
        fn(questID, obj)
      end
    end
  end

  GameEvents:OnDialogueEnd(function(event)
    local playerID = event.playerID

    ForEachActiveObjectiveOfType(playerID, "talk", function(questID, objective)
      if Evaluators.TalkEvaluator(objective, event) then
        self:CompleteObjective(playerID, questID, objective)
      end
    end)
  end)

  GameEvents:OnEntityKilled(function(event)
    for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
      ForEachActiveObjectiveOfType(playerID, "kill", function(questID, objective)
        if Evaluators.KillEvaluator(objective, event) then
          self:CompleteObjective(playerID, questID, objective)
        end
      end)
    end
  end
  )

  GameEvents:OnQuestTrigger(function(event)
    local playerID = event.playerID
    ForEachActiveObjectiveOfType(playerID, "come", function(questID, objective)
      if Evaluators.TriggerEvaluator(objective, event) then
        self:CompleteObjective(playerID, questID, objective)
      end
    end)
  end)
end

return Quest
