LinkLuaModifier("modifier_custom_liquid_fire_debuff", "abilities/ocean/custom_liquid_fire.lua",
    LUA_MODIFIER_MOTION_NONE)

custom_liquid_fire = class({})

function custom_liquid_fire:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    local projSpeed = self:GetSpecialValueFor('proj_speed') or 900

    local projInfo = {
        Target = target,
        Source = caster,
        Ability = self,
        EffectName = "particles/units/heroes/hero_lina/lina_base_attack.vpcf",
        iMoveSpeed = projSpeed,
        vSourceLoc = caster:GetAbsOrigin(),
        dDodgeable = true,
        bReplaceExisting = false,
        flExpireTime = GameRules:GetGameTime() + 30,
        bProvidesVision = true,
        iVisionRadius = 200,
        iVisionTeamNumber = caster:GetTeamNumber()
    }
    ProjectileManager:CreateTrackingProjectile(projInfo)
    EmitSoundOn("Hero_Jakiro.LiquidFire", caster)
end

function custom_liquid_fire:OnProjectileHit(target, location)
    if not IsServer() or not target then return end

    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor('aoe_radius') or 200
    local duration = self:GetSpecialValueFor('debuff_duration') or 5.0
    local damage = self:GetSpecialValueFor('damage_on_touch') or 100


    local pfx = ParticleManager:CreateParticle('particles/units/heroes/hero_jakiro/jakiro_liquid_fire_explosion.vpcf',
        PATTACH_ABSORIGIN, target)
    ParticleManager:SetParticleControl(pfx, 1, Vector(radius, radius, radius))
    ParticleManager:ReleaseParticleIndex(pfx)
    EmitSoundOn("Hero_Jakiro.LiquidFire", target)

    local enemies = FindUnitsInRadius(
        caster:GetTeamNumber(),
        target:GetAbsOrigin(),
        nil,
        radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false
    )


    for _, enemy in ipairs(enemies) do
        local damageTable = {
            victim = enemy,
            attacker = caster,
            damage = damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self
        }
        ApplyDamage(damageTable)
        enemy:AddNewModifier(caster, self, "modifier_custom_liquid_fire_debuff", { duration = duration })
    end
    return true
end

-------------------------------
---
modifier_custom_liquid_fire_debuff = class({})

function modifier_custom_liquid_fire_debuff:IsHidden() return false end

function modifier_custom_liquid_fire_debuff:IsPurgable() return true end

function modifier_custom_liquid_fire_debuff:IsDebuff() return true end

function modifier_custom_liquid_fire_debuff:OnCreated()
    if not IsServer() then return end
    local abil = self:GetAbility()
    self.dmgPerSec = abil:GetSpecialValueFor('dmg_per_sec') or 20
    self:StartIntervalThink(1.0)
end

function modifier_custom_liquid_fire_debuff:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    local abil = self:GetAbility()
    local caster = self:GetCaster()
    local damageTable = {
        victim = parent,
        attacker = caster,
        damage = self.dmgPerSec,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = abil
    }
    ApplyDamage(damageTable)
end

function modifier_custom_liquid_fire_debuff:GetEffectName()
    return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end

function modifier_custom_liquid_fire_debuff:StatusEffectPriority()
    return MODIFIER_PRIORITY_ULTRA
end
