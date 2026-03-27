modifier_tadpole_ranged_ai = class({})

function modifier_tadpole_ranged_ai:IsHidden() return true end

function modifier_tadpole_ranged_ai:IsPurgable() return false end

function modifier_tadpole_ranged_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_tadpole_ranged_ai:OnDeath(params)
    if not self.customDeathSound then return end
    local parent = self:GetParent()
    if params.unit == parent then
        EmitSoundOn(self.customDeathSound, parent)
    end
end

function modifier_tadpole_ranged_ai:OnCreated()
    if not IsServer() then return end
    local unit = self:GetParent()
    unit:SetIdleAcquire(false)
    unit:SetAcquisitionRange(0)

    local unitName = unit:GetUnitName()
    local kv = GetUnitKeyValuesByName(unitName)
    if kv then
        self.customDeathSound = kv["CustomDeathSound"]
        self.requiredTimeInAggroOffset = kv["RequiredTimeInAggroOffset"]
    end
end

function modifier_tadpole_ranged_ai:OnIntervalThink()
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

        local casterPos = unit:GetAbsOrigin()
        local targetPos = target:GetAbsOrigin()
        local distance = (targetPos - casterPos):Length2D()
        local timeInAggro = currentTime - (unit.aggroStartTime or 0)
        unit.lastCastTime = unit.lastCastTime or 0

        if IsCasting(unit) then return end

        local requiredTimeInAggro = 2.5
        if self.requiredTimeInAggroOffset then
            requiredTimeInAggro = requiredTimeInAggro + self.requiredTimeInAggroOffset
        end
        local requiredDelay = 2
        if timeInAggro >= requiredTimeInAggro and (currentTime - unit.lastCastTime) >= requiredDelay then
            if CastAllAbilities(unit, target) then
                unit.lastCastTime = currentTime
                return
            end
        end
        if not IsCasting(unit) then
            local desiredDistance = 900
            local tolerance = 100

            if math.abs(distance - desiredDistance) > tolerance then
                local direction = (targetPos - casterPos):Normalized()
                local movePoint = targetPos - (direction * desiredDistance)

                unit:MoveToPosition(movePoint)
            end
        end
    else
    end
end
