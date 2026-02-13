trap_arrow = class({})
LinkLuaModifier("modifier_trap_arrow_thinker", "abilities/trap_arrow.lua", LUA_MODIFIER_MOTION_NONE)

function trap_arrow:GetIntrinsicModifierName()
    return "modifier_trap_arrow_thinker"
end

function trap_arrow:FireTrap(origin, range)
    local caster = self:GetCaster()

    caster:StartGesture(ACT_DOTA_ATTACK)

    local fwd = caster:GetForwardVector()
    local projectile_info = {
        Ability = self,
        EffectName = "particles/trap_arrow.vpcf",
        vSpawnOrigin = origin,
        fDistance = range,
        fStartRadius = 100,
        fEndRadius = 100,
        Source = caster,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        vVelocity = fwd * 800,
        bProvidesVision = true,
        iVisionRadius = 200,
        iVisionTeamNumber = caster:GetTeamNumber()
    }

    ProjectileManager:CreateLinearProjectile(projectile_info)
end

function trap_arrow:OnProjectileHit(target, location)
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

modifier_trap_arrow_thinker = class({})

function modifier_trap_arrow_thinker:IsHidden() return true end

function modifier_trap_arrow_thinker:SetTrapActive(value)
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

function modifier_trap_arrow_thinker:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(2.0)

    local parent = self:GetParent()
    local forward = parent:GetForwardVector()
    local attachHndl = parent:ScriptLookupAttachment("nozzle")
    local startPos = parent:GetAttachmentOrigin(attachHndl)
    local baseHeight = GetGroundHeight(startPos, nil)
    local maxRange = 1000
    local finalDistance = maxRange

    for i = 32, maxRange, 32 do
        local checkPos = startPos + (forward * i)

        if GetGroundHeight(checkPos, nil) > baseHeight + 50 then
            finalDistance = i
            break
        end
    end

    self.nozzlePos = startPos
    self.range = finalDistance
end

function modifier_trap_arrow_thinker:OnIntervalThink()
    if self:GetAbility() then
        self:GetAbility():FireTrap(self.nozzlePos, self.range)
    end
end
