return {
    TalkEvaluator =
        function(objective, event)
            if not objective.npc then return false end
            return event.lastNode.npc == objective.npc
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

    BeatEvaluator =
        function(objective, event)
            local victimName = event.unit:GetUnitName()
            return objective.npc == victimName 
        end,

    TriggerEvaluator =
        function(objective, event)
            if not objective.trigger or not event.triggerName then return false end
            return event.triggerName == objective.trigger
        end,

}
