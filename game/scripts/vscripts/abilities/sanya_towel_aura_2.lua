LinkLuaModifier("modifier_sanya_towel_aura_buff_2", "modifiers/abilities/modifier_sanya_towel_aura_buff_2", LUA_MODIFIER_MOTION_NONE)

sanya_towel_aura_2 = class({})

function sanya_towel_aura_2:Spawn()
    if IsServer() then
        self:SetHidden( true )
        -- 
    end
end

function sanya_towel_aura_2:GetCastRange()
    return self:GetSpecialValueFor('radius')
end


function sanya_towel_aura_2:OnUpgrade()
    local caster = self:GetCaster()
    local aura1 = caster:FindAbilityByName("sanya_towel_aura_1")
    local aura3 = caster:FindAbilityByName("sanya_towel_aura_3")

    if aura1:GetLevel() < self:GetLevel() and aura3:GetLevel() < self:GetLevel() then
        caster.__active_towel_aura = 2
        if caster.aura_pfx then
            ParticleManager:DestroyParticle(caster.aura_pfx, true)
            ParticleManager:ReleaseParticleIndex(caster.aura_pfx)
            caster.aura_pfx = nil
        end
        self:CreateAuraParticle()
    end
    if aura3:GetLevel() == self:GetLevel() then return end
    aura3:SetLevel(self:GetLevel())
end

function sanya_towel_aura_2:OnSpellStart()
    local caster = self:GetCaster()
    ParticleManager:DestroyParticle(caster.aura_pfx, true)
    ParticleManager:ReleaseParticleIndex(caster.aura_pfx)
    caster.aura_pfx = nil
    caster.__active_towel_aura = 3
    local aura3 = caster:FindAbilityByName('sanya_towel_aura_3')
    aura3:CreateAuraParticle(caster, aura3:GetSpecialValueFor('radius'))
    caster:SwapAbilities('sanya_towel_aura_2', 'sanya_towel_aura_3', false, true)
end

function sanya_towel_aura_2:CreateAuraParticle()
    local caster = self:GetCaster()
    if caster.__active_towel_aura == 2 then
        caster.aura_pfx = ParticleManager:CreateParticle("particles/sanya_towel_aura_red.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        ParticleManager:SetParticleControl(caster.aura_pfx, 1, Vector(self:GetSpecialValueFor('radius'), 0, 0))
    end
end