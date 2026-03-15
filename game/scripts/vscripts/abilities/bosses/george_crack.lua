george_crack = class {}

-- function george_crack:OnAbilityPhaseStart()
--     if not IsServer() then return end
--     local caster = self:GetCaster()
--     local casterPos = caster:GetAbsOrigin()
--     local targetPos = self:GetCursorPosition()
--     local distance = self:GetSpecialValueFor("distance")
--     local width = self:GetSpecialValueFor("width")
--     local v = targetPos - casterPos
--     self.dir = v:Normalized()
--     ShowGenericLineWarning(casterPos, casterPos + self.dir * distance, width, self:GetCastPoint())
-- end

function george_crack:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local targetPos = self:GetCursorPosition()
    local distance = self:GetSpecialValueFor("distance")
    local width = self:GetSpecialValueFor("width")
    local damage = self:GetSpecialValueFor("damage")
    local travelTime = self:GetSpecialValueFor("travel_time")
    local dir = (targetPos - casterPos):Normalized()

    local pfx = ParticleManager:CreateParticle("particles/george_crack.vpcf", PATTACH_ABSORIGIN, caster)
    local endPos = casterPos + dir * distance
    ParticleManager:SetParticleControl(pfx, 1, endPos)
    ParticleManager:SetParticleControl(pfx, 3, Vector(0, travelTime, 0))

    Timers:CreateTimer(travelTime, function()
        ParticleManager:DestroyParticle(pfx, false)
        ParticleManager:ReleaseParticleIndex(pfx)

        local enemies = FindEnemiesForAIInLine(casterPos, endPos, width)
        for _, ent in ipairs(enemies) do
            ApplyDamage({
                victim = ent,
                attacker = caster,
                damage = damage,
                damage_type = self:GetAbilityDamageType(),
                ability = self,
            })
        end
    end)
end
