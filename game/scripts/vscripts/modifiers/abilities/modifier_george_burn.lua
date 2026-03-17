modifier_george_burn = class {}

function modifier_george_burn:IsHidden() return false end

function modifier_george_burn:IsDebuff() return true end

function modifier_george_burn:IsPurgable() return true end

function modifier_george_burn:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.3)

    self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_huskar/huskar_burning_spear_debuff.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
end

function modifier_george_burn:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_george_burn:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    ApplyDamage({
        victim = parent,
        attacker = self:GetCaster(),
        damage = 1,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = self:GetAbility(),
    })
end
