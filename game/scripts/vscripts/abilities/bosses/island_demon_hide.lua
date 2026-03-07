island_demon_hide = class {}

function island_demon_hide:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    ShowGenericCircleWarning(casterPos, self:GetCastRange(casterPos, nil), self:GetCastPoint())
end

function island_demon_hide:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local enemies = FindEnemiesForAIInRadius(casterPos, self:GetCastRange(casterPos, nil))

    for _, ent in ipairs(enemies) do
        ent:AddNewModifier(caster, self, "modifier_island_duo_hidden_vis", {
            duration = self:GetSpecialValueFor("duration")
        })
    end

    caster:EmitSound("ability.island_demon.illusions.cast")
end