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
        end
}
