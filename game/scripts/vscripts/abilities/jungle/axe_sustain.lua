LinkLuaModifier("modifier_axe_sustain", "modifiers/jungle/modifier_axe_sustain", LUA_MODIFIER_MOTION_NONE)
axe_sustain = class({})

function axe_sustain:OnToggle()
    local caster = self:GetCaster()
    local modifier_name = "modifier_axe_sustain"

    if self:GetToggleState() then
        caster:AddNewModifier(caster, self, modifier_name, {})
    else
        caster:RemoveModifierByName(modifier_name)
    end
end
