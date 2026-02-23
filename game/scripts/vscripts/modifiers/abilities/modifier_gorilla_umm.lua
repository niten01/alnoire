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
    end
end

function modifier_gorilla_umm:OnDestroy()
    local parent = self:GetParent()
    parent:SetAbsOrigin(self.ogPosition)
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
