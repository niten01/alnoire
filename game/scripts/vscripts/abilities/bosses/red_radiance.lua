red_radiance = class({})
LinkLuaModifier("modifier_red_radiance", "abilities/bosses/red_radiance.lua", LUA_MODIFIER_MOTION_NONE)



function red_radiance:OnSpellStart()
    local caster = self:GetCaster()
    self.channel_pfx = ParticleManager:CreateParticle(
        "particles/econ/items/ember_spirit/ember_spirit_vanishing_flame/ember_spirit_vanishing_flame_ambient.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, caster)

    caster:EmitSound("ability.red.radiance.channel")
    caster:EmitSound("ability.red.radiance.start_channel")
end

function red_radiance:OnChannelFinish(bInterrupted)
    if not IsServer() then return end

    local caster = self:GetCaster()
    if self.channel_pfx then
        ParticleManager:DestroyParticle(self.channel_pfx, true)
        ParticleManager:ReleaseParticleIndex(self.channel_pfx)
        self.channel_pfx = nil
    end
    caster:StopSound("ability.red.radiance.channel")
    caster:EmitSound("ability.red.radiance.end_channel")

    if bInterrupted then return end

    local sanya = FindSanyaInRadius(caster:GetAbsOrigin(), 65536)
    assert(sanya)

    local ms = sanya:GetMoveSpeedModifier(sanya:GetBaseMoveSpeed(), true)
    local sprintAbility = sanya:FindAbilityByName("sanya_sprint")
    assert(sprintAbility)
    local sprintSpeed = sprintAbility:GetSpecialValueFor("sprint_speed")
    local sprintMod = sanya:FindModifierByName("modifier_custom_sprint")
    if sprintMod then
        ms = ms - sprintSpeed
    end

    local bonusMS = self:GetSpecialValueFor("bonus_ms")
    ms = ms + sprintSpeed + bonusMS

    local duration = self:GetSpecialValueFor("duration")
    local dps = self:GetSpecialValueFor("damage_per_sec")
    local radius = self:GetSpecialValueFor("radius")
    caster:AddNewModifier(caster, self, "modifier_red_radiance", {
        duration = duration,
        targetMS = ms,
        dps = dps,
        radius = radius,
    })
end

-------------------------------------------------------------

modifier_red_radiance = class {}

function modifier_red_radiance:OnCreated(kv)
    if not IsServer() then return end
    local parent = self:GetParent()
    local ms = parent:GetBaseMoveSpeed()
    self.msBonus = kv.targetMS - ms

    self.pfx = ParticleManager:CreateParticle("particles/econ/items/ember_spirit/ember_ti9/ember_ti9_flameguard.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)

    parent:EmitSound("ability.red.radiance.apply")
    parent:EmitSound("ability.red.radiance.loop")

    self.radius = kv.radius
    local interval = 0.1
    self.damagePerTick = kv.dps * interval
    self:StartIntervalThink(interval)
end

function modifier_red_radiance:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
    local parent = self:GetParent()
    parent:StopSound("ability.red.radiance.loop")
end

function modifier_red_radiance:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    local enemies = FindEnemiesForAIInRadius(parent:GetAbsOrigin(), self.radius)
    for _, ent in ipairs(enemies) do
        ApplyDamage({
            victim = ent,
            attacker = parent,
            damage = self.damagePerTick,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self:GetAbility(),
        })
    end
end

function modifier_red_radiance:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
    }
end

function modifier_red_radiance:GetModifierMoveSpeedBonus_Constant()
    return self.msBonus
end
