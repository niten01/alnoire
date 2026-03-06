logarithmus_alt_throw = class {}

function logarithmus_alt_throw:Spawn()
    if not IsServer() then
        CustomIndicator:RegisterAbility(self)
    else
        self:SetHidden(true)
    end
end

function logarithmus_alt_throw:CreateCustomIndicator(position, unit, behavior)
    if behavior ~= DOTA_CLICK_BEHAVIOR_CAST then return end
    local caster = self:GetCaster()

    self.indicator = ParticleManager:CreateParticle("particles/ui_mouseactions/custom_range_finder_cone.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, caster)
    local width = self:GetSpecialValueFor("width")
    ParticleManager:SetParticleControl(self.indicator, 3, Vector(width, width, 0))
    ParticleManager:SetParticleControl(self.indicator, 4, Vector(0, 255, 0))

    self:UpdateCustomIndicator(position, unit, behavior)
end

function logarithmus_alt_throw:UpdateCustomIndicator(position, unit, behavior)
    if behavior ~= DOTA_CLICK_BEHAVIOR_CAST then return end

    local casterPos = self:GetCaster():GetAbsOrigin()
    ParticleManager:SetParticleControl(self.indicator, 1, casterPos)

    local dir = (position - casterPos):Normalized()
    local range = self:GetCastRange(casterPos, nil)
    local endPos = casterPos + dir * range
    ParticleManager:SetParticleControl(self.indicator, 2, endPos)
end

function logarithmus_alt_throw:DestroyCustomIndicator(position, unit, behavior)
    if behavior ~= DOTA_CLICK_BEHAVIOR_CAST then return end

    ParticleManager:DestroyParticle(self.indicator, false)
    ParticleManager:ReleaseParticleIndex(self.indicator)
    self.indicator = nil
end

function logarithmus_alt_throw:Slice(from, to)
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
end

function logarithmus_alt_throw:OnSpellStart()
    local caster = self:GetCaster()
    local inactiveDuration = self:GetSpecialValueFor("tp_animation_point") - self:GetCastPoint()

    caster:AddNewModifier(caster, self, "modifier_logarithmus_casting", { duration = inactiveDuration })

    PlayLogarithmusBladeEffect(caster, 1.5)

    local casterPos = caster:GetAbsOrigin()
    local targetPos = self:GetCursorPosition()
    targetPos.z = casterPos.z
    local dir = (targetPos - casterPos):Normalized()
    local endPos = casterPos + dir * self:GetCastRange(casterPos, nil)
    self:Slice(casterPos, endPos)
    caster:EmitSound("ability.logarithmus.throw.first")

    endPos = GetSafeBlinkDestination(casterPos, endPos)
    endPos = GetClearSpaceForUnit(caster, endPos)

    Timers:CreateTimer(inactiveDuration, function()
        if not caster:IsAlive() then return end
        self:Slice(casterPos, endPos)
        caster:EmitSound("ability.logarithmus.alt_throw.second")

        caster:Stop()
        caster:SetAbsOrigin(endPos)
        caster:SetForwardVector(dir)
        caster:FaceTowards(endPos + dir)
    end)
end
