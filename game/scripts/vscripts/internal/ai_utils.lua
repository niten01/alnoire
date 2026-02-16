function MoveHome(unit)
    if not IsServer() or not unit or unit:IsNull() then return end
    if unit:GetCurrentActiveAbility() then return end
    if not unit.spawnPos then return end

    local dist = (unit:GetAbsOrigin() - unit.spawnPos):Length2D()
    if dist > 50 then
        unit:MoveToPosition(unit.spawnPos)
    end
end

function CastAllAbilities(unit, target)
    if unit:IsSilenced() or unit:IsStunned() then return false end
    local currentAbility = unit:GetCurrentActiveAbility()
    if currentAbility then return currentAbility end
    local abilityCount = unit:GetAbilityCount()
    for i = 0, abilityCount - 1 do
        local ability = unit:GetAbilityByIndex(i)
        print('abil ' .. ability:GetName())
        if ability and ability:IsActivated() and ability:IsFullyCastable() and not ability:IsPassive() then
            local range = ability:GetCastRange(unit:GetAbsOrigin(), target)
            local dist = (unit:GetAbsOrigin() - target:GetAbsOrigin()):Length2D()
            if dist <= (range + 100) then
                local behavior = ability:GetBehavior()
                print(behavior)
                if bit.band(behavior, DOTA_ABILITY_BEHAVIOR_HIDDEN) ~= 0 then goto continue end

                if bit.band(behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 then
                    unit:CastAbilityOnTarget(target, ability, -1)
                elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 then
                    unit:CastAbilityNoTarget(ability, -1)
                elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_POINT) ~= 0 then
                    unit:CastAbilityOnPosition(target:GetAbsOrigin(), ability, -1)
                end
                return ability
            end
        end
        ::continue::
    end
    return false
end

function SetAllAbilitiesCooldown(unit, fcooldown)
    for i = 0, unit:GetAbilityCount() - 1 do
        local ab = unit:GetAbilityByIndex(i)
        if ab and not ab:IsPassive() then
            local cd = ab:GetCooldownTimeRemaining()
            if cd > fcooldown then
                ab:StartCooldown(fcooldown)
                unit.lastCastTime = GameRules:GetGameTime()
            end
        end
    end
end

function AnyAlive(packTargetData)
    if not IsServer() then return end
    if not packTargetData then return end
    local hasAliveUnits = false
    if packTargetData.units then
        for i = #packTargetData.units, 1, -1 do
            local u = packTargetData.units[i]
            if u and not u:IsNull() and u:IsAlive() then
                hasAliveUnits = true
                break
            end
        end
    end

    return hasAliveUnits
end

function DrawDebugCircle(entity, radius)
    if not IsServer() then return end
    if not entity or not radius then return end
    local pfx = ParticleManager:CreateParticle("particles/sanya_debug_radius_ring.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, entity:GetAbsOrigin() + Vector(0, 0, 50))
    ParticleManager:SetParticleControl(pfx, 2, Vector(radius, 0, 50))
    return pfx
end

function DestroyDebugCircle(pfx)
    ParticleManager:DestroyParticle(pfx, false)
    ParticleManager:ReleaseParticleIndex(pfx)
end

function FindSanyaInRadius(centerPoint, radius)
    local units = FindUnitsInRadius(
        DOTA_TEAM_BADGUYS,
        centerPoint,
        nil,
        radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO,
        DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
        FIND_CLOSEST,
        false
    )

    for _, unit in pairs(units) do
        if unit:IsRealHero() and unit:GetPlayerOwnerID() ~= -1 and not unit:IsSpiritBearCustom() then
            return unit
        end
    end

    return nil
end

function RemoveAllIdleModifiers(unit)
    if not IsServer() then return end
    if not unit or unit:IsNull() or not unit:IsAlive() then return end
    local modifiers = unit:FindAllModifiers()

    for _, mod in ipairs(modifiers) do
        local modName = mod:GetName()
        if modName and string.find(string.lower(modName), "idle") then
            unit:RemoveModifierByName(modName)
        end
    end
end

function SetAIModifierActive(modifier, bActive)
    if not IsServer() then return end
    if not modifier:GetParent() then return end
    local unit = modifier:GetParent()
    if not unit:IsAlive() then return end
    unit:Stop()
    unit:SetIdleAcquire(false)
    unit:SetAcquisitionRange(0)

    RemoveAllIdleModifiers(unit)

    if bActive then
        modifier:StartIntervalThink(BATTLE_THINK_INTERVAL)
        modifier:OnIntervalThink()
    else
        modifier:StartIntervalThink(-1)
    end
end

function DefaultAiTick(unit)
    if not IsServer() then return end
    if not unit or not unit:IsAlive() then return end

    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    if not beaconState or beaconState == 'off' or beaconState == 'dead' then return end

    local target = beaconData.target
    local currentPos = unit:GetAbsOrigin()
    local distToSpawn = (currentPos - unit.spawnPos):Length2D()

    if beaconState == 'aggro' then
        if not unit.aggroStartTime then
            unit.aggroStartTime = GameRules:GetGameTime()
        end
    else
        unit.aggroStartTime = nil
    end

    if beaconState == 'aggro' and target and target:IsAlive() then
        return false
    end

    -- бежим сука
    if beaconState == 'retreat' then
        MoveHome(unit)
    end

    -- стоим сука
    if beaconState == 'idle' then
        if distToSpawn > 150 then
            MoveHome(unit)
        end
    end

    if beaconState == 'retreat' or beaconState == 'idle' then
        unit:SetAcquisitionRange(0)
        if unit:GetHealthPercent() < 100 then
            unit:Heal(unit:GetMaxHealth() * 0.1, nil)
        end
    end
    return true
end

function AdjustTickRate(unit)
    if not IsServer() then return end
    if not unit or not unit:IsAlive() then return end

    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    if not beaconState or beaconState == 'off' or beaconState == 'dead' then return end

    local currentPos = unit:GetAbsOrigin()
    local distToSpawn = (currentPos - unit.spawnPos):Length2D()
    local target_interval = IDLE_THINK_INTERVAL
    if beaconState == 'aggro' or beaconState == 'retreat' or beaconData.somebodyNear or distToSpawn > 150 then
        target_interval = BATTLE_THINK_INTERVAL
    end
    if beaconData.currentCreepInterval ~= target_interval then
        beaconData.currentCreepInterval = target_interval
        print("AI Switch to interval: " .. target_interval)
    end
end
