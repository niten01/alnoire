item_sanya_flask = class({})

function item_sanya_flask:Spawn()
    if not IsServer() then return end
end

function item_sanya_flask:OnSpellStart()
    self:SpendCharge(0)
    local caster = self:GetCaster()
    if caster:HasModifier('modifier_item_sanya_flask_heal') then
        caster:RemoveModifierByName('modifier_item_sanya_flask_heal')
    end
    EmitSoundOn("items.flask.cast", caster)
    caster:AddNewModifier(caster, self, 'modifier_item_sanya_flask_heal',
        { duration = self:GetSpecialValueFor('duration') })
end
