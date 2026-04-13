modifier_immobile = class {}

function modifier_immobile:IsHidden() return true end

function modifier_immobile:IsPurgable() return false end

function modifier_immobile:GetTexture()
    return "modifier_invulnerable"
end
