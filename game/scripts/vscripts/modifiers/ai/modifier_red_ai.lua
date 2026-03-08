modifier_red_ai = class({})
LinkLuaModifier("modifier_red_tired", "modifiers/ai/modifier_red_ai.lua", LUA_MODIFIER_MOTION_NONE)

function modifier_red_ai:IsHidden() return true end

function modifier_red_ai:IsPurgable() return false end

function modifier_red_ai:OnCreated()
    self.blinkLeftTarget = Entities:FindByName(nil, "red_blink_left")
    self.blinkRightTarget = Entities:FindByName(nil, "red_blink_right")
    assert(self.blinkLeftTarget and self.blinkRightTarget, "No npc_red blink targets, add them, or use a proper map")

    self.blinkUsed = false
    self.tired = false
end

function modifier_red_ai:MakeTired(unit, duration)
    self.tired = true
    Timers:CreateTimer(0.2, function()
        unit:AddNewModifier(nil, nil, "modifier_red_tired", { duration = duration })
        Timers:CreateTimer(duration, function() self.tired = false end)
    end)
end

function modifier_red_ai:OnIntervalThink()
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

    if beaconState == 'aggro' and target and target:IsAlive() then
        if unit:HasModifier("modifier_red_radiance") then
            if not unit:GetAggroTarget() then
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_MOVE_TO_TARGET,
                    TargetIndex = target:entindex(),
                    Queue = false,
                })
            end
            return
        end

        if self.tired then return end

        if self.blinkUsed then
            if CastAbility(unit, target, "red_machine_gun") then
                if unit.lastCastAbilityName == "red_machine_gun" then
                    Timers:CreateTimer(0.1, function()
                        if not unit or unit:IsNull() then return nil end
                        if unit:FindAbilityByName("red_machine_gun"):GetCooldownTimeRemaining() > 0 then
                            self.blinkUsed = false
                            if RandomFloat(0, 1) < 0.7 then
                                self:MakeTired(unit, 6)
                            end
                            return nil
                        end
                        return 0.1
                    end)
                end
            end
            return
        end

        if CastRandomAvailableAbility(unit, target, {
                "red_radiance",
                "red_fireball"
            }) then
            if unit.lastCastAbilityName == "red_fireball" then
                if RandomFloat(0, 1) < 0.5 then
                    self:MakeTired(unit, 4)
                end
            end
            return
        end

        -- everything on CD, do the trick
        local unitPos = unit:GetAbsOrigin()
        local blinkTarget = self.blinkLeftTarget:GetAbsOrigin()
        if #(unitPos - self.blinkRightTarget:GetAbsOrigin()) > #(unitPos - blinkTarget) then
            blinkTarget = self.blinkRightTarget:GetAbsOrigin()
        end
        if CastAbility(unit, blinkTarget, "red_blink") then
            if unit.lastCastAbilityName == "red_blink" then
                self.blinkUsed = true
                return
            end
        end
    end
end

-------------------------------------------------------------------------

modifier_red_tired = class {}

function modifier_red_tired:OnCreated()
    if not IsServer() then return end
    self:GetParent():EmitSound("ability.red.tired")
end

function modifier_red_tired:CheckState()
    return {
        [MODIFIER_STATE_SILENCED] = true,
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
    }
end

function modifier_red_tired:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
    }
end

function modifier_red_tired:GetActivityTranslationModifiers()
    return "tired"
end

function modifier_red_tired:GetOverrideAnimation()
    return ACT_DOTA_IDLE
end
