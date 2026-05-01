EpsTraps = EpsTraps or {}

function EpsTraps:Init()
    self.activated = false
    self.traps = {
        { npc = "npc_trap_fire",     modifier = "modifier_trap_fire_thinker" },
        { npc = "npc_trap_arrow",    modifier = "modifier_trap_arrow_thinker" },
        { npc = "npc_trap_spikes",   modifier = "modifier_trap_spikes_thinker",  act3Only = true },
        { npc = "npc_trap_pendulum", modifier = "modifier_trap_pendulum_thinker" },
    }

    GameEvents:OnActChange(function(event)
        if event.act == 3 then
            SpawnManager:SpawnNPC("spawner_trap_spikes")
            SpawnManager:SpawnNPC("spawner_trap_fake_spikes")
        end
    end)
end

function EpsTraps:IsActivated()
    return self.activated
end

function EpsTraps:SetActivated(activated)
    if self.activated == activated then return end

    DebugPrint("[ALNOIRE] Traps minigame is now " .. (activated and 'active' or 'inactive'))

    for _, trap in ipairs(self.traps) do
        if GlobalState:Get().act < 3 and trap.act3Only then goto continue end

        for _, ent in ipairs(Entities:FindAllByName(trap.npc)) do
            local thinker = ent:FindModifierByName(trap.modifier)
            thinker:SetTrapActive(activated)
        end
        ::continue::
    end

    self.activated = activated
end

function EpsTraps:GetDamage(target)
    if GlobalState:Get().act >= 3 then
        return 0.21 * target:GetMaxHealth()
    end
    return 0.34 * target:GetMaxHealth()
end

return EpsTraps
