LinkLuaModifier("modifier_shadow_fiend_shadowraze_lua", "abilities/bosses/island_fiend_shadowraze_common",
    LUA_MODIFIER_MOTION_NONE)

if shadowraze == nil then
    shadowraze = {}
end

function shadowraze.OnSpellStart(this)
    -- get references
    local caster = this:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local distance = this:GetSpecialValueFor("range")
    local front = this:GetCaster():GetForwardVector():Normalized()
    local target_pos = this:GetCaster():GetAbsOrigin() + front * distance

    shadowraze.Hit(this, caster, target_pos)
end

function shadowraze.Hit(this, caster, pos)
    local ability = caster:FindAbilityByName("shadow_fiend_shadowraze_a_lua")
    local target_radius = ability:GetSpecialValueFor("shadowraze_radius")
    local base_damage = ability:GetSpecialValueFor("shadowraze_damage")
    local stack_damage = ability:GetSpecialValueFor("stack_bonus_damage")

    -- get affected enemies
    local enemies = FindEnemiesForAIInRadius(pos, target_radius)

    -- for each affected enemies
    for _, enemy in pairs(enemies) do
        -- Get Stack
        local modifier = enemy:FindModifierByNameAndCaster("modifier_shadow_fiend_shadowraze_lua", caster)
        local stack = 0
        if modifier ~= nil then
            stack = modifier:GetStackCount()
        end

        -- Apply damage
        local damageTable = {
            victim = enemy,
            attacker = caster,
            damage = base_damage + stack * stack_damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = this,
        }
        ApplyDamage(damageTable)

        -- Add stack
        shadowraze.ApplyModifier(this, enemy)
    end

    -- Effects
    shadowraze.PlayEffects(this, pos, target_radius)
end

function shadowraze.ApplyModifier(ability, target, numStacks)
    local numStacks = numStacks or 1
    local stack_duration = ability:GetCaster():FindAbilityByName("shadow_fiend_shadowraze_a_lua"):GetSpecialValueFor(
        "duration")
    local modifier = target:FindModifierByNameAndCaster("modifier_shadow_fiend_shadowraze_lua", ability:GetCaster())
    if modifier == nil then
        modifier = target:AddNewModifier(
            ability:GetCaster(),
            ability,
            "modifier_shadow_fiend_shadowraze_lua",
            { duration = stack_duration }
        )
    else
        modifier:ForceRefresh()
    end

    if not modifier then return end
    modifier:SetStackCount(modifier:GetStackCount() + numStacks)
end

function shadowraze.PlayEffects(this, position, radius)
    -- get resources
    local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
    local sound_cast = "Hero_Nevermore.Shadowraze"

    -- create particle
    -- local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, position)
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, 1, 1))
    ParticleManager:ReleaseParticleIndex(effect_cast)

    -- create sound
    EmitSoundOnLocationWithCaster(position, sound_cast, this:GetCaster())
end

--------------------------------------------------------------------------------

modifier_shadow_fiend_shadowraze_lua = modifier_shadow_fiend_shadowraze_lua or class({})


function modifier_shadow_fiend_shadowraze_lua:IsHidden()
    return false
end

function modifier_shadow_fiend_shadowraze_lua:IsDebuff()
    return true
end

function modifier_shadow_fiend_shadowraze_lua:IsPurgable()
    return false
end

function modifier_shadow_fiend_shadowraze_lua:OnCreated(kv)
    self:SetStackCount(1)
end

function modifier_shadow_fiend_shadowraze_lua:OnRefresh(kv)

end

function modifier_shadow_fiend_shadowraze_lua:GetEffectName()
    return "particles/units/heroes/hero_nevermore/nevermore_shadowraze_debuff.vpcf"
end

function modifier_shadow_fiend_shadowraze_lua:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
