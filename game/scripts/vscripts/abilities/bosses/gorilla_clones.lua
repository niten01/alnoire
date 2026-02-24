gorilla_clones = class {}

function gorilla_clones:ShowWarning(targetPos)
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local warningDelay = self:GetSpecialValueFor("warning_delay")
    local radius = self:GetSpecialValueFor("capture_radius")
    local numShots = self:GetSpecialValueFor("num_shots")
    local spread = self:GetSpecialValueFor("spread")
    local dir = (targetPos - casterPos):Normalized()
    local endPos = casterPos + dir * self:GetSpecialValueFor("distance")
    self.endPoints = PointsFan(casterPos, endPos, numShots, spread)

    for _, point in ipairs(self.endPoints) do
        ShowGenericLineWarning(casterPos, point, radius, warningDelay)
    end

    return warningDelay
end

function gorilla_clones:OnSpellStart()
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local distance = self:GetSpecialValueFor("distance")
    local cloneSpeed = self:GetSpecialValueFor("clone_speed")
    local radius = self:GetSpecialValueFor("capture_radius")

    assert(self.endPoints)
    self.projectiles = {}
    for _, point in ipairs(self.endPoints) do
        local dir = (point - casterPos):Normalized()
        dir.z = 0
        local p = ProjectileManager:CreateLinearProjectile({
            Ability = self,
            EffectName = "particles/gorilla_clone_trail.vpcf",
            vSpawnOrigin = casterPos,
            vVelocity = dir * cloneSpeed,
            fDistance = distance,
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
        table.insert(self.projectiles, p)
    end
end

function gorilla_clones:OnProjectileHit(target, location)
    local caster = self:GetCaster()
    local ummDuration = self:GetSpecialValueFor("umm_duration")
    local damage = self:GetSpecialValueFor("damage")

    local targetFwd = target:GetForwardVector()
    caster:SetAbsOrigin(target:GetAbsOrigin() - targetFwd * 10)

    target:AddNewModifier(caster, self, "modifier_gorilla_umm", { duration = ummDuration, damage = damage })
    caster:AddNewModifier(caster, self, "modifier_gorilla_umm", { duration = ummDuration, damage = 0 })

    for _, p in ipairs(self.projectiles) do
        ProjectileManager:DestroyLinearProjectile(p)
    end
end
