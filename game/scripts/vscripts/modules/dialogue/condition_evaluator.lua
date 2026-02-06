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
        (not condition.step or contains(condition.step, questState.stepIdx)) then
        return true
    end
    return false
end

--[[
{ type = "var", var = "act", value = { 3, 4 } }
--]]
function Evaluators.var(nodeID, playerID, condition)
    local realValue = GlobalState:Get()[condition.var]
    return realValue ~= nil and contains(condition.value, realValue)
end

--[[
{ type="ent_var", ent_var = "first_met_global", value = { true }, npc=npc_abc }
--]]
function Evaluators.ent_var(nodeID, playerID, condition)
    local data = EntityData:ByName(condition.npc)
    if not data then return false end
    local realValue = data[condition.ent_var]
    return realValue ~= nil and contains(condition.value, realValue)
end

function M.CheckConditions(playerID, entryNodeID, conditions, premetConditions)
    local match = true
    local interesting = false
    local failedIndex = -1
    for i, condition in ipairs(conditions) do
        local skip = false
        for _, premetCondition in ipairs(premetConditions) do
            local subset = true
            for k, v in pairs(premetCondition) do
                if condition[k] ~= v then
                    subset = false
                    break
                end
            end
            if subset then
                skip = true
                break
            end
        end
        if skip then
            interesting = true
            goto continue
        end

        local evaluator = Evaluators[condition.type]
        if not evaluator then
            error("[ALNOIRE] No dialogue entry condition evaluator for type: " .. condition.type)
        end
        local result = evaluator(entryNodeID, playerID, condition)
        if not result then
            match = false
            failedIndex = i
            break
        end
        ::continue::
    end
    -- if interesting then
    --     DebugPrint("----Fail dialogue condition: " .. failedIndex .. "----")
    --     PrintTable(conditions, 2)
    -- end
    return match
end

return M
