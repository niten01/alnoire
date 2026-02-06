item_ski = item_ski or class {}


function item_ski:OnSpellStart()
    GlobalState:Get().has_ski = true
    DoorManager:Open("door_ski")
    local caster = self:GetCaster()
    caster:EmitSound("items.ski.consume")
    self:SpendCharge(0)
end