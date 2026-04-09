trap_spikes = class({})
LinkLuaModifier("modifier_trap_spikes_thinker", "abilities/trap_spikes.lua", LUA_MODIFIER_MOTION_NONE)

function trap_spikes:GetIntrinsicModifierName()
    return "modifier_trap_spikes_thinker"
end

function trap_spikes:TriggerSpikes()
    local caster = self:GetCaster()
    local radius = 170

    caster:EmitSound('sfx.trap_spikes.shoot')

    local enemies = FindEnemiesForAIInRadius(caster:GetAbsOrigin(), radius)
    ScreenShake(caster:GetAbsOrigin(), 5, 0.1, 0.5, 500, 0, true)

    for _, ent in ipairs(enemies) do
        ApplyDamage({
            victim = ent,
            attacker = caster,
            damage = EpsTraps:GetDamage(ent),
            damage_type = DAMAGE_TYPE_PURE,
            ability = self
        })

        ent:AddNewModifier(caster, self, "modifier_stunned_wrap", { duration = 0.5 })
    end
end

-------------------------------------------------------------------------
modifier_trap_spikes_thinker = class({})

function modifier_trap_spikes_thinker:IsHidden() return true end

function modifier_trap_spikes_thinker:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR_FOR_ENEMIES]   = true,
		[MODIFIER_STATE_NO_HEALTH_BAR_FOR_OTHER_PLAYERS]   = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_trap_spikes_thinker:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
    }
end

function modifier_trap_spikes_thinker:GetOverrideAnimation()
    return ACT_DOTA_DISABLED
end

function modifier_trap_spikes_thinker:SetTrapActive(value)
    if not IsServer() then return end
    if value == true then
        self:StartIntervalThink(0.2)
    elseif value == false then
        self:StartIntervalThink(-1);
    end
end

function modifier_trap_spikes_thinker:OnCreated()
    if not IsServer() then return end
    self.is_triggered = false
    self.cooldown = 5.0
end

function modifier_trap_spikes_thinker:OnIntervalThink()
    if not EpsTraps:IsActivated() then
        self:SetTrapActive(false)
        return
    end

    if self.is_triggered then return end

    local parent = self:GetParent()
    local trigger_radius = 170

    local enemies = FindEnemiesForAIInRadius(parent:GetAbsOrigin(), trigger_radius)

    if #enemies > 0 then
        self:BeginTrapSequence()
    end
end

function modifier_trap_spikes_thinker:BeginTrapSequence()
    self.is_triggered = true
    local parent = self:GetParent()

    parent:EmitSound("sfx.trap_spikes.activate")
    parent:StartGesture(ACT_DOTA_ATTACK)

    local delay = 1

    Timers:CreateTimer(delay, function()
        self:GetAbility():TriggerSpikes()

        Timers:CreateTimer(self.cooldown, function()
            self.is_triggered = false
        end)
    end)
end
