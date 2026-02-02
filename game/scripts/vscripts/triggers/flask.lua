require('internal.gameevents')

local OnRefillFlask = CreateGameEvent('OnRefillFlask')

function GiveItemFlask(_, event)
    print("123")
    local activator = event.activator
    if not activator or not activator:IsRealHero() then return end
    local pid = activator:GetPlayerID()
    PlayerResource:ReplaceHeroWith(pid, "npc_dota_hero_sanya_towel_master", 0, 0)
    print("[trigger_flask] changed hero to towel master)")
end

function GiveItemRecipe(_, event)
    print("234")
    local activator = event.activator
    if not activator or not activator:IsRealHero() then return end
    activator:AddItemByName('item_sanya_flask_upgrade_recipe')
    for i = 0, 29 do
        activator:HeroLevelUp( false )
    end
end

function StartRefillFlask(_, event)
    local activator = event.activator
    if not activator or not activator:IsRealHero() then return end
    OnRefillFlask({
        hero = activator
    })
end