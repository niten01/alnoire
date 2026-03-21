item_fan = class {}

function item_fan:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local travelTime = self:GetSpecialValueFor("travel_time")
  local distance = self:GetSpecialValueFor("distance")

  local pfx = ParticleManager:CreateParticle("particles/custom_items/item_fan.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
  ParticleManager:ReleaseParticleIndex(pfx)

  caster:EmitSound("items.fan.cast")

  local enemies = FindEnemiesForSanyaInRadius(casterPos, self:GetCastRange(casterPos, nil))
  for _, enemy in ipairs(enemies) do
    local enemyPos = enemy:GetAbsOrigin()
    local dir = (enemyPos - casterPos):Normalized()
    local dest = GetSafeBlinkDestination(enemyPos, enemyPos + dir * distance)
    local realDist = #(dest - enemyPos)

    enemy:AddNewModifier(caster, self, "modifier_move_ease", {
      directionX = dir.x,
      directionY = dir.y,
      duration = travelTime,
      distance = realDist,
      activity = ACT_DOTA_FLAIL,
    })
  end
end