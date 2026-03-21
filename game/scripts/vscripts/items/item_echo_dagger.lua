item_echo_dagger = class {}
LinkLuaModifier("modifier_echo_dagger_owner", "items/item_echo_dagger", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_echo_dagger_second_hit", "items/item_echo_dagger", LUA_MODIFIER_MOTION_NONE)

function item_echo_dagger:GetIntrinsicModifierName()
    return "modifier_echo_dagger_owner"
end

----------------------------------------------------------------------

modifier_echo_dagger_owner = class {}

function modifier_echo_dagger_owner:IsHidden() return true end

function modifier_echo_dagger_owner:IsPurgable() return false end

function modifier_echo_dagger_owner:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_echo_dagger_owner:OnAttackLanded(params)
    if not IsServer() then return end

    local parent = self:GetParent()
    local ability = self:GetAbility()
    local target = params.target

    if params.attacker == parent and not parent:IsIllusion() then
        if ability:IsCooldownReady() and target:IsAlive() then
            ability:StartCooldown(ability:GetCooldown(ability:GetLevel()))

            parent:AddNewModifier(parent, ability, "modifier_echo_dagger_second_hit", { duration = -1 })
        end
    end
end

-----------------------------------------------------------------------

modifier_echo_dagger_second_hit = class {}

function modifier_echo_dagger_second_hit:IsHidden() return false end

function modifier_echo_dagger_second_hit:IsPurgable() return false end

function modifier_echo_dagger_second_hit:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_ATTACKSPEED_ABSOLUTE_MAX,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_echo_dagger_second_hit:OnCreated()
    local ability = self:GetAbility()
    if ability then
        self.damagePct = ability:GetSpecialValueFor("damage_reduction_pct")
    end
end

function modifier_echo_dagger_second_hit:GetModifierAttackSpeedAbsoluteMax()
    return MAXIMUM_ATTACK_SPEED
end

function modifier_echo_dagger_second_hit:GetModifierAttackSpeedBonus_Constant()
    return 1000
end

function modifier_echo_dagger_second_hit:GetModifierBaseAttackTimePercentage()
    return 0
end

function modifier_echo_dagger_second_hit:GetModifierBaseDamageOutgoing_Percentage()
    return -self.damagePct
end

function modifier_echo_dagger_second_hit:OnAttackLanded(params)
    if not IsServer() then return end
    local parent = self:GetParent()
    if params.attacker ~= parent then return end

    params.attacker:EmitSound("items.echo_dagger.layer")

    self:Destroy()
end

function modifier_echo_dagger_second_hit:GetTexture()
    return "item_echo_dagger"
end
