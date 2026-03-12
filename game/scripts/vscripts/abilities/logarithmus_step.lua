logarithmus_step = class {}
LinkLuaModifier("modifier_logarithmus_step_recastable", "abilities/logarithmus_step", LUA_MODIFIER_MOTION_NONE)

function logarithmus_step:Spawn()
    self.sequentialUses = 0
end

function logarithmus_step:OnUpgrade()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local alt = caster:FindAbilityByName("logarithmus_alt_step")
    assert(alt)
    alt:SetLevel(self:GetLevel())
end

function logarithmus_step:GetCastRange(vLocation, hTarget)
    if IsClient() then
        return self:GetSpecialValueFor("blink_range")
    end
    return 0
end

function logarithmus_step:GetVectorTargetStartRadius()
    return self:GetSpecialValueFor("stab_width")
end

function logarithmus_step:GetVectorTargetRange()
    return self:GetSpecialValueFor("vector_range")
end

function logarithmus_step:OnVectorCastStart(vStartLocation, vDirection)
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local maxSequentialUses = self:GetSpecialValueFor("max_sequential_uses")

    local blinkPos = vStartLocation
    blinkPos.z = casterPos.z
    blinkPos = GetSafeBlinkDestination(casterPos, blinkPos, self:GetSpecialValueFor("blink_range"))

    local pfx = ParticleManager:CreateParticle("particles/logarithmus_step_simplified.vpcf", PATTACH_ABSORIGIN, caster)
    ParticleManager:SetParticleControl(pfx, 0, casterPos)
    ParticleManager:SetParticleControl(pfx, 1, blinkPos)
    ParticleManager:ReleaseParticleIndex(pfx)

    EmitSoundOnLocationWithCaster(casterPos, "ability.logarithmus.step.start", caster)

    local hitPos = blinkPos + vDirection * self:GetVectorTargetRange()
    hitPos.z = casterPos.z

    caster:SetAbsOrigin(blinkPos)
    FindClearSpaceForUnit(caster, blinkPos, true)
    caster:SetForwardVector(vDirection)
    caster:FaceTowards(hitPos)

    if self.sequentialUses == maxSequentialUses - 1 then
        EmitSoundOnLocationWithCaster(blinkPos, "ability.logarithmus.step.cast_max", caster)
    else
        EmitSoundOnLocationWithCaster(blinkPos, "ability.logarithmus.step.cast", caster)
    end

    pfx = ParticleManager:CreateParticle("particles/logarithmus_step.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, blinkPos)
    ParticleManager:SetParticleControl(pfx, 1, hitPos)
    ParticleManager:ReleaseParticleIndex(pfx)

    PlayLogarithmusBladeEffect(caster, 1.0)

    local enemies = FindEnemiesForSanyaInLine(blinkPos, hitPos, self:GetSpecialValueFor("stab_width"))
    for _, ent in ipairs(enemies) do
        PlayLogarithmusImpaleEffect(ent, blinkPos)
        ApplyDamage({
            victim = ent,
            attacker = caster,
            damage = self:GetAbilityDamage(),
            damage_type = self:GetAbilityDamageType(),
            ability = self,
        })
    end

    if #enemies > 0 then
        IncrementLogarithmusStacks(caster)
        self.sequentialUses = self.sequentialUses + 1
        if self.sequentialUses < maxSequentialUses then
            caster:AddNewModifier(caster, self, "modifier_logarithmus_step_recastable", {
                duration = self:GetSpecialValueFor("recast_decay")
            })
        else
            self.sequentialUses = 0
        end
    end
end

-------------------------------------------------------

modifier_logarithmus_step_recastable = class {}

function modifier_logarithmus_step_recastable:IsHidden() return false end

function modifier_logarithmus_step_recastable:IsPurgable() return false end

function modifier_logarithmus_step_recastable:OnCreated()
    if not IsServer() then return end
    self:GetAbility():EndCooldown()
end

modifier_logarithmus_step_recastable.OnRefresh = modifier_logarithmus_step_recastable.OnCreated

function modifier_logarithmus_step_recastable:OnDestroy()
    if not IsServer() then return end
    local parent = self:GetParent()
    local ability = self:GetAbility()
    if ability == parent:GetCurrentActiveAbility() then return end
    ability:StartCooldown(ability:GetEffectiveCooldown(ability:GetLevel()))
    ability.sequentialUses = 0
end
