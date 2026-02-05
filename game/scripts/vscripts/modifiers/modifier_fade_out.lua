modifier_fade_out = class({})

function modifier_fade_out:IsHidden() return true end

function modifier_fade_out:DeclareFunctions()
    return { MODIFIER_PROPERTY_INVISIBILITY_LEVEL }
end

function modifier_fade_out:GetModifierInvisibilityLevel()
    -- This returns a 0.0 to 1.0 value
    -- You can link this to the modifier's remaining duration
    return self:GetRemainingTime() / self:GetDuration()
end