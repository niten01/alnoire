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
{ type = "green_test", green_strong_hit = true }
--]]
function Evaluators.green_test() return false end

--[[
{ type = "kill", beat = "npc_abc" }
--]]
function Evaluators.kill() return false end

--[[
{ type = "quest", questID = "q_test_quest_01", status = QuestStatus.ACTIVE, step = 1 (optional) }
--]]
function Evaluators.quest(nodeID, playerID, condition)
    local questID = condition.questID
    local questState = Quest:GetQuestState(questID)
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

--[[
{ type="has_item", has_item = "item_something" }
--]]
function Evaluators.has_item(nodeID, playerID, condition)
    local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
    if not hero then
        error("No hero")
    end
    return hero:HasItemInInventory(condition.has_item)
end

--[[
{ type="no_item", no_item = "item_something" }
--]]
function Evaluators.no_item(nodeID, playerID, condition)
    local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
    if not hero then
        error("No hero")
    end
    return not hero:HasItemInInventory(condition.no_item)
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
            -- fail fast in non-debug
            if not IsInToolsMode() then break end
        end
        ::continue::
    end
    if not match and interesting then
        DebugPrint("----Fail dialogue condition: " .. failedIndex .. "----")
        PrintTable(conditions, 2)
    end
    return match
end

return M
