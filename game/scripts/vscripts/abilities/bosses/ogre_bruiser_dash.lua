ogre_bruiser_dash = class {}
LinkLuaModifier("modifier_ogre_bruiser_dash", "abilities/bosses/ogre_bruiser_dash.lua", LUA_MODIFIER_MOTION_NONE)

function ogre_bruiser_dash:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

function ogre_bruiser_dash:OnSpellStart()
    local caster = self:GetCaster()
    assert(caster)

    caster:AddNewModifier(caster, self, "modifier_ogre_bruiser_dash", {
        duration = self:GetSpecialValueFor("duration")
    })

    caster:EmitSound("ability.ogre_bruiser.surge")
end

-------------------------------------------------

modifier_ogre_bruiser_dash = class {}

function modifier_ogre_bruiser_dash:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
    }
end

function modifier_ogre_bruiser_dash:GetModifierMoveSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor('bonus_ms')
end

function modifier_ogre_bruiser_dash:OnCreated()
    self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_dark_seer/dark_seer_surge.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
end

function modifier_ogre_bruiser_dash:OnDestroy()
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
end
