item_orb_of_deceleration = class {}
LinkLuaModifier("modifier_item_orb_of_deceleration", "items/item_orb_of_deceleration", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_orb_of_deceleration_tgt", "items/item_orb_of_deceleration", LUA_MODIFIER_MOTION_NONE)


function item_orb_of_deceleration:GetIntrinsicModifierName()
    return "modifier_item_orb_of_deceleration"
end

---------------------------------------------------

modifier_item_orb_of_deceleration = class {}

function modifier_item_orb_of_deceleration:IsHidden() return true end
function modifier_item_orb_of_deceleration:IsPurgable() return false end

function modifier_item_orb_of_deceleration:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_item_orb_of_deceleration:OnAttackLanded(keys)
    if keys.attacker ~= self:GetParent() then return end
    local ability = self:GetAbility()
    keys.target:AddNewModifier(self:GetParent(), ability, "modifier_item_orb_of_deceleration_tgt", {
        duration = ability:GetSpecialValueFor("duration"),
    })
end

-----------------------------------------------------

modifier_item_orb_of_deceleration_tgt = class {}

function modifier_item_orb_of_deceleration_tgt:IsHidden() return false end

function modifier_item_orb_of_deceleration_tgt:IsDebuff() return true end

function modifier_item_orb_of_deceleration_tgt:OnCreated(kv)
    local ability = self:GetAbility()
    if ability then
        self.msReduction = ability:GetSpecialValueFor("ms_reduction")
    end
end

function modifier_item_orb_of_deceleration_tgt:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
end

function modifier_item_orb_of_deceleration_tgt:GetModifierMoveSpeedBonus_Constant()
    return -self.msReduction
end
