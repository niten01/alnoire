require('internal.gameevents')

local OnQuestTriggerEvent = CreateGameEvent 'OnQuestTrigger'
function QuestTriggerOnStartTouch(trigger, event)
    local activator = event.activator
    if not activator or not activator:IsRealHero() then return end

    local triggerName = trigger:GetName()
    if not triggerName then
        DebugPrint("[???] Unnamed quest trigger")
        return
    end

    OnQuestTriggerEvent({
        triggerName = triggerName,
        playerID = activator:GetPlayerID(),
    })
end
