LinkLuaModifier("modifier_sanya_towel_root", "modifiers/abilities/modifier_sanya_towel_root", LUA_MODIFIER_MOTION_NONE)

sanya_towel_root = class({})

function sanya_towel_root:Spawn()
end

function sanya_towel_root:GetAOERadius()
    return self:GetSpecialValueFor("aoe_radius")
end

function sanya_towel_root:OnSpellStart()
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    local radius = self:GetSpecialValueFor("aoe_radius")
    local duration = self:GetSpecialValueFor("duration")
    local pfx = ParticleManager:CreateParticle(
    "particles/sanya_towel_root.vpcf",
        PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, point)
    ParticleManager:SetParticleControl(pfx, 3, Vector(radius, 0, 0))
    ParticleManager:ReleaseParticleIndex(pfx)
    EmitSoundOnLocationWithCaster(point, "ability.towel_master.towel_root", caster)

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
        enemy:AddNewModifier(caster, self, "modifier_sanya_towel_root", { duration = duration })
    end
end
