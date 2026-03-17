george_impale = class {}

function george_impale:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local targetPos = self:GetCursorPosition()
    local width = self:GetSpecialValueFor("width")
    ShowGenericLineWarning(casterPos, targetPos, width, self:GetCastPoint())
end

function george_impale:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    caster.georgeCasting = true

    local targetPos = self:GetCursorPosition()
    local width = self:GetSpecialValueFor("width")
    local length = self:GetSpecialValueFor("length")
    local damage = self:GetSpecialValueFor("damage")
    local time = self:GetSpecialValueFor("travel_time")

    local v = targetPos - casterPos
    local dist = #v - length / 2

    caster:EmitSound("ability.george.impale.dash")
    caster:EmitSound("ability.george.impale.cast")

    local pfx = ParticleManager:CreateParticle("particles/george_move.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    caster:AddNewModifier(caster, self, "modifier_move_ease", {
        directionX = v.x,
        directionY = v.y,
        duration = time,
        distance = dist,
        pfx = pfx,
    })

    local pfx = ParticleManager:CreateParticle("particles/george_impale_spear.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControlEnt(pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_spear", Vector(0, 0, 0), false)

    Timers:CreateTimer(time, function()
        ParticleManager:DestroyParticle(pfx, false)
        ParticleManager:ReleaseParticleIndex(pfx)
        caster.georgeCasting = false

        local casterPos = caster:GetAbsOrigin()
        local enemies = FindEnemiesForAIInLine(casterPos, casterPos + caster:GetForwardVector() * length, width)
        for _, ent in ipairs(enemies) do
            ApplyDamage({
                victim = ent,
                attacker = caster,
                damage = damage,
                damage_type = self:GetAbilityDamageType(),
                ability = self,
            })
            ApplyGeorgeBurn(ent, self)
            EmitSoundOnLocationWithCaster(ent:GetAbsOrigin(), "ability.george.impale.hit", caster)
        end
    end)
end
