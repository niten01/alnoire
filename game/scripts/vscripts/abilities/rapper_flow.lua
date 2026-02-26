rapper_flow = class {}
LinkLuaModifier("modifier_rapper_flow", "abilities/rapper_flow.lua", LUA_MODIFIER_MOTION_NONE)

function rapper_flow:Spawn()
    if not IsServer() then return end
    self:SetLevel(1)
end

function rapper_flow:GetIntrinsicModifierName()
    return "modifier_rapper_flow"
end

------------------------------------------------------------

modifier_rapper_flow = class {}

function modifier_rapper_flow:IsHidden() return false end

function modifier_rapper_flow:IsPurgable() return false end

function modifier_rapper_flow:OnCreated()
    self:SetStackCount(0)
end

function modifier_rapper_flow:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_rapper_flow:OnAttack()
    DebugPrint("saldkfja")
    self:IncrementStackCount()
end

function modifier_rapper_flow:GetModifierDamageOutgoing_Percentage()
    self:GetStackCount()
end
