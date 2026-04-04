modifier_tower = class({})

function modifier_tower:IsHidden() return false end

function modifier_tower:IsPurgable() return false end

function modifier_tower:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_tower:OnDeath(event)
    if not IsServer() then return end
    if event.unit ~= self:GetParent() then return end
    local parent = self:GetParent()
    parent:AddNoDraw()
    local towerName = parent:GetUnitName()
    local towerPfxName = 'particles/econ/world/towers/rock_golem/radiant_rock_golem_destruction.vpcf'
    if string.find(towerName, 'bad') then
        towerPfxName = "particles/econ/world/towers/rock_golem/dire_rock_golem_destruction.vpcf"
    end
    local towerPfx = ParticleManager:CreateParticle(
        towerPfxName, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(towerPfx, 0, parent:GetAbsOrigin())
    ParticleManager:SetParticleControl(towerPfx, 1, parent:GetAbsOrigin() + parent:GetForwardVector())
    ParticleManager:ReleaseParticleIndex(towerPfx)

    ClashGame:OnTowerKilled(towerName)
end
