function MoveHome(unit)
  if not IsServer() or not unit or unit:IsNull() then return end
  if unit:GetCurrentActiveAbility() then return end
  if not unit.spawnPos then return end

  local dist = (unit:GetAbsOrigin() - unit.spawnPos):Length2D()
  if dist > 50 then
    unit:MoveToPosition(unit.spawnPos)
  end

  Timers:CreateTimer(0.1, function()
    if not unit or unit:IsNull() then return end
    local dist = (unit:GetAbsOrigin() - unit.spawnPos):Length2D()
    if dist < 5 then
      local turnPos = unit.spawnPos + unit.spawnForward * 2
      unit:FaceTowards(turnPos)
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

-- rangeTolerance - offset from cast range that is still acceptable, default 100
function CanCastAbility(unit, target, ability, rangeTolerance)
  rangeTolerance = rangeTolerance or 100

  if unit:IsSilenced() or unit:IsStunned() then return false end
  if IsCasting(unit) then return false end
  if not ability or not ability:IsActivated() or not ability:IsFullyCastable() or ability:IsPassive() then return false end
  local range = ability:GetCastRange(unit:GetAbsOrigin(), TargetUnitOrNil(target))
  local dist = #(unit:GetAbsOrigin() - GetTargetPos(target))
  local behavior = ability:GetBehaviorInt()
  if bit.band(behavior, DOTA_ABILITY_BEHAVIOR_HIDDEN) ~= 0 or ability:IsHidden() then return false end
  return dist <= (range + rangeTolerance)
end

local function CastIterWrapper(unit, target, fn, rangeTolerance)
  -- always intercept when casting another ability
  if IsCasting(unit) then return true end
  if unit:IsSilenced() then return nil end
  local abilityCount = unit:GetAbilityCount()
  for i = 0, abilityCount - 1 do
    local ability = unit:GetAbilityByIndex(i)
    if not CanCastAbility(unit, target, ability, rangeTolerance) then goto continue end
    if fn(ability) then return ability end
    ::continue::
  end
  return nil
end

function GiveCastOrderSimple(unit, target, ability)
  local behavior = ability:GetBehaviorInt()
  assert(behavior)
  if bit.band(behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0 then
    unit:CastAbilityOnTarget(target, ability, -1)
  elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 then
    unit:CastAbilityNoTarget(ability, -1)
  elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_POINT) ~= 0 then
    if ability.offset then
      CastAbilityOnPositionWithOffset(unit, ability, target, ability.offset)
    else
      unit:CastAbilityOnPosition(GetTargetPos(target), ability, -1)
    end
  elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_TOGGLE) ~= 0 then
    unit:CastAbilityToggle(ability, -1)
  else
    DebugPrint("[Error] Unknown behavior for: " .. ability:GetName() .. " Value: " .. tostring(behavior))
    error("Could not cast ability: " .. ability:GetName())
  end
end

function GiveCastOrderForcedBehavior(unit, ability, behavior, target)
  assert(behavior)
  if behavior == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
    unit:CastAbilityOnTarget(target, ability, -1)
  elseif behavior == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
    unit:CastAbilityNoTarget(ability, -1)
  elseif behavior == DOTA_ABILITY_BEHAVIOR_POINT then
    if ability.forcedPosition then
      unit:CastAbilityOnPosition(ability.forcedPosition, ability, -1)
    else
      unit:CastAbilityOnPosition(GetTargetPos(target), ability, -1)
    end
  elseif behavior == DOTA_ABILITY_BEHAVIOR_TOGGLE then
    unit:CastAbilityToggle(ability, -1)
  else
    DebugPrint("[Error] Unknown behavior for: " .. ability:GetName() .. " Value: " .. tostring(behavior))
    error("Could not cast ability: " .. ability:GetName())
  end
end

function CastAbilityOnPositionWithOffset(unit, ability, target, offset)
  local casterPos = unit:GetAbsOrigin()
  local targetPos = GetTargetPos(target)
  local direction = (targetPos - casterPos):Normalized()
  local finalPoint = targetPos + (direction * offset)
  unit:CastAbilityOnPosition(finalPoint, ability, -1)
end

-- give appropriate cast order given ability is castable
function GiveCastOrderAI(unit, target, ability)
  unit.lastCastAbilityName = ability:GetAbilityName()
  -- idk if using just lastCastTime will break anything so make a new one
  unit.genericLastCastTime = GameRules:GetGameTime()
  local cast = function()
    if not unit or unit:IsNull() then return end
    unit:Stop()
    if ability.forcedBehavior then
      GiveCastOrderForcedBehavior(unit, ability, ability.forcedBehavior, target)
    else
      GiveCastOrderSimple(unit, target, ability)
    end
  end

  unit.isCasting = true
  if ability.ShowWarning then
    local delay = ability:ShowWarning(GetTargetPos(target)) or 1
    Timers:CreateTimer(delay, function()
      cast()
      Timers:CreateTimer(0.1, function()
        unit.isCasting = false
      end)
    end)
  else
    cast()
    Timers:CreateTimer(ability:GetCastPoint() + 0.01, function()
      unit.isCasting = false
    end)
  end
end

-- rangeTolerance - optional
function CastAbility(unit, target, abilityName, rangeTolerance)
  if IsCasting(unit) then return true end
  if unit:IsSilenced() then return false end
  local ability = unit:FindAbilityByName(abilityName)
  assert(ability, "No such ability: " .. abilityName)
  if not CanCastAbility(unit, target, ability, rangeTolerance) then return false end
  GiveCastOrderAI(unit, target, ability)
  return true
end

-- rangeTolerance - optional
function CastRandomAbility(unit, target, abilityNames, rangeTolerance)
  local chosenName = abilityNames[RandomInt(1, #abilityNames)]
  return CastIterWrapper(unit, target, function(ability)
    if ability:GetName() == chosenName then
      GiveCastOrderAI(unit, target, ability)
      return true
    end
    return false
  end, rangeTolerance)
end

function GetRandomAvailableAbilityName(unit, target, abilityNames)
  local availNames = {}
  for _, abilityName in pairs(abilityNames) do
    local ability = unit:FindAbilityByName(abilityName)
    assert(ability, "No such ability: " .. abilityName)
    if CanCastAbility(unit, target, ability) then
      table.insert(availNames, abilityName)
    end
  end

  if #availNames == 0 then return nil end

  local chosenName = availNames[RandomInt(1, #availNames)]
  return chosenName
end

function CastRandomAvailableAbility(unit, target, abilityNames)
  local availNames = {}
  for _, abilityName in pairs(abilityNames) do
    local ability = unit:FindAbilityByName(abilityName)
    assert(ability, "No such ability: " .. abilityName)
    if CanCastAbility(unit, target, ability) then
      table.insert(availNames, abilityName)
    end
  end

  if #availNames == 0 then return false end

  local chosenName = availNames[RandomInt(1, #availNames)]
  return CastIterWrapper(unit, target, function(ability)
    if ability:GetName() == chosenName then
      GiveCastOrderAI(unit, target, ability)
      return true
    end
    return false
  end)
end

function CastAllAbilities(unit, target)
  return CastIterWrapper(unit, target, function(ability)
    GiveCastOrderAI(unit, target, ability)
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

function DrawDebugCircle(target, radius, duration)
  if not IsServer() then return end
  if not target or not radius then return end
  local pfx = ParticleManager:CreateParticle("particles/sanya_debug_radius_ring.vpcf", PATTACH_WORLDORIGIN, nil)
  ParticleManager:SetParticleControl(pfx, 0, GetTargetPos(target))
  ParticleManager:SetParticleControl(pfx, 2, Vector(radius, 0, 0))
  if duration then
    Timers:CreateTimer(duration, function()
      DestroyDebugCircle(pfx)
    end)
  end
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
    DOTA_UNIT_TARGET_TEAM_BOTH,
    DOTA_UNIT_TARGET_HERO,
    DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
    FIND_ANY_ORDER,
    false
  )

  for _, unit in ipairs(units) do
    if unit:IsRealHero() and unit:GetPlayerOwnerID() ~= -1 and not unit:IsSpiritBearCustom() then
      return unit
    end
  end

  return nil
end

function FindEnemiesForSanyaInRadius(center, radius)
  return FindUnitsInRadius(
    DOTA_TEAM_GOODGUYS,
    center,
    nil,
    radius,
    DOTA_UNIT_TARGET_TEAM_ENEMY,
    DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
    FIND_CLOSEST,
    false
  )
end

function FindEnemiesForSanyaInLine(p1, p2, width)
  return FindUnitsInLine(
    DOTA_TEAM_GOODGUYS,
    p1, p2,
    nil,
    width,
    DOTA_UNIT_TARGET_TEAM_ENEMY,
    DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE
  )
end

-- find enemies fo curTeam in segment starting at center, with direction of vector, radius is #vector and total width of cone in degrees is angle
function FindEnemiesInSector(curTeam, center, vector, angle)
  local units = FindUnitsInRadius(
    curTeam,
    center,
    nil,
    #vector,
    DOTA_UNIT_TARGET_TEAM_ENEMY,
    DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    DOTA_UNIT_TARGET_FLAG_NONE,
    FIND_ANY_ORDER,
    false
  )

  local unitsInSector = {}

  local cosHalfAngle = math.cos(math.rad(angle / 2))

  vector.z = 0
  local dirNormalized = vector:Normalized()
  for _, unit in pairs(units) do
    local vToUnit3D = unit:GetAbsOrigin() - center
    vToUnit3D.z = 0
    local vToUnit = vToUnit3D:Normalized()
    local dotProduct = dirNormalized:Dot(vToUnit)

    if dotProduct >= cosHalfAngle then
      table.insert(unitsInSector, unit)
    end
  end

  return unitsInSector
end

function FindEnemiesForAIInRadius(center, radius)
  return FindUnitsInRadius(
    DOTA_TEAM_BADGUYS,
    center,
    nil,
    radius,
    DOTA_UNIT_TARGET_TEAM_ENEMY,
    DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE + DOTA_UNIT_TARGET_FLAG_INVULNERABLE +
    DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
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
    DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE
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
  if not IsServer() then return true end
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
    if distToSpawn > 300 then
      MoveHome(unit)
    end
    intercept = true
  end

  if beaconState == 'retreat' or beaconState == 'idle' then
    if unit:GetHealthPercent() < 100 then
      unit:Heal(unit:GetMaxHealth() * 0.1, nil)
    end
  end

  if intercept then return true end

  if beaconState == 'aggro' and target and not target:IsNull() and target:IsAlive() then
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
    DebugPrint("AI Switch to interval: " .. target_interval)
  end
end

function ShowGenericLineWarning(p1, p2, width, duration, startEnt)
  local particleName = "particles/ui_mouseactions/custom_range_finder_cone.vpcf"
  local pfx = ParticleManager:CreateParticle(particleName, PATTACH_WORLDORIGIN, nil)
  ParticleManager:SetParticleControl(pfx, 1, p1)
  ParticleManager:SetParticleControl(pfx, 2, p1)
  ParticleManager:SetParticleControl(pfx, 3, Vector(width, width, 0))
  ParticleManager:SetParticleControl(pfx, 4, Vector(255, 0, 0))
  local elapsed  = 0
  local interval = 0.01
  local dist     = #(p1 - p2)
  local dir      = (p2 - p1):Normalized()
  local curEnd   = p1
  local lastTime = GameRules:GetGameTime()
  Timers:CreateTimer(interval, function()
    local now = GameRules:GetGameTime()
    local dt = now - lastTime
    lastTime = now

    curEnd = p1 + dir * dist * (elapsed / duration)
    ParticleManager:SetParticleControl(pfx, 2, curEnd)
    if startEnt then
      ParticleManager:SetParticleControl(pfx, 1, startEnt:GetAbsOrigin())
    end
    elapsed = elapsed + dt
    if elapsed >= duration then
      ParticleManager:DestroyParticle(pfx, false)
      ParticleManager:ReleaseParticleIndex(pfx)
      return nil
    else
      return interval
    end
  end)
end

function ShowGenericCircleWarning(center, radius, duration, centerEnt)
  local particleName = "particles/warning_circle.vpcf"
  local pfx = ParticleManager:CreateParticle(particleName, centerEnt and PATTACH_ABSORIGIN_FOLLOW or PATTACH_WORLDORIGIN,
    centerEnt)
  if not centerEnt then
    ParticleManager:SetParticleControl(pfx, 0, center)
  end
  ParticleManager:SetParticleControl(pfx, 1, Vector(radius, 0, 0))
  ParticleManager:SetParticleControl(pfx, 2, Vector(duration, 0, 0))
  Timers:CreateTimer(duration, function()
    ParticleManager:DestroyParticle(pfx, false)
    ParticleManager:ReleaseParticleIndex(pfx)
  end)
end

function ShowGenericCurveWarning(curveInfo, width, duration)
  local interval = 0.01
  local iter = curveInfo:UnstableIteratorElapsed()
  local point = iter()
  local pfx = ParticleManager:CreateParticle("particles/warning_rope.vpcf", PATTACH_WORLDORIGIN, nil)
  ParticleManager:SetParticleControl(pfx, 0, point)
  local z = GetGroundHeight(point, nil)
  ParticleManager:SetParticleControl(pfx, 1, Vector(width, 0, 0))

  local startTime = GameRules:GetGameTime()
  Timers:CreateTimer(0, function()
    point.z = z
    ParticleManager:SetParticleControl(pfx, 0, point)

    local curTime = GameRules:GetGameTime()

    point = iter((curTime - startTime) / duration)
    if point then
      return interval
    else
      ParticleManager:DestroyParticle(pfx, false)
      ParticleManager:ReleaseParticleIndex(pfx)
      return nil
    end
  end)
end

local function GetBisect(casterPos, targetPos, side)
  local vTarget = targetPos - casterPos
  local sidePos = casterPos + side * vTarget:Length()
  local midPoint = (sidePos + targetPos) / 2
  return (midPoint - casterPos):Normalized()
end

-- aimed towards, 45 degrees to the side, returns direction with more space
function GetOptimalStrafeDestination(casterPos, targetPos, distance)
  local side = (targetPos - casterPos):Normalized():Cross(Vector(0, 0, 1)):Normalized()
  local strafeDir = GetBisect(casterPos, targetPos, side)
  local dest = GetSafeBlinkDestination(casterPos, casterPos + strafeDir * distance)
  local otherDir = GetBisect(casterPos, targetPos, -side)
  local otherDest = GetSafeBlinkDestination(casterPos, casterPos + otherDir * distance)
  if #(otherDest - casterPos) > #(dest - casterPos) then
    strafeDir = otherDir
    dest = otherDest
  end
  return dest
end

-- startAngle (IN RADIANS) is optional (default 0)
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

-- creates a fan of N lines spread in +-alpha (in degrees) around given line
function PointsFan(startPos, endPos, numPoints, alpha)
  local endPoints = {}
  local alphaRad = math.rad(alpha)

  local dx = endPos.x - startPos.x
  local dy = endPos.y - startPos.y

  local baseAngle = math.atan2(dy, dx)
  local length = math.sqrt(dx * dx + dy * dy)

  if numPoints <= 1 then
    return { endPos }
  end

  for i = 0, numPoints - 1 do
    local fraction = i / (numPoints)

    local relativeAngle = -alphaRad + (fraction * (alphaRad * 2))
    local finalAngle = baseAngle + relativeAngle

    local newEndX = startPos.x + math.cos(finalAngle) * length
    local newEndY = startPos.y + math.sin(finalAngle) * length

    table.insert(endPoints, Vector(newEndX, newEndY, endPos.z))
  end

  return endPoints
end

------------------------------------------------------------
ArcInfo = class {}

function ArcInfo:constructor(center, radius, startAngle, sweep, startPoint, endPoint)
  self.center = center
  self.radius = radius
  self.startAngle = startAngle
  self.sweep = sweep
  self.startPoint = startPoint
  self.endPoint = endPoint
end

function ArcInfo:StableIterator(nSteps)
  local i = 0
  return function()
    if i > nSteps then return nil end

    local t = i / nSteps
    local currentAngle = self.startAngle + (self.sweep * t)

    local px = self.center.x + self.radius * math.cos(currentAngle)
    local py = self.center.y + self.radius * math.sin(currentAngle)

    i = i + 1
    return Vector(px, py, 0)
  end
end

-- Returns a function that can be called with delta values that accumulate to 1.0 at traversal finish.
-- i.e. iter(0.05) - iter(0.3) - iter(0.15) - iter(0.5) which will yield proportional steps
-- usable in iter(dt/totalTime) scenarios
function ArcInfo:UnstableIterator()
  local elapsed = 0
  local reachedEnd = false

  return function(dt)
    if reachedEnd then return nil end
    dt = dt or 0

    local currentAngle = self.startAngle + (self.sweep * elapsed)

    local px = self.center.x + self.radius * math.cos(currentAngle)
    local py = self.center.y + self.radius * math.sin(currentAngle)

    if elapsed >= 1 then
      reachedEnd = true
    end

    elapsed = math.min(elapsed + dt, 1)

    return Vector(px, py, 0)
  end
end

-- same as UnstableIterator but iter function takes normalized elapsed time instead of dt (length fraction essentially)
function ArcInfo:UnstableIteratorElapsed()
  local reachedEnd = false

  return function(elapsed)
    if reachedEnd then return nil end
    elapsed = elapsed and math.min(1, elapsed) or 0

    local currentAngle = self.startAngle + (self.sweep * elapsed)

    local px = self.center.x + self.radius * math.cos(currentAngle)
    local py = self.center.y + self.radius * math.sin(currentAngle)

    if elapsed >= 1 then
      reachedEnd = true
    end

    return Vector(px, py, 0)
  end
end

function ArcInfo:Length()
  return math.abs(self.radius * self.sweep)
end

-- returns an ArcInfo object that has several iterators
function PointsArc(startPoint, midPoint, endPoint)
  startPoint.z = 0
  midPoint.z = 0
  endPoint.z = 0
  local x1, y1 = startPoint.x, startPoint.y
  local x2, y2 = midPoint.x, midPoint.y
  local x3, y3 = endPoint.x, endPoint.y

  local D = 2 * (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2))

  if math.abs(D) < 1e-9 then
    error("Points are collinear; cannot form an arc.")
  end

  local h          = ((x1 ^ 2 + y1 ^ 2) * (y2 - y3) + (x2 ^ 2 + y2 ^ 2) * (y3 - y1) + (x3 ^ 2 + y3 ^ 2) * (y1 - y2)) / D
  local k          = ((x1 ^ 2 + y1 ^ 2) * (x3 - x2) + (x2 ^ 2 + y2 ^ 2) * (x1 - x3) + (x3 ^ 2 + y3 ^ 2) * (x2 - x1)) / D

  local center     = Vector(h, k, 0)
  local radius     = #(startPoint - center)

  local startAngle = math.atan2(y1 - k, x1 - h)
  local midAngle   = math.atan2(y2 - k, x2 - h)
  local endAngle   = math.atan2(y3 - k, x3 - h)

  local sweep      = endAngle - startAngle
  if sweep < -math.pi then sweep = sweep + 2 * math.pi end
  if sweep > math.pi then sweep = sweep - 2 * math.pi end

  local midSweep = midAngle - startAngle
  if midSweep < -math.pi then midSweep = midSweep + 2 * math.pi end
  if midSweep > math.pi then midSweep = midSweep - 2 * math.pi end

  if (midSweep > 0) ~= (sweep > 0) or math.abs(midSweep) > math.abs(sweep) then
    sweep = (sweep > 0) and (sweep - 2 * math.pi) or (sweep + 2 * math.pi)
  end

  return ArcInfo(center, radius, startAngle, sweep, startPoint, endPoint)
end

---------------------------------------------------------------------------------------------------
ParabolaInfo = class {}

function ParabolaInfo:constructor(startPoint, endPoint, ctrlPoint)
  self.startPoint = startPoint
  self.ctrlPoint = ctrlPoint
  self.endPoint = endPoint
end

function ParabolaInfo:GetPoint(fraction)
  local invT = 1 - fraction
  return (self.startPoint * (invT ^ 2)) +
      (self.ctrlPoint * (2 * invT * fraction)) +
      (self.endPoint * (fraction ^ 2))
end

-- see ArcInfo:UnstableIterator
function ParabolaInfo:UnstableIterator()
  local t = 0
  local reachedEnd = false

  return function(dt)
    if reachedEnd then return nil end

    dt = dt or 0
    local point = self:GetPoint(t)

    if t >= 1 then
      reachedEnd = true
    end

    t = math.min(t + dt, 1)

    return point
  end
end

function ParabolaInfo:UnstableIteratorElapsed()
  local reachedEnd = false

  return function(elapsed)
    if reachedEnd then return nil end

    elapsed = elapsed and math.min(1, elapsed) or 0
    local point = self:GetPoint(elapsed)
    DrawDebugCircle(point, 30, 0.2)

    if elapsed >= 1 then
      reachedEnd = true
    end

    return point
  end
end

-- see ArcInfo:StableIterator
function ParabolaInfo:StableIterator(numPoints)
  local i = 0

  return function()
    if i > numPoints then return nil end

    local point = self:GetPoint(i / numPoints)
    i = i + 1
    return point
  end
end

function ParabolaInfo:Length()
  local length = 0
  local prevPoint = self.startPoint
  for point in self:StableIterator(200) do
    length = length + #(prevPoint - point)
    prevPoint = point
  end
  return length
end

-- returns ParabolaInfo
function PointsParabola(startPoint, midPoint, endPoint)
  local ctrlPoint = (midPoint * 2) - (startPoint * 0.5) - (endPoint * 0.5)

  return ParabolaInfo(
    startPoint,
    endPoint,
    ctrlPoint
  )
end
