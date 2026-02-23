LinkLuaModifier('modifier_bear_shield', 'abilities/jungle/bear_shield', LUA_MODIFIER_MOTION_NONE)

bear_shield = class({})

function bear_shield:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    local duration = self:GetSpecialValueFor("duration") or 3.0

    target:AddNewModifier(caster, self, "modifier_bear_shield", { duration = duration })
    target:EmitSound("Item.LotusOrb.Target")
end

function bear_shield:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function bear_shield:GetCooldown()
    return self:GetSpecialValueFor('cooldown') or 3.5
end

function bear_shield:GetCastRange()
    return self:GetSpecialValueFor('castRange') or 1000
end

function bear_shield:GetCooldown()
    return self:GetSpecialValueFor('cooldown') or 3.5
end

function bear_shield:GetCastAnimation()
    return ACT_DOTA_CAST_ABILITY_1
end

---------------------------

modifier_bear_shield = class({})
function modifier_bear_shield:IsHidden() return false end

function modifier_bear_shield:IsPurgable() return false end

function modifier_bear_shield:IsDebuff() return false end

function modifier_bear_shield:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
end

function modifier_bear_shield:GetModifierIncomingDamage_Percentage()
    local abil = self:GetAbility()
    local dmredPercent = abil:GetSpecialValueFor('blockPercent') or 90
    return -dmredPercent
end

function modifier_bear_shield:OnCreated()
    if not IsServer() then return end
    local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_ice_age.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    local pfx2 = ParticleManager:CreateParticle("particles/neutral_fx/ogre_magi_frost_armor.vpcf",
        PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(pfx, 1, self:GetParent(), PATTACH_POINT_FOLLOW, 'attach_origin',
        self:GetCaster():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(pfx, 2, Vector(0, 0, 0))
    self:AddParticle(pfx, false, false, -1, false, false)
    self:AddParticle(pfx2, false, false, -1, false, false)
end
