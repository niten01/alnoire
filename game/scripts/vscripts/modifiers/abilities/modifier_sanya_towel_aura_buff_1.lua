modifier_sanya_towel_aura_buff_1 = class({})

function modifier_sanya_towel_aura_buff_1:IsHidden() return false end
function modifier_sanya_towel_aura_buff_1:IsPurgable() return false end
function modifier_sanya_towel_aura_buff_1:IsDebuff() return false end

function modifier_sanya_towel_aura_buff_1:GetModifierConstantHealthRegen()
    local ability = self:GetAbility()
    return ability:GetSpecialValueFor('hp_regen')
end

function modifier_sanya_towel_aura_buff_1:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
end

