require('libraries/event')

GameEvents = GameEvents or {}

function CreateGameEvent (name) --luacheck: ignore CreateGameEvent
  local event = Event()

  GameEvents[name] = (function (self, fn)
    return event.listen(fn)
  end)

  return event.broadcast
end


