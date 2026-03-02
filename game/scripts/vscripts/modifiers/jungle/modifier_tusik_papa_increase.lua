modifier_tusik_papa_increase = class({})

function modifier_tusik_papa_increase:IsHidden() return false end

function modifier_tusik_papa_increase:IsPurgable() return false end

function modifier_tusik_papa_increase:IsDebuff() return true end

function modifier_tusik_papa_increase:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
end

function modifier_tusik_papa_increase:OnRefresh()
    if not IsServer() then return end
    self:IncrementStackCount()
end

function modifier_tusik_papa_increase:GetTexture()
    return "tusk_walrus_punch"
end
