LinkLuaModifier("modifier_morph_strike", "abilities/ocean/morph_custom_strike", LUA_MODIFIER_MOTION_NONE)
morph_custom_strike = class({})

function morph_custom_strike:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    local projSpeed = self:GetSpecialValueFor('projSpeed') or 1600

    local projInfo = {
        Target = target,
        Source = caster,
        Ability = self,
        EffectName = "particles/units/heroes/hero_morphling/morphling_adaptive_strike_agi_proj.vpcf",
        iMoveSpeed = projSpeed,
        vSourceLoc = caster:GetAbsOrigin(),
        dDodgeable = true,
        bReplaceExisting = false,
        flExpireTime = GameRules:GetGameTime() + 30,
        bProvidesVision = true,
        iVisionRadius = 200,
        iVisionTeamNumber = caster:GetTeamNumber()
    }
    EmitSoundOn("Hero_Morphling.AdaptiveStrikeStr.Cast", caster)
    ProjectileManager:CreateTrackingProjectile(projInfo)
end

function morph_custom_strike:OnProjectileHit(target, location)
    if not IsServer() or not target then return end

    local caster = self:GetCaster()
    local damageBase = self:GetSpecialValueFor("damageBase") or 85
    local stunDuration = self:GetSpecialValueFor('stunDuration') or 2.0


    local pfx = ParticleManager:CreateParticle('particles/units/heroes/hero_morphling/morphling_adaptive_strike.vpcf',
        PATTACH_ABSORIGIN, target)
    ParticleManager:SetParticleControl(pfx, 1, target:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(pfx)
    EmitSoundOn("Hero_Morphling.AdaptiveStrikeStr.Target", target)

    local damageTable = {
        victim = target,
        attacker = caster,
        damage = damageBase,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = self
    }
    ApplyDamage(damageTable)
    target:AddNewModifier(caster, self, 'modifier_morph_strike', { duration = stunDuration })

    return true
end

----------------------------
--- Modifiers

modifier_morph_strike = class({})

function modifier_morph_strike:IsHidden()
    return false
end

function modifier_morph_strike:IsPurgable()
    return false
end

function modifier_morph_strike:IsDebuff()
    return true
end

function modifier_morph_strike:CheckState()
    return {
        [MODIFIER_STATE_STUNNED] = true,
    }
end

function modifier_morph_strike:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
end

function modifier_morph_strike:GetOverrideAnimation()
    return ACT_DOTA_DISABLED
end
