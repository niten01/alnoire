logarithmus_clone = class {}

function logarithmus_clone:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local distance = self:GetSpecialValueFor("distance")
  local flyTime = self:GetSpecialValueFor("fly_time")
  local back = -caster:GetForwardVector()
  local endPos = GetSafeBlinkDestination(casterPos, casterPos + back * distance, distance)
  local realDistance = #(endPos - casterPos)
  local speed = realDistance / flyTime
  caster:AddNewModifier(caster, self, "modifier_move", {
    directionX = back.x,
    directionY = back.y,
    duration = flyTime,
    speed = speed
  })

  local swingDelay = self:GetSpecialValueFor("swing_delay")
  Timers:CreateTimer(swingDelay, function()

  end)
end
