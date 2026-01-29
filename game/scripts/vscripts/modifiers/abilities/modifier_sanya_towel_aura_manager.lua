modifier_sanya_towel_aura_manager = class({})

function modifier_sanya_towel_aura_manager:IsHidden() return false end
function modifier_sanya_towel_aura_manager:IsPurgable() return false end

function modifier_sanya_towel_aura_manager:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.2)
end

function modifier_sanya_towel_aura_manager:OnIntervalThink()
    local caster = self:GetCaster()
    local aura1 = caster:FindAbilityByName('sanya_towel_aura_1')
    local aura2 = caster:FindAbilityByName('sanya_towel_aura_2')
    local aura3 = caster:FindAbilityByName('sanya_towel_aura_3')
    local allies = FindUnitsInRadius(
        caster:GetTeamNumber(),         
        caster:GetAbsOrigin(),            
        nil,
        aura1:GetSpecialValueFor('radius'),                            
        DOTA_UNIT_TARGET_TEAM_FRIENDLY,   
        DOTA_UNIT_TARGET_CREEP,            
        DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,
        FIND_ANY_ORDER,
        false
    )
    for _, summon in pairs(allies) do
        if caster.__active_towel_aura == 1 then
            summon:RemoveModifierByName('modifier_sanya_towel_aura_buff_2')
            summon:RemoveModifierByName('modifier_sanya_towel_aura_buff_3')
            summon:AddNewModifier(caster, aura1, 'modifier_sanya_towel_aura_buff_1', {})
        end
        if caster.__active_towel_aura == 2 then
            summon:RemoveModifierByName('modifier_sanya_towel_aura_buff_1')
            summon:RemoveModifierByName('modifier_sanya_towel_aura_buff_3')
            summon:AddNewModifier(caster, aura2, 'modifier_sanya_towel_aura_buff_2', {})
        end
        if caster.__active_towel_aura == 3 then
            summon:RemoveModifierByName('modifier_sanya_towel_aura_buff_1')
            summon:RemoveModifierByName('modifier_sanya_towel_aura_buff_2')
            summon:AddNewModifier(caster, aura3, 'modifier_sanya_towel_aura_buff_3', {})
        end
    end
    
    
end