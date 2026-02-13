modifier_default_creep_ai = class({})

function modifier_default_creep_ai:IsHidden() return true end
function modifier_default_creep_ai:IsPurgable() return false end

function modifier_default_creep_ai:OnCreated()
    if not IsServer() then return end
    if not self:GetParent() then return end
end

function modifier_default_creep_ai:SetThinking(bval)
    if not IsServer() then return end
    if not self:GetParent() then return end
    local unit = self:GetParent()
    if not unit:IsAlive() then return end
    local unit = self:GetParent()
    unit:SetIdleAcquire(false)
    unit:SetAcquisitionRange(0)
    unit:Stop()
    if unit:HasModifier('modifier_story_npc') then
        unit:RemoveModifierByName('modifier_story_npc')
    end

    if bval then
        self:StartIntervalThink(BATTLE_THINK_INTERVAL)
    else
        self:StartIntervalThink(-1)
    end
end

function modifier_default_creep_ai:OnIntervalThink()
    print("UNIT THINKING")
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return BATTLE_THINK_INTERVAL end

    local beaconState = beaconData.state
    if not beaconState or beaconState == 'off' or beaconState == 'dead' then return IDLE_THINK_INTERVAL end

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

    -- деремся сука
    if beaconState == 'aggro' and target and target:IsAlive() then
        if distToSpawn > beaconData.rangeRetreat then 
            MoveHome(unit)
        else
            local currentTime = GameRules:GetGameTime()
            
            if unit:IsChanneling() or unit:GetCurrentActiveAbility() then
                return BATTLE_THINK_INTERVAL 
            end

            local timeInAggro = currentTime - (unit.aggroStartTime or 0)
            unit.lastCastTime = unit.lastCastTime or 0

            if timeInAggro >= 5 and (currentTime - unit.lastCastTime) >= 2 then
                if CastAllAbilities(unit, target)  then
                    unit.lastCastTime = currentTime
                    return BATTLE_THINK_INTERVAL 
                end
            end
            if unit:GetAggroTarget() ~= target then
                unit:MoveToTargetToAttack(target)
            end
        end

    -- бежим сука
    elseif beaconState == 'retreat' then
        MoveHome(unit)

    -- стоим сука
    elseif beaconState == 'idle' then
        if distToSpawn > 150 then
            MoveHome(unit)
        end
    end

    if beaconState == 'retreat' or beaconState == 'idle' then
        if unit:GetHealthPercent() < 100 then
            unit:Heal(unit:GetMaxHealth() * 0.1, nil)
        end
    end

    if beaconState == 'aggro' or beaconState == 'retreat' or beaconData.somebodyNear or distToSpawn > 150 then
        --print('крип battle!')
        return BATTLE_THINK_INTERVAL
    end
    --print('крип idle!')
    return IDLE_THINK_INTERVAL
end
