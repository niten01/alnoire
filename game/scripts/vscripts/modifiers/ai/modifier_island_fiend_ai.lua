modifier_island_fiend_ai = class({})

function modifier_island_fiend_ai:IsHidden() return true end

function modifier_island_fiend_ai:IsPurgable() return false end

function modifier_island_fiend_ai:ResetState()
    self.phase = 1
    self.blinkSeq = -1
    self.blinkSeqInProgress = false
    self.blinkSeqTimers = {}
    self.partner = nil
    Timers:CreateTimer(0, function()
        self:RemoveModifierByName("modifier_island_duo_frenzy")
        self.partner = Entities:FindByName(nil, "npc_island_demon")
        if not self.partner then return 0.5 end

        self.partnerAI = self.partner:FindModifierByName("modifier_island_demon_ai")
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
        if self.phase == 1 then
            self:Phase1(unit, target)
        elseif self.phase == 2 then
            self:Phase2(unit, target)
        elseif self.phase == 3 then
            self:Phase3(unit, target)
        end
    end
end

function modifier_island_fiend_ai:Phase1(unit, target)
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
            self.partnerAI.phase = 2
        end)

        self.partner:AddNewModifier(unit, nil, "modifier_island_duo_hidden", {
            duration = -1
        })
        unit:AddNewModifier(unit, nil, "modifier_island_duo_frenzy", {
            duration = -1,
            cdr = -50
        })
        Music:StartCustomMusic(target:GetPlayerOwnerID(), "music.island_duo.phase2")

        unit:SetHealth(unit:GetMaxHealth())
    end

    if self.blinkSeqInProgress then return end

    if self:BlinkSequence(unit, target) then return end
end

function modifier_island_fiend_ai:Phase2(unit, target)
    if self.blinkSeqInProgress then return end

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
        unit:RemoveModifierByName("modifier_island_duo_frenzy")
        self.partner:RemoveModifierByName("modifier_island_duo_hidden")
        self.partner:EmitSound("island_demon.phase3")
        self.phase = 3
        self.partnerAI.phase = 3
        unit:RemoveModifierByName("modifier_generic_unkillable")
        self.partner:RemoveModifierByName("modifier_generic_unkillable")

        Music:StartCustomMusic(target:GetPlayerOwnerID(), "music.island_duo.phase3")

        unit:SetHealth(unit:GetMaxHealth())
        self.partner:SetHealth(unit:GetMaxHealth())
    end
end

function modifier_island_fiend_ai:Phase3(unit, target)
    local blink = unit:FindAbilityByName("island_fiend_blink")

    if target:HasModifier("modifier_island_duo_hidden_vis") then
        if self:RequiemSeq(unit, target) then return end
        return
    end

    if self.blinkSeqInProgress then return end

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
            self:SeqTimer(1, function()
                GiveCastOrderAI(unit, target, unit:FindAbilityByName("shadow_fiend_shadowraze_a_lua"))
                local blinkSeqTarget = target:GetAbsOrigin()
                self:SeqTimer(razeDelay, function()
                    GiveCastOrderAI(unit, blinkSeqTarget, unit:FindAbilityByName("shadow_fiend_shadowraze_b_lua"))
                    self:SeqTimer(razeDelay, function()
                        GiveCastOrderAI(unit, blinkSeqTarget, unit:FindAbilityByName("shadow_fiend_shadowraze_c_lua"))
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
            self:SeqTimer(1, function()
                GiveCastOrderAI(unit, target, unit:FindAbilityByName("shadow_fiend_shadowraze_a_lua"))
                self.blinkSeqTarget = target:GetAbsOrigin()
                self:SeqTimer(razeDelay, function()
                    GiveCastOrderAI(unit, target, unit:FindAbilityByName("shadow_fiend_shadowraze_b_lua"))
                    self:SeqTimer(razeDelay, function()
                        GiveCastOrderAI(unit, target, unit:FindAbilityByName("shadow_fiend_shadowraze_c_lua"))
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
            self:SeqTimer(1, function()
                GiveCastOrderAI(unit, target, unit:FindAbilityByName("island_fiend_crossraze"))
                self.blinkSeq = -1
                self.blinkSeqInProgress = false
            end)
        end
        return true
    end

    return false
end

function modifier_island_fiend_ai:RequiemSeq(unit, target)
    if self.blinkSeq == 3 then return end

    self:StopSeq()
    local blink = unit:FindAbilityByName("island_fiend_blink")
    self.blinkSeqInProgress = true
    self.blinkSeq = 3
    blink:EndCooldown()
    unit:Stop()
    GiveCastOrderAI(unit, target, blink)
    Timers:CreateTimer(0.8, function()
        local requiem = unit:FindAbilityByName("island_fiend_requiem")
        GiveCastOrderAI(unit, target, requiem)
        Timers:CreateTimer(requiem:GetCastPoint() + 0.3, function()
            self.blinkSeqInProgress = false
            self.blinkSeq = -1
        end)
    end)

    return true
end

function modifier_island_fiend_ai:StopSeq()
    self:GetParent():Stop()
    for tid, _ in pairs(self.blinkSeqTimers) do
        Timers:RemoveTimer(tid)
    end
    self.blinkSeq = -1
    self.blinkSeqInProgress = false
end

function modifier_island_fiend_ai:SeqTimer(delay, fn)
    local tid = DoUniqueString("seq_timer")
    Timers:CreateTimer(tid, {
        endTime = delay,
        callback = function()
            fn()
            self.blinkSeqTimers[tid] = nil
        end,
    })
    self.blinkSeqTimers[tid] = true
end
