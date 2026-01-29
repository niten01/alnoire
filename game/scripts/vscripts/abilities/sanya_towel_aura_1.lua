LinkLuaModifier("modifier_sanya_towel_aura_manager", "modifiers/abilities/modifier_sanya_towel_aura_manager", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sanya_towel_aura_buff_1", "modifiers/abilities/modifier_sanya_towel_aura_buff_1", LUA_MODIFIER_MOTION_NONE)

sanya_towel_aura_1 = class({})

function sanya_towel_aura_1:Spawn()
    if IsServer() then
        local caster = self:GetCaster()
        caster.__active_towel_aura = 1
        if not caster:HasModifier("modifier_sanya_towel_aura_manager") then
            caster:AddNewModifier(caster, self, 'modifier_sanya_towel_aura_manager', {})
        end
    end
end

function sanya_towel_aura_1:GetCastRange()
    return self:GetSpecialValueFor('radius')
end

function sanya_towel_aura_1:OnUpgrade()
    local caster = self:GetCaster()
    local aura2 = caster:FindAbilityByName("sanya_towel_aura_2")
    if aura2:GetLevel() == self:GetLevel() then return end
    aura2:SetLevel(self:GetLevel())
end

function sanya_towel_aura_1:OnSpellStart()
    local caster = self:GetCaster()
    caster.__active_towel_aura = 2
    caster:SwapAbilities('sanya_towel_aura_1', 'sanya_towel_aura_2', false, true)
end