modifier_gorilla_umm = class {}

function modifier_gorilla_umm:IsHidden() return true end

function modifier_gorilla_umm:IsPurgable() return false end

function modifier_gorilla_umm:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
    }
end

function modifier_gorilla_umm:CheckState()
    return {
        [MODIFIER_STATE_SILENCED] = true,
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true
    }
end

function modifier_gorilla_umm:GetActivityTranslationModifiers()
    return "torment"
end

function modifier_gorilla_umm:OnCreated(kv)
    if not IsServer() then return end
    local parent = self:GetParent()
    local attacker = self:GetCaster()
    self.ogPosition = parent:GetAbsOrigin()
    parent:SetAbsOrigin(attacker:GetAbsOrigin())
    parent:SetForwardVector(attacker:GetForwardVector())

    local interval = 0.32
    self.damagePerTick = kv.damage * interval
    if self.damagePerTick ~= 0 then
        self:StartIntervalThink(interval)
        self:OnIntervalThink()

        local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_windrunner/wr_taunt_kiss_heart.vpcf",
            PATTACH_ABSORIGIN, parent)
        ParticleManager:SetParticleControlTransformForward(pfx, 0, parent:GetAbsOrigin(), Vector(0, -0.01, 1))
        ParticleManager:ReleaseParticleIndex(pfx)
    end

    local headOffset = 320
    pfx = ParticleManager:CreateParticle("particles/econ/events/plus/high_five/high_five_lvl3_hearts_impact.vpcf",
        PATTACH_ABSORIGIN, parent)
    ParticleManager:SetParticleControl(pfx, 0, parent:GetAbsOrigin() + Vector(0, 0, headOffset))
    ParticleManager:ReleaseParticleIndex(pfx)

    self.pfx = ParticleManager:CreateParticle("particles/gorilla_umm_process.vpcf",
        PATTACH_ABSORIGIN, parent)
    ParticleManager:SetParticleControl(self.pfx, 3, parent:GetAbsOrigin() + Vector(0, 0, headOffset / 2))
end

function modifier_gorilla_umm:OnDestroy()
    if not IsServer() then return end
    local parent = self:GetParent()
    parent:SetAbsOrigin(self.ogPosition)

    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_gorilla_umm:OnIntervalThink()
    local parent = self:GetParent()
    local attacker = self:GetCaster()
    ApplyDamage({
        victim = parent,
        attacker = attacker,
        damage = self.damagePerTick,
        damage_type = DAMAGE_TYPE_PHYSICAL,
        ability = self:GetAbility()
    })
end
