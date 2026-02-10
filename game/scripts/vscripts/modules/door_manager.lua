DoorManager = DoorManager or {}

function DoorManager:Init()
  ChatCommand:LinkDevCommand("-dooropen", function(event, args)
    self:Open(args[1])
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
        self:Open(doorName)
        break
      end
      ::continue::
    end
  end)
end

function DoorManager:Open(doorName)
  local data = EntityData:ByName(doorName)
  if not data then
    error("No data for door: " .. doorName)
    return
  end

  if not data.clipEntity then
    error("No clip entity for door: " .. doorName)
    return
  end
  for _, clipEnt in ipairs(Entities:FindAllByName(data.clipEntity)) do
    DoEntFireByInstanceHandle(clipEnt, "Disable", "", 0, nil, nil)
  end

  if data.openAnimation then
    for _, doorEnt in ipairs(Entities:FindAllByName(doorName)) do
      DoEntFireByInstanceHandle(doorEnt, "SetAnimation", data.openAnimation, 0, nil, nil)
    end
  end
end

return DoorManager
