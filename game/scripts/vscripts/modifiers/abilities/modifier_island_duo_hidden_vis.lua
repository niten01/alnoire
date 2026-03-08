modifier_island_duo_hidden_vis = class {}

function modifier_island_duo_hidden_vis:IsHidden() return false end

function modifier_island_duo_hidden_vis:IsPurgable() return false end

function modifier_island_duo_hidden_vis:OnCreated() 
    if not IsServer() then return end
    local parent = self:GetParent()
    parent:AddNoDraw()

    self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_shadow_demon/shadow_demon_disruption.vpcf",
        PATTACH_WORLDORIGIN, nil)
    local pos = parent:GetAbsOrigin()
    pos.z = pos.z + 50
    ParticleManager:SetParticleControl(self.pfx, 0, pos)
end

function modifier_island_duo_hidden_vis:OnDestroy()
    if not IsServer() then return end
    local parent = self:GetParent()
    parent:RemoveNoDraw()

    if self.pfx then
        ParticleManager:DestroyParticle(self.pfx, false)
        ParticleManager:ReleaseParticleIndex(self.pfx)
        self.pfx = nil
    end
end

function modifier_island_duo_hidden_vis:CheckState()
    return {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_SILENCED] = true,
        [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
    }
end
