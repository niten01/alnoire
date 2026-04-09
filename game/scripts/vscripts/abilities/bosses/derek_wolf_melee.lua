derek_wolf_melee = class {}

function derek_wolf_melee:Spawn()
    if not IsServer() then return end
    self.actParticleName = {
        [ACT_DOTA_ATTACK] = "particles/derek_wolf_attack1.vpcf",
        [ACT_DOTA_ATTACK2] = "particles/derek_wolf_attack2.vpcf",
    }
end

function derek_wolf_melee:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local radius = self:GetSpecialValueFor("radius")
    -- ShowGenericCircleWarning(casterPos, radius, self:GetCastPoint() + self:GetSpecialValueFor("anim_attack_point"))
end

function derek_wolf_melee:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    caster.derekCasting = true

    local radius = self:GetSpecialValueFor("radius")
    local damage = self:GetSpecialValueFor("damage")
    local spread = self:GetSpecialValueFor("spread")
    local animAttackPoint = self:GetSpecialValueFor("anim_attack_point")

    local act, particleName = GetRandomTableKV(self.actParticleName)
    caster:StartGesture(act)
    Timers:CreateTimer(animAttackPoint, function()
        caster.derekCasting = false

        local pfx = ParticleManager:CreateParticle(particleName, PATTACH_ABSORIGIN, caster)
        ParticleManager:ReleaseParticleIndex(pfx)

        caster:EmitSound("ability.derek.swing")

        local casterPos = caster:GetAbsOrigin()
        local enemies = FindEnemiesInSegment(DOTA_TEAM_BADGUYS, casterPos+ caster:GetForwardVector()*100, caster:GetForwardVector() * radius, spread)
        for _, ent in ipairs(enemies) do
            ApplyDamage({
                victim = ent,
                attacker = caster,
                damage = damage,
                damage_type = self:GetAbilityDamageType(),
                ability = self,
            })

            PlayDerekBloodEffects(ent, -caster:GetForwardVector())
        end
    end)
end
