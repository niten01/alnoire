island_demon_poison = class {}
LinkLuaModifier("modifier_island_demon_poison", "modifiers/abilities/modifier_island_demon_poison", LUA_MODIFIER_MOTION_NONE)

function island_demon_poison:ShowWarning(targetPos)
    local caster    = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local delay     = self:GetSpecialValueFor("warning_delay")
    local radius    = self:GetSpecialValueFor("projectile_radius")
    local range     = self:GetSpecialValueFor("range")
    local dir       = (targetPos - casterPos):Normalized()

    self.endPos     = casterPos + dir * range
    ShowGenericLineWarning(casterPos, self.endPos, radius, delay)

    return delay
end

function island_demon_poison:OnSpellStart()
    local caster    = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local radius    = self:GetSpecialValueFor("projectile_radius")
    local speed     = self:GetSpecialValueFor("projectile_speed")
    local v         = (self.endPos - casterPos)


    caster:EmitSound("ability.island_demon.poison.cast")

    ProjectileManager:CreateLinearProjectile({
        Ability = self,
        EffectName = "particles/econ/items/shadow_demon/sd_ti7_shadow_poison/sd_ti7_shadow_poison_proj.vpcf",
        vSpawnOrigin = casterPos,
        vVelocity = v:Normalized() * speed,
        fDistance = #v,
        fStartRadius = radius,
        fEndRadius = radius,
        Source = caster,
        bHasFrontalCone = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        bProvidesVision = true,
        iVisionRadius = 500,
        iVisionTeamNumber = caster:GetTeamNumber()
    })
end

function island_demon_poison:OnProjectileHit(target, location)
    if not target then return end

    local caster = self:GetCaster()
    local damage = self:GetSpecialValueFor("damage")

    target:EmitSound("ability.island_demon.poison.impact")

    ApplyDamage({
        victim = target,
        attacker = caster,
        damage = damage,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = self,
    })

    local mod = target:FindModifierByName("modifier_island_demon_poison")
    if not mod then
        mod = target:AddNewModifier(caster, self, "modifier_island_demon_poison", {
            duration = self:GetSpecialValueFor("poison_decay")
        })
    else
        mod:ForceRefresh()
        mod:IncrementStackCount()
    end

    return false
end
