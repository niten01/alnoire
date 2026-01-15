local PlayerQuestState = class {}
local QuestStatus = require('modules.quest.quest_status')

function PlayerQuestState:constructor(quests)
    self.questStates = {}
    for id, _ in pairs(quests) do
        self.questStates[id] = {
            status = QuestStatus.INACTIVE,
            stepIdx = 1
        }
    end
    self.flags = {} -- global events flags
end

function PlayerQuestState:StartQuest(questID)
    self.questStates[questID].status = QuestStatus.ACTIVE
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
