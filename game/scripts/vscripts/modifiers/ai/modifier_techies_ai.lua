modifier_techies_ai = class({})

function modifier_techies_ai:IsHidden() return true end

function modifier_techies_ai:IsPurgable() return false end

function modifier_techies_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
        MODIFIER_EVENT_ON_ABILITY_START,
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_techies_ai:OnCreated()
    if not IsServer() then return end
    local unit = self:GetParent()
    local unitName = unit:GetUnitName()
    local kv = GetUnitKeyValuesByName(unitName)
    if kv then
        local soundIndex = kv["JungleTechSoundIndex"] or "One"
        local tauntName = kv['JungleTechTauntName'] or "ACT_DOTA_VICTORY"
        self.tauntNum = _G[tauntName] or ACT_DOTA_VICTORY
        self.laughName = "JungleTech.Laugh." .. soundIndex
        self.deathName = "JungleTech.Death." .. soundIndex
    end
end

function modifier_techies_ai:CheckState()
    return {
        [MODIFIER_STATE_FORCED_FLYING_VISION] = true,
    }
end

function modifier_techies_ai:OnAbilityFullyCast(event)
    if event.unit == self:GetParent() then
        self.bHappened = true
        self.timeToTaunt = nil
        self.timeToTeleport = nil
    end
end

function modifier_techies_ai:OnAbilityStart(event)
    if event.unit == self:GetParent() then
        self.bAbilityStarted = true
        self.bIsCastingNow = false
    end
end

function modifier_techies_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    local target = beaconData.target
    if not self.bHappened and not self.bAbilityStarted and not self.bIsCastingNow and beaconState == 'aggro' and target and target:IsAlive() then
        self.bIsCastingNow = true
        if self.laughName then
            EmitSoundOn(self.laughName, unit)
        end
        local targetPos = target:GetAbsOrigin()
        local leadTime = 1.2
        local castPos = targetPos
        -- local targetVel = target:GetForwardVector() * target:GetIdealSpeed()
        -- local castPos = targetPos + targetVel * leadTime


        if target:IsMoving() then
            local currentSpeed = target:GetIdealSpeed()
            local targetDir = target:GetForwardVector()
            local targetVel = targetDir * currentSpeed
            local predictedPos = targetPos + targetVel * leadTime
            local bPathClear = GridNav:CanFindPath(targetPos, predictedPos)
            local bPointBlocked = GridNav:IsBlocked(predictedPos)
            local bTraversable = GridNav:IsTraversable(predictedPos)
            print(bPathClear)
            print(bPointBlocked)
            print(bTraversable)

            if bPathClear and not bPointBlocked and bTraversable then
                castPos = predictedPos
            else
                castPos = targetPos
            end
        end

        local abil = unit:GetAbilityByIndex(0)
        ExecuteOrderFromTable({
            UnitIndex = unit:entindex(),
            OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
            AbilityIndex = abil:entindex(),
            Position = castPos,
            Queue = false,
        })
    elseif self.bHappened then
        if not self.timeToTaunt then
            self.timeToTaunt = GameRules:GetGameTime() + 0.5
        end
        if GameRules:GetGameTime() >= self.timeToTaunt and not self.tauning then
            if self.tauntNum then
                unit:StartGestureWithFade(self.tauntNum, 0.3, 0)
            end
            self.tauning = true
            self.timeToTeleport = GameRules:GetGameTime() + 4.0
        end
        if self.timeToTeleport and GameRules:GetGameTime() >= self.timeToTeleport then
            if unit.spawnPos then
                self:TechiesPoofOut(unit)
                unit:FadeGesture(ACT_DOTA_VICTORY)
            end
        end
    end

    AdjustTickRate(unit)
    self:StartIntervalThink(beaconData.currentCreepInterval)
end

function modifier_techies_ai:TechiesPoofOut(unit)
    if not IsServer() or not unit then return end
    if not unit:IsAlive() then return end
    local oldPos = unit:GetAbsOrigin()
    local pfx = ParticleManager:CreateParticle("particles/techies_poofout.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, oldPos)
    ParticleManager:ReleaseParticleIndex(pfx)
    EmitSoundOn("Hero_MonkeyKing.Transform.Off", unit)
    FindClearSpaceForUnit(unit, unit.spawnPos, true)
    self.bHappened = false
    self.bAbilityStarted = false
    self.bIsCastingNow = false
    self.tauning = false
    self.timeToTaunt = nil
    self.timeToTeleport = nil
end

function modifier_techies_ai:OnDeath(params)
    if not IsServer() then return end
    local killedUnit = params.unit
    local parent = self:GetParent()
    if killedUnit == parent then
        EmitSoundOn(self.deathName, parent)
    end
end
