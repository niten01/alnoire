modifier_cust_rosh = class({})

function modifier_cust_rosh:IsHidden()
    return true
end
function modifier_cust_rosh:IsPurgable()
    return false
end

function modifier_cust_rosh:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_cust_rosh:OnDeath(params)
    if not IsServer() then return end
    if params.unit == self:GetParent() then
        EmitSoundOn("Roshan.Death", self:GetParent())
    end
end