LinkLuaModifier('modifier_tusik_papa_spellAmp', "abilities/ocean/tusik_papa_passive", LUA_MODIFIER_MOTION_NONE)
tusik_papa_passive = class({})

function tusik_papa_passive:GetIntrinsicModifierName()
    return "modifier_tusik_papa_spellAmp"
end

------------------

modifier_tusik_papa_spellAmp = class({})

function modifier_tusik_papa_spellAmp:IsHidden()
    return false
end

function modifier_tusik_papa_spellAmp:IsPurgable()
    return false
end

function modifier_tusik_papa_spellAmp:IsDebuff()
    return false
end

function modifier_tusik_papa_spellAmp:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
    local abil = self:GetAbility()
    self.abilAmp = abil:GetSpecialValueFor('BaseAttackDamageAmpPerStack') or 10
    self:StartIntervalThink(1.0)
end

function modifier_tusik_papa_spellAmp:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE
    }
end

function modifier_tusik_papa_spellAmp:GetModifierBaseAttack_BonusDamage()
    if self.abilAmp then
        return (self:GetStackCount() * self.abilAmp) or 0
    end
    return 0
end
