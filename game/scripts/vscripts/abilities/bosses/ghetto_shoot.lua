ghetto_shoot = class {}

function ghetto_shoot:OnSpellStart()
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local targetPos = self:GetCursorPosition()

    local projRange = self:GetCastRange(casterPos, nil)
    local projSpeed = self:GetSpecialValueFor('proj_speed')
    local projHitbox = self:GetSpecialValueFor('proj_radius')


    local direction = (targetPos - casterPos):Normalized()
    direction.z = 0

    local projectileInfo = {
        Ability = self,
        EffectName = "particles/derek_linear_proj.vpcf",
        vSpawnOrigin = casterPos + Vector(0, 0, 35),
        fDistance = projRange,
        fStartRadius = projHitbox,
        fEndRadius = projHitbox,
        Source = caster,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        vVelocity = direction * projSpeed,
        bProvidesVision = true,
        iVisionRadius = 200,
        iVisionTeamNumber = caster:GetTeamNumber()
    }

    ProjectileManager:CreateLinearProjectile(projectileInfo)
    EmitSoundOn("ghetto.shoot", caster)
end

function ghetto_shoot:OnProjectileHit(target, location)
    if target and target:IsAlive() then
        local caster = self:GetCaster()
        local projDamage = self:GetAbilityDamage()
        local damageTable = {
            victim = target,
            attacker = caster,
            damage = projDamage,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            ability = self
        }
        ApplyDamage(damageTable)
        return true
    end
    return false
end
