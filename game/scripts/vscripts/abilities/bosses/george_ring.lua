george_ring = class {}

function george_ring:ShowWarning()
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local minRadius = self:GetSpecialValueFor("min_radius")
    local warningDelay = self:GetSpecialValueFor("warning_delay")
    ShowGenericCircleWarning(casterPos, minRadius, warningDelay + self:GetCastPoint())
    return warningDelay
end

function george_ring:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local minRadius = self:GetSpecialValueFor("min_radius")
    local maxRadius = self:GetSpecialValueFor("max_radius")
    local width = self:GetSpecialValueFor("width")
    local damage = self:GetSpecialValueFor("damage")
    local travelTime = self:GetSpecialValueFor("travel_time")

    local pulse = caster:AddNewModifier(caster, self, "modifier_generic_ring", {
        start_radius = minRadius,
        end_radius = maxRadius,
        width = width,
        speed = (maxRadius - minRadius) / travelTime,
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
end
