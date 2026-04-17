modifier_item_sanya_flask_ms = class({})

function modifier_item_sanya_flask_ms:IsHidden() return false end

function modifier_item_sanya_flask_ms:IsPurgable() return true end

function modifier_item_sanya_flask_ms:IsDebuff() return false end

function modifier_item_sanya_flask_ms:GetTexture()
    return "windrunner_windrun_sylvan"
end

function modifier_item_sanya_flask_ms:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
end

function modifier_item_sanya_flask_ms:GetModifierMoveSpeedBonus_Constant()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("msBuff")
    end
end
