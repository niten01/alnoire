genius_push = class {}

function genius_push:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local radius = self:GetSpecialValueFor("radius")
    local enemies = FindEnemiesForAIInRadius(casterPos, radius)
    local time = self:GetSpecialValueFor("time")
    for _, ent in ipairs(enemies) do
        local direction = ent:GetAbsOrigin() - caster:GetAbsOrigin()
        local distance = radius - #direction
        local speed = distance / time
        ent:AddNewModifier(caster, self, "modifier_move", {
            duration = time,
            directionX = direction.x,
            directionY = direction.y,
            speed = speed,
        })
    end

    local pfx = ParticleManager:CreateParticle("particles/genius_push_sphere.vpcf", PATTACH_ABSORIGIN, caster)
    ParticleManager:ReleaseParticleIndex(pfx)

    caster:EmitSound("ability.genius.push.cast")
end
