sanya_towel_aura_1 = class({})

function sanya_towel_aura_1:Spawn()
    if IsServer() then
        local radius = self:GetSpecialValueFor('radius')
        local caster = self:GetCaster()
        local friends = FindUnitsInRadius(
            caster:GetTeamNumber(),
            caster:GetAbsOrigin(),
            nil,
            radius,
            DOTA_UNIT_TARGET_TEAM_FRIENDLY,
            DOTA_UNIT_TARGET_ALL,
            DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER,
            false
        )
        for _, friend in pairs(friends) do
            friend:AddNewModifier(caster, self, "modifier_sanya_towel_aura_1", { hp_regen = self:GetSpecialValueFor('hp_regen') })
        end
    end
end

function sanya_towel_aura_1:GetCastRange()
    return self:GetSpecialValueFor('radius')
end

function sanya_towel_aura_1:OnSpellStart()
    local caster = self:GetCaster()
    local next_aura = "sanya_towel_aura_2"
    caster:RemoveModifierByName("modifier_sanya_towel_aura_1")
    caster:SwapAbilities("sanya_towel_aura_1", "sanya_towel_aura_2", false, true)
end