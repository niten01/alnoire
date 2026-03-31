modifier_desert_huskar_ai = class({})

function modifier_desert_huskar_ai:IsHidden() return true end

function modifier_desert_huskar_ai:IsPurgable() return false end

function modifier_desert_huskar_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_desert_huskar_ai:OnDeath(params)
    if not self.customDeathSound then return end
    local parent = self:GetParent()
    if params.unit == parent then
        EmitSoundOn(self.customDeathSound, parent)
    end
end

function modifier_desert_huskar_ai:OnCreated()
    if not IsServer() then return end
    local unit = self:GetParent()
    unit:SetIdleAcquire(false)
    unit:SetAcquisitionRange(0)

    local unitName = unit:GetUnitName()
    local kv = GetUnitKeyValuesByName(unitName)
    self.ult = unit:FindAbilityByName('desert_huskar_push')
    if kv then
        self.customDeathSound = kv["CustomDeathSound"]
        self.requiredTimeInAggroOffset = kv["RequiredTimeInAggroOffset"]
    end
end

function modifier_desert_huskar_ai:OnIntervalThink()
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

        if self.ult.offset < 0 then
            self.ult.offset = -self.ult.offset
        end

        local allies = FindUnitsInRadius(
            unit:GetTeamNumber(),
            beaconData.pos,
            nil,
            beaconData.rangeFastTickRate,
            DOTA_UNIT_TARGET_TEAM_FRIENDLY,
            DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_CLOSEST,
            false
        )

        local desertTroll = nil
        for _, ally in pairs(allies) do
            if ally:GetUnitName() == "npc_desert_troll" and ally ~= unit and ally:IsAlive() then
                desertTroll = ally
                break
            end
        end

        if desertTroll then
            local targetPos = target:GetAbsOrigin()
            local vecToUnit = (unit:GetAbsOrigin() - targetPos):Normalized()
            local vecToTroll = (desertTroll:GetAbsOrigin() - targetPos):Normalized()
            local dot = vecToUnit:Dot(vecToTroll)

            if dot < -0.2 then
                if self.ult.offset >= 0 then
                    self.ult.offset = -self.ult.offset
                end
            end
        end

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
