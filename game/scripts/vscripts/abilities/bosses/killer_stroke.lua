killer_stroke = class {}

function killer_stroke:OnAbilityPhaseStart()
    if not IsServer() then return end
    self:GetCaster():EmitSound("ability.killer.stroke.precast")
end

function killer_stroke:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local targetPos = self:GetCursorPosition()
    local length = self:GetSpecialValueFor("length")
    local speed = self:GetSpecialValueFor("speed")
    local startRadius = self:GetSpecialValueFor("start_radius")
    local endRadius = self:GetSpecialValueFor("end_radius")
    local dir = (targetPos - casterPos):Normalized()

    caster:EmitSound("ability.killer.stroke.cast")
    caster:EmitSound("ability.killer.stroke.layer")
    caster:EmitSound("ability.killer.stroke.projectile")
    ProjectileManager:CreateLinearProjectile({
        Ability = self,
        EffectName = "particles/units/heroes/hero_grimstroke/grimstroke_darkartistry_proj.vpcf",
        vSpawnOrigin = casterPos,
        vVelocity = dir * speed,
        fDistance = length,
        fStartRadius = startRadius,
        fEndRadius = endRadius,
        Source = caster,
        bHasFrontalCone = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        bProvidesVision = true,
        iVisionRadius = 500,
        iVisionTeamNumber = caster:GetTeamNumber()
    })

    self:StartCooldown(AbilityRandomValueFloat(self, "cd"))
end

function killer_stroke:OnProjectileHit(target, location)
    if not IsServer() then return end
    if not target then return end

    local caster = self:GetCaster()
    local damage = self:GetSpecialValueFor("damage")

    caster:EmitSound("ability.killer.stroke.damage")

    ApplyDamage({
        victim = target,
        attacker = caster,
        damage = damage,
        damage_type = self:GetAbilityDamageType(),
        ability = self,
    })
end
