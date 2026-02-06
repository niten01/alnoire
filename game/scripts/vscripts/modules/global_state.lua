GlobalState = GlobalState or {}

function GlobalState:Init()
    self.state = {
        act = 1,
        knows_village_password = false,
        has_village_pass = false,
        has_ski = false,
    }


    GameEvents:OnGameInProgress(function()
        -- set initial act
        GlobalState:SetAct(self.state.act)
    end)

    ChatCommand:LinkDevCommand("-setact", function(event, args)
        GlobalState:SetAct(tonumber(args[1]))
    end)
end

local OnActChangeEvent = CreateGameEvent 'OnActChange'
function GlobalState:SetAct(act)
    self.state.act = act
    OnActChangeEvent({ act = act })
end

function GlobalState:Get()
    return self.state
end

return GlobalState
