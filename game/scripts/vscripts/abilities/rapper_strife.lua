rapper_strife = class {}
LinkLuaModifier("modifier_rapper_strife", "abilities/rapper_strife.lua", LUA_MODIFIER_MOTION_NONE)

function rapper_strife:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local flow = caster:FindModifierByName("modifier_rapper_flow")
    assert(flow)


    caster:AddNewModifier(caster, self, "modifier_rapper_strife", {
        duration = flow:GetStackCount() * self:GetSpecialValueFor("duration_per_stack"),
        attackSpeedBonus = self:GetSpecialValueFor("attack_speed_bonus")
    })
end

------------------------------------------------------------------

modifier_rapper_strife = class {}

function modifier_rapper_strife:IsHidden() return false end

function modifier_rapper_strife:IsDebuff() return false end

function modifier_rapper_strife:IsPurgable() return false end

function modifier_rapper_strife:OnCreated(kv)
    if not IsServer() then return end

    self.attackSpeedBonus = kv.attackSpeedBonus
    self:StartIntervalThink(0.01)
    self.hasTarget = false
    self.alternateFire = false
    self:GetParent():Stop()
end

modifier_rapper_strife.OnRefresh = modifier_rapper_strife.OnCreated

function modifier_rapper_strife:CheckState()
    return {
        [MODIFIER_STATE_DISARMED] = true
    }
end

function modifier_rapper_strife:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,

        MODIFIER_EVENT_ON_TAKEDAMAGE,
        MODIFIER_EVENT_ON_ATTACK,
    }
end

function modifier_rapper_strife:GetModifierAttackSpeedBonus_Constant()
    return self.attackSpeedBonus
end

function modifier_rapper_strife:GetActivityTranslationModifiers()
    return "focusfire"
end

function modifier_rapper_strife:OnTakeDamage(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    self:Destroy()
end

function modifier_rapper_strife:OnAttack(params)
    local parent = self:GetParent()
    ScreenShake(parent:GetAbsOrigin(), 2, 2, 0.5, 3000, 0, true)
    if not IsServer() then return end
    if params.attacker ~= parent then return end

    self.alternateFire = not self.alternateFire
    ProjectileManager:CreateTrackingProjectile({
        Target = params.target,
        Source = parent,
        Ability = self:GetAbility(),
        EffectName = parent:GetRangedProjectileName(),
        iMoveSpeed = parent:GetProjectileSpeed(),
        iSourceAttachment = self.alternateFire and DOTA_PROJECTILE_ATTACHMENT_ATTACK_1 or
            DOTA_PROJECTILE_ATTACHMENT_ATTACK_2,
        bDrawsOnMinimap = false,
        bDodgeable = true,
        bIsAttack = true,
        bVisibleToEnemies = true,
        bReplaceExisting = false,
        flExpireTime = GameRules:GetGameTime() + 10,
        bProvidesVision = false,
    })
end

function modifier_rapper_strife:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    local enemies = FindEnemiesForSanyaInRadius(parent:GetAbsOrigin(), parent:Script_GetAttackRange() + 1)
    local target = enemies[1]
    self.hasTarget = not not target
    if not target then return end

    parent:PerformAttack(target, true, true, false, false, false, false, false)
end
