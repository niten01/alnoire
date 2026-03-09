ball_dash = class {}

function ball_dash:ShowWarning(targetPos)
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local dir = (targetPos - casterPos):Normalized()
    local delay = self:GetSpecialValueFor("warning_delay")
    local dest = GetSafeBlinkDestination(casterPos, casterPos + dir * 9999)
    local slideAbility = caster:FindAbilityByName("ball_slide")
    assert(slideAbility)
    self.dir = dir
    ShowGenericLineWarning(casterPos, dest, slideAbility:GetSpecialValueFor("damage_radius"), delay)
    return delay
end

function ball_dash:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local slide = caster:FindModifierByName("modifier_ball_slide")
    assert(slide)
    local impulse = self:GetSpecialValueFor("impulse")
    assert(self.dir)
    slide.velocity = self.dir * impulse
end
