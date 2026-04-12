modifier_chaser_final_ai = class({})

function modifier_chaser_final_ai:IsHidden() return true end

function modifier_chaser_final_ai:IsPurgable() return false end

function modifier_chaser_final_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH,
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST
    }
end

function modifier_chaser_final_ai:OnAbilityFullyCast(params)
    if not IsServer() then return end
    local parent = self:GetParent()
    local beaconData = parent.packTargetData
    if params.unit == parent then
        if params.ability:GetAbilityName() == 'chaser_rite' then
            beaconData.castRite = true
            local currentTime = GameRules:GetGameTime()
            beaconData.lastRiteCastTime = currentTime
            beaconData.castedCloneRites = 0
        end
        if params.ability:GetAbilityName() == 'chaser_stun' then
            beaconData.castStun = true
            local currentTime = GameRules:GetGameTime()
            beaconData.lastStunCastTime = currentTime
            beaconData.castedCloneStuns = 0
        end
    end
end

function modifier_chaser_final_ai:OnDeath(params)
    if not self.customDeathSound then return end
    local parent = self:GetParent()
    if params.unit == parent then
        EmitSoundOn(self.customDeathSound, parent)
    end
end

function modifier_chaser_final_ai:OnCreated()
    if not IsServer() then return end
    local unit = self:GetParent()
    unit:SetIdleAcquire(false)
    unit:SetAcquisitionRange(0)

    local unitName = unit:GetUnitName()
    local kv = GetUnitKeyValuesByName(unitName)
    self.rite = unit:FindAbilityByName('chaser_rite')
    self.stun = unit:FindAbilityByName('chaser_stun')
    if kv then
        self.customDeathSound = kv["CustomDeathSound"]
        self.requiredTimeInAggroOffset = kv["RequiredTimeInAggroOffset"]
    end
end

function modifier_chaser_final_ai:OnIntervalThink()
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
