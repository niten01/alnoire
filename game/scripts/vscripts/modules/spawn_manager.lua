SpawnManager = SpawnManager or class {}

function SpawnManager:Init(game)
    self.game = game

    self.classDefaultWearables = {
        npc_dota_hero_sanya = {
            
        }
    }

    GameEvents:OnHeroInGame(bind(self.OnHeroInGame, self))
end

function SpawnManager:OnHeroInGame(hero)
    if not IsServer() then return end

    hero:AddNewModifier(hero, nil, "modifier_anim_translate_thinker", { duration = -1 })
end

return SpawnManager
