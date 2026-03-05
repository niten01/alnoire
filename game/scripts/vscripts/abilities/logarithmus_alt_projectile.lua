logarithmus_alt_projectile = class {}

function logarithmus_alt_projectile:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local speed = self:GetSpecialValueFor("projectile_speed")
    local projRadius = self:GetSpecialValueFor("projectile_radius")
    local radius = self:GetCastRange(casterPos, nil)
    local numProjectiles = self:GetSpecialValueFor("num_projectiles")

    local startPoints = PointsAlongRing(casterPos, radius, numProjectiles, 0)
    for i, point in ipairs(startPoints) do
        local pfx = ParticleManager:CreateParticle(
            "particles/logarithmus_projectile.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(pfx, 0, point)
        ParticleManager:SetParticleControl(pfx, 2, Vector(speed - 100, 0, 0))
        local function destroyPfx()
            ParticleManager:DestroyParticle(pfx, false)
            ParticleManager:ReleaseParticleIndex(pfx)
        end

        local interval = 0.05
        Timers:CreateTimer(0, function()

        end)
    end
end
