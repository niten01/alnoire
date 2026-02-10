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


    ClashGame:OnTowerKilled(self:GetParent():GetUnitName())
end