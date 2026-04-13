SummonInventory = class {}

function SummonInventory:Init()
    GameEvents:OnEntityKilled(function(event)
        local killedUnit = event.killed_unit
        if killedUnit:GetUnitName() ~= "towel_summon" then return end
        self:SaveSummonInventory(killedUnit)
    end)

    GameEvents:OnTowelSummonInGame(function(spawnedUnit)
        if not IsServer() then return end
        if spawnedUnit:GetUnitName() ~= "towel_summon" then return end
        Timers:CreateTimer(0.3, function()
            SummonInventory:ReturnInventory(spawnedUnit)
        end)
    end)
end

function SummonInventory:ReturnInventory(spawnedUnit)
    local owner = spawnedUnit:GetOwner()

    if owner and owner.summonItemStash then
        for _, item in ipairs(owner.summonItemStash) do
            if not item:IsNull() then
                item:RemoveEffects(EF_NODRAW)
                spawnedUnit:AddItem(item)
            end
        end
        owner.summonItemStash = {}
    end
end

function SummonInventory:SaveSummonInventory(summonUnit)
    local owner = summonUnit:GetOwner()

    if owner and owner:IsRealHero() then
        owner.summonItemStash = {}

        for i = 0, 14 do
            local item = summonUnit:GetItemInSlot(i)
            if item then
                summonUnit:TakeItem(item)
                table.insert(owner.summonItemStash, item)

                item:SetParent(owner, "")
                item:AddEffects(EF_NODRAW)
            end
        end
        PrintTable(owner.summonItemStash)
    end
end

return SummonInventory
