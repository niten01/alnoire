modifier_desert_troll = class({})

function modifier_desert_troll:IsHidden()
    return true
end

function modifier_desert_troll:IsPurgable()
    return false
end

function modifier_desert_troll:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
    }
end

function modifier_desert_troll:GetActivityTranslationModifiers()
    return "melee"
end
