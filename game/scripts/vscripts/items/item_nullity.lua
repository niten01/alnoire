item_nullity = class {}
LinkLuaModifier("modifier_item_nullity", "items/item_nullity", LUA_MODIFIER_MOTION_NONE)


function item_nullity:GetIntrinsicModifierName()
    return "modifier_item_nullity"
end

---------------------------------------------------

modifier_item_nullity = class {}

function modifier_item_nullity:IsHidden() return true end

function modifier_item_nullity:IsPurgable() return false end

function modifier_item_nullity:OnCreated()
    local ability = self:GetAbility()
    if ability then
        self.evadeChancePct = ability:GetSpecialValueFor("evasion_chance_pct")
    end
end

function modifier_item_nullity:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
    }
end

function modifier_item_nullity:GetModifierIncomingDamage_Percentage()
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
