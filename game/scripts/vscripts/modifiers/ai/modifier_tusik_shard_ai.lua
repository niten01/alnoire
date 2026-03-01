modifier_tusik_shard_ai = class({})

function modifier_tusik_shard_ai:IsHidden() return true end

function modifier_tusik_shard_ai:IsPurgable() return false end

function modifier_tusik_shard_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_tusik_shard_ai:OnDeath(params)
    if not self.customDeathSound then return end
    local parent = self:GetParent()
    if params.unit == parent then
        EmitSoundOn(self.customDeathSound, parent)
    end
end

function modifier_tusik_shard_ai:OnCreated()
    if not IsServer() then return end
    local unit = self:GetParent()
    unit:SetIdleAcquire(false)
    unit:SetAcquisitionRange(0)

    local unitName = unit:GetUnitName()
    local kv = GetUnitKeyValuesByName(unitName)
    if kv then
        self.customDeathSound = kv["CustomDeathSound"]
    end
end

function modifier_tusik_shard_ai:OnIntervalThink()
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
        unit.aggroStartTime = unit.aggroStartTime or currentTime
        unit.lastCastTime = unit.lastCastTime or 0
        local timeInAggro = currentTime - (unit.aggroStartTime or 0)

        if timeInAggro >= 2.5 and (currentTime - unit.lastCastTime) >= 2 then
            self:CastSpellWithOffSet(unit, target:GetAbsOrigin(), 150)
        end

        if not IsCasting(unit) then
            local desiredDistance = 700
            local tolerance = 150

            if math.abs(distance - desiredDistance) > tolerance then
                local direction = (targetPos - casterPos):Normalized()
                local movePoint = targetPos - (direction * desiredDistance)

                unit:MoveToPosition(movePoint)
            end
        end
    else
        unit.aggroStartTime = nil
    end
end

function modifier_tusik_shard_ai:CastSpellWithOffSet(unit, targetPos, offset)
    local casterPos = unit:GetAbsOrigin()
    local direction = (targetPos - casterPos):Normalized()
    local finalPoint = targetPos + (direction * offset)

    local abil = unit:GetAbilityByIndex(0)
    if abil and abil:IsFullyCastable() and not IsCasting(unit) then
        ExecuteOrderFromTable({
            UnitIndex = unit:entindex(),
            OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
            AbilityIndex = abil:entindex(),
            Position = finalPoint,
            Queue = false,
        })
        unit.lastCastTime = GameRules:GetGameTime()
        return true
    end
    return false
end
