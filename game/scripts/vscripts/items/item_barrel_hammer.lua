item_quelling_blade = class {}

function item_quelling_blade:OnSpellStart()
    local target = self:GetCursorTarget()
    if target and target:GetUnitName() == "npc_minigame_barrel" then
        BarrelClick:OnBarrelClicked(target)
    end
end
