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
    if unit:IsSilenced() or unit:IsStunned() or unit:IsChanneling() then return false end
    local abilityCount = unit:GetAbilityCount()
    for i = 0, abilityCount - 1 do
        local ability = unit:GetAbilityByIndex(i)
        if ability and ability:IsActivated() and ability:IsFullyCastable() and not ability:IsPassive() then
            local range = ability:GetCastRange(unit:GetAbsOrigin(), target)
            local dist = (unit:GetAbsOrigin() - target:GetAbsOrigin()):Length2D()
            if dist <= (range + 100) then
                local behavior = ability:GetBehavior()
                if bit.band(behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 then
                    unit:CastAbilityOnTarget(target, ability, -1)
                elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 then
                    unit:CastAbilityNoTarget(ability, -1)
                elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_POINT) ~= 0 then
                    unit:CastAbilityOnPosition(target:GetAbsOrigin(), ability, -1)
                end
                return true
            end
        end
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