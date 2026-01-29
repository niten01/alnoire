modifier_sanya_towel_aura_buff_2 = class({})

function modifier_sanya_towel_aura_buff_2:IsHidden() return false end
function modifier_sanya_towel_aura_buff_2:IsPurgable() return false end
function modifier_sanya_towel_aura_buff_2:IsDebuff() return false end

function modifier_sanya_towel_aura_buff_2:GetModifierConstantHealthRegen()
    local ability = self:GetAbility()
    return 200
end

function modifier_sanya_towel_aura_buff_2:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
end