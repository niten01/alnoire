modifier_dark_pugna_ai = class({})

function modifier_dark_pugna_ai:IsHidden() return true end

function modifier_dark_pugna_ai:IsPurgable() return false end

function modifier_dark_pugna_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH,
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
end

local SPOTS = { "darkforest_pugna_tp_1", "darkforest_pugna_tp_2", "darkforest_pugna_tp_3", "darkforest_pugna_tp_4" }

function modifier_dark_pugna_ai:TpToRandomSpot(unit, spotNames)
    if not IsServer() then return end
    if not unit or unit:IsNull() or not unit:IsAlive() then return end
    if unit:IsChanneling() then
        unit:Stop()
    end
    local availableSpots = {}
    for _, name in pairs(spotNames) do
        if name ~= self.lastSpot then
            table.insert(availableSpots, name)
        end
    end
    local randomSpotName = availableSpots[RandomInt(1, #availableSpots)]
    self.lastSpot = randomSpotName
    local targetEnt = Entities:FindByName(nil, randomSpotName)
    if not targetEnt then
        print("[PUGNA_ERROR] Could not find entity with name: " .. randomSpotName)
        return
    end
    local targetPos = targetEnt:GetAbsOrigin()
    unit:StartGesture(ACT_DOTA_CAST_ABILITY_1)
    Timers:CreateTimer(0.3, function()
        if not unit or unit:IsNull() or not unit:IsAlive() then return end

        local pfx = ParticleManager:CreateParticle(
            "particles/dark_pugna_tp.vpcf",
            PATTACH_ABSORIGIN,
            unit
        )
        ParticleManager:ReleaseParticleIndex(pfx)
        EmitSoundOn("Hero_MonkeyKing.Transform.Off", unit)
    end)
    Timers:CreateTimer(0.5, function()
        if not unit or unit:IsNull() or not unit:IsAlive() then return end
        unit:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
        FindClearSpaceForUnit(unit, targetPos, true)
        EmitSoundOn("Hero_MonkeyKing.Transform.On", unit)
    end)
    Timers:CreateTimer(0.3, function()
        if not unit or unit:IsNull() or not unit:IsAlive() then return end
        unit.timeToTp = false
    end)
end

function modifier_dark_pugna_ai:OnTakeDamage(params)
    if not IsServer() then return end
    local parent = self:GetParent()
    if params.unit == parent then
        parent.timeToTp = true
        parent:Stop()
        self:TpToRandomSpot(parent, SPOTS)
    end
end

function modifier_dark_pugna_ai:OnDeath(params)
    local parent = self:GetParent()
    if params.unit == parent then
        if parent.teammate then
            parent.teammate:Kill(nil, parent.teammate)
        end
        if not self.customDeathSound then return end
        EmitSoundOn(self.customDeathSound, parent)
    end
end

function modifier_dark_pugna_ai:CheckState()
    return {
        [MODIFIER_STATE_DISARMED] = true,
    }
end

function modifier_dark_pugna_ai:OnCreated()
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

function modifier_dark_pugna_ai:OnIntervalThink()
    if self.timeToTp then
        return
    end
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    if not unit.teammate then
        local allies = FindUnitsInRadius(
            unit:GetTeamNumber(),
            unit:GetAbsOrigin(),
            nil,
            3000,
            DOTA_UNIT_TARGET_TEAM_FRIENDLY,
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
            FIND_ANY_ORDER,
            false
        )
        for _, ally in pairs(allies) do
            if ally ~= unit and ally:IsAlive() and ally.packTargetData == unit.packTargetData then
                unit.teammate = ally
                break
            end
        end
        if unit.teammate == nil then
            return
        end
    end
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
        if not unit.teammate:IsChanneling() and unit:IsChanneling() then
            unit:Stop()
        end
        if IsCasting(unit) then return end
        if unit.teammate:IsChanneling() then
            if CastAbility(unit, target, "pugna_life_drain") then
                return
            end
        end
    else
    end
end
