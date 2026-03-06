logarithmus_alt_step = class {}
LinkLuaModifier("modifier_logarithmus_alt_step", "abilities/logarithmus_alt_step", LUA_MODIFIER_MOTION_NONE)

function logarithmus_alt_step:Spawn()
    if not IsServer() then return end
    self:SetHidden(true)
end

function logarithmus_alt_step:GetCastRange(vLocation, hTarget)
    if IsClient() then
        return self:GetSpecialValueFor("dash_range")
    end
    return 0
end

function logarithmus_alt_step:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()

    self.endPos = self:GetCursorPosition()
    self.endPos.z = casterPos.z
    self.endPos = GetSafeBlinkDestination(casterPos, self.endPos, self:GetSpecialValueFor("dash_range"))

    -- local pfx = ParticleManager:CreateParticle("particles/logarithmus_step_simplified.vpcf", PATTACH_ABSORIGIN, caster)
    -- ParticleManager:SetParticleControl(pfx, 0, casterPos)
    -- ParticleManager:SetParticleControl(pfx, 1, self.endPos)
    -- ParticleManager:ReleaseParticleIndex(pfx)
end

function logarithmus_alt_step:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()

    assert(self.endPos)
    local dir = self.endPos - casterPos
    local duration = self:GetSpecialValueFor("dash_time")
    local speed = dir:Length() / duration

    caster:AddNewModifier(caster, self, "modifier_move", {
        directionX = dir.x,
        directionY = dir.y,
        speed = speed,
        duration = duration,
        activity = ACT_DOTA_CHANNEL_ABILITY_2
    })

    caster:AddNewModifier(caster, self, "modifier_logarithmus_alt_step", {
        dps = self:GetSpecialValueFor("dps"),
        radius = self:GetSpecialValueFor("spin_radius"),
        duration = duration,
    })

    PlayLogarithmusBladeEffect(caster, duration + 0.8)
end

------------------------------------------------------------------

modifier_logarithmus_alt_step = class {}


function modifier_logarithmus_alt_step:OnCreated(kv)
    if not IsServer() then return end
    local parent = self:GetParent()

    local interval = 0.1
    self.damagePerInterval = kv.dps * interval
    self.radius = kv.radius

    self.pfx = ParticleManager:CreateParticle("particles/logarithmus_spin.vpcf", PATTACH_ABSORIGIN_FOLLOW,
        parent)
    ParticleManager:SetParticleControl(self.pfx, 5, Vector(self.radius, 1, 1))

    parent:EmitSound("ability.logarithmus.alt_step.cast")

    self:StartIntervalThink(interval)
end

function modifier_logarithmus_alt_step:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_logarithmus_alt_step:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    local parentPos = parent:GetAbsOrigin()
    local enemies = FindEnemiesForSanyaInRadius(parentPos, self.radius)
    for _, ent in ipairs(enemies) do
        PlayLogarithmusImpaleEffect(ent, parentPos)
        ApplyDamage({
            victim = ent,
            attacker = parent,
            damage = self.damagePerInterval,
            damage_type = self:GetAbility():GetAbilityDamageType(),
            ability = self,
        })
    end
end
