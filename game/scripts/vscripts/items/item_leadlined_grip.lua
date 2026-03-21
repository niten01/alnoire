item_leadlined_grip = class {}
LinkLuaModifier("modifier_leadlined_grip_buff", "items/item_leadlined_grip", LUA_MODIFIER_MOTION_NONE)

function item_leadlined_grip:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    caster:EmitSound("items.leadlined_grip.cast")
    caster:AddNewModifier(self:GetCaster(), self, "modifier_leadlined_grip_buff", {
        duration = self:GetSpecialValueFor("duration"),
    })
end

------------------------------------------------------------------

modifier_leadlined_grip_buff = class {}

function modifier_leadlined_grip_buff:IsHidden() return false end

function modifier_leadlined_grip_buff:IsPurgable() return false end

function modifier_leadlined_grip_buff:OnCreated(kv)
    local ability = self:GetAbility()
    if ability then
        self.asReduction = ability:GetSpecialValueFor("attack_speed_reduction")
        self.bonusDamage = ability:GetSpecialValueFor("bonus_damage")
    end
end

function modifier_leadlined_grip_buff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_EVENT_ON_ATTACK_LANDED,
    }
end

function modifier_leadlined_grip_buff:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end

    params.target:EmitSound("items.leadlined_grip.hit")

    local pfx = ParticleManager:CreateParticle("particles/custom_items/leadlined_grip_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW,
        params.target)
    ParticleManager:ReleaseParticleIndex(pfx)

    self:Destroy()
end

function modifier_leadlined_grip_buff:GetModifierBaseAttack_BonusDamage()
    return self.bonusDamage
end

function modifier_leadlined_grip_buff:GetModifierAttackSpeedBonus_Constant()
    return -self.asReduction
end

function modifier_leadlined_grip_buff:GetTexture()
    return "item_leadlined_grip"
end
