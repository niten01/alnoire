modifier_towel_summon_overpower = class({})

function modifier_towel_summon_overpower:IsHidden()
    return false
end

function modifier_towel_summon_overpower:IsPurgable()
    return false
end

function modifier_towel_summon_overpower:IsDebuff()
    return false
end

function modifier_towel_summon_overpower:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_towel_summon_overpower:GetModifierAttackSpeedBonus_Constant()
    if not IsServer() then return end
    local attack_stacks = self:GetStackCount()
    local ability = self:GetAbility()
    return attack_stacks * ability:GetSpecialValueFor('asb_per_attack')
end

function modifier_towel_summon_overpower:OnTooltip()
    if not IsServer() then return end
    local ability = self:GetAbility()
    return self:GetStackCount() * ability:GetSpecialValueFor('atb_per_attack')
end

function modifier_towel_summon_overpower:OnCreated()
    if not IsServer() then return end
    local caster = self:GetParent()
    local pfx = ParticleManager:CreateParticle("particles/econ/items/shredder/timber_controlled_burn/timber_controlled_burn_timberchain_ember.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    self:AddParticle( pfx, false, false, -1, false, true )
    self:SetStackCount(0)
end

function modifier_towel_summon_overpower:OnAttackLanded(params)
    if not IsServer() then return end
    local attacker = params.attacker
    local caster = self:GetParent()
    if attacker == caster then
        self:IncrementStackCount()
    end
end