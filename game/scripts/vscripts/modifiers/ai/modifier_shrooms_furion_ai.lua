LinkLuaModifier("modifier_shrooms_furion_whilecast", "modifiers/ai/modifier_shrooms_furion_ai", LUA_MODIFIER_MOTION_NONE)

modifier_shrooms_furion_ai = class({})

function modifier_shrooms_furion_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    local target = beaconData.target

    local hpPct = unit:GetHealthPercent()
    if hpPct <= 60 and not beaconData.furionCallsSecondWave then
        beaconData.furionCallsSecondWave = true
        -- Можно проиграть особый звук или эффект призыва
    end

    if beaconData.shroomsAreRising then
        if not unit:HasModifier('modifier_shrooms_furion_whilecast') then
            unit:AddNewModifier(unit, nil, 'modifier_shrooms_furion_whilecast', {})
        end
        if not self.isTaunting then
            if beaconData.furionCallsSecondWave then
                EmitSoundOn("JungleFurion.Cast.Second", unit)
            else
                EmitSoundOn("JungleFurion.Cast.First", unit)
            end
            unit:StartGestureWithFade(ACT_DOTA_CAST_ABILITY_2, 0.1, 0.3)
            self.isTaunting = true
        end
        return 0.1
    else
        self.isTaunting = false
        if unit:HasModifier('modifier_shrooms_furion_whilecast') then
            unit:RemoveModifierByName('modifier_shrooms_furion_whilecast')
        end
    end


    if not DefaultAiTick(unit) then
        -- деремся сука
        if beaconState == 'aggro' and target and target:IsAlive() then
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

    AdjustTickRate(unit)
    self:StartIntervalThink(beaconData.currentCreepInterval)
end

function modifier_shrooms_furion_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_shrooms_furion_ai:OnDeath(params)
    if not IsServer() then return end
    local killedUnit = params.unit
    if self:GetParent() == killedUnit then
        EmitSoundOn('JungleFurion.Death', killedUnit)
    end
end

----------
modifier_shrooms_furion_whilecast = class({})

function modifier_shrooms_furion_whilecast:IsHidden() return true end

function modifier_shrooms_furion_whilecast:IsPurgable() return true end

function modifier_shrooms_furion_whilecast:CheckState()
    return {
        [MODIFIER_STATE_ROOTED] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_DISARMED] = true,
    }
end
