ogre_bruiser_fast_hit = class {}

function ogre_bruiser_fast_hit:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
end

function ogre_bruiser_fast_hit:OnAbilityPhaseStart()
    local caster = self:GetCaster()
    assert(caster)
    caster:EmitSound("ability.ogre_bruiser.swing")
end

function ogre_bruiser_fast_hit:OnSpellStart()
    local caster = self:GetCaster()
    assert(caster)
    local casterPos = caster:GetAbsOrigin()
    local radius = self:GetSpecialValueFor("radius")
    local damage = self:GetSpecialValueFor("damage")

    local attIdx = caster:ScriptLookupAttachment("attach_weapon")
    local pos = caster:GetAttachmentOrigin(attIdx)

    caster:EmitSound("ability.ogre_bruiser.impact")

    local pfx = ParticleManager:CreateParticle("particles/neutral_fx/ogre_bruiser_smash.vpcf", PATTACH_POINT, caster)
    ParticleManager:SetParticleControl(pfx, 0, pos)
    ParticleManager:ReleaseParticleIndex(pfx)

    local enemies = FindAIEnemies(pos, radius)
    for _, ent in ipairs(enemies) do
        ApplyDamage({
            victim = ent,
            attacker = caster,
            damage = damage,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            ability = self,
        })
    end

    ScreenShake(casterPos, 10, 0.3, 0.5, 3000, 0, true)
end
