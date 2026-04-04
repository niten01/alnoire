LinkLuaModifier("modifier_custom_tower_attack", "abilities/clash/custom_tower_attack", LUA_MODIFIER_MOTION_NONE)
custom_tower_attack = class({})

function custom_tower_attack:GetIntrinsicModifierName()
    return "modifier_custom_tower_attack"
end

-----------------------------------------------------------


modifier_custom_tower_attack = class({})

function modifier_custom_tower_attack:IsHidden()
    return true
end

function modifier_custom_tower_attack:CheckState()
    return {
        [MODIFIER_STATE_DISARMED] = true,
    }
end

function modifier_custom_tower_attack:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_IGNORE_CAST_ANGLE
    }
end

function modifier_custom_tower_attack:GetModifierIgnoreCastAngle()
    return 1
end

function modifier_custom_tower_attack:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(BATTLE_THINK_INTERVAL)
end

function modifier_custom_tower_attack:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    if not parent or not parent:IsAlive() then return end
    local point = parent:GetAbsOrigin()
    local range = parent:GetBaseAttackRange()

    local enemies = FindUnitsInRadius(
        parent:GetTeamNumber(),
        point,
        nil,
        range,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_CLOSEST,
        false
    )

    if #enemies == 0 then return end

    local nearestTarget = enemies[1]
    if nearestTarget then
        parent:PerformAttack(nearestTarget, true, true, false, false, true, false, false)
    end
end
