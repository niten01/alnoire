modifier_default_creep_ai = class({})

function modifier_default_creep_ai:IsHidden() return true end

function modifier_default_creep_ai:IsPurgable() return false end

function modifier_default_creep_ai:SetThinking(bval)
    if not IsServer() then return end
    if not self:GetParent() then return end
    local unit = self:GetParent()
    if not unit:IsAlive() then return end
    unit:Stop()
    unit:SetIdleAcquire(false)
    unit:SetAcquisitionRange(0)
    if unit:HasModifier('modifier_story_npc') then
        unit:RemoveModifierByName('modifier_story_npc')
    end
    if unit:GetTeam() ~= DOTA_TEAM_BADGUYS then
        unit:SetTeam(DOTA_TEAM_BADGUYS)
    end

    RemoveAllIdleModifiers(unit)

    if bval then
        self:StartIntervalThink(BATTLE_THINK_INTERVAL)
    else
        self:StartIntervalThink(-1)
    end
end

function modifier_default_creep_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    local target = beaconData.target

    if not DefaultAiTick(unit) then
        -- деремся сука
        if beaconState == 'aggro' and target and target:IsAlive() then
            local currentTime = GameRules:GetGameTime()

            if unit:IsChanneling() or unit:GetCurrentActiveAbility() then
                return BATTLE_THINK_INTERVAL
            end

            local timeInAggro = currentTime - (unit.aggroStartTime or 0)
            unit.lastCastTime = unit.lastCastTime or 0

            if timeInAggro >= 5 and (currentTime - unit.lastCastTime) >= 2 then
                if CastAllAbilities(unit, target) then
                    unit.lastCastTime = currentTime
                    return BATTLE_THINK_INTERVAL
                end
            end
            if not unit:GetAggroTarget() then
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                    Position = target:GetAbsOrigin(),
                    Queue = false,
                })
            end
        else
        end
    end

    AdjustTickRate(unit)
    self:StartIntervalThink(beaconData.currentCreepInterval)
end
