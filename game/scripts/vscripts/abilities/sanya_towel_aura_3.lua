LinkLuaModifier("modifier_sanya_towel_aura_buff_3", "modifiers/abilities/modifier_sanya_towel_aura_buff_3", LUA_MODIFIER_MOTION_NONE)

sanya_towel_aura_3 = class({})

function sanya_towel_aura_3:Spawn()
    if IsServer() then
        self:SetHidden( true )
        -- 
    end
end

function sanya_towel_aura_3:GetCastRange()
    return self:GetSpecialValueFor('radius')
end


function sanya_towel_aura_3:OnUpgrade()
    local caster = self:GetCaster()
    local aura2 = caster:FindAbilityByName("sanya_towel_aura_2")
    local aura1 = caster:FindAbilityByName("sanya_towel_aura_1")

    if aura2:GetLevel() < self:GetLevel() and aura1:GetLevel() < self:GetLevel() then
        caster.__active_towel_aura = 3
        if caster.aura_pfx then
            ParticleManager:DestroyParticle(caster.aura_pfx, true)
            caster.aura_pfx = nil
        end
        self:CreateAuraParticle()
    end

    if aura1:GetLevel() == self:GetLevel() then return end
    aura1:SetLevel(self:GetLevel())
end

function sanya_towel_aura_3:OnSpellStart()
    local caster = self:GetCaster()
    ParticleManager:DestroyParticle(caster.aura_pfx, true)
    caster.aura_pfx = nil
    caster.__active_towel_aura = 1
    local aura1 = caster:FindAbilityByName('sanya_towel_aura_1')
    aura1:CreateAuraParticle(caster, aura1:GetSpecialValueFor('radius'))
    caster:SwapAbilities('sanya_towel_aura_3', 'sanya_towel_aura_1', false, true)
end

function sanya_towel_aura_3:CreateAuraParticle()
    local caster = self:GetCaster()
    if caster.__active_towel_aura == 3 then
        caster.aura_pfx = ParticleManager:CreateParticle("particles/sanya_towel_aura_blue.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        ParticleManager:SetParticleControl(caster.aura_pfx, 1, Vector(self:GetSpecialValueFor('radius'), 0, 0))
    end
end