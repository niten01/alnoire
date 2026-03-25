Zones = class {}

function Zones:Init()
    GameEvents:OnEntityKilled(function(event)
        local victim = event.killed_unit
        if victim:IsRealHero() and not victim:IsSpiritBearCustom() then
            Timers:CreateTimer(CUSTOM_RESPAWN_TIME, function()
                for zoneName, _ in EntityData:AllByType("zone") do
                    for _, zoneTrigger in ipairs(Entities:FindAllByName(zoneName)) do
                        if zoneTrigger:IsTouching(victim) then
                            -- this is respawn mechanic quirk, so ig it's ok to emulate trigger touch here
                            ZoneOnStartTouch(zoneTrigger, { activator = victim })
                            goto out
                        end
                    end
                end
                ::out::
            end)
        end
    end)
end

return Zones
