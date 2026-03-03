modifier_mk_ai = class({})

function modifier_mk_ai:IsHidden() return true end

function modifier_mk_ai:IsPurgable() return false end

function modifier_mk_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED,
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST
    }
end

function modifier_mk_ai:OnAbilityFullyCast(params)
    local parent = self:GetParent()
    if params.unit == parent then
        parent.castBonk = false
    end
end

function modifier_mk_ai:OnAttackLanded(event)
    if not IsServer() then return end
    local attacker = event.attacker
    local victim = event.target
    if attacker == self:GetParent() then
        if victim:HasModifier('modifier_mk_stack_debuff') then
            local mod = victim:FindModifierByName('modifier_mk_stack_debuff')
            if mod:GetStackCount() == 8 then
                EmitSoundOn("Bidlo.Laugh.Begin", attacker)
                attacker.castBonk = true
            end
        end
    end
end

function modifier_mk_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    local target = beaconData.target

    if not DefaultAiTick(unit) then
        -- деремся сука
        if beaconState == 'aggro' and target and target:IsAlive() then
            if unit.castBonk then
                local ability = unit:GetAbilityByIndex(0)
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    Position = target:GetAbsOrigin(),
                    AbilityIndex = ability:entindex(),
                    Queue = false,
                })
                return BATTLE_THINK_INTERVAL
            end

            if not unit:GetAggroTarget() and not unit.castBonk then
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                    Position = target:GetAbsOrigin(),
                    Queue = false,
                })
            end
        else
            --
        end
    end

    AdjustTickRate(unit)
    self:StartIntervalThink(beaconData.currentCreepInterval)
end
