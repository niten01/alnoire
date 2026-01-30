sanya_towel_dash = class {}

LinkLuaModifier("modifier_towel_dash", "modifiers/abilities/modifier_towel_dash",
  LUA_MODIFIER_MOTION_BOTH)

function sanya_towel_dash:OnSpellStart()
  local caster = self:GetCaster()
  local target = self:GetCursorPosition()

  if caster:HasModifier("modifier_towel_dash") then
    return
  end

  local start = caster:GetAbsOrigin()
  local maxDistance = self:GetCastRange(start, nil)
  local destination = GetSafeBlinkDestination(start, target, maxDistance)
  local distance = #(destination - start)
  local direction = (destination - start):Normalized()
  local distanceFraction = distance / maxDistance
  local peakHeight = 50 * distanceFraction
  local speed = self:GetSpecialValueFor("dash_speed")
  local duration = distance / speed

  ExecuteOrderFromTable({
    UnitIndex = caster:entindex(),
    OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
    Position = destination,
    Queue = false
  })

  caster.jumpInfo = {
    distance = distance,
    direction = direction,
    peak_height = peakHeight,
    travelled = 0,
    speed = speed
  }
  caster:AddNewModifier(caster, self, "modifier_towel_dash", { duration = duration })
end
