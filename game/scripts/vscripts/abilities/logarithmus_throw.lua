logarithmus_throw = class {}

function logarithmus_throw:Spawn()
    if not IsServer() then
        CustomIndicator:RegisterAbility(self)
    end
end

function logarithmus_throw:OnUpgrade()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local alt = caster:FindAbilityByName("logarithmus_alt_throw")
    assert(alt)
    alt:SetLevel(self:GetLevel())
end

function logarithmus_throw:CreateCustomIndicator(position, unit, behavior)
    if behavior ~= DOTA_CLICK_BEHAVIOR_CAST then return end
    local caster = self:GetCaster()

    self.indicator = ParticleManager:CreateParticle("particles/ui_mouseactions/custom_range_finder_cone.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, caster)
    local width = self:GetSpecialValueFor("width")
    ParticleManager:SetParticleControl(self.indicator, 3, Vector(width, width, 0))
    ParticleManager:SetParticleControl(self.indicator, 4, Vector(0, 255, 0))

    self:UpdateCustomIndicator(position, unit, behavior)
end

function logarithmus_throw:UpdateCustomIndicator(position, unit, behavior)
    if behavior ~= DOTA_CLICK_BEHAVIOR_CAST then return end

    local casterPos = self:GetCaster():GetAbsOrigin()
    ParticleManager:SetParticleControl(self.indicator, 1, casterPos)

    local dir = (position - casterPos):Normalized()
    local range = self:GetCastRange(casterPos, nil)
    local endPos = casterPos + dir * range
    ParticleManager:SetParticleControl(self.indicator, 2, endPos)
end

function logarithmus_throw:DestroyCustomIndicator(position, unit, behavior)
    if behavior ~= DOTA_CLICK_BEHAVIOR_CAST then return end

    ParticleManager:DestroyParticle(self.indicator, false)
    ParticleManager:ReleaseParticleIndex(self.indicator)
    self.indicator = nil
end

function logarithmus_throw:Slice(from, to)
    local pfx = ParticleManager:CreateParticle("particles/logarithmus_step.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, from)
    ParticleManager:SetParticleControl(pfx, 1, to)
    ParticleManager:ReleaseParticleIndex(pfx)

    local enemies = FindEnemiesForSanyaInLine(from, to, self:GetSpecialValueFor("width"))
    for _, ent in ipairs(enemies) do
        PlayLogarithmusImpaleEffect(ent, from)
        ApplyDamage({
            victim = ent,
            attacker = self:GetCaster(),
            damage = self:GetAbilityDamage(),
            damage_type = self:GetAbilityDamageType(),
            ability = self,
        })
    end

    return #enemies > 0
end

function logarithmus_throw:OnSpellStart()
    local caster = self:GetCaster()
    local inactiveDuration = self:GetSpecialValueFor("end_inactive_animation_point") - self:GetCastPoint()

    caster:AddNewModifier(caster, self, "modifier_logarithmus_casting", { duration = inactiveDuration })

    PlayLogarithmusBladeEffect(caster, 1.5)

    local casterPos = caster:GetAbsOrigin()
    -- local bladeIdx = caster:ScriptLookupAttachment("attach_blade_start")
    -- local casterPos = caster:GetAttachmentOrigin(bladeIdx)

    local targetPos = self:GetCursorPosition()
    targetPos.z = casterPos.z
    local dir = (targetPos - casterPos):Normalized()
    local endPos = casterPos + dir * self:GetCastRange(casterPos, nil)
    local secondSlashDelay = self:GetSpecialValueFor("second_slash_animation_point") - self:GetCastPoint()

    local hit = self:Slice(casterPos, endPos)
    caster:EmitSound("ability.logarithmus.throw.first")

    Timers:CreateTimer(secondSlashDelay, function()
        hit = hit or self:Slice(endPos, casterPos)
        caster:EmitSound("ability.logarithmus.throw.second")

        if hit then
            IncrementLogarithmusStacks(caster)
        end
    end)
end
