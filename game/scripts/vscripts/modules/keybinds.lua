-- Doesn't support abilities with targeting
Keybinds = Keybinds or class {}

function Keybinds:Init()
    ChatCommand:LinkCommand("-bindsprint", function(event, args)
        if not args or not args[1] then
            GameRules:SendCustomMessage("Usage: -bindsprint [key]", 0, 0)
        end
        local key = args[1]
        self:RegisterBind(event.playerID, "sanya_sprint", string.upper(key))
    end)

    CustomGameEventManager:RegisterListener("keybind_cast_ability", bind(self.OnKeybindCastAbility, self))
    GameEvents:OnHeroInGame(bind(self.OnHeroInGame, self))
end

function Keybinds:OnHeroInGame(hero)
    if not IsServer() then return end
    if hero:GetUnitName() == "npc_dota_hero_sanya_logarithmus" then
        self:RegisterBind(hero:GetPlayerOwnerID(), "sanya_sprint", "G")
    end
end

function Keybinds:OnKeybindCastAbility(_, event)
    local playerID = event.PlayerID
    local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
    assert(hero)

    local ability = hero:FindAbilityByName(event.abilityName)
    assert(ability, "No such ability: " .. event.abilityName)
    GiveCastOrderSimple(hero, hero:GetCursorCastTarget() or hero:GetCursorPosition(), ability)
end

function GetAbilityIndexInLayout(unit, abilityHandle)
    for i = 0, unit:GetAbilityCount() - 1 do
        local currentAbility = unit:GetAbilityByIndex(i)
        if currentAbility == abilityHandle then
            return i
        end
    end
    return nil
end

function Keybinds:RegisterBind(playerID, abilityName, key)
    local player = PlayerResource:GetPlayer(playerID)
    assert(player, "No player for ID: " .. tostring(playerID))
    local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
    assert(hero)

    local layoutIndex = GetAbilityIndexInLayout(hero, hero:FindAbilityByName(abilityName))
    assert(layoutIndex)

    CustomGameEventManager:Send_ServerToPlayer(player, "keybind_register_bind", {
        abilityName = abilityName,
        key = key,
        layoutIndex = layoutIndex
    })
    DebugPrint("[ALNOIRE] Registered keybind: " .. abilityName .. " - " .. key)
end

return Keybinds
