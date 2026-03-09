modifier_training_dummy = class({})

function modifier_training_dummy:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MIN_HEALTH,
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
end

function modifier_training_dummy:GetMinHealth()
    return 1
end

function modifier_training_dummy:OnTakeDamage(params)
    if not IsServer() then return end
    local parent = self:GetParent()
    if params.unit ~= parent then return end

    if params.unit:GetHealth() <= 1 then
        parent:SetHealth(parent:GetMaxHealth())
    end

    parent:StartGesture(ACT_DOTA_FLINCH)
end
