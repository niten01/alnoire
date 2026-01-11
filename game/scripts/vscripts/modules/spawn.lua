SpawnManager = SpawnManager or class {}

function SpawnManager:Init()
    GameEvents:OnHeroSpawned(bind(self.OnHeroSpawned, self))
end

function SpawnManager:OnHeroSpawned(keys)
    ---@type CDOTA_BaseNPC_Hero?
    local unit = EntIndexToHScript(keys.entindex)

    if not unit or unit:IsNull() then return end

    unit:AddNewModifier(unit, nil, "modifier_anim_translate_thinker", { duration = -1 })
end
