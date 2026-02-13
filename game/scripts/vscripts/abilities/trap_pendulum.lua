trap_pendulum = class({})
LinkLuaModifier("modifier_trap_pendulum_thinker", "abilities/trap_pendulum.lua", LUA_MODIFIER_MOTION_NONE)

function trap_pendulum:GetIntrinsicModifierName()
    return "modifier_trap_pendulum_thinker"
end

function trap_pendulum:OnProjectileHit(target, location)
    if target then
        ApplyDamage({
            victim = target,
            attacker = self:GetCaster(),
            damage = 100,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            ability = self
        })
        target:EmitSound("Hero_Axe.CounterHelix")
    end
end

------------------------------------------------------------

modifier_trap_pendulum_thinker = class({})

function modifier_trap_pendulum_thinker:IsHidden() return true end

function modifier_trap_pendulum_thinker:SetTrapActive(value)
    if not IsServer() then return end
    local parent = self:GetParent()
    if value == true then
        local attrs = parent.injectedAttributes
        assert(attrs and attrs.trap_speed and attrs.trap_delay)
        self.swing_speed = attrs.trap_speed

        local baseAnimLength = 5.3
        local animLength = baseAnimLength / self.swing_speed
        local interval = animLength / 2

        Timers:CreateTimer(attrs.trap_delay, function()
            Timers:CreateTimer(animLength / 4, function()
                parent:StartGestureWithPlaybackRate(ACT_DOTA_IDLE, self.swing_speed)
            end)
            self:StartIntervalThink(interval)
        end)
    elseif value == false then
        self:StartIntervalThink(-1);
    end
end

function modifier_trap_pendulum_thinker:OnCreated()
end

function modifier_trap_pendulum_thinker:OnIntervalThink()
    if not EpsTraps:IsActivated() then
        self:SetTrapActive(false)
        return
    end

    local caster = self:GetCaster()

    local length = 250
    local origin = caster:GetAbsOrigin()
    local rightVec = caster:GetRightVector():Normalized()
    local startPos = origin - rightVec * length
    local endPos = origin + rightVec * length

    local enemies = FindUnitsInLine(
        caster:GetTeamNumber(),
        startPos,
        endPos,
        nil,
        150,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE
    )

    for _, enemy in pairs(enemies) do
        self:GetAbility():OnProjectileHit(enemy, enemy:GetAbsOrigin())
    end
end
