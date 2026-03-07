modifier_island_fiend_ai = class({})

function modifier_island_fiend_ai:IsHidden() return true end

function modifier_island_fiend_ai:IsPurgable() return false end

function modifier_island_fiend_ai:ResetState()
    self.phase = 3
    self.blinkSeq = -1
    self.blinkSeqInProgress = false
    Timers:CreateTimer(0, function()
        self.partner = Entities:FindByName(nil, "npc_island_demon")
        if not self.partner then return 0.5 end
        return nil
    end)
end

modifier_island_fiend_ai.OnCreated = modifier_island_fiend_ai.ResetState

function modifier_island_fiend_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end

    if DefaultAiTick(unit) then
        if beaconData.state == "retreat" then
            self:ResetState()
        end
        AdjustTickRate(unit)
        self:StartIntervalThink(beaconData.currentCreepInterval)
        return
    end

    local beaconState = beaconData.state
    local target = beaconData.target
    if beaconState == 'aggro' and target and target:IsAlive() then
        -- if self:BlinkSequence(unit, target) then return end
        -- if CastAbility(unit, target, "island_fiend_eye") then return end
        -- if CastAbility(unit, target, "island_fiend_crossraze") then return end

        if self.blinkSeqInProgress then return end

        if self.phase == 1 then
            self:Phase1(unit, target)
        elseif self.phase == 2 then
            self:Phase2(unit, target)
        elseif self.phase == 3 then
            self:Phase3(unit, target)
        end

        -- if not unit:GetAggroTarget() and not unit:IsCommandRestricted() then
        --     ExecuteOrderFromTable({
        --         UnitIndex = unit:entindex(),
        --         OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
        --         Position = target:GetAbsOrigin(),
        --         Queue = false,
        --     })
        -- end
    end
end

function modifier_island_fiend_ai:Phase1(unit, target)
    local unit = self:GetParent()
    if self:BlinkSequence(unit, target) then return end

    if self.partner and self.partner:GetHealth() == 1 then
        self.phase = -1
        unit:Stop()
        unit:RemoveGesture(ACT_DOTA_IDLE)
        unit:StartGesture(ACT_DOTA_IDLE_RARE)
        unit:ResetSequence("idle_rare_alt_anim")
        unit:EmitSound("island_fiend.laugh")
        Timers:CreateTimer(2.5, function()
            unit:FadeGesture(ACT_DOTA_IDLE_RARE)
            self.phase = 2
        end)
        self.partner:AddNewModifier(unit, nil, "modifier_island_duo_hidden", {
            duration = -1
        })
        Music:StartCustomMusic(target:GetPlayerOwnerID(), "music.island_duo.phase2")
    end
end

function modifier_island_fiend_ai:Phase2(unit, target)
    local blink = unit:FindAbilityByName("island_fiend_blink")
    if self.blinkSeq == -1 and CanCastAbility(unit, target, blink) then
        self.blinkSeq = RandomInt(0, 1)
    end

    if self.blinkSeq == 0 then
        if self:BlinkTurnSequence(unit, target) then return end
    elseif self.blinkSeq == 1 then
        if self:BlinkCrossraze(unit, target) then return end
    end

    if CastAbility(unit, target, "island_fiend_eye") then return end

    if unit:GetHealth() == 1 then
        self.partner:RemoveModifierByName("modifier_island_duo_hidden")
        self.partner:EmitSound("island_demon.phase3")
        self.phase = 3
        local partnerAI = self.partner:FindModifierByName("modifier_island_fiend_ai")
        partnerAI.phase = 3
        unit:RemoveModifierByName("modifier_generic_unkillable")
        self.partner:RemoveModifierByName("modifier_generic_unkillable")
        Music:StartCustomMusic(target:GetPlayerOwnerID(), "music.island_duo.phase3")
    end
end

function modifier_island_fiend_ai:Phase3(unit, target)
    local blink = unit:FindAbilityByName("island_fiend_blink")
    if target:HasModifier("modifier_island_duo_hidden_vis") then
        blink:EndCooldown()
        if CastAbility(unit, target, "island_fiend_blink") then
            if unit.lastCastAbilityName == "island_fiend_blink" then
                self.blinkSeqInProgress = true
                Timers:CreateTimer(0.8, function()
                    GiveCastOrder(unit, target, unit:FindAbilityByName("island_fiend_requiem"))
                    self.blinkSeqInProgress = false
                end)
            end
            return
        end
        return
    end

    if self.blinkSeq == -1 and CanCastAbility(unit, target, blink) then
        self.blinkSeq = RandomInt(0, 1)
    end

    if self.blinkSeq == 0 then
        if self:BlinkTurnSequence(unit, target) then return end
    elseif self.blinkSeq == 1 then
        if self:BlinkCrossraze(unit, target) then return end
    end

    if CastAbility(unit, target, "island_fiend_eye") then return end
end

function modifier_island_fiend_ai:BlinkSequence(unit, target)
    local razeDelay = 0.8

    if CastAbility(unit, target, "island_fiend_blink") then
        if unit.lastCastAbilityName == "island_fiend_blink" then
            self.blinkSeqInProgress = true
            Timers:CreateTimer(1, function()
                GiveCastOrder(unit, target, unit:FindAbilityByName("shadow_fiend_shadowraze_a_lua"))
                local blinkSeqTarget = target:GetAbsOrigin()
                Timers:CreateTimer(razeDelay, function()
                    GiveCastOrder(unit, blinkSeqTarget, unit:FindAbilityByName("shadow_fiend_shadowraze_b_lua"))
                    Timers:CreateTimer(razeDelay, function()
                        GiveCastOrder(unit, blinkSeqTarget, unit:FindAbilityByName("shadow_fiend_shadowraze_c_lua"))
                        self.blinkSeq = -1
                        self.blinkSeqInProgress = false
                    end)
                end)
            end)
        end
        return true
    end

    return false
end

function modifier_island_fiend_ai:BlinkTurnSequence(unit, target)
    local razeDelay = 0.8

    if CastAbility(unit, target, "island_fiend_blink") then
        if unit.lastCastAbilityName == "island_fiend_blink" then
            self.blinkSeqInProgress = true
            Timers:CreateTimer(1, function()
                GiveCastOrder(unit, target, unit:FindAbilityByName("shadow_fiend_shadowraze_a_lua"))
                self.blinkSeqTarget = target:GetAbsOrigin()
                Timers:CreateTimer(razeDelay, function()
                    GiveCastOrder(unit, target, unit:FindAbilityByName("shadow_fiend_shadowraze_b_lua"))
                    Timers:CreateTimer(razeDelay, function()
                        GiveCastOrder(unit, target, unit:FindAbilityByName("shadow_fiend_shadowraze_c_lua"))
                        self.blinkSeq = -1
                        self.blinkSeqInProgress = false
                    end)
                end)
            end)
        end
        return true
    end

    return false
end

function modifier_island_fiend_ai:BlinkCrossraze(unit, target)
    if CastAbility(unit, target, "island_fiend_blink") then
        if unit.lastCastAbilityName == "island_fiend_blink" then
            self.blinkSeqInProgress = true
            Timers:CreateTimer(1, function()
                GiveCastOrder(unit, target, unit:FindAbilityByName("island_fiend_crossraze"))
                self.blinkSeq = -1
                self.blinkSeqInProgress = false
            end)
        end
        return true
    end

    return false
end
