logarithmus_alt_clone = class {}

function logarithmus_alt_clone:Spawn()
    if not IsServer() then return end
    self:SetHidden(true)
end

function logarithmus_alt_clone:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local target = self:GetCursorTarget()
    local targetPos = target:GetAbsOrigin()
    local cloneDuration = self:GetSpecialValueFor("clone_duration")
    local cloneAttackPoint = self:GetSpecialValueFor("clone_attack_point")

    local points = PointsAlongRing(targetPos, target:GetHullRadius() + 100, 4)
    for _, point in ipairs(points) do point.z = targetPos.z end
    local realPointIdx = RandomInt(1, #points)
    local realPoint = points[realPointIdx]

    caster:EmitSound("ability.logarithmus.alt_clone.cast")

    for i, point in ipairs(points) do
        if i == realPointIdx then goto continue end

        local dir = (targetPos - point):Normalized()
        local clonePfx = ParticleManager:CreateParticle("particles/logarithmus_alt_remnant.vpcf", PATTACH_WORLDORIGIN,
            nil)
        ParticleManager:SetParticleControl(clonePfx, 0, point)
        ParticleManager:SetParticleControl(clonePfx, 1, point - dir * 10)
        ParticleManager:SetParticleControl(clonePfx, 2, Vector(17, 0, 0)) -- attack_clone_chop


        -- destroy clone
        Timers:CreateTimer(cloneDuration, function()
            ParticleManager:DestroyParticle(clonePfx, false)
            ParticleManager:ReleaseParticleIndex(clonePfx)

            EmitSoundOnLocationWithCaster(point, "ability.logarithmus.clone.dissolve", caster)
        end)

        -- attack
        Timers:CreateTimer(cloneAttackPoint, function()
            caster:EmitSound("ability.logarithmus.alt_clone.swing")

            PlayLogarithmusImpaleEffect(target, point)
        end)
        ::continue::
    end

    ApplyDamage({
        victim = target,
        attacker = caster,
        damage = self:GetAbilityDamage(),
        damage_type = self:GetAbilityDamageType(),
        ability = self,
    })

    local pfx = ParticleManager:CreateParticle("particles/logarithmus_step_simplified.vpcf", PATTACH_ABSORIGIN, caster)
    ParticleManager:SetParticleControl(pfx, 0, casterPos)
    ParticleManager:SetParticleControl(pfx, 1, realPoint)
    ParticleManager:ReleaseParticleIndex(pfx)

    local dir = (targetPos - realPoint):Normalized()
    caster:Stop()
    caster:AddNewModifier(caster, self, "modifier_logarithmus_casting", { duration = cloneAttackPoint })
    caster:SetAbsOrigin(realPoint)
    caster:SetForwardVector(dir)
    caster:FaceTowards(targetPos)
    caster:StartGesture(ACT_DOTA_ATTACK_EVENT)
    Timers:CreateTimer(cloneAttackPoint, function()
        PlayLogarithmusImpaleEffect(target, realPoint)
        -- caster:PerformAttack(target, true, true, true, false, false, false,
        --     false)
    end)
end
