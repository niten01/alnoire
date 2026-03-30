rapper_souljah = class {}
LinkLuaModifier("modifier_rapper_souljah", "abilities/rapper_souljah.lua", LUA_MODIFIER_MOTION_NONE)

function rapper_souljah:RandomEndPointInFan()
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local range = self:GetCastRange(casterPos, nil)

    local baseAngle = math.atan2(self.direction.y, self.direction.x)
    local fraction = RandomFloat(-1, 1)

    local relativeAngle = fraction * self.spreadRad
    local finalAngle = baseAngle + relativeAngle
    local endPos = Vector(
        casterPos.x + range * math.cos(finalAngle),
        casterPos.y + range * math.sin(finalAngle),
        0
    )
    return endPos, fraction
end

function rapper_souljah:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    caster:EmitSound("ability.rapper.souljah.cast")
end

function rapper_souljah:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local target = self:GetCursorPosition()
    self.direction = (target - casterPos):Normalized()
    self.spreadRad = math.rad(self:GetSpecialValueFor("spread"))
    self.shotSpeed = self:GetSpecialValueFor("shot_speed")
    self.projectileRadius = self:GetSpecialValueFor("projectile_radius")

    local duration = self:GetChannelTime()
    self.numShots = self:GetSpecialValueFor("num_shots")
    self.elapsedTime = 0
    self.shotsFired = 0
    self.interval = duration / self.numShots

    caster:AddNewModifier(caster, self, "modifier_rapper_souljah", { duration = -1 })
end

function rapper_souljah:Fire()
    local caster = self:GetCaster()
    local endPos, spreadFraction = self:RandomEndPointInFan()
    local range = self:GetCastRange(caster:GetAbsOrigin(), nil)

    local attIdx = caster:ScriptLookupAttachment((spreadFraction <= 0) and "attach_attack2" or "attach_attack1")
    local startPos = caster:GetAttachmentOrigin(attIdx)
    local dir = (endPos - startPos):Normalized()
    dir.z = 0

    caster:EmitSound("Hero_Rapper.Attack")

    local leanMod = caster:FindModifierByName("modifier_lean_power_rapper")
    local isLean = leanMod and RollPercentage(leanMod.chancePct)

    ProjectileManager:CreateLinearProjectile({
        Ability = self,
        EffectName = isLean and "particles/rapper_souljah_projectile_lean.vpcf" or
            "particles/rapper_souljah_projectile.vpcf",
        vSpawnOrigin = startPos,
        vVelocity = dir * self.shotSpeed,
        fDistance = range,
        fStartRadius = self.projectileRadius,
        fEndRadius = self.projectileRadius,
        Source = caster,
        bHasFrontalCone = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        bProvidesVision = true,
        iVisionRadius = 500,
        iVisionTeamNumber = caster:GetTeamNumber(),
        ExtraData = {
            isLean = isLean,
            leanRadius = isLean and leanMod.radius,
            leanDamage = isLean and leanMod.damage,
        }
    })
end

function rapper_souljah:OnProjectileHit_ExtraData(target, location, data)
    if not target then return end
    local caster = self:GetCaster()

    caster:PerformAttack(target, true, true, true, false, false, false, false)

    if IsServer() and data.isLean > 0 then
        assert(data.leanRadius and data.leanDamage)
        PlayLeanSplash(target, data.leanRadius)

        local enemies = FindEnemiesForSanyaInRadius(target:GetAbsOrigin(), data.leanRadius)
        for _, ent in ipairs(enemies) do
            ApplyDamage({
                victim = ent,
                attacker = self:GetCaster(),
                damage = data.leanDamage,
                damage_type = DAMAGE_TYPE_MAGICAL,
                ability = self,
            })
        end
    end
end

function rapper_souljah:OnChannelThink(dt)
    if not IsServer() then return end

    self.elapsedTime = self.elapsedTime + dt
    while self.shotsFired < self.numShots do
        local nextShotTime = (self.shotsFired + 1) * self.interval

        if self.elapsedTime >= nextShotTime then
            self:Fire()
            self.shotsFired = self.shotsFired + 1
        else
            break
        end
    end
end

function rapper_souljah:OnChannelFinish(bInterrupted)
    if not IsServer() then return end

    if not bInterrupted and self.shotsFired < self.numShots then
        self:Fire()
    end

    self:GetCaster():RemoveModifierByName("modifier_rapper_souljah")
end

-------------------------------------------------------

modifier_rapper_souljah = class {}

function modifier_rapper_souljah:IsHidden() return true end

function modifier_rapper_souljah:IsPurgable() return false end

function modifier_rapper_souljah:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_rapper_souljah:GetModifierBaseDamageOutgoing_Percentage()
    return -self:GetAbility():GetSpecialValueFor("damage_reduction_pct")
end
