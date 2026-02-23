LinkLuaModifier('modifier_pomidorka_clap_debuff', "abilities/jungle/pomidorko_clap", LUA_MODIFIER_MOTION_NONE)

pomidorko_clap = class({})

function pomidorko_clap:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    EmitSoundOn('JungleBears.Red.Clap', caster)
end

function pomidorko_clap:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor('radius')

    local point = caster:GetAbsOrigin()
    local distance = 150
    local forward_vector = caster:GetForwardVector()
    local posOffset = point + (forward_vector * distance)
    local enemies = FindUnitsInRadius(
        caster:GetTeamNumber(),
        posOffset,
        nil,
        radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false
    )
    local damage = self:GetSpecialValueFor('damage')
    local duration = self:GetSpecialValueFor('duration')

    local pfx = ParticleManager:CreateParticle('particles/neutral_fx/ursa_thunderclap.vpcf', PATTACH_POINT, caster)
    ParticleManager:SetParticleControl(pfx, 0, posOffset)
    ParticleManager:SetParticleControl(pfx, 1, Vector(radius, 0, 0))
    ParticleManager:ReleaseParticleIndex(pfx)

    for _, enemy in pairs(enemies) do
        ApplyDamage({
            victim = enemy,
            attacker = caster,
            damage = damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self,
        })
        enemy:AddNewModifier(caster, self, "modifier_pomidorka_clap_debuff", { duration = duration })
    end
end

function pomidorko_clap:GetCooldown()
    return self:GetSpecialValueFor('cooldown')
end

function pomidorko_clap:GetAOERadius()
    return self:GetSpecialValueFor('radius')
end

function pomidorko_clap:GetCastRange()
    return self:GetSpecialValueFor('radius')
end

function pomidorko_clap:GetCastAnimation()
    return ACT_DOTA_CAST_ABILITY_1
end

function pomidorko_clap:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_POINT
end

-------------------------------

modifier_pomidorka_clap_debuff = class({})

function modifier_pomidorka_clap_debuff:IsHidden() return false end

function modifier_pomidorka_clap_debuff:IsPurgable() return true end

function modifier_pomidorka_clap_debuff:IsDebuff() return true end

function modifier_pomidorka_clap_debuff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_pomidorka_clap_debuff:GetModifierMoveSpeedBonus_Constant()
    local abil = self:GetAbility()
    local ms = abil:GetSpecialValueFor('slowAmount')
    return -ms or -70
end

function modifier_pomidorka_clap_debuff:GetModifierAttackSpeedBonus_Constant()
    local abil = self:GetAbility()
    local as = abil:GetSpecialValueFor('attackSpeedSlow')
    return -as or -50
end
