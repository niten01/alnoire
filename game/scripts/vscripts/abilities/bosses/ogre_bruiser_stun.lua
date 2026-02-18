ogre_bruiser_stun = class {}

function ogre_bruiser_stun:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
end

function ogre_bruiser_stun:OnAbilityPhaseStart()
    local caster = self:GetCaster()
    assert(caster)
    caster:EmitSound("ability.ogre_bruiser.roar")
end

function ogre_bruiser_stun:OnSpellStart()
    local caster = self:GetCaster()
    assert(caster)
    local casterPos = caster:GetAbsOrigin()
    local radius = self:GetSpecialValueFor("radius")
    local damage = self:GetSpecialValueFor("damage")
    local stunDuration = self:GetSpecialValueFor("duration")

    caster:EmitSound("ability.ogre_bruiser.slam")

    local pfx = ParticleManager:CreateParticle("particles/econ/items/earthshaker/deep_magma/deep_magma_10th/deep_magma_10th_echoslam_start.vpcf", PATTACH_POINT, caster)
    ParticleManager:SetParticleControl(pfx, 0, casterPos)
    ParticleManager:ReleaseParticleIndex(pfx)

    local enemies = FindEnemiesForAIInRadius(casterPos, radius)
    for _, ent in ipairs(enemies) do
        ApplyDamage({
            victim = ent,
            attacker = caster,
            damage = damage,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            ability = self,
        })
        ent:AddNewModifier(caster, self, "modifier_stunned", { duration = stunDuration })
    end

    ScreenShake(casterPos, 10, 0.3, 0.5, 3000, 0, true)
end
