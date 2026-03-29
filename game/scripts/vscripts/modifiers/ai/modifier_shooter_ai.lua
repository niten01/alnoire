modifier_shooter_ai = class({})

function modifier_shooter_ai:IsHidden() return true end

function modifier_shooter_ai:IsPurgable() return false end

function modifier_shooter_ai:OnCreated()
    if not IsServer() then return end
    self.usedEulSeq = false
    self.eulSeqInProgress = false
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
                Timers:CreateTimer(2.1, function()
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
        if not self.usedEulSeq then
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
