LinkLuaModifier("modifier_shadow_fiend_shadowraze_lua", "abilities/bosses/island_fiend_shadowraze",
    LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
shadow_fiend_shadowraze_a_lua = class({})
shadow_fiend_shadowraze_b_lua = class({})
shadow_fiend_shadowraze_c_lua = class({})

function shadow_fiend_shadowraze_a_lua:OnSpellStart()
    if not IsServer() then return end
    shadowraze.OnSpellStart(self)
end

function shadow_fiend_shadowraze_b_lua:OnSpellStart()
    if not IsServer() then return end
    shadowraze.OnSpellStart(self)
end

function shadow_fiend_shadowraze_c_lua:OnSpellStart()
    if not IsServer() then return end
    shadowraze.OnSpellStart(self)
end

--------------------------------------------------------------------------------

if shadowraze == nil then
    shadowraze = {}
end

function shadowraze.OnSpellStart(this)
    -- get references
    local caster = this:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local distance = this:GetCastRange(casterPos, nil)
    local front = this:GetCaster():GetForwardVector():Normalized()
    local target_pos = this:GetCaster():GetAbsOrigin() + front * distance
    local target_radius = this:GetSpecialValueFor("shadowraze_radius")
    local base_damage = this:GetSpecialValueFor("shadowraze_damage")
    local stack_damage = this:GetSpecialValueFor("stack_bonus_damage")
    local stack_duration = this:GetSpecialValueFor("duration")

    -- get affected enemies
    local enemies = FindEnemiesForAIInRadius(target_pos, target_radius)

    -- for each affected enemies
    for _, enemy in pairs(enemies) do
        -- Get Stack
        local modifier = enemy:FindModifierByNameAndCaster("modifier_shadow_fiend_shadowraze_lua", this:GetCaster())
        local stack = 0
        if modifier ~= nil then
            stack = modifier:GetStackCount()
        end

        -- Apply damage
        local damageTable = {
            victim = enemy,
            attacker = this:GetCaster(),
            damage = base_damage + stack * stack_damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = this,
        }
        ApplyDamage(damageTable)

        -- Add stack
        if modifier == nil then
            enemy:AddNewModifier(
                this:GetCaster(),
                this,
                "modifier_shadow_fiend_shadowraze_lua",
                { duration = stack_duration }
            )
        else
            modifier:IncrementStackCount()
            modifier:ForceRefresh()
        end
    end

    -- Effects
    shadowraze.PlayEffects(this, target_pos, target_radius)
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

modifier_shadow_fiend_shadowraze_lua = class({})


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
