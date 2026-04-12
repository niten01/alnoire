modifier_chaser_clone_ai = class({})

function modifier_chaser_clone_ai:IsHidden() return true end

function modifier_chaser_clone_ai:IsPurgable() return false end

function modifier_chaser_clone_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_chaser_clone_ai:OnDeath(params)
    if not self.customDeathSound then return end
    local parent = self:GetParent()
    if params.unit == parent then
        EmitSoundOn(self.customDeathSound, parent)
    end
end

function modifier_chaser_clone_ai:OnCreated()
    if not IsServer() then return end
    local unit = self:GetParent()
    unit:SetIdleAcquire(false)
    unit:SetAcquisitionRange(0)

    local unitName = unit:GetUnitName()
    local kv = GetUnitKeyValuesByName(unitName)

    if kv then
        self.customDeathSound = kv["CustomDeathSound"]
        self.requiredTimeInAggroOffset = kv["RequiredTimeInAggroOffset"]
        self.minRiteDelay = tonumber(kv["MinRiteDelay"])
        self.maxRiteDelay = tonumber(kv["MaxRiteDelay"])
        self.minStunDelay = tonumber(kv["MinStunDelay"])
        self.maxStunDelay = tonumber(kv["MaxStunDelay"])
        self.nextRiteDelay = RandomFloat(self.minRiteDelay, self.maxRiteDelay)
        self.nextStunDelay = RandomFloat(self.minStunDelay, self.maxStunDelay)
    end
end

function modifier_chaser_clone_ai:OnIntervalThink()
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

        if beaconData.castRite and (currentTime - beaconData.lastRiteCastTime) >= self.nextRiteDelay then
            if CastAbility(unit, target, "chaser_rite") then
                print('randRiteDelay - ' .. self.nextRiteDelay)
                self.nextRiteDelay = RandomFloat(self.minRiteDelay, self.maxRiteDelay)
                unit.lastCastTime = currentTime
                beaconData.castedCloneRites = beaconData.castedCloneRites + 1
                if beaconData.castedCloneRites >= 2 then
                    beaconData.castRite = false
                end
                return
            end
        end

        if beaconData.castStun and (currentTime - beaconData.lastStunCastTime) >= self.nextStunDelay then
            if CastAbility(unit, target, "chaser_stun") then
                print('randStunDelay - ' .. self.nextStunDelay)
                self.nextStunDelay = RandomFloat(self.minStunDelay, self.maxStunDelay)
                unit.lastCastTime = currentTime
                beaconData.castedCloneStuns = beaconData.castedCloneStuns + 1
                if beaconData.castedCloneStuns >= 2 then
                    beaconData.castStun = false
                end
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
