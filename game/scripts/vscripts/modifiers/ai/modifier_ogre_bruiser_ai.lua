modifier_ogre_bruiser_ai = class({})

function modifier_ogre_bruiser_ai:IsHidden() return true end

function modifier_ogre_bruiser_ai:IsPurgable() return false end


local function IsUtilAbility(abilityName)
    return abilityName == "ogre_bruiser_dash" or abilityName == "ogre_bruiser_stun" or abilityName == "ogre_bruiser_pull"
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

    if beaconState == 'aggro' and target and target:IsAlive() then
        -- don't waste two utilities
        if not IsUtilAbility(unit.lastCastAbilityName) then
            if CastRandomAbility(unit, target, { "ogre_bruiser_dash", "ogre_bruiser_stun", "ogre_bruiser_pull" }) then return end
        end

        if CastRandomAbility(unit, target, { "ogre_bruiser_fast_hit", "ogre_bruiser_fly_hit" }) then
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
