modifier_sanya_towel_aura_buff_3 = class({})

function modifier_sanya_towel_aura_buff_3:IsHidden() return false end
function modifier_sanya_towel_aura_buff_3:IsPurgable() return false end
function modifier_sanya_towel_aura_buff_3:IsDebuff() return false end

function modifier_sanya_towel_aura_buff_3:GetModifierMoveSpeedBonus_Constant()
    local ability = self:GetAbility()
    local ms = ability:GetSpecialValueFor('speed_bonus')
    return ms or 50
end

function modifier_sanya_towel_aura_buff_3:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_AVOID_DAMAGE
    }
end

function modifier_sanya_towel_aura_buff_3:GetModifierAvoidDamage(params)
    if not IsServer() then return end
    local ability = self:GetAbility()
    local percent = ability:GetSpecialValueFor("miss_chance")
    if RollPercentage(percent) then
        return 1
    else return 0
    end
end
