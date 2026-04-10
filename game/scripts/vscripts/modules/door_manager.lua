DoorManager = DoorManager or {}

function DoorManager:Init()
  ChatCommand:LinkDevCommand("-dooropen", function(event, args)
    self:Open(args[1])
  end)
  ChatCommand:LinkDevCommand("-doorclose", function(event, args)
    self:Close(args[1])
  end)

  GameEvents:OnButtonPress(function(event)
    for doorName, door in EntityData:AllByType("door") do
      if not door.requiresButtons then goto continue end
      local idx = -1
      for i, reqBtn in ipairs(door.requiresButtons) do
        if reqBtn == event.buttonName then
          idx = i
          break
        end
      end
      if idx == -1 then goto continue end
      table.remove(door.requiresButtons, idx)
      if TableLength(door.requiresButtons) == 0 then
        self:Open(doorName)
      end
      ::continue::
    end
  end)

  GameEvents:OnPlayerUsedChat(function(event)
    local input = event.text:lower():gsub('[%p%c]', '')
    local playerID = event.playerID
    local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
    for doorName, door in EntityData:AllByType("door") do
      if not door.requiresPassword then goto continue end

      local minDist = math.huge
      for _, doorEnt in ipairs(Entities:FindAllByName(doorName)) do
        local dist = (doorEnt:GetAbsOrigin() - hero:GetAbsOrigin()):Length()
        if dist < minDist then
          minDist = dist
        end
      end

      DebugPrint("[ALNOIRE] Checking door pass attempt: " .. input .. ", against: " .. door.requiresPassword)
      if door.requiresPassword == input and minDist <= DOOR_PASSWORD_RADIUS then
        door.requiresPassword = nil -- all passwords work once
        self:Open(doorName)
        break
      end
      ::continue::
    end
  end)
end

function DoorManager:Open(doorName)
  local data = EntityData:ByName(doorName)
  assert(data, "No data for door: " .. doorName)
  assert(data.clipEntity, "No clip entity for door: " .. doorName)
  DebugPrint("[ALNOIRE] Opening door: " .. doorName)

  for _, clipEnt in ipairs(Entities:FindAllByName(data.clipEntity)) do
    DoEntFireByInstanceHandle(clipEnt, "Disable", "", 0, nil, nil)
  end

  if data.openAnimation then
    for _, doorEnt in ipairs(Entities:FindAllByName(doorName)) do
      DoEntFireByInstanceHandle(doorEnt, "SetAnimation", data.openAnimation, 0, nil, nil)
    end
  end

  if data.particle then
    local doorEnt = Entities:FindByName(nil, doorName)
    local pfx = ParticleManager:CreateParticle(data.particle, PATTACH_ABSORIGIN,
      doorEnt)
    ParticleManager:ReleaseParticleIndex(pfx)
  end

  if data.openSound then
    local doorEnt = Entities:FindByName(nil, doorName)
    assert(doorEnt)
    doorEnt:EmitSound(data.openSound)
  end
end

function DoorManager:Close(doorName)
  local data = EntityData:ByName(doorName)
  assert(data, "No data for door: " .. doorName)
  assert(data.clipEntity, "No clip entity for door: " .. doorName)

  for _, clipEnt in ipairs(Entities:FindAllByName(data.clipEntity)) do
    DoEntFireByInstanceHandle(clipEnt, "Enable", "", 0, nil, nil)
  end

  if data.closeAnimation then
    for _, doorEnt in ipairs(Entities:FindAllByName(doorName)) do
      DoEntFireByInstanceHandle(doorEnt, "SetAnimation", data.closeAnimation, 0, nil, nil)
    end
  end

  -- if data.closeSound then
  --   local doorEnt = Entities:FindByName(nil, doorName)
  --   assert(doorEnt)
  --   doorEnt:EmitSound(data.closeSound)
  -- end
end

return DoorManager
