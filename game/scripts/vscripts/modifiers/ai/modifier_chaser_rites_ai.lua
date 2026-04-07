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

function modifier_chaser_rites_ai:OnTakeDamage(params)
    if not IsServer() then return end
    local parent = self:GetParent()
    if params.unit ~= parent then return end

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
