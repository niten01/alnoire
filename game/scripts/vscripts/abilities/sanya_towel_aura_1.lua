LinkLuaModifier("modifier_sanya_towel_aura_manager", "modifiers/abilities/modifier_sanya_towel_aura_manager", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sanya_towel_aura_buff_1", "modifiers/abilities/modifier_sanya_towel_aura_buff_1", LUA_MODIFIER_MOTION_NONE)

sanya_towel_aura_1 = class({})

function sanya_towel_aura_1:Spawn()
    if IsServer() then
        local caster = self:GetCaster()
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
    local aura3 = caster:FindAbilityByName("sanya_towel_aura_3")

    if aura2:GetLevel() < self:GetLevel() and aura3:GetLevel() < self:GetLevel() then
        caster.__active_towel_aura = 1
        if caster.aura_pfx then
            ParticleManager:DestroyParticle(caster.aura_pfx, true)
            caster.aura_pfx = nil
        end
        self:CreateAuraParticle()
    end

    if aura2:GetLevel() == self:GetLevel() then return end
    aura2:SetLevel(self:GetLevel())
end

function sanya_towel_aura_1:OnSpellStart()
    local caster = self:GetCaster()
    ParticleManager:DestroyParticle(caster.aura_pfx, true)
    caster.aura_pfx = nil
    caster.__active_towel_aura = 2
    local aura2 = caster:FindAbilityByName('sanya_towel_aura_2')
    aura2:CreateAuraParticle(caster, aura2:GetSpecialValueFor('radius'))
    caster:SwapAbilities('sanya_towel_aura_1', 'sanya_towel_aura_2', false, true)
end

function sanya_towel_aura_1:CreateAuraParticle()
    local caster = self:GetCaster()
    if caster.__active_towel_aura == 1 then
        caster.aura_pfx = ParticleManager:CreateParticle("particles/sanya_towel_aura_green.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        ParticleManager:SetParticleControl(caster.aura_pfx, 1, Vector(self:GetSpecialValueFor('radius'), 0, 0))
    end
end