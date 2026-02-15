modifier_demon_power = class {}

function modifier_demon_power:IsHidden() return true end

function modifier_demon_power:IsPurgable() return false end

function modifier_demon_power:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_demon_power:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_demon_power:GetModifierAttackSpeed_Limit()
    return 1
end

function modifier_demon_power:GetModifierAttackSpeedBonus_Constant()
    return 40
end

function modifier_demon_power:OnCreated()
    if not IsServer() then return end

    self.particleL = ParticleManager:CreateParticle(
        "particles/econ/items/bloodseeker/bloodseeker_crownfall_immortal/bloodseeker_crownfall_immortal_ambient_eyeglow_l.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        self:GetParent()
    )
    self.particleR = ParticleManager:CreateParticle(
        "particles/econ/items/bloodseeker/bloodseeker_crownfall_immortal/bloodseeker_crownfall_immortal_ambient_eyeglow_r.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        self:GetParent()
    )

    ParticleManager:SetParticleControlEnt(self.particleL, 8, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_eyeL",
        Vector(0, 0, 0), true)
    ParticleManager:SetParticleControlEnt(self.particleL, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_eyeL",
        Vector(0, 0, 0), true)
    ParticleManager:SetParticleControlEnt(self.particleR, 9, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_eyeR",
        Vector(0, 0, 0), true)
    ParticleManager:SetParticleControlEnt(self.particleR, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_eyeR",
        Vector(0, 0, 0), true)
end

function modifier_demon_power:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.particleL, false)
    ParticleManager:DestroyParticle(self.particleR, false)
    ParticleManager:ReleaseParticleIndex(self.particleL)
    ParticleManager:ReleaseParticleIndex(self.particleR)
end
