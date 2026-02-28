modifier_sanya_towel_aura_buff_1 = class({})

function modifier_sanya_towel_aura_buff_1:IsHidden() return false end

function modifier_sanya_towel_aura_buff_1:IsPurgable() return false end

function modifier_sanya_towel_aura_buff_1:IsDebuff() return false end

function modifier_sanya_towel_aura_buff_1:OnCreated()
    if not IsServer() then return end
    local ability = self:GetAbility()
    self.hp_regen = ability:GetSpecialValueFor('hp_regen') or 10
    self.decreaseMult = ability:GetSpecialValueFor('decreaseMult') or 0.7
    self.delayBeforeReset = ability:GetSpecialValueFor('delayBeforeReset') or 1.0
    self:StartIntervalThink(1.0)

    self.pfx = ParticleManager:CreateParticle("particles/sanya_towel_aura_green_summon.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
end

function modifier_sanya_towel_aura_buff_1:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_sanya_towel_aura_buff_1:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    local abil = self:GetAbility()
    local healAmount = self.hp_regen
    if self.lastHitTime and (GameRules:GetGameTime() - self.lastHitTime) <= self.delayBeforeReset then
        healAmount = healAmount * self.decreaseMult
    end

    parent:Heal(healAmount, abil)

    local pfx = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)
    ParticleManager:ReleaseParticleIndex(pfx)
    SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, parent, healAmount, nil)
end

function modifier_sanya_towel_aura_buff_1:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
end

function modifier_sanya_towel_aura_buff_1:OnTakeDamage(params)
    local parent = self:GetParent()
    if params.unit == parent then
        self.lastHitTime = GameRules:GetGameTime()
    end
end
