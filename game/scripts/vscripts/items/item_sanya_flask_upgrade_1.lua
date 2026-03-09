require('internal.gameevents')
item_sanya_flask_upgrade_1 = class({})
LinkLuaModifier("modifier_item_sanya_flask_upgrade_1", "modifiers/items/modifier_item_sanya_flask_upgrade_1",
    LUA_MODIFIER_MOTION_NONE)



function item_sanya_flask_upgrade_1:Spawn()
    if not IsServer() then return end
end

function item_sanya_flask_upgrade_1:OnSpellStart()
    self:SpendCharge(0)
    local caster = self:GetCaster()
    if caster:HasModifier('modifier_item_sanya_flask_upgrade_1') then
        caster:RemoveModifierByName('modifier_item_sanya_flask_upgrade_1')
    end
    caster:AddNewModifier(caster, self, 'modifier_item_sanya_flask_upgrade_1',
        { duration = self:GetSpecialValueFor('duration') })
end
