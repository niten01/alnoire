LinkLuaModifier('modifier_bomb_passive', "abilities/ocean/bomb_passive", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier('modifier_delayed_explosion', "abilities/ocean/bomb_passive", LUA_MODIFIER_MOTION_NONE)


bomb_passive = class({})

function bomb_passive:GetIntrinsicModifierName()
    return "modifier_bomb_passive"
end

---------------


modifier_bomb_passive = class({})

function modifier_bomb_passive:IsHidden()
    return true
end

function modifier_bomb_passive:IsPurgable()
    return false
end

function modifier_bomb_passive:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
        MODIFIER_PROPERTY_MIN_HEALTH
    }
end

function modifier_bomb_passive:GetMinHealth()
    if self:GetParent():HasModifier("modifier_delayed_explosion") then
        return 0
    end
    if self:GetAbility() then
        return 1
    end
end

function modifier_bomb_passive:OnTakeDamage(params)
    if not IsServer() then return end
    local parent = self:GetParent()
    local abil = self:GetAbility()
    if params.unit == parent and parent:GetHealth() <= 1 and not parent:HasModifier("modifier_delayed_explosion") then
        local delay = abil:GetSpecialValueFor('delayBeforeExplosion')
        parent:AddNewModifier(parent, abil, "modifier_delayed_explosion", { duration = delay })
    end
end

--------------
---
modifier_delayed_explosion = class({})

function modifier_delayed_explosion:IsHidden()
    return true
end

function modifier_delayed_explosion:IsPurgable()
    return false
end

function modifier_delayed_explosion:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
end

function modifier_delayed_explosion:CheckState()
    return {
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
    }
end

function modifier_delayed_explosion:GetOverrideAnimation()
    return ACT_DOTA_FLAIL
end

function modifier_delayed_explosion:OnDestroy()
    if not IsServer() then return end
    local parent = self:GetParent()
    local abil = self:GetAbility()


    parent:RemoveModifierByName("modifier_bomb_passive")
    if not parent:IsAlive() then return end
    self:Explode()
end

function modifier_delayed_explosion:Explode()
    if not IsServer() then return end
    local abil = self:GetAbility()
    local parent = self:GetParent()
    local rangeAoe = abil:GetSpecialValueFor("rangeAoe") or 200
    local explosionDamage = abil:GetSpecialValueFor("explosionDamage") or 95

    local pfx = ParticleManager:CreateParticle(
        "particles/units/heroes/hero_sandking/sandking_caustic_finale_explode.vpcf",
        PATTACH_ABSORIGIN, parent)
    ParticleManager:ReleaseParticleIndex(pfx)
    EmitSoundOn("Ability.SandKing_CausticFinale", parent)

    local enemies = FindUnitsInRadius(
        parent:GetTeamNumber(),
        parent:GetAbsOrigin(),
        nil,
        rangeAoe,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false
    )

    for _, enemy in pairs(enemies) do
        ApplyDamage({
            victim = enemy,
            attacker = parent,
            damage = explosionDamage,
            damage_type = DAMAGE_TYPE_PURE,
            ability = abil,
        })
    end
    parent:Kill(abil, parent)
end
