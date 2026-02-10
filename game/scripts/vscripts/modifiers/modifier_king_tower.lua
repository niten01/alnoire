modifier_king_tower = class({})

function modifier_king_tower:IsHidden() return true end

function modifier_king_tower:IsPurgable() return false end

function modifier_king_tower:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_king_tower:OnDeath(event)
    if not IsServer() then return end

    if event.unit ~= self:GetParent() then return end
    local teamNum = self:GetParent():GetTeamNumber()
    print("[ALNOIRE] KING TOWER DIED:", self:GetParent():GetUnitName())

    ClashGame:OnKingTowerKilled(
        teamNum
    )
end
