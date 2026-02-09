trap_fire_arrow = class({})
LinkLuaModifier("modifier_trap_thinker", "abilities/trap_fire_arrow.lua", LUA_MODIFIER_MOTION_NONE)

function trap_fire_arrow:GetIntrinsicModifierName()
    return "modifier_trap_thinker"
end

function trap_fire_arrow:FireTrap()
    local caster = self:GetCaster()

    caster:StartGesture(ACT_DOTA_ATTACK)

    local forward = caster:GetForwardVector()

    local projectile_info = {
        Ability = self,
        EffectName = "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf",
        vSpawnOrigin = caster:GetAbsOrigin(),
        fDistance = 1000,
        fStartRadius = 100,
        fEndRadius = 100,
        Source = caster,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        vVelocity = forward * 800,
        bProvidesVision = true,
        iVisionRadius = 200,
        iVisionTeamNumber = caster:GetTeamNumber()
    }

    ProjectileManager:CreateLinearProjectile(projectile_info)
end

function trap_fire_arrow:OnProjectileHit(target, location)
    if target then
        ApplyDamage({
            victim = target,
            attacker = self:GetCaster(),
            damage = 200,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self
        })
        return false
    end
end

------------------------------------------------------------

modifier_trap_thinker = class({})

function modifier_trap_thinker:IsHidden() return true end

function modifier_trap_thinker:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(2.0)
end

function modifier_trap_thinker:OnIntervalThink()
    if self:GetAbility() then
        self:GetAbility():FireTrap()
    end
end
