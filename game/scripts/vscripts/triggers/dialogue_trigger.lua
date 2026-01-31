function DialogueTriggerOnStartTouch(trigger, event)
    local activator = event.activator
    if not activator or not activator:IsRealHero() then return end
    local playerID = activator:GetPlayerID()

    local premetCondition = { type = "trigger", trigger = trigger:GetName() }

    local entrypoint = Dialogue:GetDialogueNodeBestMatchEntrypoint(playerID, { premetCondition })
    if not entrypoint then return end
    Dialogue:StartDialogueForAll(entrypoint.nodeID)
end
