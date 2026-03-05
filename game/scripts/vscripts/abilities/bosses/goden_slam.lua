goden_slam = class {}

function goden_slam:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    caster:EmitSound("ability.goden.slam.cast.roar")
end

function goden_slam:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local damage = self:GetSpecialValueFor("damage")
    local radius = self:GetCastRange(casterPos, nil)

    local pfx = ParticleManager:CreateParticle(
        "particles/goden_slam.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControl(pfx, 1, Vector(60, 0, 0))
    ParticleManager:ReleaseParticleIndex(pfx)

    caster:EmitSound("ability.goden.slam.cast")

    DrawDebugCircle(casterPos, radius, 3)
    local enemies = FindEnemiesForAIInRadius(casterPos, radius)
    for _, ent in ipairs(enemies) do
        ApplyDamage({
            victim = ent,
            attacker = caster,
            damage = damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self
        })
    end
end
