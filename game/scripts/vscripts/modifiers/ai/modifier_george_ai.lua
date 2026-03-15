modifier_george_ai = class({})

function modifier_george_ai:IsHidden() return true end

function modifier_george_ai:IsPurgable() return false end

function modifier_george_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
end

function modifier_george_ai:ResetState()
    if self.phase == 2 then
        self:TransitionBack()
    end

    self.phase = 1

    local parent = self:GetParent()
    parent:AddNewModifier(parent, nil, "modifier_generic_unkillable", { duration = -1 })

    Timers:CreateTimer(1, function()
        parent:AddNewModifier(parent, nil, "modifier_model", {
            duration = -1,
            model = "models/creeps/ice_biome/undeadtusk/undead_tuskskeleton_armor01.vmdl",
            scale = 1.5,
        })
    end)
end

modifier_george_ai.OnCreated = modifier_george_ai.ResetState

function modifier_george_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    local target = beaconData.target

    if DefaultAiTick(unit) then
        if beaconData.state == "retreat" then
            self:ResetState()
        end
        AdjustTickRate(unit)
        self:StartIntervalThink(beaconData.currentCreepInterval)
        return
    end

    if beaconState == 'aggro' and target and target:IsAlive() then
        if self.phase == 1 then
            self:Phase1(unit, target)
        elseif self.phase == 2 then
            self:Phase2(unit, target)
        end
    end
end

function modifier_george_ai:OnTakeDamage(params)
    if not IsServer() then return end
    local parent = self:GetParent()
    if params.unit ~= parent then return end
    if self.phase ~= 2 then return end

    if params.unit:GetHealth() <= 1 then
        DamageTracker:LogLethalDamage(params)
        self:TransitionBack()
        parent:SetTeam(DOTA_TEAM_GOODGUYS)
    end
end

function modifier_george_ai:Phase1(unit, target)
    if unit.georgeCasting then return end

    if 1 or unit:GetHealth() == 1 then
        self:Transition()
        return
    end

    local shield = unit:FindModifierByName("modifier_george_shield")
    if not shield or shield.charges <= 0 then
        if CastAbility(unit, target, "george1_shield") then return end
        if CastAbility(unit, target, "george1_parry") then return end
    end

    if CastAbility(unit, target, "george1_kick") then return end
    if CastAbility(unit, target, "george1_summon") then return end
    if CastAbility(unit, target, "george1_stalactites") then return end
end

function modifier_george_ai:Phase2(unit, target)
    if unit.georgeCasting then return end
    if CastAbility(unit, target, "george_crack") then return end
end

function modifier_george_ai:Sink()
    local unit = self:GetParent()
    local sinkDuration = 2
    local sinkDepth = 150
    local sinkProgress = 0
    local interval = 0.1
    local step = sinkDepth / (sinkDuration / interval)
    Timers:CreateTimer(0, function()
        local pos = unit:GetAbsOrigin()
        pos.z = pos.z - step
        unit:SetAbsOrigin(pos)
        sinkProgress = sinkProgress + step
        if sinkProgress >= sinkDepth then
            unit:AddNoDraw()
            return nil
        else
            return interval
        end
    end)
end

function modifier_george_ai:Unsink()
    local unit = self:GetParent()
    local pos = unit:GetAbsOrigin()
    pos.z = GetGroundHeight(pos, unit)
    FindClearSpaceForUnit(unit, pos, true)
    unit:RemoveNoDraw()
end

function modifier_george_ai:Transition()
    local duration = 4.5
    self.phase = -1

    local unit = self:GetParent()
    local unitPos = unit:GetAbsOrigin()
    -- unit:EmitSound("george.vo.transform")
    unit:StartGesture(ACT_DOTA_DIE)
    Music:StartCustomMusicForAll("music.george.phase2")

    self:Sink()

    local pfxs = {}
    local pfx = ParticleManager:CreateParticle(
        "particles/econ/items/wraith_king/wraith_king_arcana/wk_arc_reincarn_style2.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, unitPos)
    ParticleManager:SetParticleControl(pfx, 1, Vector(duration, 0, 0))
    table.insert(pfxs, pfx)

    local pfx = ParticleManager:CreateParticle(
        "particles/econ/items/wraith_king/wraith_king_arcana/wk_arc_reincarn.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, unitPos)
    ParticleManager:SetParticleControl(pfx, 1, Vector(duration, 0, 0))
    table.insert(pfxs, pfx)

    local pfx = ParticleManager:CreateParticle(
        "particles/george_reincarn_tombstone.vpcf", PATTACH_WORLDORIGIN,
        nil)
    ParticleManager:SetParticleControl(pfx, 0, unitPos)
    table.insert(pfxs, pfx)

    Timers:CreateTimer(duration, function()
        for _, pfx in ipairs(pfxs) do
            ParticleManager:DestroyParticle(pfx, false)
            ParticleManager:ReleaseParticleIndex(pfx)
        end

        local pfx = ParticleManager:CreateParticle(
            "particles/units/heroes/hero_phoenix/phoenix_supernova_reborn.vpcf", PATTACH_ABSORIGIN, unit)
        ParticleManager:ReleaseParticleIndex(pfx)

        unit:SetHealth(unit:GetMaxHealth())
        unit:RemoveModifierByName("modifier_stunned")
        unit:RemoveModifierByName("modifier_george_shield")
        unit:RemoveModifierByName("modifier_model")
        self:Unsink()
        unit:StartGesture(ACT_DOTA_SPAWN)

        Timers:CreateTimer(0.5, function()
            self.phase = 2
        end)
    end)
end

function modifier_george_ai:TransitionBack()
    -- local unit = self:GetParent()
    -- unit:RemoveModifierByName("modifier_model")
    -- local pfx = ParticleManager:CreateParticle(
    --     "particles/econ/items/lifestealer/ls_ti10_immortal/ls_ti10_immortal_infest.vpcf",
    --     PATTACH_ABSORIGIN_FOLLOW,
    --     unit)
    -- ParticleManager:ReleaseParticleIndex(pfx)
end
