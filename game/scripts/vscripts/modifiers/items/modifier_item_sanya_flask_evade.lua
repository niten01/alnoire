modifier_item_sanya_flask_evade = class({})

function modifier_item_sanya_flask_evade:IsHidden() return false end

function modifier_item_sanya_flask_evade:IsPurgable() return true end

function modifier_item_sanya_flask_evade:IsDebuff() return false end

function modifier_item_sanya_flask_evade:GetTexture()
    return "templar_assassin_self_trap"
end

function modifier_item_sanya_flask_evade:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_EVASION_CONSTANT
    }
end

function modifier_item_sanya_flask_evade:GetModifierEvasion_Constant()
    return self.evadeBonus
end

function modifier_item_sanya_flask_evade:OnCreated()
    if not IsServer() then return end
    local abil = self:GetAbility()
    self.evadeBonus = abil:GetSpecialValueFor('evadePercent')
end
