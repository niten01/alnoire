modifier_shooter_ai = class({})

function modifier_shooter_ai:IsHidden() return true end

function modifier_shooter_ai:IsPurgable() return false end

function modifier_shooter_ai:OnCreated()
    if not IsServer() then return end
    self.usedEulSeq = false
    self.eulSeqInProgress = false
    self.evadeIdx = 1
    self.evadeTargets = {
        "shooter_evade_1",
        "shooter_evade_2",
        "shooter_evade_3",
    }
end

function modifier_shooter_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_shooter_ai:OnAttackLanded(params)
    if not IsServer() then return end
    if params.target ~= self:GetParent() then return end
    if self.evadeIdx > #self.evadeTargets then return end
    local parent = self:GetParent()
    local tgt = Entities:FindByName(nil, self.evadeTargets[self.evadeIdx])
    assert(tgt)

    local pfx = ParticleManager:CreateParticle("particles/econ/events/ti5/blink_dagger_start_ti5.vpcf",
        PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, parent:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(pfx)

    local pfx = ParticleManager:CreateParticle("particles/econ/events/ti5/blink_dagger_end_ti5.vpcf", PATTACH_WORLDORIGIN,
        nil)
    ParticleManager:SetParticleControl(pfx, 0, tgt:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(pfx)

    parent:EmitSound("ability.shooter.evade")
    parent:SetAbsOrigin(tgt:GetAbsOrigin())

    parent:EmitSound("shooter.vo.evade" .. tostring(self.evadeIdx))

    self.evadeIdx = self.evadeIdx + 1
end

function modifier_shooter_ai:OnIntervalThink()
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
        if target:HasModifier("modifier_shooter_eul") then
            if self.usedEulSeq then return end
            Timers:CreateTimer(0.7, function()
                GiveCastOrderSimple(unit, target, unit:FindAbilityByName("sniper_assassinate"))
                for i = 1, 10, 1 do
                    Timers:CreateTimer(0.1 * i, function()
                        GameRules:SendCustomMessage("летать + сосать", 0, 0)
                    end)
                end
                unit:EmitSound("shooter.vo.eul")
                Timers:CreateTimer(2.3, function()
                    PauseGame(true)
                    self.eulSeqInProgress = false
                end)
            end)
            self.usedEulSeq = true
            return
        end

        if self.eulSeqInProgress then return end

        if CastAbility(unit, target, "sniper_concussive_grenade") then return end
        if CastAbility(unit, target, "sniper_shrapnel") then return end
        if self.evadeIdx > #self.evadeTargets and not self.usedEulSeq then
            self.eulSeqInProgress = true
            GiveCastOrderSimple(unit, target, unit:FindAbilityByName("shooter_eul"))
            return
        end

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
