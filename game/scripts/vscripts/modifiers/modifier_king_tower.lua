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
    local parent = self:GetParent()
    parent:AddNoDraw()
    local teamNum = self:GetParent():GetTeamNumber()
    print("[ALNOIRE] KING TOWER DIED:", self:GetParent():GetUnitName())
    local banana_prop_floor = Entities:FindByName(nil, "king_tower_onmap_effect_floor")
    local banana_prop_air = Entities:FindByName(nil, "king_tower_onmap_effect_air")
    if banana_prop_floor then
        UTIL_Remove(banana_prop_floor)
    end
    if banana_prop_air then
        UTIL_Remove(banana_prop_air)
    end
    local pfxName = "particles/king_tower_bad_destroy.vpcf"
    if teamNum == DOTA_TEAM_BADGUYS then
        local kingTowerPfx = ParticleManager:CreateParticle(pfxName, PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(kingTowerPfx, 0, parent:GetAbsOrigin())
        ParticleManager:SetParticleControl(kingTowerPfx, 3, parent:GetAbsOrigin() + parent:GetForwardVector())
        EmitSoundOn("KingTowerBad.Destroy", parent)
        Timers:CreateTimer(10.0, function()
            ParticleManager:DestroyParticle(kingTowerPfx, true)
            ParticleManager:ReleaseParticleIndex(kingTowerPfx)
        end)
    end

    ClashGame:OnKingTowerKilled(
        teamNum
    )
end

function modifier_king_tower:CheckState()
    return {
        [MODIFIER_STATE_FROZEN] = true,
    }
end
