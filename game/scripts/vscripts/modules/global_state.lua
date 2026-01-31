GlobalState = GlobalState or {}

function GlobalState:Init()
    self.state = {
        act = 0,
    }
end

function GlobalState:Get()
    return self.state
end

return GlobalState
