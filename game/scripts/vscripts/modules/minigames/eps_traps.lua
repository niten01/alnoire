EpsTraps = EpsTraps or {}

function EpsTraps:Init()
    self.activated = false
    self.traps = {
        { npc = "npc_trap_fire",     modifier = "modifier_trap_fire_thinker" },
        { npc = "npc_trap_arrow",    modifier = "modifier_trap_arrow_thinker" },
        { npc = "npc_trap_spikes",   modifier = "modifier_trap_spikes_thinker" },
        { npc = "npc_trap_pendulum", modifier = "modifier_trap_pendulum_thinker" },
    }
end

function EpsTraps:IsActivated()
    return self.activated
end

function EpsTraps:SetActivated(activated)
    if self.activated == activated then return end

    DebugPrint("[ALNOIRE] Traps minigame is now " .. (activated and 'active' or 'inactive'))

    for _, trap in ipairs(self.traps) do
        for _, ent in ipairs(Entities:FindAllByName(trap.npc)) do
            local thinker = ent:FindModifierByName(trap.modifier)
            thinker:SetTrapActive(activated)
        end
    end

    self.activated = activated
end

return EpsTraps
