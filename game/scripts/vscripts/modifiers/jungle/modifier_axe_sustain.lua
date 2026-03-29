modifier_axe_sustain = class({})

function modifier_axe_sustain:IsHidden()
    return true
end

function modifier_axe_sustain:IsDebuff()
    return false
end

function modifier_axe_sustain:IsPurgable()
    return false
end

function modifier_axe_sustain:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_EVENT_ON_ATTACK_LANDED,
        MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
    }
end

function modifier_axe_sustain:GetDisableAutoAttack()
    return 1
end

function modifier_axe_sustain:GetModifierBaseAttack_BonusDamage()
    if not self.damageBonus then
        return 0
    end
    return self.damageBonus
end

function modifier_axe_sustain:OnCreated()
    if not IsServer() then return end
    local parent = self:GetParent()
    local abil = self:GetAbility()
    self.damageBonus = abil:GetSpecialValueFor('bonusDamage') or 200
    self.damageReductionPercent = abil:GetSpecialValueFor('damageReductionPercent') or 90.0
    local pfx = ParticleManager:CreateParticle("particles/econ/events/fall_2022/mjollnir/mjollnir_shield_fall2022.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)
    self:AddParticle(pfx, false, false, -1, false, false)
end

function modifier_axe_sustain:GetModifierIncomingDamage_Percentage()
    if not self.damageReductionPercent then return 0 end
    return -self.damageReductionPercent
end

function modifier_axe_sustain:OnAttackLanded(args)
    if not IsServer() then return end
    if args.target == self:GetParent() then
        EmitSoundOn('Ability.PlasmaFieldImpact', self:GetParent())
    end
end
