modifier_test_eyes = class {}

function modifier_test_eyes:IsHidden() return true end

function modifier_test_eyes:IsPurgable() return false end

function modifier_test_eyes:OnCreated()
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

function modifier_test_eyes:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.particle, false)
    ParticleManager:ReleaseParticleIndex(self.particle)
end
