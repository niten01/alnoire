modifier_tusik_uppercut_ai = class({})

function modifier_tusik_uppercut_ai:IsHidden() return true end

function modifier_tusik_uppercut_ai:IsPurgable() return false end

function modifier_tusik_uppercut_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH,
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
    }
end

function modifier_tusik_uppercut_ai:OnAbilityFullyCast(params)
    local parent = self:GetParent()
    if params.unit == parent then
        if self.punch_target then
            if not self.punch_target:HasModifier('modifier_tusik_papa_increase') then
                self.punch_target:AddNewModifier(parent, nil, 'modifier_tusik_papa_increase', { duration = 20.0 })
            else
                local mod = self.punch_target:FindModifierByName("modifier_tusik_papa_increase")
                mod:IncrementStackCount()
            end
            self.punch_target = nil
        end
        if self.papa then
            local mod = self.papa:FindModifierByName('modifier_tusik_papa_spellAmp')
            if mod then
                mod:IncrementStackCount()
            end
        end
    end
end

function modifier_tusik_uppercut_ai:OnDeath(params)
    if not self.customDeathSound then return end
    local parent = self:GetParent()
    if params.unit == parent then
        EmitSoundOn(self.customDeathSound, parent)
    end
end

function modifier_tusik_uppercut_ai:OnCreated()
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

function modifier_tusik_uppercut_ai:OnIntervalThink()
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

    local allies = FindUnitsInRadius(
        unit:GetTeam(),
        beaconData.pos,
        nil,
        beaconData.rangeRetreat + 100,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY,
        DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false
    )

    for _, ally in ipairs(allies) do
        if ally and ally:GetUnitName() == 'npc_ocean_tusik_papa' then
            self.papa = ally
        end
    end
    -- деремся сука
    if beaconState == 'aggro' and target and target:IsAlive() then
        local currentTime = GameRules:GetGameTime()

        local timeInAggro = currentTime - (unit.aggroStartTime or 0)
        unit.lastCastTime = unit.lastCastTime or 0

        if IsCasting(unit) then return end

        if timeInAggro >= 2.5 and (currentTime - unit.lastCastTime) >= 2 then
            if CastAllAbilities(unit, target) then
                self.punch_target = target
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
