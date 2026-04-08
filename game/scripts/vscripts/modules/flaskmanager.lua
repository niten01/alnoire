FlaskManager = FlaskManager or {}

function FlaskManager:Init()
    ChatCommand:LinkDevCommand("-giveeldenflask", function(event, args)
        local playerID = event.playerID
        local hero = PlayerResource:GetSelectedHeroEntity(playerID)

        if hero then
            hero:AddItemByName("item_sanya_flask")
        end
    end)

    ChatCommand:LinkDevCommand("-refillelden", function(event, args)
        self:RefillFlask(event.playerID)
    end)

    ChatCommand:LinkDevCommand("-giveeldenflaskseed", function(event, args)
        local playerID = event.playerID
        local hero = PlayerResource:GetSelectedHeroEntity(playerID)

        if hero then
            hero:AddItemByName("item_sanya_flask_seed")
        end
    end)

    GameEvents:OnInventoryThink(function(event)
        if event.item:GetName() ~= "item_sanya_flask" and
            event.item:GetName() ~= "item_sanya_flask_upgrade_1"
        then
            return
        end
        if event.slot == NEUTRAL_SLOT_IDX then return end

        local item = event.item
        event.hero:SwapItems(event.item:GetItemSlot(), NEUTRAL_SLOT_IDX)
    end)

    GameEvents:OnEntityKilled(function(event)
        local victim = event.killed_unit
        if victim:IsRealHero() and not victim:IsSpiritBearCustom() then
            local playerID = victim:GetPlayerOwnerID()
            self:RefillFlask(playerID)
        end
    end)
end

function FlaskManager:RefillFlask(playerID)
    local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
    assert(hero, "No hero was found for flask refill")
    local item = hero:FindItemInInventory('item_sanya_flask')
    local item1 = hero:FindItemInInventory('item_sanya_flask_upgrade_1')
    if not item and not item1 then return end
    local flask = item or item1
    if not flask then return end
    flask:SetCurrentCharges(flask:GetInitialCharges())
    flask:EndCooldown()
end

function FlaskManager:RefillOneCharge(playerID)
    local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
    assert(hero, "No hero was found for flask refill")
    local item = hero:FindItemInInventory('item_sanya_flask')
    local item1 = hero:FindItemInInventory('item_sanya_flask_upgrade_1')
    if not item and not item1 then return end
    local flask = item or item1
    if not flask then return end
    local oldCharges = flask:GetCurrentCharges()
    if oldCharges + 1 > flask:GetInitialCharges() then
        return
    end
    flask:SetCurrentCharges(oldCharges + 1)
    flask:EndCooldown()
end

return FlaskManager
