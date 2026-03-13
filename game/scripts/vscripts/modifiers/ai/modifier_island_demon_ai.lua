modifier_island_demon_ai = class({})

function modifier_island_demon_ai:IsHidden() return true end

function modifier_island_demon_ai:IsPurgable() return false end

function modifier_island_demon_ai:ResetState()
    self.phase = 1
    self.hideSeqInProgress = false
    self.partner = nil
    Timers:CreateTimer(0, function()
        self.partner = Entities:FindByName(nil, "npc_island_fiend")
        if not self.partner then return 0.5 end
        self.partnerAI = self.partner:FindModifierByName("modifier_island_fiend_ai")
        return nil
    end)

    local parent = self:GetParent()
    parent:AddNewModifier(parent, nil, "modifier_generic_unkillable", { duration = -1 })
end

modifier_island_demon_ai.OnCreated = modifier_island_demon_ai.ResetState

function modifier_island_demon_ai:OnIntervalThink()
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

function modifier_island_demon_ai:Phase1(unit, target)
    if CastAbility(unit, target, "island_demon_poison") then return end

    if self.partner and self.partner:GetHealth() == 1 then
        self.phase = -1
        unit:Stop()
        unit:StartGesture(ACT_DOTA_SPAWN_STATUE)
        unit:ResetSequence("idle_rare_alt_anim")
        unit:EmitSound("island_demon.laugh")
        Timers:CreateTimer(2.7, function()
            self.phase = 2
            self.partnerAI.phase = 2
        end)

        self.partner:AddNewModifier(unit, nil, "modifier_island_duo_hidden", {
            duration = -1
        })
        Music:StartCustomMusic(target:GetPlayerOwnerID(), "music.island_duo.phase2")
        unit:SetHealth(unit:GetMaxHealth())
    end
end

function modifier_island_demon_ai:Phase2(unit, target)
    local allies = FindEnemiesForSanyaInRadius(unit:GetAbsOrigin(), 9999)
    local numIlls = 0
    local maxIlls = #Entities:FindAllByName("spawner_island_demon_illusion")
    for _, ally in pairs(allies) do
        if ally:GetName() == "npc_island_demon_illusion" then
            numIlls = numIlls + 1
        end
    end

    if numIlls == 0 then
        if CastAbility(unit, target, "island_demon_illusions") then return end
    elseif numIlls < maxIlls - 1 then
        if CastAbility(unit, target, "island_demon_swap") then return end
    end

    if CastAbility(unit, target, "island_demon_poison") then return end

    if unit:GetHealth() == 1 then
        self.partner:RemoveModifierByName("modifier_island_duo_hidden")
        self.partner:EmitSound("island_fiend.phase3")
        self.phase = 3
        self.partnerAI.phase = 3
        unit:RemoveModifierByName("modifier_generic_unkillable")
        self.partner:RemoveModifierByName("modifier_generic_unkillable")

        Music:StartCustomMusic(target:GetPlayerOwnerID(), "music.island_duo.phase3")

        unit:SetHealth(unit:GetMaxHealth())
        self.partner:SetHealth(unit:GetMaxHealth())
    end
end

function modifier_island_demon_ai:Phase3(unit, target)
    if self.hideSeqInProgress then return end

    local allies = FindEnemiesForSanyaInRadius(unit:GetAbsOrigin(), 9999)
    local numIlls = 0
    local maxIlls = #Entities:FindAllByName("spawner_island_demon_illusion")
    for _, ally in pairs(allies) do
        if ally:GetName() == "npc_island_demon_illusion" then
            numIlls = numIlls + 1
        end
    end

    if numIlls == 0 then
        if CastAbility(unit, target, "island_demon_illusions") then return end
    else
        if CastAbility(unit, target, "island_demon_swap") then return end
    end

    if not self.partner or self.partner:IsNull() then
        if CastAbility(unit, target, "island_demon_poison") then return end
        return
    end

    local requiem = self.partner:FindAbilityByName("island_fiend_requiem")
    if requiem:GetCooldownTimeRemaining() <= 0 and not self.partnerAI.blinkSeqInProgress then
        if CastAbility(unit, target, "island_demon_blink") then
            if unit.lastCastAbilityName == "island_demon_blink" then
                self.hideSeqInProgress = true
                Timers:CreateTimer(1, function()
                    if self.partnerAI and not self.partnerAI:IsNull() then
                        self.partnerAI:StopSeq()
                    end
                    GiveCastOrderAI(unit, target, unit:FindAbilityByName("island_demon_hide"))
                    Timers:CreateTimer(1, function()
                        self.hideSeqInProgress = false
                    end)
                end)
            end
            return
        end
    else
        if CastAbility(unit, target, "island_demon_poison") then return end
    end
end
