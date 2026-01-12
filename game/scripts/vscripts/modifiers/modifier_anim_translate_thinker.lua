modifier_anim_translate_thinker = class {}

function modifier_anim_translate_thinker:IsHidden() return true end

function modifier_anim_translate_thinker:IsPurgable() return false end

function modifier_anim_translate_thinker:OnCreated(kv)
    self:StartIntervalThink(0.5)
end

function modifier_anim_translate_thinker:OnIntervalThink()
    ---@type CDOTA_BaseNPC
    local unit = self:GetParent()
    if unit:GetAggroTarget() ~= nil
        or unit:IsAttacking()
        or HasEnemiesInRadius(unit, 500) then
        AddAnimationTranslate(unit, "aggressive")
    else
        RemoveAnimationTranslate(unit)
    end
end

function HasEnemiesInRadius(unit, radius)
    if not unit or unit:IsNull() or not unit:IsAlive() then return false, {} end

    local team = unit:GetTeamNumber()
    local origin = unit:GetAbsOrigin()

    local teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY
    local typeFilter = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC -- heroes + creeps (add BUILDING if you want)
    local flagFilter =
        DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE
        + DOTA_UNIT_TARGET_FLAG_NO_INVIS
        + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE

    local units = FindUnitsInRadius(
        team,
        origin,
        nil,
        radius,
        teamFilter,
        typeFilter,
        flagFilter,
        FIND_ANY_ORDER,
        false
    )

    for _, u in ipairs(units) do
        if u and not u:IsNull()
            and u:IsAlive()
            and not u:IsInvulnerable()
            and not u:IsAttackImmune()
        then
            return true
        end
    end

    return false
end
