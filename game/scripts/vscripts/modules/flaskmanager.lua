FlaskManager = FlaskManager or {}

function FlaskManager:Init()
    ChatCommand:LinkDevCommand("-giveeldenflask", function(event, args)
        local playerID = event.playerid
        local hero = PlayerResource:GetSelectedHeroEntity(playerID)

        if hero then
            hero:AddItemByName("item_sanya_flask")
        end
    end)

    ChatCommand:LinkDevCommand("-refillelden", function(event, args)
        self:RefillFlask()
    end)
end

function FlaskManager:RefillFlask()
    local hero = PlayerResource:GetSelectedHeroEntity(0)
    assert(hero, "No hero was found for flask refill")
    local item = hero:FindItemInInventory('item_sanya_flask')
    local item1 = hero:FindItemInInventory('item_sanya_flask_upgrade_1')
    if not item and not item1 then return end
    local flask = item or item1
    if not flask then return end
    flask:SetCurrentCharges(flask:GetInitialCharges())
    flask:EndCooldown()
end

return FlaskManager
