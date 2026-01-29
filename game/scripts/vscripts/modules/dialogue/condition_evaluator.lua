local M = {}

local Evaluators = {}

--[[
{ type = "interact", interact = "npc_bob" }
--]]
function Evaluators.interact() return false end

--[[
{ type = "trigger", trigger = "trigger_abc" }
--]]
function Evaluators.trigger() return false end

--[[
{ type = "beat", beat = "npc_abc" }
--]]
function Evaluators.beat() return false end

--[[
{ type = "quest", questID = "q_test_quest_01", status = QuestStatus.ACTIVE, step = 1 (optional) }
--]]
function Evaluators.quest(nodeID, playerID, condition)
    local questID = condition.questID
    local questState = Quest:GetQuestState(playerID, questID)
    if not questState then return false end
    if questState.status == condition.status and
        (not condition.step or condition.step == questState.stepIdx) then
        return true
    end
    return false
end

--[[
{ type = "var", var = "act", value = 3 }
--]]
function Evaluators.var(nodeID, playerID, condition)
    local realValue = GlobalState:Get().act
    return realValue and realValue == condition.value
end

--[[
{ type="ent_var", ent_var = "act", value = 3, npc=npc_abc }
--]]
function Evaluators.ent_var(nodeID, playerID, condition)
    local data = EntityData:ByName(condition.npc)
    if not data then return false end
    local realValue = data[condition.ent_var]
    return realValue and realValue == condition.value
end

function M.CheckConditions(playerID, entryNodeID, conditions, premetConditions)
    local match = true
    for _, condition in ipairs(conditions) do
        local skip = false
        for _, premetCondition in ipairs(premetConditions) do
            if equals(premetCondition, condition) then
                skip = true
            end
        end
        if skip then goto continue end

        local evaluator = Evaluators[condition.type]
        if not evaluator then
            error("[ALNOIRE] No dialogue entry condition evaluator for type: " .. condition.type)
        end
        local result = evaluator(entryNodeID, playerID, condition)
        if not result then
            match = false
            break
        end
        ::continue::
    end
    return match
end

return M
