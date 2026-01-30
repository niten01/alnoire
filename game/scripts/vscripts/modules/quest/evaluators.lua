return {
    TalkEvaluator =
        function(questID, objective, event)
            if not objective.npc then return nil end
            if not event.choice then return nil end

            local actions = event.choice.actions
            if not actions then return nil end

            for _, action in ipairs(actions) do
                if action.type == "quest_start" and
                    action.questID == questID then
                    return true
                end
            end

            return nil
        end,

    KillEvaluator =
        function(objective, event)
            if not objective.currentProgress then objective.currentProgress = 0 end
            if not objective.targetProgress then objective.targetProgress = 1 end

            local victim = event.killed_unit
            if not victim.IsBaseNPC or not victim:IsBaseNPC() then return false end
            if objective.npc == victim:GetUnitName() then
                objective.currentProgress = objective.currentProgress + 1
            end

            return objective.currentProgress == objective.targetProgress
        end,

    TriggerEvaluator =
        function(objective, event)
            if not objective.trigger or not event.triggerName then return false end
            return event.triggerName == objective.trigger
        end,

}
