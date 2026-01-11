
function GameMode:OnAnyNPCSpawned(keys)
	local unit = EntIndexToHScript(keys.entindex)

	if not unit or unit:IsNull() then return end


	if  unit:IsRealHero() and unit.bFirstSpawned == nil then
        unit.bFirstSpawned = true;
        GameMode:OnHeroSpawned(keys)
    end 

    -- handles both npcs and heroes
    GameMode:OnNPCSpawned(keys)
end

function GameMode:OnGameRulesStateChange(keys)
    if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        GameMode:OnGameInProgress(keys)
    end
end