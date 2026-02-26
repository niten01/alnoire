GlobalState = GlobalState or {}

function GlobalState:Init()
    self.state = {
        act = 0,

        freed_island_creeps = false,
        knows_village_password = false,
        has_village_pass = false,
        has_ski = false,
        green_test_tried = false,
        perekup_good_ending = false,

        has_concert_pass = false,
        concert_crowd_met = false,
        concert_crowd_beaten = false,

        is_ghetto_member = false,
    }


    GameEvents:OnGameInProgress(function()
        -- set initial act
        GlobalState:SetAct(self.state.act)
    end)

    ChatCommand:LinkDevCommand("-setact", function(event, args)
        GlobalState:SetAct(tonumber(args[1]))
    end)
    ChatCommand:LinkDevCommand("-getvar", function(event, args)
        print(args[1], ':', GlobalState:Get()[args[1]])
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
