logarithmus_alt_projectile = class {}

function logarithmus_alt_projectile:Spawn()
    if not IsServer() then return end
    self:SetHidden(true)
end

function logarithmus_alt_projectile:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local zOffset = 70
    local duration = self:GetSpecialValueFor("max_duration")
    local speed = self:GetSpecialValueFor("projectile_speed")
    local projRadius = self:GetSpecialValueFor("projectile_radius")
    local radius = self:GetCastRange(casterPos, nil)
    local numProjectiles = self:GetSpecialValueFor("num_projectiles")
    local interval = 0.05
    local angularVel = speed / radius
    local angleStep = angularVel * interval

    caster:EmitSound("ability.logarithmus.alt_projectile.cast")

    local angleDiff = 2 * math.pi / numProjectiles
    for i = 1, numProjectiles, 1 do
        local elapsed = 0
        local angle = angleDiff * (i - 1)
        local pfx = ParticleManager:CreateParticle(
            "particles/logarithmus_projectile.vpcf", PATTACH_WORLDORIGIN, nil)
        local px = casterPos.x + radius * math.cos(angle)
        local py = casterPos.y + radius * math.sin(angle)
        local pos = Vector(px, py, casterPos.z + zOffset)
        ParticleManager:SetParticleControl(pfx, 0, pos)
        ParticleManager:SetParticleControl(pfx, 2, Vector(speed - 100, 0, 0))

        EmitSoundOnLocationWithCaster(pos, "ability.logarithmus.alt_projectile.cast", caster)

        local function destroyPfx(pos)
            ParticleManager:DestroyParticle(pfx, false)
            ParticleManager:ReleaseParticleIndex(pfx)

            EmitSoundOnLocationWithCaster(pos, "ability.logarithmus.alt_projectile.hit", caster)
        end

        Timers:CreateTimer(0, function()
            angle = angle + angleStep
            local casterPos = caster:GetAbsOrigin()
            local px = casterPos.x + radius * math.cos(angle)
            local py = casterPos.y + radius * math.sin(angle)
            local pos = Vector(px, py, casterPos.z + zOffset)
            ParticleManager:SetParticleControl(pfx, 1, pos)

            local enemies = FindEnemiesForSanyaInRadius(pos, projRadius)
            for _, ent in ipairs(enemies) do
                destroyPfx(pos)
                self:OnProjectileHit(ent, pos)
                return nil
            end

            elapsed = elapsed + interval
            if elapsed > duration then
                destroyPfx(pos)
                return nil
            else
                return interval
            end
        end)
    end
end

function logarithmus_alt_projectile:OnProjectileHit(target, pos)
    if not IsServer() then return end
    local caster = self:GetCaster()
    PlayLogarithmusImpaleEffect(target, pos)
    ApplyDamage({
        victim = target,
        attacker = caster,
        damage = self:GetAbilityDamage(),
        damage_type = self:GetAbilityDamageType(),
        ability = self,
    })
    IncrementLogarithmusStacks(caster)
end
