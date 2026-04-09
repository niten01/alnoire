modifier_genius_ai = class({})

function modifier_genius_ai:IsHidden() return true end

function modifier_genius_ai:IsPurgable() return false end

function modifier_genius_ai:OnCreated()
    local parent = self:GetParent()
    self.waitProcast = false
end

function modifier_genius_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    local target = beaconData.target

    AdjustTickRate(unit)
    self:StartIntervalThink(beaconData.currentCreepInterval)
    if DefaultAiTick(unit) then
        return
    end

    if beaconState == 'aggro' and target and target:IsAlive() then
        if unit:GetHealthPercent() < 10 then
            if CastAbility(unit, unit, "oracle_false_promise") then return end
        end

        if CastAbility(unit, target, "genius_rain") then return end

        if CastAbility(unit, target, "oracle_fortunes_end") then
            if unit.lastCastAbilityName == "oracle_fortunes_end" then
                self.waitProcast = true
            end
            return
        end

        if not self.waitProcast then
            if CastAbility(unit, target, "genius_push") then return end

            local flareTgt = target:GetAbsOrigin()
            local rainMod = target:FindModifierByName("modifier_rain_slippery")
            local approxFwd = 300
            if rainMod then
                flareTgt = flareTgt + rainMod.velocity:Normalized() * approxFwd
                -- DebugDrawSphere(flareTgt, Vector(255, 0, 0), 100, 30, false, 0.2)
            end
            if CastAbility(unit, flareTgt, "genius_flare") then return end
        else
            if CastAbility(unit, target, "oracle_purifying_flames") then
                if unit.lastCastAbilityName == "oracle_purifying_flames" then
                    self.waitProcast = false
                end
                return
            end
        end
    end
end
