modifier_dark_drow_ai = class({})

function modifier_dark_drow_ai:IsHidden() return true end

function modifier_dark_drow_ai:IsPurgable() return false end

function modifier_dark_drow_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_dark_drow_ai:OnDeath(params)
    if not self.customDeathSound then return end
    local parent = self:GetParent()
    if params.unit == parent then
        EmitSoundOn(self.customDeathSound, parent)
    end
end

function modifier_dark_drow_ai:OnCreated()
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

function modifier_dark_drow_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    local target = beaconData.target

    if DefaultAiTick(unit) then
        local distFromSpawnPos = (unit:GetAbsOrigin() - unit.spawnPos):Length2D()
        if distFromSpawnPos > 10 then
            unit:MoveToPosition(unit.spawnPos)
        end
        AdjustTickRate(unit)
        self:StartIntervalThink(beaconData.currentCreepInterval)

        return
    end

    -- деремся сука
    if beaconState == 'aggro' and target and target:IsAlive() then
        if IsCasting(unit) then return end
        local distFromDrow = (target:GetAbsOrigin() - unit:GetAbsOrigin()):Length2D()
        local distFromSpawnPos = (unit:GetAbsOrigin() - unit.spawnPos):Length2D()
        if distFromSpawnPos > 10 then
            if not unit.stoppedLastTime then
                unit:Stop()
                unit.stoppedLastTime = true
            end
            unit:MoveToPosition(unit.spawnPos)
            return
        else
            unit.stoppedLastTime = false
        end
        if distFromDrow <= 200 then
            if CastAllAbilities(unit, target) then
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
