require('internal.gameevents')
item_sanya_flask = class({})
LinkLuaModifier("modifier_item_sanya_flask", "modifiers/items/modifier_item_sanya_flask", LUA_MODIFIER_MOTION_NONE)


function item_sanya_flask:Spawn()
    if not IsServer() then return end
    if not item_sanya_flask.__event_registered then
        item_sanya_flask.__event_registered = true

        GameEvents:OnRefillFlask(function(event)
            item_sanya_flask:OnRefillFlask(event)
        end)
    end
end

function item_sanya_flask:OnSpellStart()
    self:SpendCharge(0)
    local caster = self:GetCaster()
    if caster:HasModifier('modifier_item_sanya_flask') then
        caster:RemoveModifierByName('modifier_item_sanya_flask')
    end
    caster:AddNewModifier(caster, self, 'modifier_item_sanya_flask', {duration = self:GetSpecialValueFor('duration')})
    
end

function item_sanya_flask:OnRefillFlask(event)
    local hero = event.hero
    local item = hero:FindItemInInventory('item_sanya_flask')
    if not item then return end
    item:SetCurrentCharges(item:GetInitialCharges())
    item:EndCooldown()

end
