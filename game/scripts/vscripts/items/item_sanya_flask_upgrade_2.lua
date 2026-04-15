item_sanya_flask_upgrade_2 = class({})

function item_sanya_flask_upgrade_2:Spawn()
    if not IsServer() then return end
end

function item_sanya_flask_upgrade_2:OnSpellStart()
    self:SpendCharge(0)
    local caster = self:GetCaster()
    if caster:HasModifier('modifier_item_sanya_flask_heal') then
        caster:RemoveModifierByName('modifier_item_sanya_flask_heal')
    end
    EmitSoundOn("items.flask.cast", caster)
    caster:AddNewModifier(caster, self, 'modifier_item_sanya_flask_heal',
        { duration = self:GetSpecialValueFor('duration') })
    if caster:HasModifier('modifier_item_sanya_flask_ms') then
        caster:RemoveModifierByName('modifier_item_sanya_flask_ms')
    end
    caster:AddNewModifier(caster, self, 'modifier_item_sanya_flask_ms',
        { duration = self:GetSpecialValueFor('buffDuration') })
end
