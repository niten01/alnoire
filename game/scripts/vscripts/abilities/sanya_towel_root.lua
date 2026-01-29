LinkLuaModifier("modifier_sanya_towel_root", "modifiers/abilities/modifier_sanya_towel_root", LUA_MODIFIER_MOTION_NONE)

sanya_towel_root = class({})

function sanya_towel_root:Spawn()
    if IsServer() then
        self:SetLevel(1)
    end
end

function sanya_towel_root:GetAOERadius()
    return self:GetSpecialValueFor("aoe_radius")
end

function sanya_towel_root:OnSpellStart()
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    local radius = self:GetSpecialValueFor("aoe_radius")
    local duration = self:GetSpecialValueFor("duration")
    local pfx = ParticleManager:CreateParticle("particles/econ/items/treant_protector/treant_ti10_immortal_head/treant_ti10_immortal_overgrowth_cast.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, point)
    ParticleManager:SetParticleControl(pfx, 1, Vector(radius, 1, 1))
    ParticleManager:ReleaseParticleIndex(pfx)

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
        enemy:AddNewModifier(caster, self, "modifier_sanya_towel_root", {duration = duration})
    end
end