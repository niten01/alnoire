LinkLuaModifier("modifier_tadpole_get_shooted", "abilities/ocean/tadpole_shot", LUA_MODIFIER_MOTION_NONE)
tadpole_shot = class({})

function tadpole_shot:OnSpellStart()
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local targetPos = self:GetCursorPosition()

    local projRange = self:GetSpecialValueFor('proj_range')
    local projSpeed = self:GetSpecialValueFor('proj_speed')
    print(projSpeed)
    local projHitbox = self:GetSpecialValueFor('proj_hitbox')


    local direction = (targetPos - casterPos):Normalized()
    direction.z = 0

    local projectileInfo = {
        Ability = self,
        EffectName = "particles/units/heroes/hero_viper/viper_poison_attack_.vpcf",
        vSpawnOrigin = casterPos + Vector(0, 0, 35),
        fDistance = projRange,
        fStartRadius = projHitbox,
        fEndRadius = projHitbox,
        Source = caster,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        vVelocity = direction * projSpeed,
        bProvidesVision = true,
        iVisionRadius = 200,
        iVisionTeamNumber = caster:GetTeamNumber()
    }

    ProjectileManager:CreateLinearProjectile(projectileInfo)
    EmitSoundOn("n_creep_warpine.SeedShot.Target", caster)
end

function tadpole_shot:OnProjectileHit(target, location)
    if target and target:IsAlive() then
        local caster = self:GetCaster()
        local projDamage = self:GetSpecialValueFor('proj_damage_on_hit') or 150
        local debuffDuration = self:GetSpecialValueFor('debuff_duration') or 5.0
        local damageTable = {
            victim = target,
            attacker = caster,
            damage = projDamage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self
        }
        ApplyDamage(damageTable)
        target:AddNewModifier(caster, self, "modifier_tadpole_get_shooted", { duration = debuffDuration })
        return true
    end
    return false
end

-------------------------------

modifier_tadpole_get_shooted = class({})

function modifier_tadpole_get_shooted:IsHidden()
    return false
end

function modifier_tadpole_get_shooted:IsPurgable()
    return true
end

function modifier_tadpole_get_shooted:IsDebuff()
    return true
end

function modifier_tadpole_get_shooted:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
end

function modifier_tadpole_get_shooted:GetModifierMoveSpeedBonus_Constant()
    if self.msPenalty then
        return -self.msPenalty
    end
end

function modifier_tadpole_get_shooted:OnCreated()
    if not IsServer() then return end
    local abil = self:GetAbility()
    self.msPenalty = abil:GetSpecialValueFor('slow_amount') or 30
    self.dmgPerSec = abil:GetSpecialValueFor('damage_per_second') or 15
    local parent = self:GetParent()

    local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_pudge/pudge_rot.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)
    ParticleManager:SetParticleControl(pfx, 1, Vector(50, 50, 50))
    self:AddParticle(pfx, false, false, -1, false, false)

    self:StartIntervalThink(1.0)
end

function modifier_tadpole_get_shooted:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_tadpole_get_shooted:OnIntervalThink()
    if not IsServer() then return end
    local abil = self:GetAbility()
    local caster = abil:GetCaster()
    local parent = self:GetParent()
    local damageTable = {
        victim = parent,
        attacker = caster,
        damage = self.dmgPerSec,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = abil
    }
    ApplyDamage(damageTable)
end
