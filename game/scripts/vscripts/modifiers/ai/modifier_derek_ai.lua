modifier_derek_ai = class({})

function modifier_derek_ai:IsHidden() return true end

function modifier_derek_ai:IsPurgable() return false end

function modifier_derek_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
end

function modifier_derek_ai:ResetState()
    if not IsServer() then return end
    if self.phase == 2 then
        self:TransitionBack()
    end

    self.phase = 1
    self.remainingLeaps = 0

    local parent = self:GetParent()
    parent:AddNewModifier(parent, nil, "modifier_generic_unkillable", { duration = -1 })
end

modifier_derek_ai.OnCreated = modifier_derek_ai.ResetState

function modifier_derek_ai:OnIntervalThink()
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

function modifier_derek_ai:OnTakeDamage(params)
    if not IsServer() then return end
    local parent = self:GetParent()
    if params.unit ~= parent then return end
    if self.phase ~= 2 then return end

    if params.unit:GetHealth() <= 1 then
        Music:StopCustomMusic(params.attacker:GetPlayerOwnerID())
        DamageTracker:LogLethalDamage(params)
        self:TransitionBack()
        parent:SetTeam(DOTA_TEAM_GOODGUYS)
        self.phase = -1
    end
end

function modifier_derek_ai:Phase1(unit, target)
    if unit.derekCasting then return end

    if unit:GetHealth() == 1 then
        self.phase = -1
        Music:StartCustomMusicForAll("music.silence.explore")
        if not target or target:IsNull() or not target:IsAlive() then return end
        target:Stop()
        Dialogue:StartDialogueForPlayer(target:GetPlayerOwnerID(), "d_derek_phase_2_start")
        return
    end

    local distToTarget = #(unit:GetAbsOrigin() - target:GetAbsOrigin())
    local isClose = distToTarget <= 600

    if CastAbility(unit, target, "derek_epicenter") then return end
    if CastAbility(unit, target, "derek_strafe") then return end
    if CastAbility(unit, target, "derek_axe_fury") then return end
    if CastAbility(unit, target, "derek_lift", 0) then return end

    if isClose then
        if CastAbility(unit, target, "derek_rebound") then return end
    else
        if CastAbility(unit, target, "derek_axes") then return end
        if CastAbility(unit, target, "derek_slice") then return end
    end
end

function modifier_derek_ai:Phase2(unit, target)
    if unit.derekCasting then return end

    local leap = unit:FindAbilityByName("derek_wolf_leap")
    if self.remainingLeaps > 0 then
        leap:EndCooldown()
        if CastAbility(unit, target, "derek_wolf_leap") then
            if unit.lastCastAbilityName == "derek_wolf_leap" then
                unit.lastCastAbilityName = nil
                self.remainingLeaps = self.remainingLeaps - 1
            end
        end
        return
    end

    if CastAbility(unit, target, "derek_wolf_melee") then return end

    if CanCastAbility(unit, target, leap) then
        self.remainingLeaps = RandomInt(3, 7)
        unit.lastCastAbilityName = nil
    end

    if CastAbility(unit, target, "derek_wolf_daggers") then return end
    if CastAbility(unit, target, "derek_wolf_bite") then return end
    if CastRandomAbility(unit, target, { "derek_wolf_stun_howl", "derek_wolf_explode_howl" }, 0) then return end
end

function modifier_derek_ai:Transition()
    self.phase = -1
    local unit = self:GetParent()
    unit:EmitSound("derek.vo.transform")
    unit:EmitSound("derek.vo.transform.rise")
    unit:StartGesture(ACT_DOTA_TRANSITION)
    Music:StartCustomMusicForAll("music.derek.phase2")

    local pfx = ParticleManager:CreateParticle("particles/derek_transform_charge.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
    ParticleManager:SetParticleControlEnt(pfx, 1, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), false)
    ParticleManager:SetParticleControlEnt(pfx, 2, unit, PATTACH_ABSORIGIN_FOLLOW, "", Vector(0, 0, 0), false)
    ParticleManager:SetParticleControlEnt(pfx, 3, unit, PATTACH_ABSORIGIN_FOLLOW, "", Vector(0, 0, 0), false)
    ParticleManager:SetParticleControlEnt(pfx, 9, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)

    Timers:CreateTimer(8.3, function()
        ParticleManager:DestroyParticle(pfx, false)
        ParticleManager:ReleaseParticleIndex(pfx)

        local pfx = ParticleManager:CreateParticle(
            "particles/econ/items/lifestealer/ls_ti10_immortal/ls_ti10_immortal_infest.vpcf",
            PATTACH_ABSORIGIN_FOLLOW,
            unit)
        ParticleManager:ReleaseParticleIndex(pfx)

        pfx = ParticleManager:CreateParticle(
            "particles/units/heroes/hero_lycan/lycan_shapeshift_cast.vpcf",
            PATTACH_ABSORIGIN_FOLLOW,
            unit)
        ParticleManager:ReleaseParticleIndex(pfx)
        unit:AddNewModifier(unit, nil, "modifier_model", {
            duration = -1,
            model = "models/derek/derek_wolf.vmdl",
            scale = 1.8,
        })

        unit:StartGesture(ACT_DOTA_SPAWN)
        unit:EmitSound("derek.transform.howl")
        unit:EmitSound("derek.transform.roar")

        unit:SetHealth(unit:GetMaxHealth())

        Timers:CreateTimer(0.5, function()
            self.phase = 2
        end)
    end)
end

function modifier_derek_ai:TransitionBack()
    local unit = self:GetParent()
    unit:RemoveModifierByName("modifier_model")
    local pfx = ParticleManager:CreateParticle(
        "particles/econ/items/lifestealer/ls_ti10_immortal/ls_ti10_immortal_infest.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        unit)
    ParticleManager:ReleaseParticleIndex(pfx)
end
