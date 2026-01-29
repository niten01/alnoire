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
    local aura3 = caster:FindAbilityByName("sanya_towel_aura_3")
    if aura3:GetLevel() == self:GetLevel() then return end
    aura3:SetLevel(self:GetLevel())
end

function sanya_towel_aura_2:OnSpellStart()
    local caster = self:GetCaster()
    caster.__active_towel_aura = 3
    caster:SwapAbilities('sanya_towel_aura_2', 'sanya_towel_aura_3', false, true)
end