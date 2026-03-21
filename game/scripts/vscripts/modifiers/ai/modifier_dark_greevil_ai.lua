LinkLuaModifier("modifier_greevil_underground", "modifiers/ai/modifier_dark_greevil_ai", LUA_MODIFIER_MOTION_NONE)

modifier_dark_greevil_ai = class({})

function modifier_dark_greevil_ai:OnCreated()
    if not IsServer() then return end
    local unit = self:GetParent()

    self.undergroundDepth = 120
    self.isUnderground = true
    self.isRising = false
    self.unitSpawnTargetName = unit.spawnerName or ""
    self.isSecondGroup = string.find(self.unitSpawnTargetName, "second") ~= nil
    self.spawnIndex = string.match(self.unitSpawnTargetName, "%d+") or "0"

    unit:AddNoDraw()
    unit:AddNewModifier(unit, nil, "modifier_greevil_underground", {})

    self.mushroom_prop = SpawnEntityFromTableSynchronous("prop_dynamic", {
        model = unit:GetModelName(),
        origin = unit:GetAbsOrigin() - Vector(0, 0, self.undergroundDepth),
        angles = unit:GetAnglesAsVector(),
    })
end

function modifier_dark_greevil_ai:OnIntervalThink()
    if not IsServer() then return end
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end

    local beaconData = unit.packTargetData
    if not beaconData then return end

    local beaconState = beaconData.state
    local target = beaconData.target

    if self.isRising then
        return 0.1
    end

    if self.isUnderground then
        local shouldRise = false

        if not self.isSecondGroup then
            if beaconState == 'aggro' and target and target:IsAlive() then
                shouldRise = true
            end
        else
            local triggerKey = "rise_second_wave_" .. self.spawnIndex
            if beaconData[triggerKey] then
                shouldRise = true
            end
        end

        if shouldRise then
            self.isUnderground = false
            self:RiseUp(beaconData)
            return 0.1
        end

        return 0.5
    end

    if not DefaultAiTick(unit) then
        if beaconState == 'aggro' and target and target:IsAlive() then
            if not unit:GetAggroTarget() then
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                    Position = target:GetAbsOrigin(),
                    Queue = false,
                })
            end
        end
    end

    AdjustTickRate(unit)
    self:StartIntervalThink(beaconData.currentCreepInterval or 0.5)
end

function modifier_dark_greevil_ai:RiseUp(beaconData)
    local unit = self:GetParent()
    if not unit or unit:IsNull() then return end

    self.isRising = true
    EmitSoundOn('Hero_NyxAssassin.Burrow.In', unit)

    local duration = 2.0
    local steps = 70
    local stepPos = self.undergroundDepth / steps

    local pfx = ParticleManager:CreateParticle("particles/shrooms_dig.vpcf", PATTACH_WORLDORIGIN, nil)
    local surface_pos = unit:GetAbsOrigin()
    ParticleManager:SetParticleControl(pfx, 0, surface_pos)
    ParticleManager:SetParticleControl(pfx, 4, Vector(duration, 0, 0))
    ParticleManager:ReleaseParticleIndex(pfx)

    for i = 1, steps do
        Timers:CreateTimer(i * (duration / steps), function()
            if not unit or unit:IsNull() or not unit:IsAlive() then
                if self.mushroom_prop and not self.mushroom_prop:IsNull() then self.mushroom_prop:RemoveSelf() end
                return
            end

            if self.mushroom_prop and not self.mushroom_prop:IsNull() then
                local currentPropPos = self.mushroom_prop:GetAbsOrigin()
                self.mushroom_prop:SetAbsOrigin(currentPropPos + Vector(0, 0, stepPos))
            end

            if i == steps then
                self.isRising = false
                self.isUnderground = false

                if self.mushroom_prop and not self.mushroom_prop:IsNull() then
                    self.mushroom_prop:RemoveSelf()
                    self.mushroom_prop = nil
                end
                FindClearSpaceForUnit(unit, unit:GetAbsOrigin(), true)
                Timers:CreateTimer(0.01, function()
                    unit:RemoveNoDraw()
                end)
                unit:RemoveModifierByName("modifier_greevil_underground")
            end
        end)
    end
end

function modifier_dark_greevil_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_dark_greevil_ai:OnDeath(params)
    if not IsServer() then return end
    local unit = self:GetParent()
    local beaconData = unit.packTargetData

    if params.unit == unit and not self.isSecondGroup and beaconData then
        local triggerKey = 'rise_second_wave_' .. self.spawnIndex
        beaconData[triggerKey] = true
    end
end

function modifier_dark_greevil_ai:OnDestroy()
    if not IsServer() then return end
    if self.mushroom_prop and not self.mushroom_prop:IsNull() then
        self.mushroom_prop:RemoveSelf()
    end
end

---------------------
---
modifier_greevil_underground = class({})

function modifier_greevil_underground:IsHidden() return true end

function modifier_greevil_underground:IsPurgable() return false end

function modifier_greevil_underground:CheckState()
    return {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_FROZEN] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_ATTACK_IMMUNE] = true,
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end
