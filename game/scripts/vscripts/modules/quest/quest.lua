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
local QuestsState = require('modules.quest.quests_state')
local Evaluators = require('modules.quest.evaluators')

local OnQuestCompleteEvent = CreateGameEvent 'OnQuestComplete'

function Quest:Init()
  DebugPrint("[ALNOIRE] Initializing Quest module")
  self.quests = require("data.quests")

  DebugPrint("[ALNOIRE] Loaded " .. TableLength(self.quests) .. " quests")

  self.questStates = QuestsState(self.quests)

  ChatCommand:LinkDevCommand("-queststatus", function(event, args)
    self:ShowQuestStatus(event, args)
  end)

  ChatCommand:LinkDevCommand("-questreset", function(event)
    self.questStates = QuestsState(self.quests)
    self:UpdateQuestlog()
  end)

  ChatCommand:LinkDevCommand("-questcompleteparticles", function(event)
    self:EmitQuestCompleteParticles()
  end)

  ChatCommand:LinkDevCommand("-setqueststatus", function(event, args)
    local questState = self.questStates:GetOneQuestState(args[1])
    questState.status = args[2]
    self:UpdateQuestlog()
  end)

  ChatCommand:LinkDevCommand("-setqueststep", function(event, args)
    local questState = self.questStates:GetOneQuestState(args[1])
    questState.status = QuestStatus.ACTIVE
    questState.stepIdx = tonumber(args[2])
    self:UpdateQuestlog()
  end)

  GameEvents:OnActChange(bind(self.OnActChange, self))

  self:RegisterEvaluators()
end

function Quest:StartQuestForAll(questID)
  DebugPrint("[ALNOIRE] Start quest: " .. questID)
  self:TryRemoveExclamation(questID)
  local quest = self.quests[questID]
  if not quest then
    print("??? Invalid quest ID")
    return
  end

  self.questStates:StartQuest(questID)
  for _, action in ipairs(quest.onAccept or {}) do
    StoryDriver:HandleAction(nil, action)
  end
  self:UpdateQuestlog()
end

function Quest:RejectQuest(questID)
  DebugPrint("[ALNOIRE] Reject quest: " .. questID)
  self.questStates:RejectQuest(questID)
end

function Quest:UpdateQuestlog()
  local questlog = {}
  local activeStates = self.questStates:GetActiveQuestStates()
  for questID, state in pairs(activeStates) do
    local quest = self.quests[questID]
    local activeStep = quest.steps[state.stepIdx]
    table.insert(questlog, {
      name = quest.name,
      stepDescription = activeStep.description,
      questID = questID,
    })
  end
  for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
    if PlayerResource:IsValidPlayerID(playerID) and PlayerResource:IsValidPlayer(playerID) then
      CustomNetTables:SetTableValue("questlog", tostring(playerID), questlog)
    end
  end
end

function Quest:CompleteObjective(questID, objective)
  DebugPrint("[ALNOIRE] Objective complete: ")
  PrintTable(objective, 2)
  local state = self:GetQuestState(questID)
  if not state then return end
  local quest = self.quests[questID]
  local activeStep = quest.steps[state.stepIdx]
  if not activeStep then return end

  self:TryGiveReward(objective)
  objective.complete = true

  local hasIncomplete = false
  for _, obj in ipairs(activeStep.objectives) do
    if not obj.complete then
      hasIncomplete = true
      break
    end
  end
  if not hasIncomplete then
    self:AdvanceStep(questID)
  end

  self:UpdateQuestlog()
end

function Quest:TryGiveReward(obj)
  for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
    if PlayerResource:IsValidPlayerID(playerID) then
      local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
      if hero then
        if obj.rewardXP then
          hero:AddExperience(obj.rewardXP * X_MULT, DOTA_ModifyXP_TomeOfKnowledge, false, true)
        end
        if obj.rewardGold then
          hero:ModifyGold(obj.rewardGold, true, DOTA_ModifyGold_CreepKill)
          hero:EmitSound("sfx.quest_bounty.gold")
        end
        for _, itemName in ipairs(obj.rewardItems or {}) do
          SafeGiveItem(playerID, itemName)
        end
      end
    end
  end
end

function Quest:AdvanceStep(questID)
  local state = self:GetQuestState(questID)
  local quest = self.quests[questID]
  local activeStep = quest.steps[state.stepIdx]
  DebugPrint("[ALNOIRE] Advance quest step: " .. questID .. " " .. state.stepIdx .. " -> " .. state.stepIdx + 1)

  self:TryGiveReward(activeStep)
  for _, action in ipairs(activeStep.postStepActions or {}) do
    StoryDriver:HandleAction(nil, action)
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
  local state = self:GetQuestState(questID)
  if not state then return end
  state.status = QuestStatus.COMPLETED
  self:UpdateQuestlog()

  self:TryGiveReward(quest)

  OnQuestCompleteEvent({
    quest = quest
  })
  if not quest.noFireworks then
    Timers:CreateTimer(0.5, function()
      self:EmitQuestCompleteParticles()
    end)
  end
  Notifications:TopToAll({ text = "Квест выполнен \"" .. quest.name .. "\"", duration = 5 })
end

function Quest:EmitQuestCompleteParticles()
  if not IsServer() then return end
  for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
    if not PlayerResource:IsValidPlayerID(playerID) or not PlayerResource:IsValidPlayer(playerID) then
      goto continue
    end
    local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
    if not hero then return end

    local pfx = ParticleManager:CreateParticle(
      "particles/sanya_quest_complete_firework.vpcf",
      PATTACH_ABSORIGIN_FOLLOW, hero)
    ParticleManager:SetParticleControl(pfx, 0, hero:GetAbsOrigin())

    hero:EmitSound("sfx.quest_complete.fire")
    Timers:CreateTimer(0.5, function()
      hero:EmitSound("sfx.quest_complete.explode")
    end)

    Timers:CreateTimer(10, function()
      ParticleManager:ReleaseParticleIndex(pfx)
    end)
    ::continue::
  end
end

function Quest:GetQuestState(questID)
  return self.questStates:GetOneQuestState(questID)
end

function Quest:GetActiveObjectivesByType(type)
  local objectives = {}
  for questID, state in pairs(self.questStates:GetActiveQuestStates()) do
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

local function QuestExpired(quest, act)
  return (max(quest.acts) or math.huge) < act
end

function Quest:OnActChange(event)
  local act = event.act
  for questID, quest in pairs(self.quests) do
    local isNowActive = not QuestExpired(quest, act)
    self:TryRemoveExclamation(questID)

    if isNowActive then
      -- try cancel quest that doesn't meet requirements
      for _, req in ipairs(quest.requires or {}) do
        if not QuestExpired(self.quests[req], act) then
          -- we can still complete it
          goto skip_req
        end
        local state = self.questStates:GetOneQuestState(req)
        if state.status ~= QuestStatus.COMPLETED then
          self.questStates:CancelQuest(questID)
          goto skip_quest
        end
        ::skip_req::
      end

      if quest.showExclamation then
        if not quest.giver then
          error("Quest " .. questID .. " has no giver")
          return
        end
        for _, giverEnt in ipairs(Entities:FindAllByName(quest.giver)) do
          quest.exclamationPfx = ParticleManager:CreateParticle("particles/generic_gameplay/generic_has_quest.vpcf",
            PATTACH_CUSTOMORIGIN, giverEnt)
          local origin = giverEnt:GetAbsOrigin()
          origin.z = origin.z + 350
          local fwd = Vector(0, -1, 0)
          ParticleManager:SetParticleControlTransform(quest.exclamationPfx, 0, origin, VectorToAngles(fwd))
          break
        end
      end
    else
      local states = self.questStates
      if states:GetOneQuestState(questID).status ~= QuestStatus.COMPLETED then
        states:CancelQuest(questID)
      end
    end
    ::skip_quest::
  end
  self:UpdateQuestlog()
end

function Quest:ShowQuestStatus(event, args)
  local state = self.questStates
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
  local function ForEachActiveObjectiveOfType(type, fn)
    local objectives = self:GetActiveObjectivesByType(type)
    for questID, questObjectives in pairs(objectives) do
      for _, obj in ipairs(questObjectives) do
        fn(questID, obj)
      end
    end
  end

  GameEvents:OnDialogueEnd(function(event)
    ForEachActiveObjectiveOfType("talk", function(questID, objective)
      if Evaluators.TalkEvaluator(objective, event) then
        self:CompleteObjective(questID, objective)
      end
    end)
  end)

  GameEvents:OnEntityKilled(function(event)
    ForEachActiveObjectiveOfType("kill", function(questID, objective)
      if Evaluators.KillEvaluator(objective, event) then
        self:CompleteObjective(questID, objective)
      end
    end)
  end
  )

  GameEvents:OnCancelLethalDamage(function(event)
    ForEachActiveObjectiveOfType("beat", function(questID, objective)
      if Evaluators.BeatEvaluator(objective, event) then
        self:CompleteObjective(questID, objective)
      end
    end)
  end)

  GameEvents:OnQuestTrigger(function(event)
    ForEachActiveObjectiveOfType("come", function(questID, objective)
      if Evaluators.TriggerEvaluator(objective, event) then
        self:CompleteObjective(questID, objective)
      end
    end)
  end)

  GameEvents:OnItemObtain(function(event)
    ForEachActiveObjectiveOfType("get_item", function(questID, objective)
      if Evaluators.GetItemEvaluator(objective, event) then
        self:CompleteObjective(questID, objective)
      end
    end)
  end)

  GameEvents:OnNPCRemove(function(event)
    ForEachActiveObjectiveOfType("remove", function(questID, objective)
      if Evaluators.RemoveEvaluator(objective, event) then
        self:CompleteObjective(questID, objective)
      end
    end)
  end)
end

return Quest
