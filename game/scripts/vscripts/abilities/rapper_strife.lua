rapper_strife = class {}
LinkLuaModifier("modifier_rapper_strife", "abilities/rapper_strife.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rapper_strife_max", "abilities/rapper_strife.lua", LUA_MODIFIER_MOTION_NONE)

function rapper_strife:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local flow = caster:FindModifierByName("modifier_rapper_flow")
    assert(flow)

    if flow:GetStackCount() == 0 then
        caster:EmitSound("ability.rapper.strife.fail")
        return
    end

    caster:AddNewModifier(caster, self, "modifier_rapper_strife", {
        duration = flow:GetStackCount() * self:GetSpecialValueFor("duration_per_stack"),
        attackSpeedBonus = self:GetSpecialValueFor("attack_speed_bonus")
    })

    if flow:GetStackCount() >= flow.maxStacks then
        caster:AddNewModifier(caster, self, "modifier_rapper_strife_max", {
            duration = -1,
            pulseDamage = self:GetSpecialValueFor("perfect_pulse_damage"),
            pulseRadius = self:GetSpecialValueFor("perfect_pulse_radius"),
            damageReduction = self:GetSpecialValueFor("perfect_incoming_damage_reduction_pct"),
            numPulses = self:GetSpecialValueFor("perfect_num_pulses"),
        })
    end
end

function rapper_strife:OnUpgrade()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local flowAbility = caster:FindAbilityByName("rapper_flow")
    assert(flowAbility)
    flowAbility:UpgradeAbility(true)
end

------------------------------------------------------------------

modifier_rapper_strife = class {}

function modifier_rapper_strife:IsHidden() return false end
function modifier_rapper_strife:IsDebuff() return false end
function modifier_rapper_strife:IsPurgable() return false end

function modifier_rapper_strife:OnCreated(kv)
    if not IsServer() then return end

    self.attackSpeedBonus = kv.attackSpeedBonus
    self.flowPerShot = self:GetAbility():GetSpecialValueFor("flow_per_shot")
    self:StartIntervalThink(0.01)
    self.hasTarget = false
    self.alternateFire = false
    self:GetParent():Stop()

    local parent = self:GetParent()
    self.pfx = ParticleManager:CreateParticle("particles/rapper_strife_buff.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)
end

function modifier_rapper_strife:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)

    local parent = self:GetParent()
    parent:RemoveModifierByName("modifier_rapper_strife_max")
end

function modifier_rapper_strife:CheckState()
    return {
        [MODIFIER_STATE_DISARMED] = true
    }
end

function modifier_rapper_strife:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,

        MODIFIER_EVENT_ON_TAKEDAMAGE,
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_EVENT_ON_ABILITY_START
    }
end

function modifier_rapper_strife:OnAbilityStart(kv)
    if not IsServer() then return end
    if kv.unit ~= self:GetParent() then return end
    if kv.ability == self:GetAbility() then return end
    self:Destroy()
end

function modifier_rapper_strife:GetModifierAttackSpeedBonus_Constant()
    return self.attackSpeedBonus
end

function modifier_rapper_strife:GetActivityTranslationModifiers()
    return "focusfire"
end

function modifier_rapper_strife:OnTakeDamage(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if params.damage == 0 then return end
    self:Destroy()
end

function modifier_rapper_strife:OnAttack(params)
    local parent = self:GetParent()
    ScreenShake(parent:GetAbsOrigin(), 2, 2, 0.5, 5000, 0, true)

    if not IsServer() then return end
    if params.attacker ~= parent then return end

    local perfect_mod = parent:FindModifierByName("modifier_rapper_strife_max")
    if perfect_mod then
        perfect_mod:OnIntervalThink()
        local SPA = parent:GetSecondsPerAttack(false)
        if SPA >= 0.2 then
            Timers:CreateTimer(SPA / 2, function()
                if not perfect_mod or perfect_mod:IsNull() then return end
                perfect_mod:OnIntervalThink()
            end)
        end
    end

    local flow = parent:FindModifierByName("modifier_rapper_flow")
    assert(flow)
    flow:SetStackCount(math.max(0, flow:GetStackCount() - self.flowPerShot))

    self.alternateFire = not self.alternateFire
    ProjectileManager:CreateTrackingProjectile({
        Target = params.target,
        Source = parent,
        Ability = self:GetAbility(),
        EffectName = parent:GetRangedProjectileName(),
        iMoveSpeed = parent:GetProjectileSpeed(),
        iSourceAttachment = self.alternateFire and DOTA_PROJECTILE_ATTACHMENT_ATTACK_1 or
            DOTA_PROJECTILE_ATTACHMENT_ATTACK_2,
        bDrawsOnMinimap = false,
        bDodgeable = true,
        bIsAttack = true,
        bVisibleToEnemies = true,
        bReplaceExisting = false,
        flExpireTime = GameRules:GetGameTime() + 10,
        bProvidesVision = false,
    })
end

function modifier_rapper_strife:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    local enemies = FindEnemiesForSanyaInRadius(parent:GetAbsOrigin(), parent:Script_GetAttackRange() + 1)
    local target = enemies[1]
    self.hasTarget = not not target
    if not target then return end

    parent:FaceTowards(target:GetAbsOrigin())
    parent:PerformAttack(target, true, true, false, false, false, false, false)
end

------------------------------------------------------------

modifier_rapper_strife_max = class {}

function modifier_rapper_strife_max:IsHidden() return false end

function modifier_rapper_strife_max:IsDebuff() return false end

function modifier_rapper_strife_max:IsPurgable() return false end

function modifier_rapper_strife_max:OnCreated(kv)
    if not IsServer() then return end
    self.numPulses = kv.numPulses
    self:SetStackCount(self.numPulses)

    self.pulseDamage = kv.pulseDamage
    self.pulseRadius = kv.pulseRadius
    self.damageReduction = kv.damageReduction
    self.pattern = {
        true,
        false,
        false,
        true,
        false,
        false,
        true,
        false,
        false,
        false,
        true,
        false,
        false,
        true,
        false,
        false
    }
    self.totalPulses = 0
    self.loopSounds = {
        "ability.rapper.strife.perfect_pulse",
        "ability.rapper.strife.perfect_pulse_low",
        "ability.rapper.strife.perfect_pulse_very_low",
    }
    self.currentStep = 0
    self.currentLoop = 1

    local parent = self:GetParent()
    self.pfx = ParticleManager:CreateParticle(
        "particles/rapper_strife_perfect_buff.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)
    ParticleManager:SetParticleControlEnt(self.pfx, 5, parent, PATTACH_POINT_FOLLOW, "attach_hitloc",
        parent:GetAbsOrigin(), true)
end

function modifier_rapper_strife_max:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_rapper_strife_max:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
end

function modifier_rapper_strife_max:CheckState()
    return {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_rapper_strife_max:GetModifierIncomingDamage_Percentage()
    return -self.damageReduction
end

function modifier_rapper_strife_max:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()

    self.currentStep = self.currentStep + 1
    if self.currentStep > #self.pattern then
        self.currentStep = 1
        self.currentLoop = self.currentLoop + 1
    end
    if self.currentStep % 2 == 1 then
        parent:EmitSound("ability.rapper.strife.perfect_pulse_tick")
    end

    if not self.pattern[self.currentStep] then return end

    self.totalPulses = self.totalPulses + 1
    self:DecrementStackCount()

    if not IsServer() then return end

    local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_primal_beast/primal_beast_trample.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)
    ParticleManager:SetParticleControl(pfx, 1, Vector(self.pulseRadius, 0, 0))
    ParticleManager:ReleaseParticleIndex(pfx)

    parent:EmitSound(self.loopSounds[self.currentLoop])

    local enemies = FindEnemiesForSanyaInRadius(parent:GetAbsOrigin(), self.pulseRadius)
    for _, ent in ipairs(enemies) do
        ApplyDamage({
            victim = ent,
            attacker = parent,
            damage = self.pulseDamage,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            ability = self,
        })
    end

    if self.totalPulses >= self.numPulses then
        self:Destroy()
    end
end
