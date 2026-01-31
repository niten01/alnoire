modifier_towel_summon_delayed_explode = class({})

function modifier_towel_summon_delayed_explode:IsHidden() return true end
function modifier_towel_summon_delayed_explode:IsPurgable() return false end
function modifier_towel_summon_delayed_explode:IsDebuff() return false end

function modifier_towel_summon_delayed_explode:CheckState()
    if not IsServer() then return end
    return {
        [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
        [MODIFIER_STATE_DISARMED] = true,
    }
end



function modifier_towel_summon_delayed_explode:OnCreated()
    if not IsServer() then return end
    local caster = self:GetParent()
    caster:Stop()
    local ability = self:GetAbility()
    for i = 0, caster:GetAbilityCount() - 1 do
        local abil = caster:GetAbilityByIndex(i)
        if abil then
            abil:SetActivated(false)
        end
    end
    local radius = ability:GetSpecialValueFor('radius')
    self.pfx = ParticleManager:CreateParticle("particles/econ/items/dark_willow/dark_willow_immortal_2021/dw_2021_willow_wisp_spell_marker_ring_outer_hot.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    self.pfx_2 = ParticleManager:CreateParticle("particles/econ/items/phoenix/eye_of_the_sun/phoenix_supernova_egg_eye_sun_glow_loadout.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControl(self.pfx, 1, Vector(radius, 0, 0))
    ParticleManager:SetParticleControl(self.pfx_2, 1, Vector(0, 0, 0))
    caster:StartGesture( ACT_DOTA_ATTACK )
end

function modifier_towel_summon_delayed_explode:OnDestroy()
    if not IsServer() then return end
    if self.pfx then
        ParticleManager:DestroyParticle(self.pfx, true)
        ParticleManager:ReleaseParticleIndex(self.pfx)
        self.pfx = nil
    end

    if self.pfx_2 then
        ParticleManager:DestroyParticle(self.pfx_2, true)
        ParticleManager:ReleaseParticleIndex(self.pfx_2)
        self.pfx_2 = nil
    end


    local caster = self:GetParent()
    caster:RemoveGesture( ACT_DOTA_ATTACK )
    local ability = self:GetAbility()
    local radius = ability:GetSpecialValueFor('radius')
    local damage = ability:GetSpecialValueFor('damage')
    local pfx_exp = ParticleManager:CreateParticle("particles/econ/items/dark_willow/dark_willow_immortal_2021/dw_2021_willow_wisp_spell_impact.vpcf", PATTACH_ABSORIGIN, caster)
    local pfx_exp_2 = ParticleManager:CreateParticle("particles/units/heroes/hero_phoenix/phoenix_supernova_death_dust.vpcf", PATTACH_ABSORIGIN, caster)
    ParticleManager:SetParticleControl(pfx_exp, 1, Vector(radius, 0, 0))
    ParticleManager:SetParticleControl(pfx_exp_2, 1, Vector(radius, 0, 0))
    ParticleManager:ReleaseParticleIndex(pfx_exp)
    ParticleManager:ReleaseParticleIndex(pfx_exp_2)
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
    end

    for i = 0, caster:GetAbilityCount() - 1 do
        local abil = caster:GetAbilityByIndex(i)
        if abil then
            abil:SetActivated(true)
        end
    end
end