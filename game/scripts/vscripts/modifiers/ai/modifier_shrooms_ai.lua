LinkLuaModifier("modifier_shrooms_underground", "modifiers/ai/modifier_shrooms_ai", LUA_MODIFIER_MOTION_NONE)
modifier_shrooms_ai = class({})

function modifier_shrooms_ai:OnCreated()
    if not IsServer() then return end
    local unit = self:GetParent()
    unit:SetRenderAlpha(0)
    local unitName = unit:GetUnitName()
    local kv = GetUnitKeyValuesByName(unitName)
    local mushroom_model = "models/creeps/lane_creeps/creep_radiant_melee/radiant_melee_mushroom.vmdl"
    self.undergroundDepth = 78
    self.isSecondGroup = string.match(unitName, "_second") ~= nil
    if kv then
        local creepType = kv["JungleShroomCreepType"] or "melee"
        if creepType ~= 'melee' then
            mushroom_model = "models/creeps/lane_creeps/creep_radiant_ranged/radiant_ranged_mushroom.vmdl"
            self.undergroundDepth = 95
        end
    end

    self.isUnderground = true
    self.isRising = false
    local pos = unit:GetAbsOrigin()
    unit:SetAbsOrigin(pos - Vector(0, 0, self.undergroundDepth))
    self.mushroom_prop = SpawnEntityFromTableSynchronous("prop_dynamic", {
        model = mushroom_model,
    })
    self.mushroom_prop:FollowEntity(unit, true)
    unit:AddNewModifier(unit, nil, "modifier_shrooms_underground", {})
end

function modifier_shrooms_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    local target = beaconData.target

    if self.isUnderground then
        local shouldRise = false
        if not self.isSecondGroup and beaconState == 'aggro' and target and target:IsAlive() then
            shouldRise = true
        end
        if self.isSecondGroup and beaconData.furionCallsSecondWave then
            shouldRise = true
        end

        if shouldRise then
            self.isUnderground = false
            self:RiseUp(beaconData)
            return 0.1
        end
        return BATTLE_THINK_INTERVAL
    end

    if self.isRising then
        return 0.1
    end
    if not DefaultAiTick(unit) then
        -- деремся сука
        if beaconState == 'aggro' and target and target:IsAlive() then
            local currentTime = GameRules:GetGameTime()

            if unit:IsChanneling() or unit:GetCurrentActiveAbility() then
                return BATTLE_THINK_INTERVAL
            end

            local timeInAggro = currentTime - (unit.aggroStartTime or 0)
            unit.lastCastTime = unit.lastCastTime or 0

            if timeInAggro >= 3 and (currentTime - unit.lastCastTime) >= 2 then
                if CastAllAbilities(unit, target) then
                    unit.lastCastTime = currentTime
                    return BATTLE_THINK_INTERVAL
                end
            end
            --print(unit:GetAbilityByIndex(0):GetCooldown())
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

function modifier_shrooms_ai:RiseUp(beaconData)
    local unit = self:GetParent()
    self.isRising = true
    if not beaconData.shroomsAreRising then
        beaconData.shroomsAreRising = true
    end
    EmitSoundOn('Hero_NyxAssassin.Burrow.In', unit)

    local duration = 3.0
    local steps = 40
    local pfx = ParticleManager:CreateParticle("particles/shrooms_dig.vpcf", PATTACH_WORLDORIGIN, unit)
    local unit_x = unit:GetAbsOrigin().x
    local unit_y = unit:GetAbsOrigin().y
    local pos_z = unit:GetAbsOrigin().z + self.undergroundDepth
    ParticleManager:SetParticleControl(pfx, 0, Vector(unit_x, unit_y, pos_z))
    ParticleManager:SetParticleControl(pfx, 4, Vector(duration, 0, 0))
    ParticleManager:ReleaseParticleIndex(pfx)
    local stepPos = self.undergroundDepth / steps
    for i = 1, steps do
        Timers:CreateTimer(i * (duration / steps), function()
            if unit and not unit:IsNull() and unit:IsAlive() then
                local currentPos = unit:GetAbsOrigin()
                unit:SetAbsOrigin(currentPos + Vector(0, 0, stepPos))
                if i == steps then
                    self.isRising = false
                    if beaconData.shroomsAreRising then
                        beaconData.shroomsAreRising = false
                    end
                    FindClearSpaceForUnit(unit, unit:GetAbsOrigin(), true)
                    unit:RemoveModifierByName("modifier_shrooms_underground")
                end
            end
        end)
    end
end

function modifier_shrooms_ai:OnDestroy()
    if not IsServer() then return end
    if self.mushroom_prop and not self.mushroom_prop:IsNull() then
        self.mushroom_prop:RemoveSelf()
    end
end

------------------------
modifier_shrooms_underground = class({})

function modifier_shrooms_underground:CheckState()
    return {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_FROZEN] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_ATTACK_IMMUNE] = true,
    }
end

function modifier_shrooms_underground:IsHidden() return true end

function modifier_shrooms_underground:IsPurgable() return false end
