LinkLuaModifier('modifier_dark_ursa_almost_dead', "modifiers/ai/modifier_dark_ursa_ai", LUA_MODIFIER_MOTION_NONE)
modifier_dark_ursa_ai = class({})

function modifier_dark_ursa_ai:IsHidden() return true end

function modifier_dark_ursa_ai:IsPurgable() return false end

function modifier_dark_ursa_ai:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MIN_HEALTH,
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
end

function modifier_dark_ursa_ai:GetMinHealth()
    return 1
end

function modifier_dark_ursa_ai:OnTakeDamage(params)
    if not IsServer() then return end
    local parent = self:GetParent()
    if params.unit == parent and parent:GetHealth() <= 1 and not parent:HasModifier('modifier_dark_ursa_almost_dead') then
        local enrage = parent:FindAbilityByName('ursa_enrage')
        local duration = enrage:GetSpecialValueFor('duration')
        local target = parent.packTargetData.target
        parent:AddNewModifier(parent, enrage, 'modifier_dark_ursa_almost_dead', { duration = duration })
        CastAbility(parent, target, "ursa_enrage")
    end
end

function modifier_dark_ursa_ai:OnCreated()
    if not IsServer() then return end
    local unit = self:GetParent()
    unit:SetIdleAcquire(false)
    unit:SetAcquisitionRange(0)

    local unitName = unit:GetUnitName()
    self.overpower = unit:FindAbilityByName('ursa_overpower')
    local kv = GetUnitKeyValuesByName(unitName)
    if kv then
        unit.customDeathSound = kv["CustomDeathSound"]
        self.requiredTimeInAggroOffset = kv["RequiredTimeInAggroOffset"]
    end
end

function modifier_dark_ursa_ai:OnIntervalThink()
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
            if CastAbility(unit, target, "ursa_overpower") then
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

----------------------
modifier_dark_ursa_almost_dead = class({})

function modifier_dark_ursa_almost_dead:IsHidden()
    return true
end

function modifier_dark_ursa_almost_dead:IsPurgable()
    return false
end

function modifier_dark_ursa_almost_dead:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MIN_HEALTH,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_dark_ursa_almost_dead:GetModifierAttackSpeedBonus_Constant()
    return 300
end

function modifier_dark_ursa_almost_dead:GetMinHealth()
    return 1
end

function modifier_dark_ursa_almost_dead:OnCreated()
    if not IsServer() then return end
    local parent = self:GetParent()
    if parent:HasModifier('modifier_dark_ursa_ai') then
        parent:RemoveModifierByName('modifier_dark_ursa_ai')
    end
    self:StartIntervalThink(BATTLE_THINK_INTERVAL)
end

function modifier_dark_ursa_almost_dead:OnIntervalThink()
    if not IsServer() then return end
    local unit = self:GetParent()
    local packData = unit.packTargetData
    local target = packData.target

    if not unit:GetAggroTarget() and target then
        ExecuteOrderFromTable({
            UnitIndex = unit:entindex(),
            OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
            Position = target:GetAbsOrigin(),
            Queue = false,
        })
    end
end

function modifier_dark_ursa_almost_dead:OnDestroy()
    if not IsServer() then return end
    local parent = self:GetParent()
    EmitSoundOn(parent.customDeathSound, parent)
    parent:Kill(nil, parent)
end
