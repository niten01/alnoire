modifier_item_sanya_flask_evade = class({})

function modifier_item_sanya_flask_evade:IsHidden() return false end

function modifier_item_sanya_flask_evade:IsPurgable() return true end

function modifier_item_sanya_flask_evade:IsDebuff() return false end

function modifier_item_sanya_flask_evade:GetTexture()
    return "templar_assassin_self_trap"
end

function modifier_item_sanya_flask_evade:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
    }
end

function modifier_item_sanya_flask_evade:GetModifierIncomingDamage_Percentage()
    if not IsServer() then return end
    local parent = self:GetParent()
    if RollPercentage(self.evadeChancePct) then
        SendOverheadEventMessage(
            nil,
            OVERHEAD_ALERT_EVADE,
            parent,
            0,
            nil
        )
        return -100
    else
        return 0
    end
end

function modifier_item_sanya_flask_evade:OnCreated()
    if not IsServer() then return end
    local abil = self:GetAbility()
    self.evadeChancePct = abil:GetSpecialValueFor('evadePercent')
end
