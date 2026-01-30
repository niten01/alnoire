require('internal.gameevents')
item_sanya_flask_upgrade_1 = class({})
LinkLuaModifier("modifier_item_sanya_flask_upgrade_1", "modifiers/items/modifier_item_sanya_flask_upgrade_1", LUA_MODIFIER_MOTION_NONE)



function item_sanya_flask_upgrade_1:Spawn()
    if not IsServer() then return end
    if not item_sanya_flask_upgrade_1.__event_registered then
        item_sanya_flask_upgrade_1.__event_registered = true

        GameEvents:OnRefillFlask(function(event)
            item_sanya_flask_upgrade_1:OnRefillFlask(event)
        end)
    end
end


function item_sanya_flask_upgrade_1:OnSpellStart()
    self:SpendCharge(0)
    local caster = self:GetCaster()
    if caster:HasModifier('modifier_item_sanya_flask_upgrade_1') then
        caster:RemoveModifierByName('modifier_item_sanya_flask_upgrade_1')
    end
    caster:AddNewModifier(caster, self, 'modifier_item_sanya_flask_upgrade_1', {duration = self:GetSpecialValueFor('duration')})
    
end

function item_sanya_flask_upgrade_1:OnRefillFlask(event)
    local hero = event.hero
    local item = hero:FindItemInInventory('item_sanya_flask_upgrade_1')
    if not item then return end
    item:SetCurrentCharges(item:GetInitialCharges())
    item:EndCooldown()

end