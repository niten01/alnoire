function MoveHome(unit)
  if not IsServer() or not unit or unit:IsNull() then return end
  if unit:GetCurrentActiveAbility() then return end
  if not unit.spawnPos then return end

  local dist = (unit:GetAbsOrigin() - unit.spawnPos):Length2D()
  if dist > 50 then
    unit:MoveToPosition(unit.spawnPos)
  end

  Timers:CreateTimer(0.1, function()
    local dist = (unit:GetAbsOrigin() - unit.spawnPos):Length2D()
    if dist < 5 then
      local turnPos = unit.spawnPos + unit.spawnForward * 2
      unit:MoveToPosition(turnPos)
    else
      return 0.1
    end
  end)
end

function IsCasting(unit)
  return unit:GetCurrentActiveAbility() or unit:IsChanneling() or unit.isCasting
end

local function GetTargetPos(target)
  if target.GetAbsOrigin then
    return target:GetAbsOrigin()
  end
  return target
end

local function TargetUnitOrNil(target)
  return (target.GetUnitName and target) or nil
end

function CanCastAbility(unit, target, ability)
  if unit:IsSilenced() or unit:IsStunned() then return false end
  if IsCasting(unit) then return false end
  if not ability or not ability:IsActivated() or not ability:IsFullyCastable() or ability:IsPassive() then return false end
  local range = ability:GetCastRange(unit:GetAbsOrigin(), TargetUnitOrNil(target))
  local dist = #(unit:GetAbsOrigin() - GetTargetPos(target))
  local behavior = ability:GetBehavior()
  if bit.band(behavior, DOTA_ABILITY_BEHAVIOR_HIDDEN) ~= 0 then return false end
  return dist <= (range + 100)
end

local function CastIterWrapper(unit, target, fn)
  -- always intercept when casting another ability
  if IsCasting(unit) then return true end
  if unit:IsSilenced() then return nil end
  local abilityCount = unit:GetAbilityCount()
  for i = 0, abilityCount - 1 do
    local ability = unit:GetAbilityByIndex(i)
    if not CanCastAbility(unit, target, ability) then goto continue end
    if fn(ability) then return ability end
    ::continue::
  end
  return nil
end

-- give appropriate cast order given ability is castable
function GiveCastOrder(unit, target, ability)
  local behavior = ability:GetBehavior()
  assert(behavior)

  local cast = function()
    if bit.band(behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 then
      unit:CastAbilityOnTarget(target, ability, -1)
    elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 then
      unit:CastAbilityNoTarget(ability, -1)
    elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_POINT) ~= 0 then
      unit:CastAbilityOnPosition(target:GetAbsOrigin(), ability, -1)
    else
      error("Could not cast ability: " .. ability:GetName())
    end
    unit.lastCastAbilityName = ability:GetName()
  end

  if ability.ShowWarning then
    local delay = ability:ShowWarning(GetTargetPos(target)) or 1
    unit.isCasting = true
    Timers:CreateTimer(delay, function()
      cast()
      unit.isCasting = false
    end)
  else
    cast()
  end
end

function CastAbility(unit, target, abilityName)
  if IsCasting(unit) then return true end
  if unit:IsSilenced() then return false end
  local ability = unit:FindAbilityByName(abilityName)
  assert(ability)
  if not CanCastAbility(unit, target, abilityName) then return false end
  GiveCastOrder(unit, target, abilityName)
end

function CastRandomAbility(unit, target, abilityNames)
  local chosenName = abilityNames[RandomInt(1, #abilityNames)]
  return CastIterWrapper(unit, target, function(ability)
    if ability:GetName() == chosenName then
      GiveCastOrder(unit, target, ability)
      return true
    end
    return false
  end)
end

function CastAllAbilities(unit, target)
  return CastIterWrapper(unit, target, function(ability)
    GiveCastOrder(unit, target, ability)
    return true
  end)
end

function SetAllAbilitiesCooldown(unit, fcooldown)
  for i = 0, unit:GetAbilityCount() - 1 do
    local ab = unit:GetAbilityByIndex(i)
    if ab and not ab:IsPassive() then
      local cd = ab:GetCooldownTimeRemaining()
      if cd > fcooldown then
        ab:StartCooldown(fcooldown)
        unit.lastCastTime = GameRules:GetGameTime()
      end
    end
  end
end

function AnyAlive(packTargetData)
  if not IsServer() then return end
  if not packTargetData then return end
  local hasAliveUnits = false
  if packTargetData.units then
    for i = #packTargetData.units, 1, -1 do
      local u = packTargetData.units[i]
      if u and not u:IsNull() and u:IsAlive() then
        hasAliveUnits = true
        break
      end
    end
  end

  return hasAliveUnits
end

function DrawDebugCircle(target, radius)
  if not IsServer() then return end
  if not target or not radius then return end
  local pfx = ParticleManager:CreateParticle("particles/sanya_debug_radius_ring.vpcf", PATTACH_WORLDORIGIN, nil)
  ParticleManager:SetParticleControl(pfx, 0, GetTargetPos(target) )
  ParticleManager:SetParticleControl(pfx, 2, Vector(radius, 0, 0))
  return pfx
end

function DestroyDebugCircle(pfx)
  ParticleManager:DestroyParticle(pfx, false)
  ParticleManager:ReleaseParticleIndex(pfx)
end

function FindSanyaInRadius(centerPoint, radius)
  local units = FindUnitsInRadius(
    DOTA_TEAM_BADGUYS,
    centerPoint,
    nil,
    radius,
    DOTA_UNIT_TARGET_TEAM_ENEMY,
    DOTA_UNIT_TARGET_HERO,
    DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
    FIND_CLOSEST,
    false
  )

  for _, unit in pairs(units) do
    if unit:IsRealHero() and unit:GetPlayerOwnerID() ~= -1 and not unit:IsSpiritBearCustom() then
      return unit
    end
  end

  return nil
end

function FindEnemiesForAIInRadius(center, radius)
  return FindUnitsInRadius(
    DOTA_TEAM_BADGUYS,
    center,
    nil,
    radius,
    DOTA_UNIT_TARGET_TEAM_ENEMY,
    DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
    FIND_CLOSEST,
    false
  )
end

function FindEnemiesForAIInLine(p1, p2, width)
  return FindUnitsInLine(
    DOTA_TEAM_BADGUYS,
    p1, p2,
    nil,
    width,
    DOTA_UNIT_TARGET_TEAM_ENEMY,
    DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
    FIND_CLOSEST,
    false
  )
end

function RemoveAllIdleModifiers(unit)
  if not IsServer() then return end
  if not unit or unit:IsNull() or not unit:IsAlive() then return end
  local modifiers = unit:FindAllModifiers()

  for _, mod in ipairs(modifiers) do
    local modName = mod:GetName()
    if modName and string.find(string.lower(modName), "idle") then
      unit:RemoveModifierByName(modName)
    end
  end
end

function AddAllIdleModifiers(unit)
  if not IsServer() then return end
  if not unit or unit:IsNull() or not unit:IsAlive() then return end
  assert(unit.spawnerName)
  local spawnerData = EntityData:ByName(unit.spawnerName)
  local modifiers = spawnerData.modifiers

  for _, modName in ipairs(modifiers) do
    if modName and string.find(string.lower(modName), "idle") then
      unit:AddNewModifier(nil, nil, modName, { duration = -1 })
    end
  end
end

function SetAIModifierActive(modifier, bActive)
  if not IsServer() then return end
  if not modifier:GetParent() then return end
  local unit = modifier:GetParent()
  if not unit:IsAlive() then return end
  unit:Stop()
  unit:SetIdleAcquire(false)
  unit:SetAcquisitionRange(0)

  if bActive then
    RemoveAllIdleModifiers(unit)
    modifier:StartIntervalThink(BATTLE_THINK_INTERVAL)
    modifier:OnIntervalThink()
  else
    AddAllIdleModifiers(unit)
    modifier:StartIntervalThink(-1)
  end
end

function DefaultAiTick(unit)
  if not IsServer() then return end
  if not unit or not unit:IsAlive() then return end

  local beaconData = unit.packTargetData
  if not beaconData then return end
  local beaconState = beaconData.state
  if not beaconState or beaconState == 'off' or beaconState == 'dead' then return end

  local target = beaconData.target
  local currentPos = unit:GetAbsOrigin()
  local distToSpawn = (currentPos - unit.spawnPos):Length2D()

  if beaconState == 'aggro' then
    if not unit.aggroStartTime then
      unit.aggroStartTime = GameRules:GetGameTime()
    end
  else
    unit.aggroStartTime = nil
  end

  local intercept = false
  -- бежим сука
  if beaconState == 'retreat' then
    MoveHome(unit)
    intercept = true
  end

  -- стоим сука
  if beaconState == 'idle' then
    if distToSpawn > 150 then
      MoveHome(unit)
    end
    intercept = true
  end

  if beaconState == 'retreat' or beaconState == 'idle' then
    unit:SetAcquisitionRange(0)
    if unit:GetHealthPercent() < 100 then
      unit:Heal(unit:GetMaxHealth() * 0.1, nil)
    end
  end

  if intercept then return true end

  if beaconState == 'aggro' and target and target:IsAlive() then
    return false
  end

  return true
end

function AdjustTickRate(unit)
  if not IsServer() then return end
  if not unit or not unit:IsAlive() then return end

  local beaconData = unit.packTargetData
  if not beaconData then return end
  local beaconState = beaconData.state
  if not beaconState or beaconState == 'off' or beaconState == 'dead' then return end

  local currentPos = unit:GetAbsOrigin()
  local distToSpawn = (currentPos - unit.spawnPos):Length2D()
  local target_interval = IDLE_THINK_INTERVAL
  if beaconState == 'aggro' or beaconState == 'retreat' or beaconData.somebodyNear or distToSpawn > 150 then
    target_interval = BATTLE_THINK_INTERVAL
  end
  if beaconData.currentCreepInterval ~= target_interval then
    beaconData.currentCreepInterval = target_interval
    print("AI Switch to interval: " .. target_interval)
  end
end

-- startAngle is optional (default 0)
function PointsAlongRing(center, radius, numPoints, startAngle)
  local points = {}
  local angleStep = (2 * math.pi) / numPoints
  local startAngle = startAngle or 0

  for i = 1, numPoints do
    local angle = startAngle + (i - 1) * angleStep

    local px = center.x + radius * math.cos(angle)
    local py = center.y + radius * math.sin(angle)

    table.insert(points, Vector(px, py, 0))
  end

  return points
end

-- minRadius is optional (default 0)
function RandomPointsInCircle(center, radius, numPoints, minRadius)
  local minRadius = minRadius or 0
  local points = {}
  for i = 1, numPoints do
    local dist = RandomFloat(minRadius, radius)
    local angle = RandomFloat(0, 2 * math.pi)

    local px = center.x + dist * math.cos(angle)
    local py = center.y + dist * math.sin(angle)


    table.insert(points, Vector(px, py, 0))
  end

  return points
end
