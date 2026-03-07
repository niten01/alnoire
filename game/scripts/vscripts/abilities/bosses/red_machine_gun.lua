red_machine_gun = class {}

function red_machine_gun:GetStartPos()
    local caster = self:GetCaster()
    local attIdx = caster:ScriptLookupAttachment("attach_attack1")
    local startPos = caster:GetAttachmentOrigin(attIdx)
    return startPos
end

function red_machine_gun:ShowWarning(targetPos)
    local delayPerShot = self:GetSpecialValueFor("delay_per_shot")
    local numShots = self:GetSpecialValueFor("num_shots")
    local alpha = self:GetSpecialValueFor("spread_angle")
    local range = self:GetSpecialValueFor("range")
    local radius = self:GetSpecialValueFor("projectile_radius")

    local startPos = self:GetStartPos()
    local dir = (targetPos - startPos):Normalized()
    local endPos = startPos + dir * range

    self.endPoints = PointsFan(startPos, endPos, numShots, alpha)
    local cumDelay = 0
    for _, point in ipairs(self.endPoints) do
        Timers:CreateTimer(cumDelay, function()
            ShowGenericLineWarning(startPos, point, radius, delayPerShot)
        end)
        cumDelay = cumDelay + delayPerShot
    end
    return cumDelay
end

function red_machine_gun:OnSpellStart()
    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor("projectile_radius")
    local speed = self:GetSpecialValueFor("speed")
    local delayPerShot = self:GetSpecialValueFor("delay_per_shot")

    assert(self.endPoints)
    local cumDelay = 0
    for _, point in ipairs(self.endPoints) do
        Timers:CreateTimer(cumDelay, function()
            local startPos = self:GetStartPos()
            local dir = (point - startPos):Normalized()
            dir.z = 0
            ProjectileManager:CreateLinearProjectile({
                Ability = self,
                EffectName = "particles/econ/items/lina/lina_head_headflame/lina_spell_dragon_slave_headflame.vpcf",
                vSpawnOrigin = startPos,
                vVelocity = dir * speed,
                fDistance = #(point - startPos),
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
            EmitSoundOnLocationWithCaster(startPos, "ability.red.machine_gun.shoot", caster)
        end)
        cumDelay = cumDelay + delayPerShot
    end
end

function red_machine_gun:OnProjectileThink(location)
    -- ParticleManager:SetParticleControl(self.pfx, 1, location)
end

function red_machine_gun:OnProjectileHit(target, location)
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
