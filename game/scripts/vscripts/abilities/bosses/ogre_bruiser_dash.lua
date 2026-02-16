ogre_bruiser_dash = class {}
LinkLuaModifier("modifier_ogre_bruiser_dash", "abilities/bosses/ogre_bruiser_dash.lua", LUA_MODIFIER_MOTION_NONE)

function ogre_bruiser_dash:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function ogre_bruiser_dash:OnSpellStart()
    local caster = self:GetCaster()
    assert(caster)

    caster:AddNewModifier(nil, nil, "modifier_ogre_bruiser_dash", {
      duration = self:GetSpecialValueFor("duration")
    })
    -- local pfx = ParticleManager:CreateParticle("particles/neutral_fx/ogre_bruiser_smash.vpcf", PATTACH_POINT, caster)
    -- ParticleManager:SetParticleControl(pfx, 0, pos)
    -- ParticleManager:ReleaseParticleIndex(pfx)

end

-------------------------------------------------

modifier_ogre_bruiser_dash = class {}

function modifier_custom_sprint:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
    }
end

function modifier_ogre_bruiser_dash:GetModifierMoveSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor('bonus_ms')
end

