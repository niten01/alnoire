function DebugPrint(...)
  if USE_DEBUG then
    print(...)
  end
end

function PrintTable(t, indent, done)
  if not USE_DEBUG then
    return
  end
  --print ( string.format ('PrintTable type %s', type(keys)) )
  if type(t) ~= "table" then return end

  done = done or {}
  done[t] = true
  indent = indent or 0

  local l = {}
  for k, v in pairs(t) do
    table.insert(l, k)
  end

  table.sort(l)
  for k, v in ipairs(l) do
    -- Ignore FDesc
    if v ~= 'FDesc' then
      local value = t[v]

      if type(value) == "table" and not done[value] then
        done[value] = true
        print(string.rep(" ", indent) .. tostring(v) .. ":")
        PrintTable(value, indent + 2, done)
      elseif type(value) == "userdata" and not done[value] then
        done[value] = true
        print(string.rep(" ", indent) .. tostring(v) .. ": " .. tostring(value))
        PrintTable((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done)
      else
        if t.FDesc and t.FDesc[v] then
          print(string.rep(" ", indent) .. tostring(t.FDesc[v]))
        else
          print(string.rep(" ", indent) .. tostring(v) .. ": " .. tostring(value))
        end
      end
    end
  end
end

-- Requires an element (key) and a table, returns true if element is in the table.
function TableContains(t, element)
  if t == nil then return false end
  for k, v in pairs(t) do
    if k == element then
      return true
    end
  end
  return false
end

-- Return length of the table even if the table is nil or empty
-- # operator will not calculate table length properly if the table contains nil elements
function TableLength(t)
  if t == nil or t == {} then
    return 0
  end
  local length = 0
  for k, v in pairs(t) do
    length = length + 1
  end
  return length
end

function GetRandomTableElement(t)
  -- iterate over whole table to get all keys
  local keyset = {}
  for k in pairs(t) do
    table.insert(keyset, k)
  end
  -- keyset table doesn't have nil elements
  return t[keyset[RandomInt(1, #keyset)]]
end

-- Colors
COLOR_NONE = '\x06'
COLOR_GRAY = '\x06'
COLOR_GREY = '\x06'
COLOR_GREEN = '\x0C'
COLOR_DPURPLE = '\x0D'
COLOR_SPINK = '\x0E'
COLOR_DYELLOW = '\x10'
COLOR_PINK = '\x11'
COLOR_RED = '\x12'
COLOR_LGREEN = '\x15'
COLOR_BLUE = '\x16'
COLOR_DGREEN = '\x18'
COLOR_SBLUE = '\x19'
COLOR_PURPLE = '\x1A'
COLOR_ORANGE = '\x1B'
COLOR_LRED = '\x1C'
COLOR_GOLD = '\x1D'

function DebugAllCalls()
  if not GameRules.DebugCalls then
    print("Starting DebugCalls")
    GameRules.DebugCalls = true

    debug.sethook(function(...)
      local info = debug.getinfo(2)
      local src = tostring(info.short_src)
      local name = tostring(info.name)
      if name ~= "__index" then
        print("Call: " .. src .. " -- " .. name .. " -- " .. info.currentline)
      end
    end, "c")
  else
    print("Stopped DebugCalls")
    GameRules.DebugCalls = false
    debug.sethook(nil, "c")
  end
end

-- Author: Noya
-- This function hides all dota item cosmetics (hats/wearables) from the hero/unit and store them into a handle variable
-- Works only for wearables added with code
function HideWearables(unit)
  unit.hiddenWearables = {} -- Keep every wearable handle in a table to show them later
  local model = unit:FirstMoveChild()
  while model ~= nil do
    if model:GetClassname() == "dota_item_wearable" then
      model:AddEffects(EF_NODRAW) -- Set model hidden
      table.insert(unit.hiddenWearables, model)
    end
    model = model:NextMovePeer()
  end
end

-- Author: Noya
-- This function un-hides (shows) wearables that were hidden with HideWearables() function.
function ShowWearables(unit)
  for k, v in pairs(unit.hiddenWearables) do
    v:RemoveEffects(EF_NODRAW)
  end
end

-- Author: Noya
-- This function changes (swaps) dota item cosmetic models (hats/wearables)
-- Works only for wearables added with code
function SwapWearable(unit, target_model, new_model)
  local wearable = unit:FirstMoveChild()
  while wearable ~= nil do
    if wearable:GetClassname() == "dota_item_wearable" then
      if wearable:GetModelName() == target_model then
        wearable:SetModel(new_model)
        return
      end
    end
    wearable = wearable:NextMovePeer()
  end
end

-- This function checks if a given unit is Roshan, returns boolean value;
function CDOTA_BaseNPC:IsRoshanCustom()
  return string.find(self:GetUnitName(), "npc_dota_roshan")
end

-- This function checks if this entity is a fountain or not; returns boolean value;
function CBaseEntity:IsFountain()
  if self:GetName() == "ent_dota_fountain_bad" or self:GetName() == "ent_dota_fountain_good" then
    return true
  end

  return false
end

-- This function checks if a given unit is Lone Druid's Spirit Bear, returns boolean value;
function CDOTA_BaseNPC:IsSpiritBearCustom()
  return string.find(self:GetUnitName(), "towel_summon")
end

function IsMonkeyKingCloneCustom(entity)
  if entity.HasModifier == nil then
    return false
  end

  local monkey_king_soldier_modifiers = {
    "modifier_monkey_king_fur_army_soldier_hidden",
    "modifier_monkey_king_fur_army_soldier",
    "modifier_monkey_king_fur_army_thinker",
    "modifier_monkey_king_fur_army_soldier_inactive",
    "modifier_monkey_king_fur_army_soldier_in_position",
  }

  for _, v in pairs(monkey_king_soldier_modifiers) do
    if entity:HasModifier(v) then
      return true
    end
  end

  return false
end

-- Author: Noya
-- This function is showing custom Error Messages using notifications library
function SendErrorMessage(pID, string)
  if Notifications then
    Notifications:ClearBottom(pID)
    Notifications:Bottom(pID, { text = string, style = { color = '#E62020' }, duration = 2 })
  end
  EmitSoundOnClient("General.Cancel", PlayerResource:GetPlayer(pID))
end

function VectorDistanceSq(v1, v2)
  return (v1.x - v2.x) * (v1.x - v2.x) + (v1.y - v2.y) * (v1.y - v2.y) + (v1.z - v2.z) * (v1.z - v2.z)
end

function VectorDistance(v1, v2)
  return math.sqrt(VectorDistanceSq(v1, v2))
end

function extend(old, extra)
  local t = {}
  for k, v in pairs(old) do
    t[k] = v
  end
  for k, v in pairs(extra) do
    t[k] = v
  end
  return t
end

function concatArrays(t1,t2)
   for i=1,#t2 do
      t1[#t1+1] = t2[i]
   end
   return t1
end

function bind(fn, arg1, ...)
  if select("#", ...) == 0 then
    return function(...)
      return fn(arg1, ...)
    end
  else
    return bind(bind(fn, arg1), ...)
  end
end

function copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
  return res
end

function split(s, delimiter)
  local result = {}
  for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

---@param o1 any|table First object to compare
---@param o2 any|table Second object to compare
function equals(o1, o2)
  if o1 == o2 then return true end
  local o1Type = type(o1)
  local o2Type = type(o2)
  if o1Type ~= o2Type then return false end
  if o1Type ~= 'table' then return false end

  local keySet = {}

  for key1, value1 in pairs(o1) do
    local value2 = o2[key1]
    if value2 == nil or equals(value1, value2) == false then
      return false
    end
    keySet[key1] = true
  end

  for key2, _ in pairs(o2) do
    if not keySet[key2] then return false end
  end
  return true
end

function contains(seq, val)
  for _, el in ipairs(seq) do
    if val == el then return true end
  end
  return false
end

function max(seq)
  local mx = -math.huge
  for _, el in ipairs(seq) do
    if el > mx then mx = el end
  end
  return mx
end

--- @param start Vector unit position where blink started
--- @param targetRaw Vector basically click position
function GetSafeBlinkDestination(start, targetRaw, distance)
  local direction = (targetRaw - start):Normalized()
  local target = targetRaw
  local initialDistance = #(targetRaw - start)
  if distance then
    target = start + direction * math.min(distance, initialDistance)
  end

  local accum = start
  local maxLength = #(target - start)
  while #(accum - start) < maxLength do
    accum = accum + direction * SAFE_BLINK_PRECISION
    if GridNav:IsBlocked(accum) or not GridNav:IsTraversable(accum) then
      break
    end
  end

  return accum
end

function PlayLogarithmusBladeEffect(caster, duration)
  local pfx = ParticleManager:CreateParticle("particles/logarithmus_blade_effect.vpcf", PATTACH_CUSTOMORIGIN,
    caster)
  ParticleManager:SetParticleControlEnt(pfx, 1, caster, PATTACH_POINT_FOLLOW, "attach_blade_start",
    Vector(0, 0, 0), false)
  ParticleManager:SetParticleControlEnt(pfx, 2, caster, PATTACH_POINT_FOLLOW, "attach_blade_end",
    Vector(0, 0, 0), false)
  ParticleManager:SetParticleControl(pfx, 3, Vector(duration, 0, 0))
  ParticleManager:ReleaseParticleIndex(pfx)
end

function PlayLogarithmusImpaleEffect(target, hitFromPos)
  local pfx = ParticleManager:CreateParticle("particles/logarithmus_step_impale.vpcf", PATTACH_CUSTOMORIGIN, ent)
  ParticleManager:SetParticleControlEnt(pfx, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), false)
  ParticleManager:SetParticleControlTransformForward(pfx, 1, target:GetAbsOrigin(),
    (target:GetAbsOrigin() - hitFromPos):Normalized())
  ParticleManager:ReleaseParticleIndex(pfx)

  target:EmitSound("ability.logarithmus.impale")
end

function IncrementLogarithmusStacks(caster)
  local mod = caster:FindModifierByName("modifier_logarithmus_concentration")
  assert(mod)
  if mod:GetStackCount() >= mod:GetAbility():GetSpecialValueFor("max_stacks") then return end
  mod:IncrementStackCount()
end
