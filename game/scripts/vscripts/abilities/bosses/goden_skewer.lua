goden_skewer = class {}

function goden_skewer:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    caster:EmitSound("ability.goden.skewer.roar")
end

function goden_skewer:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local damage = self:GetSpecialValueFor("damage")
    local damageRadius = self:GetSpecialValueFor("damage_radius")
    local maxRange = self:GetSpecialValueFor("max_range")
    local speed = self:GetSpecialValueFor("speed")

    local endPos = casterPos + (self:GetCursorPosition() - casterPos):Normalized() * maxRange
    endPos = GetSafeBlinkDestination(casterPos, endPos, maxRange)
    local v = endPos - casterPos

    local pfx = ParticleManager:CreateParticle(
        "particles/goden_skewer.vpcf", PATTACH_ABSORIGIN_FOLLOW,
        caster)

    caster:EmitSound("ability.goden.skewer.cast")
    caster:EmitSound("ability.goden.skewer.loop")

    local move = caster:AddNewModifier(caster, self, "modifier_move", {
        duration = #v / speed,
        speed = speed,
        directionX = v.x,
        directionY = v.y,
        activity = ACT_DOTA_MAGNUS_SKEWER_END,
        pfx = pfx
    })

    caster:AddNewModifier(caster, self, "modifier_logarithmus_casting", { duration = move:GetRemainingTime() })
    Timers:CreateTimer(move:GetRemainingTime(), function()
        caster:StopSound("ability.goden.skewer.loop")
    end)


    local interval = 0.1
    Timers:CreateTimer(0, function()
        if not caster:HasModifier("modifier_move") then
            return nil
        end

        local casterPos = caster:GetAbsOrigin()
        ParticleManager:SetParticleControlTransformForward(pfx, 0,
            casterPos + caster:GetForwardVector() * (damageRadius + 100),
            caster:GetForwardVector())

        local enemies = FindEnemiesForAIInRadius(casterPos, damageRadius)
        for _, ent in ipairs(enemies) do
            ApplyDamage({
                victim = ent,
                attacker = caster,
                damage = damage,
                damage_type = self:GetAbilityDamageType(),
                ability = self
            })

            local dur = math.max(0, move:GetRemainingTime() - 0.5)
            ent:AddNewModifier(caster, self, "modifier_stunned", { duration = dur })
            ent:AddNewModifier(caster, self, "modifier_move", {
                duration = dur,
                speed = speed,
                directionX = v.x,
                directionY = v.y,
                activity = ACT_DOTA_FLAIL,
            })
            return nil
        end
        return interval
    end)
end
