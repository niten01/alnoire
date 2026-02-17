LinkLuaModifier("modifier_roshan_custom_passive", "abilities/jungle/roshan_custom_passive", LUA_MODIFIER_MOTION_NONE)

roshan_custom_passive = class({})

function roshan_custom_passive:GetIntrinsicModifierName()
    return "modifier_roshan_custom_passive"
end


------------------------

modifier_roshan_custom_passive = class({})

function modifier_roshan_custom_passive:IsHidden() return false end
function modifier_roshan_custom_passive:IsPurgable() return false end

function modifier_roshan_custom_passive:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
        MODIFIER_EVENT_ON_DEATH,
    }
end

function modifier_roshan_custom_passive:GetModifierPercentageCooldown()
    return 25 * self:GetStackCount()
end

function modifier_roshan_custom_passive:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(0)
end

function modifier_roshan_custom_passive:OnDeath(params)
    if not IsServer() then return end
    local unit = self:GetParent()
    local killedUnit = params.unit
    if not killedUnit or not killedUnit.packTargetData then return end

    if unit.packTargetData == killedUnit.packTargetData then
        self:IncrementStackCount()
    end
end