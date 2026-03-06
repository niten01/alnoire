modifier_island_fiend_ai = class({})

function modifier_island_fiend_ai:IsHidden() return true end

function modifier_island_fiend_ai:IsPurgable() return false end

function modifier_island_fiend_ai:OnCreated()
    local parent = self:GetParent()
    self.blinkSeqStep = 0
    self.blinkSeqTarget = nil
end

function modifier_island_fiend_ai:OnIntervalThink()
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
        if self:BlinkSequence(unit, target) then return end

        -- if not unit:GetAggroTarget() and not unit:IsCommandRestricted() then
        --     ExecuteOrderFromTable({
        --         UnitIndex = unit:entindex(),
        --         OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
        --         Position = target:GetAbsOrigin(),
        --         Queue = false,
        --     })
        -- end
    end
end

function modifier_island_fiend_ai:BlinkSequence(unit, target)
    if CastAbility(unit, target, "island_fiend_blink") then
        if unit.lastCastAbilityName == "island_fiend_blink" then
            self.blinkSeqStep = 1
        end
        return true
    end

    if self.blinkSeqStep == 1 then
        if CastAbility(unit, target, "shadow_fiend_shadowraze_a_lua") then
            if unit.lastCastAbilityName == "shadow_fiend_shadowraze_a_lua" then
                self.blinkSeqStep = 2
                self.blinkSeqTarget = target:GetAbsOrigin()
            end
            return true
        end
    elseif self.blinkSeqStep == 2 then
        if CastAbility(unit, self.blinkSeqTarget, "shadow_fiend_shadowraze_b_lua") then
            if unit.lastCastAbilityName == "shadow_fiend_shadowraze_b_lua" then
                self.blinkSeqStep = 3
            end
            return true
        end
    elseif self.blinkSeqStep == 3 then
        if CastAbility(unit, self.blinkSeqTarget, "shadow_fiend_shadowraze_c_lua") then
            if unit.lastCastAbilityName == "shadow_fiend_shadowraze_c_lua" then
                self.blinkSeqStep = 0
            end
            return true
        end
    end

    return false
end
