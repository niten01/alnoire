LinkLuaModifier("modifier_gnoll_slow_passive", "abilities/jungle/gnoll_slow_passive", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_gnoll_slow_debuff", "abilities/jungle/gnoll_slow_passive", LUA_MODIFIER_MOTION_NONE)



gnoll_slow_passive = class({})


function gnoll_slow_passive:GetIntrinsicModifierName()
    return "modifier_gnoll_slow_passive"
end

------------------------
modifier_gnoll_slow_passive = class({})

function modifier_gnoll_slow_passive:IsHidden() return true end

function modifier_gnoll_slow_passive:IsPurgable() return true end

function modifier_gnoll_slow_passive:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_gnoll_slow_passive:OnAttackLanded(params)
    if not IsServer() then return end
    local unit = self:GetParent()
    local attacker = params.attacker
    if attacker == unit then
        local target = params.target
        local abil = self:GetAbility()
        local duration = abil:GetSpecialValueFor('debuffDuration')
        target:AddNewModifier(unit, self:GetAbility(), 'modifier_gnoll_slow_debuff', { duration = duration })
    end
end

---------------------------------
modifier_gnoll_slow_debuff = class({})

function modifier_gnoll_slow_debuff:IsHidden() return false end

function modifier_gnoll_slow_debuff:IsDebuff() return true end

function modifier_gnoll_slow_debuff:IsPurgable() return true end

function modifier_gnoll_slow_debuff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_TURN_RATE_OVERRIDE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
    }
end

function modifier_gnoll_slow_debuff:GetModifierMoveSpeedBonus_Constant()
    local ability = self:GetAbility()
    local slowAmount = ability:GetSpecialValueFor('slowDebuff') or 70
    return -slowAmount
end

function modifier_gnoll_slow_debuff:GetModifierTurnRate_Override()
    local ability = self:GetAbility()
    local turnRateDebuffPercent = ability:GetSpecialValueFor('turnRateDebuffPercent') or 40.0
    return turnRateDebuffPercent
end
