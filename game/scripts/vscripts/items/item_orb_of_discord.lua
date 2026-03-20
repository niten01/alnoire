item_orb_of_discord = class {}
LinkLuaModifier("modifier_item_orb_of_discord", "items/item_orb_of_discord", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_orb_of_discord_tgt", "items/item_orb_of_discord", LUA_MODIFIER_MOTION_NONE)


function item_orb_of_discord:GetIntrinsicModifierName()
    return "modifier_item_orb_of_discord"
end

---------------------------------------------------

modifier_item_orb_of_discord = class {}

function modifier_item_orb_of_discord:IsHidden() return true end
function modifier_item_orb_of_discord:IsPurgable() return false end

function modifier_item_orb_of_discord:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_item_orb_of_discord:OnAttackLanded(keys)
    if keys.attacker ~= self:GetParent() then return end
    local ability = self:GetAbility()
    keys.target:AddNewModifier(self:GetParent(), ability, "modifier_item_orb_of_discord_tgt", {
        duration = ability:GetSpecialValueFor("duration"),
    })
end

-----------------------------------------------------

modifier_item_orb_of_discord_tgt = class {}

function modifier_item_orb_of_discord_tgt:IsHidden() return false end

function modifier_item_orb_of_discord_tgt:IsDebuff() return true end

function modifier_item_orb_of_discord_tgt:OnCreated(kv)
    local ability = self:GetAbility()
    if ability then
        self.magresReduction = ability:GetSpecialValueFor("mag_res_reduction")
    end
end

function modifier_item_orb_of_discord_tgt:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
end

function modifier_item_orb_of_discord_tgt:GetModifierMagicalResistanceBonus()
    return -self.magresReduction
end
