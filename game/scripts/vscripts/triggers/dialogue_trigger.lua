function DialogueTriggerOnStartTouch(trigger, event)
    local activator = event.activator
    if not activator or not activator:IsRealHero() or not activator:IsAlive() then return end
    local playerID = activator:GetPlayerID()

    if PackManager:HasActiveFights() then return end

    local premetCondition = { type = "trigger", trigger = trigger:GetName() }

    local entrypoint = Dialogue:GetDialogueNodeBestMatchEntrypoint(playerID, { premetCondition })
    if not entrypoint then return end
    Dialogue:StartDialogueForPlayer(playerID, entrypoint.nodeID)
end
