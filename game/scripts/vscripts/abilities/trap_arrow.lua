trap_arrow = class({})
LinkLuaModifier("modifier_trap_arrow_thinker", "abilities/trap_arrow.lua", LUA_MODIFIER_MOTION_NONE)

function trap_arrow:GetIntrinsicModifierName()
    return "modifier_trap_arrow_thinker"
end

function trap_arrow:FireTrap(origin, range)
    local caster = self:GetCaster()

    caster:StartGesture(ACT_DOTA_ATTACK)

    local attrs = caster.injectedAttributes
    local fwd = caster:GetForwardVector()
    local projectile_info = {
        Ability = self,
        EffectName = "particles/trap_arrow.vpcf",
        vSpawnOrigin = origin,
        fDistance = range,
        fStartRadius = 50,
        fEndRadius = 50,
        Source = caster,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        vVelocity = fwd * attrs.trap_speed,
        bProvidesVision = true,
        iVisionRadius = 200,
        iVisionTeamNumber = caster:GetTeamNumber()
    }

    ProjectileManager:CreateLinearProjectile(projectile_info)
end

function trap_arrow:OnProjectileHit(target, location)
    if target then
        local caster = self:GetCaster()
        ScreenShake(caster:GetAbsOrigin(), 5, 0.1, 0.5, 500, 0, true)
        target:AddNewModifier(caster, self, "modifier_stunned", { duration = 0.5 })
        ApplyDamage({
            victim = target,
            attacker = self:GetCaster(),
            damage = EpsTraps:GetDamage(target),
            damage_type = DAMAGE_TYPE_PURE,
            ability = self
        })
        return false
    end
end

------------------------------------------------------------

modifier_trap_arrow_thinker = class({})

function modifier_trap_arrow_thinker:IsHidden() return true end

function modifier_trap_arrow_thinker:GetClippedRange(origin, direction, maxRange)
    local baseHeight = GetGroundHeight(origin, nil)
    local finalDistance = maxRange

    for i = 1, maxRange, 1 do
        local checkPos = origin + (direction * i)

        if GetGroundHeight(checkPos, nil) > baseHeight + 150 then
            finalDistance = i
            break
        end
    end

    return finalDistance
end

function modifier_trap_arrow_thinker:SetTrapActive(value)
    if not IsServer() then return end
    if value == true then
        local parent = self:GetParent()

        local forward = parent:GetForwardVector()
        local attachHndl = parent:ScriptLookupAttachment("nozzle")
        local startPos = parent:GetAttachmentOrigin(attachHndl)
        local finalDistance = self:GetClippedRange(startPos, forward, 5000)

        self.nozzlePos = startPos
        self.range = finalDistance

        local attrs = parent.injectedAttributes
        assert(attrs and attrs.trap_interval and attrs.trap_delay and attrs.trap_speed)
        Timers:CreateTimer(attrs.trap_delay, function()
            self:OnIntervalThink()
            self:StartIntervalThink(attrs.trap_interval)
        end)
    elseif value == false then
        self:StartIntervalThink(-1);
    end
end

function modifier_trap_arrow_thinker:OnCreated()
end

function modifier_trap_arrow_thinker:OnIntervalThink()
    if not EpsTraps:IsActivated() then
        self:SetTrapActive(false)
        return
    end

    if self:GetAbility() then
        self:GetAbility():FireTrap(self.nozzlePos, self.range)
    end
end
