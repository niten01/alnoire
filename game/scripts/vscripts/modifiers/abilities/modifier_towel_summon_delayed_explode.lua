modifier_towel_summon_delayed_explode = class({})

function modifier_towel_summon_delayed_explode:IsHidden() return true end
function modifier_towel_summon_delayed_explode:IsPurgable() return false end
function modifier_towel_summon_delayed_explode:IsDebuff() return false end

function modifier_towel_summon_delayed_explode:CheckState()
    if not IsServer() then return end
    return {
        [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_ATTACK_IMMUNE] = true,
    }
end

function modifier_towel_summon_delayed_explode:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
end

function modifier_towel_summon_delayed_explode:GetOverrideAnimation()
    return ACT_DOTA_CHANNEL_ABILITY_3
end

function modifier_towel_summon_delayed_explode:OnCreated()
    if not IsServer() then return end
    local caster = self:GetParent()
    caster:Stop()
    local ability = self:GetAbility()
    for i = 0, caster:GetAbilityCount() - 1 do
        local abil = caster:GetAbilityByIndex(i)
        if abil then
            if abil:GetAbilityName() ~= "towel_summon_dash" then
                abil:SetActivated(false)
            end
        end
    end
    local radius = ability:GetSpecialValueFor('radius')
    local pfx_pre_1 = ParticleManager:CreateParticle("particles/sanya_summon_explosion_ring_outer.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    local pfx_pre_2 = ParticleManager:CreateParticle("particles/sanya_summon_explosion_supernova.vpcf", PATTACH_POINT_FOLLOW, caster)
    ParticleManager:SetParticleControl(pfx_pre_1, 1, Vector(radius, 0, 0))
    ParticleManager:SetParticleControl(pfx_pre_1, 2, Vector(self:GetDuration(), 0, 0))
    ParticleManager:SetParticleControlEnt(pfx_pre_2, 0, caster, PATTACH_POINT_FOLLOW, 'attach_hitloc', caster:GetAbsOrigin(), true)
    self:AddParticle(pfx_pre_1, false, false, -1, false, false)
    self:AddParticle(pfx_pre_2, false, false, -1, false, false)
end

function modifier_towel_summon_delayed_explode:OnDestroy()
    if not IsServer() then return end
    local caster = self:GetParent()
    local ability = self:GetAbility()
    local radius = ability:GetSpecialValueFor('radius')
    local damage = ability:GetSpecialValueFor('damage')
    local pfx_exp = ParticleManager:CreateParticle("particles/sanya_summon_explosion_impact_alt.vpcf", PATTACH_ABSORIGIN, caster)
    ParticleManager:SetParticleControl(pfx_exp, 1, Vector(radius + 60, 0, 0))
    ParticleManager:ReleaseParticleIndex(pfx_exp)
    ScreenShake(caster:GetAbsOrigin(), 15, 150, 0.4, 1000, 0, true)
    local enemies = FindUnitsInRadius(
        caster:GetTeamNumber(),
        caster:GetAbsOrigin(),
        nil,
        radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false
    )

    for _, enemy in pairs(enemies) do
        ApplyDamage({
            victim = enemy,
            attacker = caster,
            damage = damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = ability,
        })
        print('explosion damage applied')
    end

    for i = 0, caster:GetAbilityCount() - 1 do
        local abil = caster:GetAbilityByIndex(i)
        if abil then
            abil:SetActivated(true)
        end
    end
end