rapper_strife = class {}
LinkLuaModifier("modifier_rapper_strife", "abilities/rapper_strife.lua", LUA_MODIFIER_MOTION_NONE)

function rapper_strife:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local flow = caster:FindModifierByName("modifier_rapper_flow")
    assert(flow)


    caster:AddNewModifier(caster, self, "modifier_rapper_strife", {
        duration = flow:GetStackCount() * self:GetSpecialValueFor("duration_per_stack"),
        attackSpeedBonus = self:GetSpecialValueFor("attack_speed_bonus")
    })
end

------------------------------------------------------------------

modifier_rapper_strife = class {}

function modifier_rapper_strife:IsHidden() return false end

function modifier_rapper_strife:IsDebuff() return false end

function modifier_rapper_strife:IsPurgable() return false end

function modifier_rapper_strife:OnCreated(kv)
    if not IsServer() then return end

    self.attackSpeedBonus = kv.attackSpeedBonus
    self:StartIntervalThink(0.01)
end

function modifier_rapper_strife:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,

        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
end

function modifier_rapper_strife:GetModifierAttackSpeedBonus_Constant()
    return self.attackSpeedBonus
end

function modifier_rapper_strife:GetActivityTranslationModifiers()
    return "focusfire"
end

function modifier_rapper_strife:OnTakeDamage(params)
    if not IsServer() then return end
    DebugPrint(params.damage_category)
end

function modifier_rapper_strife:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    local enemies = FindEnemiesForSanyaInRadius(parent:GetAbsOrigin(), parent:Script_GetAttackRange())
    local target = enemies[1]
    if not target then return end

    parent:PerformAttack(target, true, true, false, false, true, false, false)
end
