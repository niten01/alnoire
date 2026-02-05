if not IsServer() then return end

function Spawn(kv)
    if not thisEntity or not IsServer() then return end
    thisEntity.spawn_pos = thisEntity:GetAbsOrigin()
    thisEntity.aggro_range = 500
    thisEntity.leash_range = 1000
    thisEntity.ability_delay = 5
    thisEntity.activation_range = 1500
    thisEntity.home_padding = 100
    thisEntity.home_minimal_padding = 50
    thisEntity.state = "IDLE"



    thisEntity:SetIdleAcquire(false)
    thisEntity:SetAcquisitionRange(0)
    thisEntity:Stop()
    -- thisEntity:SetDayTimeVisionRange(thisEntity.aggro_range)
    -- thisEntity:SetNightTimeVisionRange(thisEntity.aggro_range)
    thisEntity:SetContextThink("DefaultCreepThink", DefaultCreepThink, IDLE_THINK_INTERVAL)
end

function DefaultCreepThink()
    if not thisEntity:IsAlive() then return end
    print(thisEntity.state)
    if not thisEntity.spawn_pos or thisEntity.spawn_pos == Vector(0,0,0) then
        thisEntity.spawn_pos = thisEntity:GetAbsOrigin()
    end

    local current_pos = thisEntity:GetAbsOrigin()
    local dist_from_home = (current_pos - thisEntity.spawn_pos):Length2D()

    local nearby_enemies = FindUnitsInRadius(
        thisEntity:GetTeamNumber(),
        current_pos,
        nil,
        thisEntity.activation_range,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
        FIND_ANY_ORDER,
        false
    )
    if #nearby_enemies == 0 and thisEntity.state == "IDLE" and dist_from_home <= thisEntity.home_minimal_padding then
        return IDLE_THINK_INTERVAL
    end 

    if dist_from_home > thisEntity.leash_range or thisEntity.state == "RETURNING" then
        thisEntity.state = "RETURNING"
        local regen = thisEntity:GetMaxHealth() * CREEPS_RETURNING_HEALING_PERCENT * BATTLE_THINK_INTERVAL
        thisEntity:Heal(regen, nil)
        print('healing for' .. regen)
        thisEntity:MoveToPosition(thisEntity.spawn_pos)
        if dist_from_home < thisEntity.home_padding then
            thisEntity.state = "IDLE"
            return IDLE_THINK_INTERVAL
        end
        return BATTLE_THINK_INTERVAL
    end

    local target = nil
    for _, enemy in pairs(nearby_enemies) do
        local d = (enemy:GetAbsOrigin() - current_pos):Length2D()
        if d <= thisEntity.aggro_range then
            target = enemy
            break
        else
        end
    end

    if target then
        thisEntity.state = "AGGRO"
        thisEntity:MoveToTargetToAttack(target)
        return BATTLE_THINK_INTERVAL
    else
        if thisEntity.state == "AGGRO" then
            thisEntity.state = "IDLE"
            thisEntity:MoveToPosition(thisEntity.spawn_pos)
        end
        return BATTLE_THINK_INTERVAL
    end
end