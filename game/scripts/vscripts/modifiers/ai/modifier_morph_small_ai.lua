modifier_morph_small_ai = class({})

function modifier_morph_small_ai:IsHidden() return true end

function modifier_morph_small_ai:IsPurgable() return false end

function modifier_morph_small_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_morph_small_ai:OnDeath(params)
    if not self.customDeathSound then return end
    local parent = self:GetParent()
    if params.unit == parent then
        EmitSoundOn(self.customDeathSound, parent)
    end
end

function modifier_morph_small_ai:OnCreated()
    if not IsServer() then return end
    local unit = self:GetParent()
    unit:SetIdleAcquire(false)
    unit:SetAcquisitionRange(0)
    self.dash = unit:FindAbilityByName('morphling_waveform')

    local unitName = unit:GetUnitName()
    local kv = GetUnitKeyValuesByName(unitName)
    if kv then
        self.customDeathSound = kv["CustomDeathSound"]
        self.requiredTimeInAggroOffset = kv["RequiredTimeInAggroOffset"]
    end
end

function modifier_morph_small_ai:OnIntervalThink()
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

    -- деремся сука
    if beaconState == 'aggro' and target and target:IsAlive() then
        local currentTime = GameRules:GetGameTime()

        local timeInAggro = currentTime - (unit.aggroStartTime or 0)
        unit.lastCastTime = unit.lastCastTime or 0

        if IsCasting(unit) then return end

        local requiredTimeInAggro = 2.5
        if self.requiredTimeInAggroOffset then
            requiredTimeInAggro = requiredTimeInAggro + self.requiredTimeInAggroOffset
        end
        local requiredDelay = 2
        if timeInAggro >= requiredTimeInAggro and (currentTime - unit.lastCastTime) >= requiredDelay then
            local destination = self:GetSafeBlinkDestinationWithOffset(unit:GetAbsOrigin(), target:GetAbsOrigin(),
                900)
            self.dash.forcedPosition = destination
            if CastAllAbilities(unit, target) then
                unit.lastCastTime = currentTime
                return
            end
        end

        if not unit:GetAggroTarget() then
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                Position = target:GetAbsOrigin(),
                Queue = false,
            })
        end
    else
    end
end

--- @param start Vector unit position where blink started
--- @param targetRaw Vector basically click position
function modifier_morph_small_ai:GetSafeBlinkDestinationWithOffset(start, targetRaw, offset)
    local direction = (targetRaw - start):Normalized()
    local target = targetRaw
    local initialDistance = #(targetRaw - start)
    if offset then
        target = start + direction * offset
    end

    local accum = start
    local maxLength = #(target - start)
    while #(accum - start) < maxLength do
        local next = accum + direction * SAFE_BLINK_PRECISION
        if GridNav:IsBlocked(next) or not GridNav:IsTraversable(next) then
            accum = accum - direction * SAFE_BLINK_HULL_RADIUS
            return accum
        end
        accum = next
    end

    return target
end
