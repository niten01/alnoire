modifier_genius_ai = class({})

function modifier_genius_ai:IsHidden() return true end

function modifier_genius_ai:IsPurgable() return false end

function modifier_genius_ai:OnCreated()
end

function modifier_genius_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    local target = beaconData.target

    if DefaultAiTick(unit) then
        AdjustTickRate(unit)
        self:StartIntervalThink(beaconData.currentCreepInterval)
        return
    end

    if beaconState == 'aggro' and target and target:IsAlive() then
        -- local ability = unit:FindAbilityByName("oracle_fortunes_end")
        -- if CastAbility(unit, target, "oracle_fortunes_end") then
        --     if unit.lastCastAbilityName == "oracle_fortunes_end" then
        --         Timers:CreateTimer(ability:GetChannelTime() + 0.05, function()
        --             if CastAbility(unit, target, "oracle_purifying_flames") then return end
        --         end)
        --     end
        --     return
        -- end

        if CastAbility(unit, target, "genius_flare") then return end
    end
end
