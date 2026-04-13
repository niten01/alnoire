SummonInventory = class {}

function SummonInventory:Init()
    GameEvents:OnEntityKilled(function(event)
        local killedUnit = event.killed_unit
        DebugPrint(killedUnit:GetUnitName())
        if killedUnit:GetUnitName() ~= "towel_summon" then return end
        self:SaveSummonInventory(killedUnit)
    end)

    GameEvents:OnTowelSummonInGame(function(spawnedUnit)
        if spawnedUnit:GetUnitName() ~= "towel_summon" then return end

        local owner = spawnedUnit:GetOwner()
        DebugPrint(owner)
        PrintTable(owner.summonItemStash or {})

        if owner and owner.summonItemStash then
            for _, item in ipairs(owner.summonItemStash) do
                if not item:IsNull() then
                    DebugPrint(item:GetName())
                    item:RemoveEffects(EF_NODRAW)
                    spawnedUnit:AddItem(item)
                end
            end
            owner.summonItemStash = {}
        end
    end)
end

function SummonInventory:SaveSummonInventory(summonUnit)
    local owner = summonUnit:GetOwner()

    if owner and owner:IsRealHero() then
        owner.summonItemStash = {}

        for i = 0, 14 do
            local item = summonUnit:GetItemInSlot(i)
            DebugPrint(item)
            if item then
                summonUnit:TakeItem(item)
                table.insert(owner.summonItemStash, item)

                item:SetParent(owner, "")
                item:AddEffects(EF_NODRAW)
            end
        end
    end
end

return SummonInventory
