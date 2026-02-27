rapper_flow = class {}
LinkLuaModifier("modifier_rapper_flow", "abilities/rapper_flow.lua", LUA_MODIFIER_MOTION_NONE)

function rapper_flow:Spawn()
    if not IsServer() then return end
    self:SetLevel(1)
    local pid = self:GetCaster():GetPlayerOwnerID()
    PlayerTables:CreateTable("flow_bar_" .. tostring(pid), {
        stackCount = 0,
        maxStacks = self:GetSpecialValueFor("max_stacks")
    }, { pid })
end

function rapper_flow:GetIntrinsicModifierName()
    return "modifier_rapper_flow"
end

------------------------------------------------------------

modifier_rapper_flow = class {}

function modifier_rapper_flow:IsHidden() return false end

function modifier_rapper_flow:IsPurgable() return false end

function modifier_rapper_flow:OnCreated()
    if not IsServer() then return end

    self:SetHasCustomTransmitterData(true)

    self.damagePctPerStack = self:GetAbility():GetSpecialValueFor("damage_pct_per_stack")
    self.maxStacks = self:GetAbility():GetSpecialValueFor("max_stacks")
    self.bonusDamage = 0
end

modifier_rapper_flow.OnRefresh = modifier_rapper_flow.OnCreated

function modifier_rapper_flow:AddCustomTransmitterData()
    return {
        stackCount = self:GetStackCount(),
        maxStacks = self.maxStacks,
        damagePctPerStack = self.damagePctPerStack,
        bonusDamage = self.bonusDamage,
    }
end

function modifier_rapper_flow:HandleCustomTransmitterData(data)
    self:SetStackCount(data.stackCount)
    self.maxStacks = data.maxStacks
    self.damagePctPerStack = data.damagePctPerStack
    self.bonusDamage = data.bonusDamage
end

function modifier_rapper_flow:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_TOOLTIP,
        MODIFIER_EVENT_ON_ATTACK_LANDED,
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_rapper_flow:OnStackCountChanged()
    if not IsServer() then return end
    local pid = self:GetParent():GetPlayerOwnerID()
    PlayerTables:SetTableValue("flow_bar_" .. tostring(pid), "stackCount", self:GetStackCount())
    self.bonusDamage = self.damagePctPerStack * self:GetStackCount()
    self:SendBuffRefreshToClients()
end

function modifier_rapper_flow:OnAttackLanded(params)
    if params.attacker ~= self:GetParent() then return end
    if self:GetStackCount() >= self.maxStacks then return end

    self:IncrementStackCount()
end

function modifier_rapper_flow:GetModifierDamageOutgoing_Percentage()
    return self.bonusDamage
end

function modifier_rapper_flow:OnTooltip()
    return self:GetModifierDamageOutgoing_Percentage()
end
