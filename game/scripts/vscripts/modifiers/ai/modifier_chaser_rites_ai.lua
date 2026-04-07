modifier_chaser_rites_ai = class({})

function modifier_chaser_rites_ai:IsHidden() return true end

function modifier_chaser_rites_ai:IsPurgable() return false end

function modifier_chaser_rites_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
end

function modifier_chaser_rites_ai:OnCreated()
    if not IsServer() then return end
    self.chaserAlone = false
    local parent = self:GetParent()
    parent.lastCastTime = 0
end

local SPOTS = { "chaser_rites_tp_1", "chaser_rites_tp_2" }

function modifier_chaser_rites_ai:BlinkOut(unit, spotNames)
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
        print("[CHASER_ERROR] Could not find entity with name: " .. randomSpotName)
        return
    end
    local targetPos = targetEnt:GetAbsOrigin()
    Timers:CreateTimer(0.4, function()
        if not unit or unit:IsNull() or not unit:IsAlive() then return end

        local pfx = ParticleManager:CreateParticle(
            "particles/econ/events/fall_2022/blink/blink_dagger_fall_2022_start.vpcf",
            PATTACH_ABSORIGIN,
            unit
        )
        ParticleManager:ReleaseParticleIndex(pfx)
        EmitSoundOn("DOTA_Item.Overwhelming_Blink.NailedIt", unit)
    end)
    Timers:CreateTimer(0.6, function()
        if not unit or unit:IsNull() or not unit:IsAlive() then return end
        FindClearSpaceForUnit(unit, targetPos, true)
        if unit:HasModifier('modifier_chaser_tp_invul') then
            unit:RemoveModifierByName('modifier_chaser_tp_invul')
        end
        local pfxEnd = ParticleManager:CreateParticle(
            "particles/econ/events/fall_2022/blink/blink_dagger_end_fall2022.vpcf",
            PATTACH_ABSORIGIN,
            unit
        )
        ParticleManager:ReleaseParticleIndex(pfxEnd)
        EmitSoundOn("Blink_Layer.Overwhelming", unit)
    end)
    Timers:CreateTimer(0.3, function()
        if not unit or unit:IsNull() or not unit:IsAlive() then return end
        unit.timeToTp = false
    end)
end

function modifier_chaser_rites_ai:OnTakeDamage(params)
    if not IsServer() then return end
    local parent = self:GetParent()
    if params.unit ~= parent then return end

    if params.unit:GetHealth() >= 10 and not self.chaserAlone then
        parent.timeToTp = true
        parent:Stop()
        parent:AddNewModifier(parent, nil, 'modifier_chaser_tp_invul', {})
        self:BlinkOut(parent, SPOTS)
    end


    if params.unit:GetHealth() <= 1 then
        self:StartIntervalThink(-1)
        parent:Stop()
        parent:EmitSound("chaser.disappear")
        parent:EmitSound("chaser.laugh")
        local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_chaos_knight/chaos_knight_phantasm.vpcf",
            PATTACH_ABSORIGIN_FOLLOW, parent)
        Timers:CreateTimer(1, function()
            ParticleManager:DestroyParticle(pfx, false)
            ParticleManager:ReleaseParticleIndex(pfx)
            local pfx = ParticleManager:CreateParticle(
                "particles/units/heroes/hero_chaos_knight/chaos_knight_reality_rift.vpcf", PATTACH_ABSORIGIN, parent)
            ParticleManager:SetParticleControl(pfx, 1, parent:GetAbsOrigin())
            ParticleManager:SetParticleControlTransform(pfx, 2, parent:GetAbsOrigin(), VectorToAngles(Vector(0, -90, 0)))
            ParticleManager:ReleaseParticleIndex(pfx)
            UTIL_Remove(parent)
        end)
    end
end

function modifier_chaser_rites_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    if unit.timeToTp then
        return
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

    local currentTime = GameRules:GetGameTime()
    local requiredDelay = 2.5
    if beaconState == 'aggro' and target and target:IsAlive() then
        if (currentTime - unit.lastCastTime) >= requiredDelay and CastAllAbilities(unit, target) then
            unit.lastCastTime = GameRules:GetGameTime()
            return
        end

        if IsCasting(unit) then return end
        local beaconPos = beaconData.pos
        local allies = FindUnitsInRadius(unit:GetTeamNumber(), beaconPos, nil, beaconData.rangeFastTickRate,
            DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER, false)
        local hasGroupMembers = false
        for _, ally in pairs(allies) do
            if ally ~= unit and ally:IsAlive() and ally.packTargetData == beaconData then
                hasGroupMembers = true
                break
            end
        end
        if not hasGroupMembers then
            self.chaserAlone = true
        end
        if not unit:GetAggroTarget() and self.chaserAlone then
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                Position = target:GetAbsOrigin(),
                Queue = false,
            })
        end
    end
end
