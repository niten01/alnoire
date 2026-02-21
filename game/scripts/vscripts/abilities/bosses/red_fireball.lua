red_fireball = class {}

function red_fireball:GetStartPos()
    local caster = self:GetCaster()
    local attIdx = caster:ScriptLookupAttachment("attach_attack1")
    local startPos = caster:GetAttachmentOrigin(attIdx)
    return startPos
end

function red_fireball:ShowWarning(targetPos)
    local delay = 0.1
    local range = self:GetSpecialValueFor("range")
    local radius = self:GetSpecialValueFor("projectile_radius")

    local start = self:GetStartPos()
    local dir = (targetPos - start):Normalized()
    self.target = start + dir*range
    ShowGenericLineWarning(start, self.target, radius, delay)
    return delay
end

function red_fireball:OnSpellStart()
    local caster = self:GetCaster()
    assert(caster)
    local range = self:GetSpecialValueFor("range")
    local radius = self:GetSpecialValueFor("projectile_radius")
    local speed = self:GetSpecialValueFor("speed")

    -- local point = self:GetCursorPosition()
    assert(self.target)
    local startPos = self:GetStartPos()
    local dir = (self.target - startPos):Normalized()
    dir.z = 0
    ProjectileManager:CreateLinearProjectile({
        Ability = self,
        EffectName = "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf",
        vSpawnOrigin = startPos,
        vVelocity = dir * speed,
        fDistance = range,
        fStartRadius = radius,
        fEndRadius = radius,
        Source = caster,
        bHasFrontalCone = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        bProvidesVision = true,
        iVisionRadius = 500,
        iVisionTeamNumber = caster:GetTeamNumber()
    })

    caster:EmitSound("ability.red.fireball.cast")
end

function red_fireball:OnProjectileThink(location)
    -- ParticleManager:SetParticleControl(self.pfx, 1, location)
end

function red_fireball:OnProjectileHit(target, location)
    -- ParticleManager:DestroyParticle(self.pfx, false)
    -- ParticleManager:ReleaseParticleIndex(self.pfx)

    local damage = self:GetSpecialValueFor("damage")
    if target then
        ApplyDamage({
            victim = target,
            attacker = self:GetCaster(),
            damage = damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self
        })
        return false
    end
end
