item_sanya_flask = class({})
LinkLuaModifier("modifier_item_sanya_flask", "modifiers/items/modifier_item_sanya_flask", LUA_MODIFIER_MOTION_NONE)


function item_sanya_flask:Spawn()
    if not IsServer() then return end
end

function item_sanya_flask:OnSpellStart()
    self:SpendCharge(0)
    local caster = self:GetCaster()
    if caster:HasModifier('modifier_item_sanya_flask') then
        caster:RemoveModifierByName('modifier_item_sanya_flask')
    end
    caster:AddNewModifier(caster, self, 'modifier_item_sanya_flask', { duration = self:GetSpecialValueFor('duration') })
end
