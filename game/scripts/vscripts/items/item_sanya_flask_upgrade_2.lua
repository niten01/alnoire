require('internal.gameevents')
item_sanya_flask_upgrade_2 = class({})
LinkLuaModifier("modifier_item_sanya_flask_upgrade_2", "modifiers/items/item_sanya_flask_upgrade_2",
    LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_flask_ms_bonus", "modifiers/items/item_sanya_flask_upgrade_2",
    LUA_MODIFIER_MOTION_NONE)



function item_sanya_flask_upgrade_2:Spawn()
    if not IsServer() then return end
end

function item_sanya_flask_upgrade_2:OnSpellStart()
    self:SpendCharge(0)
    local caster = self:GetCaster()
    local buffDuration = self:GetSpecialValueFor('buffDuration')
    caster:AddNewModifier(caster, self, 'modifier_item_sanya_flask_upgrade_2',
        { duration = self:GetSpecialValueFor('duration') })
    caster:AddNewModifier(caster, self, 'modifier_flask_ms_bonus', { duration = buffDuration })
end

modifier_item_sanya_flask_upgrade_2 = class({})
