modifier_lean_power_towel_master = class {}

function modifier_lean_power_towel_master:IsHidden() return false end

function modifier_lean_power_towel_master:IsPurgable() return false end

function modifier_lean_power_towel_master:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_lean_power_towel_master:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST
    }
end

function modifier_lean_power_towel_master:TryApplyToSummon()
    local summon = Entities:FindByModel(nil, "models/towel_summon/sanya_towel_summon.vmdl")
    if not summon then
        DebugPrint("no summon")
        return false
    end
    if summon:HasModifier("modifier_lean_power_towel_summon") then return true end
    summon:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_lean_power_towel_summon", {
        duration = -1,
        chancePct = self.chancePct,
        damage = self.damage,
        radius = self.radius,
    })
    return true
end

function modifier_lean_power_towel_master:OnAbilityFullyCast(event)
    if not IsServer() then return end
    if event.unit ~= self:GetParent() or event.ability:GetAbilityName() ~= "sanya_towel_summon" then return end
    Timers:CreateTimer(0.2, function()
        if not self:TryApplyToSummon() then
            return 0.2
        end
        return nil
    end)
end

function modifier_lean_power_towel_master:OnCreated()
    if not IsServer() then return end
    self.chancePct = self:GetAbility():GetSpecialValueFor("chance_pct")
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self:TryApplyToSummon()
end

function modifier_lean_power_towel_master:OnDestroy()
    if not IsServer() then return end
end

function modifier_lean_power_towel_master:GetTexture()
    return "item_percocet_xavier"
end
