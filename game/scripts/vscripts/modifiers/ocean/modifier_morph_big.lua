modifier_morph_big = class({})

function modifier_morph_big:IsHidden()
    return true
end

function modifier_morph_big:IsPurgable()
    return false
end

function modifier_morph_big:OnCreated()
    if not IsServer() then return end
    local parent = self:GetParent()
    self.pfx = ParticleManager:CreateParticle('particles/units/heroes/hero_morphling/morphling_morph_str.vpcf',
        PATTACH_ABSORIGIN_FOLLOW, parent)
    ParticleManager:SetParticleControlEnt(self.pfx, 0, parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc",
        parent:GetAbsOrigin(), true)
end

function modifier_morph_big:OnDestroy()
    if not IsServer() then return end
    if self.pfx then
        ParticleManager:DestroyParticle(self.pfx, true)
        ParticleManager:ReleaseParticleIndex(self.pfx)
        self.pfx = nil
    end
end

--------------------------------------------

modifier_morph_small = class({})

function modifier_morph_small:IsHidden()
    return true
end

function modifier_morph_small:IsPurgable()
    return false
end

function modifier_morph_small:OnCreated()
    if not IsServer() then return end
    local parent = self:GetParent()
    self.pfx = ParticleManager:CreateParticle('particles/units/heroes/hero_morphling/morphling_morph_agi.vpcf',
        PATTACH_ABSORIGIN_FOLLOW, parent)
    ParticleManager:SetParticleControlEnt(self.pfx, 0, parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc",
        parent:GetAbsOrigin(), true)
end

function modifier_morph_small:OnDestroy()
    if not IsServer() then return end
    if self.pfx then
        ParticleManager:DestroyParticle(self.pfx, true)
        ParticleManager:ReleaseParticleIndex(self.pfx)
        self.pfx = nil
    end
end
