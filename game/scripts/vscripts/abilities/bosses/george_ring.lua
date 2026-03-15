george_ring = class {}

function george_ring:ShowWarning()
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local maxRadius = self:GetSpecialValueFor("max_radius")
    local warningDelay = self:GetSpecialValueFor("warning_delay")
    ShowGenericCircleWarning(casterPos, maxRadius, warningDelay + self:GetCastPoint())
    return warningDelay
end

function george_ring:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local maxRadius = self:GetSpecialValueFor("max_radius")
    local width = self:GetSpecialValueFor("width")
    local damage = self:GetSpecialValueFor("damage")
    local travelTime = self:GetSpecialValueFor("travel_time")
    local speed = (maxRadius) / travelTime

    local pfx = ParticleManager:CreateParticle("particles/george_ring.vpcf", PATTACH_ABSORIGIN, caster)
    ParticleManager:SetParticleControl(pfx, 1, Vector(speed, maxRadius, 1))

    local pulse = caster:AddNewModifier(caster, self, "modifier_generic_ring", {
        end_radius = maxRadius,
        width = width,
        speed = speed,
        target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
        target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    })

    pulse:SetCallback(function(enemy)
        ApplyDamage({
            victim = enemy,
            attacker = caster,
            damage = damage,
            damage_type = self:GetAbilityDamageType(),
            ability = self,
        })
    end)

    pulse:SetEndCallback(function()
        ParticleManager:DestroyParticle(pfx, false)
        ParticleManager:ReleaseParticleIndex(pfx)
    end)
end
