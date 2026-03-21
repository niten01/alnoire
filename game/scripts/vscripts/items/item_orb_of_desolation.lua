item_orb_of_desolation = class {}
LinkLuaModifier("modifier_item_orb_of_desolation", "items/item_orb_of_desolation", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_orb_of_desolation_tgt", "items/item_orb_of_desolation", LUA_MODIFIER_MOTION_NONE)


function item_orb_of_desolation:GetIntrinsicModifierName()
    return "modifier_item_orb_of_desolation"
end

---------------------------------------------------

modifier_item_orb_of_desolation = class {}

function modifier_item_orb_of_desolation:IsHidden() return true end
function modifier_item_orb_of_desolation:IsPurgable() return false end

function modifier_item_orb_of_desolation:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_item_orb_of_desolation:OnAttackLanded(keys)
    if keys.attacker ~= self:GetParent() then return end
    local ability = self:GetAbility()
    keys.target:AddNewModifier(self:GetParent(), ability, "modifier_item_orb_of_desolation_tgt", {
        duration = ability:GetSpecialValueFor("duration"),
    })
end

-----------------------------------------------------

modifier_item_orb_of_desolation_tgt = class {}

function modifier_item_orb_of_desolation_tgt:IsHidden() return false end

function modifier_item_orb_of_desolation_tgt:IsDebuff() return true end

function modifier_item_orb_of_desolation_tgt:OnCreated(kv)
    local ability = self:GetAbility()
    if ability then
        self.armorReduction = ability:GetSpecialValueFor("armor_reduction")
    end
end

function modifier_item_orb_of_desolation_tgt:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end

function modifier_item_orb_of_desolation_tgt:GetModifierPhysicalArmorBonus()
    return -self.armorReduction
end

function modifier_item_orb_of_desolation_tgt:GetTexture()
    return "item_orb_of_desolation" 
end