modifier_slark_ai = class({})

function modifier_slark_ai:IsHidden() return true end

function modifier_slark_ai:IsPurgable() return false end

function modifier_slark_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH,
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
end

function modifier_slark_ai:OnTakeDamage(params)
    if not IsServer() then return end
    local unit = self:GetParent()
    local maxExtend = 10.0
    if self.isToggleActive and params.unit == self:GetParent() then
        local currentTime = GameRules:GetGameTime()
        if unit.lastPhraseTime == nil or currentTime - unit.lastPhraseTime >= 1.5 then
            EmitSoundOn('Slark.Hit.Phrases', unit)
            unit.lastPhraseTime = currentTime
        end
        local oldTime = self.nextToggleTime
        self.nextToggleTime = math.min(self.nextToggleTime + self.durationPerAttackLanded,
            GameRules:GetGameTime() + maxExtend)

        local extension = self.nextToggleTime - oldTime
        if extension > 0 then
            print(string.format("[SLARK_AI] Damage taken! Extending active phase by %.2f sec. New end time: %.2f",
                extension, self.nextToggleTime))
        else
            print("[SLARK_AI] Damage taken! But nextToggleTime is already at MAX_EXTEND.")
        end
    end
end

function modifier_slark_ai:OnDeath(params)
    if not self.customDeathSound then return end
    local parent = self:GetParent()
    if params.unit == parent then
        EmitSoundOn(self.customDeathSound, parent)
    end
end

function modifier_slark_ai:OnCreated()
    if not IsServer() then return end
    local unit = self:GetParent()
    unit:SetIdleAcquire(false)
    unit:SetAcquisitionRange(0)

    local unitName = unit:GetUnitName()
    local kv = GetUnitKeyValuesByName(unitName)
    if kv then
        self.customDeathSound = kv["CustomDeathSound"]
        self.requiredTimeInAggroOffset = kv["RequiredTimeInAggroOffset"]
    end
    self.hit_toggle = unit:FindAbilityByName('slark_hit_toggle')
    self.minDuration = self.hit_toggle:GetSpecialValueFor('minDuration') or 1.0
    self.maxDuration = self.hit_toggle:GetSpecialValueFor('maxDuration') or 3.0
    self.durationPerAttackLanded = self.hit_toggle:GetSpecialValueFor('durationPerAttackLanded') or 1.5
    self.minWait = self.hit_toggle:GetSpecialValueFor('minWait') or 1.0
    self.maxWait = self.hit_toggle:GetSpecialValueFor('maxWait') or 3.0

    self.nextToggleTime = 0
    self.isToggleActive = false
end

function modifier_slark_ai:OnIntervalThink()
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
        unit.lastCastTime = unit.lastCastTime or 0

        if IsCasting(unit) then return end

        if not self.isToggleActive then
            if not self.reEnableTime then
                local initialDelay = 2.0 + (self.requiredTimeInAggroOffset or 0)
                self.reEnableTime = currentTime + initialDelay
            end

            if currentTime >= self.reEnableTime then
                self.hit_toggle:ToggleAbility()
                self.isToggleActive = true

                local duration = RandomFloat(self.minDuration, self.maxDuration)
                self.nextToggleTime = currentTime + duration
                self.reEnableTime = nil
                print(string.format("[SLARK_AI] TOGGLE ON! Planned base duration: %.2f sec (until %.2f)", duration,
                    self.nextToggleTime))
            end
        else
            if currentTime >= self.nextToggleTime then
                self.hit_toggle:ToggleAbility()
                self.isToggleActive = false
                local randomWait = RandomFloat(self.minWait, self.maxWait)
                self.reEnableTime = currentTime + randomWait
                print(string.format("[SLARK_AI] TOGGLE OFF! Next attempt in %.2f sec (at %.2f)", randomWait,
                    self.reEnableTime))
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
