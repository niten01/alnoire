return {
    TalkEvaluator =
        function(questID, objective, event)
            if not objective.npc then return nil end
            if not event.choice or not event.choice.actions then return nil end

            local actions = event.choice.actions.quest_end
            if not actions then return nil end

            for _, action in ipairs(actions) do
                if action.questID == questID then return true end
            end

            return nil
        end
}
