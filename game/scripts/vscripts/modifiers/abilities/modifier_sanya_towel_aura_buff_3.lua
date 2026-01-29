modifier_sanya_towel_aura_buff_3 = class({})

function modifier_sanya_towel_aura_buff_3:IsHidden() return false end
function modifier_sanya_towel_aura_buff_3:IsPurgable() return false end
function modifier_sanya_towel_aura_buff_3:IsDebuff() return false end

function modifier_sanya_towel_aura_buff_3:GetModifierConstantHealthRegen()
    local ability = self:GetAbility()
    return 300
end

function modifier_sanya_towel_aura_buff_3:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
end