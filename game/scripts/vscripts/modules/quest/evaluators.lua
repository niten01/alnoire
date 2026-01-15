return {
    TalkEvaluator =
        function(objective, event)
            if not objective.npc then return nil end
            if not event.choice or not event.choice.actions or not event.lastNode then return nil end

            -- if objective.npc ~= event.lastNode.speakerNPC then return nil end
            local actions = event.shoice.actions.quest_end
            if not actions then return nil end

            for _, action in ipairs(actions) do
                if action.questID == objective.questID then return true end
            end

            return nil
        end
}
