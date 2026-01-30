require('internal.gameevents')

local OnRefillFlask = CreateGameEvent('OnRefillFlask')

function GiveItemFlask(_, event)
    print("123")
    local activator = event.activator
    if not activator or not activator:IsRealHero() then return end
    activator:AddItemByName('item_sanya_flask')
end

function GiveItemRecipe(_, event)
    print("234")
    local activator = event.activator
    if not activator or not activator:IsRealHero() then return end
    activator:AddItemByName('item_sanya_flask_upgrade_recipe')
end

function StartRefillFlask(_, event)
    local activator = event.activator
    if not activator or not activator:IsRealHero() then return end
    OnRefillFlask({
        hero = activator
    })
end