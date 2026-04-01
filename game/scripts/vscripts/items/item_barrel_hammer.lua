item_barrel_hammer = class {}

function item_barrel_hammer:OnSpellStart()
    local target = self:GetCursorTarget()
    if target and target:GetUnitName() == "npc_minigame_barrel" then
        BarrelClick:OnBarrelClicked(target)
    end
end
