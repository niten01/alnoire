modifier_ogre_bruiser_ai = class({})

function modifier_ogre_bruiser_ai:IsHidden() return true end

function modifier_ogre_bruiser_ai:IsPurgable() return false end

function modifier_ogre_bruiser_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_ogre_bruiser_ai:OnAttackLanded(event)
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

function modifier_ogre_bruiser_ai:OnIntervalThink()
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
        local ability = CastAllAbilities(unit, target)
        if ability then
            return
            -- self:StartIntervalThink(BATTLE_THINK_INTERVAL + ability:GetCastPoint())
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
