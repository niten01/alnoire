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
    local aura1 = caster:FindAbilityByName("sanya_towel_aura_1")
    if aura1:GetLevel() == self:GetLevel() then return end
    aura1:SetLevel(self:GetLevel())
end

function sanya_towel_aura_3:OnSpellStart()
    local caster = self:GetCaster()
    caster.__active_towel_aura = 1
    caster:SwapAbilities('sanya_towel_aura_3', 'sanya_towel_aura_1', false, true)
end