modifier_mk_ai = class({})

function modifier_mk_ai:IsHidden() return true end

function modifier_mk_ai:IsPurgable() return false end

function modifier_mk_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED,
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
end

function modifier_mk_ai:OnTakeDamage(params)
    local parent = self:GetParent()
    local abil = parent:FindAbilityByName('mk_passive_custom')
    local strike = parent:FindAbilityByName('monkey_king_boundless_strike')
    if params.attacker == parent and params.inflictor == strike then
        local vampMult = abil:GetSpecialValueFor('vampMult') or 1.0
        local realHealing = vampMult * params.damage
        parent:Heal(realHealing, abil)
        SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, parent, realHealing, nil)
    end
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
    local parent = self:GetParent()
    local abil = parent:FindAbilityByName('mk_passive_custom')
    local maxStacks = abil:GetSpecialValueFor('max_stacks')
    if attacker == self:GetParent() then
        if victim:HasModifier('modifier_mk_stack_debuff') then
            local mod = victim:FindModifierByName('modifier_mk_stack_debuff')
            if mod:GetStackCount() == maxStacks then
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
