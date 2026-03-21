item_keen_killer = class({})
LinkLuaModifier("modifier_keen_killer_buff", "items/item_keen_killer", LUA_MODIFIER_MOTION_NONE)


function item_keen_killer:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    caster:EmitSound("items.keen_killer.cast")
    caster:AddNewModifier(self:GetCaster(), self, "modifier_keen_killer_buff", {
        duration = self:GetSpecialValueFor("duration"),
    })
end

--------------------------------------------------------------------------------

modifier_keen_killer_buff = class({})

function modifier_keen_killer_buff:IsHidden() return false end

function modifier_keen_killer_buff:IsPurgable() return true end

function modifier_keen_killer_buff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_keen_killer_buff:OnCreated()
    self.chancePct = self:GetAbility():GetSpecialValueFor("chance_pct")
    self.critDamagePct = self:GetAbility():GetSpecialValueFor("crit_pct")
end

function modifier_keen_killer_buff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
    }
end

function modifier_keen_killer_buff:GetModifierPreAttack_CriticalStrike(params)
    if IsServer() then
        if RollPseudoRandomPercentage(self.chancePct, DOTA_PSEUDO_RANDOM_CUSTOM_GAME_1, self:GetParent()) then
            self:GetParent():EmitSound("items.keen_killer.crit")
            return self.critDamagePct
        end
    end
end

function modifier_keen_killer_buff:GetTexture()
    return "item_keen_killer"
end
