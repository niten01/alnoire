require("abilities.bosses.island_fiend_shadowraze_common")

island_fiend_crossraze = class {}

function island_fiend_crossraze:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster    = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local radius    = caster:FindAbilityByName("shadow_fiend_shadowraze_a_lua"):GetSpecialValueFor("shadowraze_radius")
    local targetPos = self:GetCursorPosition()
    local v         = targetPos - casterPos
    local dir       = v:Normalized()
    self.points     = {}

    for i = 1, self:GetSpecialValueFor("num_points"), 1 do
        concatArrays(self.points, PointsFan(casterPos, casterPos + dir * (radius * 2 * i - radius), 4, 180))
    end
end

function island_fiend_crossraze:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()

    assert(self.points)
    for _, point in ipairs(self.points) do
        shadowraze.Hit(self, caster, point)
    end
end
