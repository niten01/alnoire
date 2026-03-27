modifier_dark_treant_ai = class({})

function modifier_dark_treant_ai:IsHidden() return true end

function modifier_dark_treant_ai:IsPurgable() return false end

function modifier_dark_treant_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_dark_treant_ai:OnDeath(params)
    local parent = self:GetParent()
    local abil = parent:FindAbilityByName('dark_treant_ult')
    local numSummons = abil:GetSpecialValueFor('numSummons')
    if params.unit:GetUnitName() == 'npc_dark_treant_summon' then
        if not self.summonDeathCounter then
            self.summonDeathCounter = 1
        else
            self.summonDeathCounter = self.summonDeathCounter + 1
        end
        if self.summonDeathCounter == numSummons then
            self.goCastUlt = true
        end
    end
    if not self.customDeathSound then return end
    if params.unit == parent then
        EmitSoundOn(self.customDeathSound, parent)
    end
end

function modifier_dark_treant_ai:OnCreated()
    if not IsServer() then return end
    local unit = self:GetParent()
    unit:SetIdleAcquire(false)
    unit:SetAcquisitionRange(0)
    self.goCastUlt = true

    local unitName = unit:GetUnitName()
    local kv = GetUnitKeyValuesByName(unitName)
    if kv then
        self.customDeathSound = kv["CustomDeathSound"]
        self.requiredTimeInAggroOffset = kv["RequiredTimeInAggroOffset"]
    end
end

function modifier_dark_treant_ai:OnIntervalThink()
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
            if self.goCastUlt then
                if CastAbility(unit, target, "dark_treant_ult") then
                    self.goCastUlt = false
                    unit.lastCastTime = GameRules:GetGameTime()
                    return
                end
            else
                if CastAbility(unit, target, "treant_leech_seed") then
                    unit.lastCastTime = GameRules:GetGameTime()
                    return
                end
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
