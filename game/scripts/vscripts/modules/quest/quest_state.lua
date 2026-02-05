local PlayerQuestState = class {}
local QuestStatus = require('modules.quest.quest_status')

function PlayerQuestState:constructor(quests)
    self.questStates = {}
    for id, _ in pairs(quests) do
        self.questStates[id] = {
            status = QuestStatus.INACTIVE,
            stepIdx = nil
        }
    end
    self.flags = {} -- global events flags
end

function PlayerQuestState:StartQuest(questID)
    local questState = self.questStates[questID]
    questState.status = QuestStatus.ACTIVE
    questState.stepIdx = 1
end

function PlayerQuestState:RejectQuest(questID)
    local questState = self.questStates[questID]
    questState.status = QuestStatus.REJECTED
end

function PlayerQuestState:CancelQuest(questID)
    local questState = self.questStates[questID]
    questState.status = QuestStatus.INCOMPLETE
end

function PlayerQuestState:GetOneQuestState(questID)
    return self.questStates[questID]
end

function PlayerQuestState:GetActiveQuestStates()
    local activeQuestsStates = {}
    for questID, state in pairs(self.questStates) do
        if state.status == QuestStatus.ACTIVE then
            activeQuestsStates[questID] = state
        end
    end
    return activeQuestsStates
end

function PlayerQuestState:GetFlag(flagName)
    return self.flags[flagName]
end

return PlayerQuestState
