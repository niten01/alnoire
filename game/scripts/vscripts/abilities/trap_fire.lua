trap_fire = class({})
LinkLuaModifier("modifier_trap_fire_thinker", "abilities/trap_fire.lua", LUA_MODIFIER_MOTION_NONE)

function trap_fire:GetIntrinsicModifierName()
    return "modifier_trap_fire_thinker"
end

function trap_fire:FireTrap()
    local caster = self:GetCaster()

    caster:FadeGesture(ACT_DOTA_ATTACK)
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

function trap_fire:OnProjectileHit(target, location)
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

modifier_trap_fire_thinker = class({})

function modifier_trap_fire_thinker:IsHidden() return true end

function modifier_trap_fire_thinker:SetTrapActive(value)
    if not IsServer() then return end
    if value == true then
        local parent = self:GetParent()
        local attrs = parent.injectedAttributes
        assert(attrs and attrs.trap_interval and attrs.trap_delay)

        Timers:CreateTimer(attrs.trap_delay, function()
            self:OnIntervalThink()
            self:StartIntervalThink(attrs.trap_interval)
        end)
    elseif value == false then
        self:StartIntervalThink(-1);
    end
end

function modifier_trap_fire_thinker:OnCreated()
end

function modifier_trap_fire_thinker:OnIntervalThink()
    if self:GetAbility() then
        self:GetAbility():FireTrap()
    end
end
