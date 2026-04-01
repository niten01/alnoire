LinkLuaModifier("modifier_towel_summon_delayed_explode", "modifiers/abilities/modifier_towel_summon_delayed_explode",
    LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_towel_summon_explosion_attack_reduce_cooldown",
    "abilities/towel_summon_explosion",
    LUA_MODIFIER_MOTION_NONE)
towel_summon_explosion = class({})

function towel_summon_explosion:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    if caster:HasModifier("modifier_towel_summon_delayed_explode") then return end
    caster:AddNewModifier(caster, self, 'modifier_towel_summon_delayed_explode',
        { duration = self:GetSpecialValueFor('delay') })
end

function towel_summon_explosion:GetCastRange()
    return self:GetSpecialValueFor('radius') or 400
end

function towel_summon_explosion:GetIntrinsicModifierName()
    return "modifier_towel_summon_explosion_attack_reduce_cooldown"
end

modifier_towel_summon_explosion_attack_reduce_cooldown = class({})
function modifier_towel_summon_explosion_attack_reduce_cooldown:IsHidden()
    return true
end

function modifier_towel_summon_explosion_attack_reduce_cooldown:IsPurgable()
    return false
end

function modifier_towel_summon_explosion_attack_reduce_cooldown:RemoveOnDeath()
    return false
end

function modifier_towel_summon_explosion_attack_reduce_cooldown:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_towel_summon_explosion_attack_reduce_cooldown:OnAttackLanded(params)
    if not IsServer() then return end

    local parent = self:GetParent()
    local ability = self:GetAbility()

    if params.attacker ~= parent then return end
    if not ability:IsCooldownReady() then
        local current_cooldown = ability:GetCooldownTimeRemaining()
        local reduction = ability:GetSpecialValueFor('cooldownReductionPerAttack')
        local new_cooldown = math.max(0, current_cooldown - reduction)

        ability:EndCooldown()
        if new_cooldown > 0 then
            ability:StartCooldown(new_cooldown)
        end
    end
end
