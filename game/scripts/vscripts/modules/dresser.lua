Dresser = Dresser or {}

local function AttachCustomWearable(hero, modelPath)
    if not IsServer() or not hero then return end

    local wearable = SpawnEntityFromTableSynchronous("prop_dynamic", {
        model = modelPath,
    })

    wearable:FollowEntity(hero, true)
    return wearable
end

function Dresser:Init()
    self.classWearables = {
        ["npc_dota_hero_sanya"] = {
            "models/sanya/wearables/sanya_armor_casual.vmdl"
        }
    }

    -- GameEvents:OnHeroInGame(function(hero)
    --     if not IsServer() then return end
    --     local defaultWearables = self.classWearables[hero:GetUnitName()]
    --     for _, wearablePath in ipairs(defaultWearables) do
    --         AttachCustomWearable(hero, wearablePath)
    --     end
    -- end)
end

return Dresser
