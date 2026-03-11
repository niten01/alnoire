derek_axes = class {}

function derek_axes:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local zOffset = 100
    local startPos = casterPos + Vector(0, 0, zOffset)

    local targetPos = self:GetCursorPosition()
    local v = targetPos - startPos
    local dir = v:Normalized()
    local endOffset = RandomFloat(self:GetLevelSpecialValueFor("end_target_offset", 0),
        self:GetLevelSpecialValueFor("end_target_offset", 1))
    local dist = #v + endOffset
    local endPos = startPos + dir * dist
    local midPoint = startPos + dir * (dist / 2)
    local side = dir:Cross(Vector(0, 0, 1)):Normalized()
    local spread = self:GetSpecialValueFor("spread")
    local mid1, mid2 = midPoint + side * spread, midPoint - side * spread

    self.curves = {
        PointsParabola(startPos, mid1, endPos),
        PointsParabola(startPos, mid2, endPos),
    }

    local radius = self:GetSpecialValueFor("radius")
    ShowGenericCurveWarning(self.curves[1], radius, self:GetCastPoint())
    ShowGenericCurveWarning(self.curves[2], radius, self:GetCastPoint())
end

function derek_axes:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    assert(self.curves)
end
