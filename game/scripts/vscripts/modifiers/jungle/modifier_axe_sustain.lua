modifier_axe_sustain = class({})

function modifier_axe_sustain:IsHidden()
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
    return 200
end

function modifier_axe_sustain:GetTexture()
    return "dragon_knight_breathe_fire"
end

function modifier_axe_sustain:GetEffectName()
    return "particles/econ/events/fall_2022/mjollnir/mjollnir_shield_fall2022.vpcf"
end

function modifier_axe_sustain:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_axe_sustain:GetModifierIncomingDamage_Percentage()
    return -90
end

function modifier_axe_sustain:OnAttackLanded(args)
    if not IsServer() then return end
    if args.target == self:GetParent() then
        EmitSoundOn('Ability.PlasmaFieldImpact', self:GetParent())
    end
end
