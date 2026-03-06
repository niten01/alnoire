LinkLuaModifier('modifier_clash_freeze', "abilities/clash/custom_freeze", LUA_MODIFIER_MOTION_NONE)

custom_freeze = class({})

function custom_freeze:GetAOERadius()
    return self:GetSpecialValueFor("aoe_radius")
end

function custom_freeze:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    local radius = self:GetSpecialValueFor("aoe_radius")
    local duration = self:GetSpecialValueFor("duration")

    local pfx = ParticleManager:CreateParticle(
        "particles/clash_custom_freeze.vpcf",
        PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, point)
    ParticleManager:ReleaseParticleIndex(pfx)
    EmitSoundOnLocationForPlayer("hero_Crystal.frostbite", point, 0)
    local enemies = FindUnitsInRadius(
        caster:GetTeamNumber(),
        point,
        nil,
        radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        0,
        false
    )

    for _, enemy in pairs(enemies) do
        enemy:AddNewModifier(caster, self, "modifier_clash_freeze", { duration = duration })
    end
end

-----------------------------

modifier_clash_freeze = class({})

function modifier_clash_freeze:IsHidden() return false end

function modifier_clash_freeze:IsPurgable() return false end

function modifier_clash_freeze:IsDebuff() return true end

function modifier_clash_freeze:GetStatusEffectName()
    return "particles/econ/items/drow/drow_arcana/drow_arcana_status_effect_frost_arrow.vpcf"
end

function modifier_clash_freeze:StatusEffectPriority()
    return MODIFIER_PRIORITY_ULTRA
end

function modifier_clash_freeze:CheckState()
    return {
        [MODIFIER_STATE_ROOTED] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_SILENCED] = true,
        [MODIFIER_STATE_MUTED] = true,
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_FROZEN] = true,
    }
end
