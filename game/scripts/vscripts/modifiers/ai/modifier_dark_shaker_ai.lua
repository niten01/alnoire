modifier_dark_shaker_ai = class({})

function modifier_dark_shaker_ai:IsHidden() return true end

function modifier_dark_shaker_ai:IsPurgable() return false end

function modifier_dark_shaker_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_dark_shaker_ai:OnDeath(params)
    local parent = self:GetParent()
    if string.find(params.unit:GetUnitName(), "npc_dark_shaker") then
        self.goCastEcho = true
    end

    if not self.customDeathSound then return end
    if params.unit == parent then
        EmitSoundOn(self.customDeathSound, parent)
    end
end

function modifier_dark_shaker_ai:OnCreated()
    if not IsServer() then return end
    local unit = self:GetParent()
    unit:SetIdleAcquire(false)
    unit:SetAcquisitionRange(0)


    self.jumpTargets = {}
    self.currentJumpIndex = 1
    local unitName = unit:GetUnitName()
    local kv = GetUnitKeyValuesByName(unitName)
    if kv then
        self.customDeathSound = kv["CustomDeathSound"]
        self.requiredTimeInAggroOffset = kv["RequiredTimeInAggroOffset"]
        local posSequenceStr = kv["posSequence"] or '1234'
        local targetNames = {
            "dark_shaker_target_1",
            "dark_shaker_target_2",
            "dark_shaker_target_3",
            "dark_shaker_target_4",
            "dark_shaker_target_5",
        }

        for digit in string.gmatch(posSequenceStr, "%d") do
            local targetIdx = tonumber(digit)
            if targetIdx and targetNames[targetIdx] then
                local ent = Entities:FindByName(nil, targetNames[targetIdx])
                if ent then
                    table.insert(self.jumpTargets, ent)
                end
            end
        end
    end
end

function modifier_dark_shaker_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    local target = beaconData.target

    if DefaultAiTick(unit) then
        AdjustTickRate(unit)
        self:StartIntervalThink(beaconData.currentCreepInterval)
        return
    end

    -- деремся сука
    if beaconState == 'aggro' and target and target:IsAlive() then
        local currentTime = GameRules:GetGameTime()

        if self.goCastEcho then
            if CastAbility(unit, target, "earthshaker_echo_slam") then
                unit.lastCastTime = currentTime
                self.goCastEcho = false
                return
            end
        end

        local timeInAggro = currentTime - (unit.aggroStartTime or 0)
        unit.lastCastTime = unit.lastCastTime or 0

        if IsCasting(unit) then return end

        local requiredTimeInAggro = 2.5
        if self.requiredTimeInAggroOffset then
            requiredTimeInAggro = requiredTimeInAggro + self.requiredTimeInAggroOffset
        end
        local requiredDelay = 1.0
        if timeInAggro >= requiredTimeInAggro and (currentTime - unit.lastCastTime) >= requiredDelay then
            if #self.jumpTargets > 0 then
                local targetJump = self.jumpTargets[self.currentJumpIndex]
                if targetJump and CastAbility(unit, targetJump, "earthshaker_enchant_totem") then
                    unit.lastCastTime = currentTime
                    self.currentJumpIndex = self.currentJumpIndex + 1
                    if self.currentJumpIndex > #self.jumpTargets then
                        self.currentJumpIndex = 1
                    end
                    return
                end
            end
        end
    else
    end
end
