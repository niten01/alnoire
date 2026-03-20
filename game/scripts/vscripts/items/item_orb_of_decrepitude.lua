item_orb_of_decrepitude = class {}
LinkLuaModifier("modifier_item_orb_of_decrepitude", "items/item_orb_of_decrepitude", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_orb_of_decrepitude_tgt", "items/item_orb_of_decrepitude", LUA_MODIFIER_MOTION_NONE)


function item_orb_of_decrepitude:GetIntrinsicModifierName()
    return "modifier_item_orb_of_decrepitude"
end

---------------------------------------------------

modifier_item_orb_of_decrepitude = class {}

function modifier_item_orb_of_decrepitude:IsHidden() return true end
function modifier_item_orb_of_decrepitude:IsPurgable() return false end

function modifier_item_orb_of_decrepitude:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_item_orb_of_decrepitude:OnAttackLanded(keys)
    if keys.attacker ~= self:GetParent() then return end
    local ability = self:GetAbility()
    keys.target:AddNewModifier(self:GetParent(), ability, "modifier_item_orb_of_decrepitude_tgt", {
        duration = ability:GetSpecialValueFor("duration"),
    })
end

-----------------------------------------------------

modifier_item_orb_of_decrepitude_tgt = class {}

function modifier_item_orb_of_decrepitude_tgt:IsHidden() return false end

function modifier_item_orb_of_decrepitude_tgt:IsDebuff() return true end

function modifier_item_orb_of_decrepitude_tgt:OnCreated(kv)
    local ability = self:GetAbility()
    if ability then
        self.attackspeedReduction = ability:GetSpecialValueFor("attack_speed_reduction")
    end
end

function modifier_item_orb_of_decrepitude_tgt:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end

function modifier_item_orb_of_decrepitude_tgt:GetModifierAttackSpeedBonus_Constant()
    return -self.attackspeedReduction
end
