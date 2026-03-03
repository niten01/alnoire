modifier_custom_sprint_passive = class({})

function modifier_custom_sprint_passive:IsHidden() return true end

function modifier_custom_sprint_passive:IsPurgable() return false end

function modifier_custom_sprint_passive:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
end

function modifier_custom_sprint_passive:OnTakeDamage(params)
    if not IsServer() then return end

    local parent = self:GetParent()
    local ability = self:GetAbility()
    if params.unit == parent and params.attacker ~= parent  then
        if ability:GetToggleState() then
            ability:ToggleAbility()
        end
        ability:StartCooldown(5.0)
    end
end
