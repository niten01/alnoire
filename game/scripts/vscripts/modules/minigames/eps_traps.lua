EpsTraps = EpsTraps or {}

function EpsTraps:Init()
    self.activated = false
end

function EpsTraps:SetActivated(activated)
    if self.activated == activated then return end

    DebugPrint("[ALNOIRE] Traps minigame is now " .. (activated and 'active' or 'inactive'))

    for _, ent in ipairs(Entities:FindAllByName("npc_trap_fire")) do
        local thinker = ent:FindModifierByName("modifier_trap_fire_thinker")
        thinker:SetTrapActive(activated)
    end

    for _, ent in ipairs(Entities:FindAllByName("npc_trap_pendulum")) do
        local thinker = ent:FindModifierByName("modifier_trap_pendulum_thinker")
        thinker:SetTrapActive(activated)
    end

    self.activated = activated
end

return EpsTraps
