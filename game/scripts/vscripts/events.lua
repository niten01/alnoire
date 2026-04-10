require('internal.gameevents')

-- Handle stuff when a player disconnects
function barebones:OnDisconnect(keys)
	DebugPrint("[BAREBONES] A Player has disconnected (not wired)")
	--PrintTable(keys)

	local name = keys.name
	local networkID = keys.networkid
	local reason = keys.reason
	local userID = keys.userid
	local playerID = keys.PlayerID
end

-- The overall game state has changed
function barebones:OnGameRulesStateChange(keys)
	--PrintTable(keys)

	local new_state = GameRules:State_Get()

	if new_state == DOTA_GAMERULES_STATE_INIT then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_INIT")
	elseif new_state == DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD")
	elseif new_state == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP")
		GameRules:SetCustomGameSetupAutoLaunchDelay(CUSTOM_GAME_SETUP_TIME)
	elseif new_state == DOTA_GAMERULES_STATE_HERO_SELECTION then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_HERO_SELECTION")
		self:OnAllPlayersLoaded()
	elseif new_state == DOTA_GAMERULES_STATE_STRATEGY_TIME then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_STRATEGY_TIME")
	elseif new_state == DOTA_GAMERULES_STATE_TEAM_SHOWCASE then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_TEAM_SHOWCASE")
	elseif new_state == DOTA_GAMERULES_STATE_WAIT_FOR_MAP_TO_LOAD then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_WAIT_FOR_MAP_TO_LOAD")
	elseif new_state == DOTA_GAMERULES_STATE_PRE_GAME then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_PRE_GAME")
		local gamemode = GameRules:GetGameModeEntity()
		gamemode:SetCustomDireScore(0)
		gamemode:SetCustomRadiantScore(0)
	elseif new_state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_GAME_IN_PROGRESS")
		self:OnGameInProgress()
	elseif new_state == DOTA_GAMERULES_STATE_POST_GAME then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_POST_GAME")
	elseif new_state == DOTA_GAMERULES_STATE_DISCONNECT then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_DISCONNECT")
	end
end

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function barebones:OnAllPlayersLoaded()
	DebugPrint("[BAREBONES] All Players have loaded into the game. (not wired)")
end

--[[
  This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
  gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
  is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]
local OnGameInProgressEvent = CreateGameEvent 'OnGameInProgress'
function barebones:OnGameInProgress()
	DebugPrint("[BAREBONES] Game in progress.")

	-- If the day/night is not changed at 00:00, the following line is needed:
	GameRules:SetTimeOfDay(0.251)

	local gamemode = GameRules:GetGameModeEntity()
	gamemode:SetContextThink("InventoryTracker", function()
		return self:InventoryThink()
	end, 0)

	OnGameInProgressEvent()
end

-- An NPC has spawned somewhere in game. This includes heroes
local OnNPCSpawnedEvent = CreateGameEvent 'OnNPCSpawned'
function barebones:OnNPCSpawned(keys)
	-- DebugPrint("[BAREBONES] A unit spawned: entindex=" .. keys.entindex)

	local npc
	if keys.entindex then
		npc = EntIndexToHScript(keys.entindex)
	else
		print("npc_spawned event doesn't have entindex key")
		return
	end

	-- OnHeroInGame
	if npc:IsRealHero() and not npc.bFirstSpawned then
		npc.bFirstSpawned = true
		self:OnHeroInGame(npc)
	end

	OnNPCSpawnedEvent(extend(keys, { unit = npc }))
end

--[[
  Hero spawned for the first time. It can happen if the player's hero is replaced with a new hero for any reason.
  This can be used for initializing heroes, such as adding levels, changing the starting gold, removing/adding abilities, adding physics, etc.
  This happens to bot and custom created heroes as well.
  The hero parameter is the hero entity that just spawned.
]]
local OnHeroInGameEvent = CreateGameEvent 'OnHeroInGame'
local OnTowelSummonInGameEvent = CreateGameEvent 'OnTowelSummonInGame'
function barebones:OnHeroInGame(hero)
	-- -- Innate abilities like Earth Spirit Stone Remnant (abilities that a hero needs to have auto-leveled up at the start of the game)
	-- -- Take a look at this guide: https://moddota.com/abilities/creating-innate-abilities
	-- local innate_abilities = {
	-- 	"innate_ability1",
	-- 	"innate_ability2"
	-- }

	-- -- Cycle through any innate abilities found, then set their level to 1
	-- for i = 1, #innate_abilities do
	-- 	local current_ability = hero:FindAbilityByName(innate_abilities[i])
	-- 	if current_ability then
	-- 		current_ability:SetLevel(1)
	-- 	end
	-- end

	Timers:CreateTimer(0.5, function()
		local playerID = hero:GetPlayerID() -- never nil (-1 by default), needs delay 1 or more frames

		if PlayerResource:IsFakeClient(playerID) then
			-- This is happening only for bots
			DebugPrint("[BAREBONES] OnHeroInGame - Bot hero " .. hero:GetUnitName() .. " (re)spawned in the game.")
			-- Set starting gold for bots
			hero:SetGold(NORMAL_START_GOLD, false)
		else
			DebugPrint("[BAREBONES] OnHeroInGame running for a non-bot player!")
			if not PlayerResource.PlayerData[playerID] and PlayerResource:IsValidPlayerID(playerID) then
				PlayerResource:InitPlayerDataForID(playerID)
			end
			if hero:IsClone() then
				DebugPrint("[BAREBONES] OnHeroInGame - Spawned hero is a Meepo Clone")
				return
			elseif hero:IsTempestDouble() then
				DebugPrint("[BAREBONES] OnHeroInGame - Spawned hero is a Tempest Double")
				return
			elseif IsMonkeyKingCloneCustom(hero) then
				DebugPrint("[BAREBONES] OnHeroInGame - Spawned hero is a Monkey King soldier or invalid entity")
				return
			elseif hero:IsSpiritBearCustom() then
				DebugPrint("[BAREBONES] OnHeroInGame - Spawned hero is a Spirit Bear")
				OnTowelSummonInGameEvent(hero)
				return
			end
			-- Set some hero stuff on first spawn or on every spawn (custom or not)
			if PlayerResource.PlayerData[playerID].already_set_hero == true then
				-- This is happening only when players create new heroes or replace them
			else
				-- This is happening for players when their primary hero spawns for the first time
				DebugPrint("[BAREBONES] OnHeroInGame - Hero " ..
					hero:GetUnitName() .. " spawned in the game for the first time for the player with ID: " .. playerID)

				-- Make heroes briefly visible on spawn (to prevent bad fog of war interactions)
				hero:MakeVisibleToTeam(DOTA_TEAM_GOODGUYS, 0.5)
				hero:MakeVisibleToTeam(DOTA_TEAM_BADGUYS, 0.5)

				-- Reentrant check
				PlayerResource.PlayerData[playerID].already_set_hero = true
				DebugPrint("[BAREBONES] OnHeroInGame - Hero " ..
					hero:GetUnitName() .. " set for the player with ID: " .. playerID)
			end

			OnHeroInGameEvent(hero)
		end
	end)
end

local OnItemPickedUpEvent = CreateGameEvent 'OnItemPickedUp'
function barebones:OnItemPickedUp(keys)
	DebugPrint("[BAREBONES] OnItemPickedUp event")
	--PrintTable(keys)

	-- Find who picked up the item
	local unit_entity
	if keys.UnitEntitIndex then -- keys.UnitEntitIndex may be always nil
		unit_entity = EntIndexToHScript(keys.UnitEntitIndex)
	elseif keys.HeroEntityIndex then
		unit_entity = EntIndexToHScript(keys.HeroEntityIndex)
	end

	local item_entity
	if keys.ItemEntityIndex then
		item_entity = EntIndexToHScript(keys.ItemEntityIndex)
	end
	local playerID = keys.PlayerID
	local item_name = keys.itemname

	OnItemPickedUpEvent(extend(keys, { unit_entity = unit_entity, item_entity = item_entity }))
end

local OnPlayerReconnectEvent = CreateGameEvent 'OnPlayerReconnect'
function barebones:OnPlayerReconnect(keys)
	DebugPrint("[BAREBONES] A Player has reconnected.")
	--PrintTable(keys)

	local new_state = GameRules:State_Get()
	if new_state > DOTA_GAMERULES_STATE_HERO_SELECTION then
		local playerID = keys.PlayerID or keys.player_id

		if not playerID or not PlayerResource:IsValidPlayerID(playerID) then
			print("OnPlayerReconnect - Reconnected player ID isn't valid!")
		end

		OnPlayerReconnectEvent(extend(keys, { playerID = playerID }))
	end
end

-- An ability was used by a player; Doesn't trigger on disconnected players.
local OnAbilityUsedEvent = CreateGameEvent 'OnAbilityUsed'
function barebones:OnAbilityUsed(keys)
	--PrintTable(keys)

	local playerID = keys.PlayerID
	local ability_name = keys.abilityname

	OnAbilityUsedEvent(keys)
end

-- A player leveled up an ability; Note: IT DOESN'T TRIGGER WHEN YOU USE SetLevel() ON THE ABILITY!
local OnPlayerLearnedAbilityEvent = CreateGameEvent 'OnPlayerLearnedAbility'
function barebones:OnPlayerLearnedAbility(keys)
	DebugPrint("[BAREBONES] OnPlayerLearnedAbility event")
	--PrintTable(keys)

	local player
	if keys.player then
		player = EntIndexToHScript(keys.player)
	end

	local ability_name = keys.abilityname

	local playerID
	if player then
		playerID = player:GetPlayerID()
	else
		playerID = keys.PlayerID
	end

	-- PlayerResource:GetBarebonesAssignedHero(index) is custom-made; can be found in 'player_resource.lua' library
	-- This could return a wrong hero if you change your hero often during gameplay
	local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
	OnPlayerLearnedAbilityEvent(extend(keys, { hero = hero }))
end

-- A player leveled up
local OnPlayerLevelUpEvent = CreateGameEvent 'OnPlayerLevelUp'
function barebones:OnPlayerLevelUp(keys)
	DebugPrint("[BAREBONES] OnPlayerLevelUp event")
	--PrintTable(keys)

	local level = keys.level
	local playerID = keys.player_id or keys.PlayerID

	local hero
	if keys.hero_entindex then
		hero = EntIndexToHScript(keys.hero_entindex)
	else
		hero = PlayerResource:GetBarebonesAssignedHero(playerID)
	end

	if hero then
		if not NO_SKILL_POINTS_LEVELS[level] then
			local unspent_ap = hero:GetAbilityPoints()
			hero:SetAbilityPoints(unspent_ap + 1)
		end
		-- Update hero gold bounty when a hero gains a level
		if USE_CUSTOM_HERO_GOLD_BOUNTY then
			local hero_level = hero:GetLevel() or level
			local hero_streak = hero:GetStreak()

			local gold_bounty
			if hero_streak > 2 then
				gold_bounty = HERO_KILL_GOLD_BASE + hero_level * HERO_KILL_GOLD_PER_LEVEL +
					(hero_streak - 2) * HERO_KILL_GOLD_PER_STREAK
			else
				gold_bounty = HERO_KILL_GOLD_BASE + hero_level * HERO_KILL_GOLD_PER_LEVEL
			end

			hero:SetMinimumGoldBounty(gold_bounty)
			hero:SetMaximumGoldBounty(gold_bounty)
		end

		-- Example how to add an extra skill point when a hero levels up
		--[[
		local levels_without_ability_point = {17, 19, 21, 22, 23, 24}	-- on this levels you should get a skill point (edit this if needed)
		for i = 1, #levels_without_ability_point do
			if level == levels_without_ability_point[i] then
				local unspent_ability_points = hero:GetAbilityPoints()
				hero:SetAbilityPoints(unspent_ability_points + 1)
			end
		end
		]]
	end

	OnPlayerLevelUpEvent(extend(keys, { hero = hero, playerID = playerID }))
end

-- A unit last hit a creep, a tower, or a hero
local OnLastHitEvent = CreateGameEvent 'OnLastHitEvent'
function barebones:OnLastHit(keys)
	--DebugPrint("[BAREBONES] OnLastHit event")
	--PrintTable(keys)

	local IsFirstBlood = keys.FirstBlood == 1
	local IsHeroKill = keys.HeroKill == 1
	local IsTowerKill = keys.TowerKill == 1

	-- Player ID that got a last hit
	local playerID = keys.PlayerID

	-- Killed unit (creep, hero, tower etc.)
	local killed_entity
	if keys.EntKilled then
		killed_entity = EntIndexToHScript(keys.EntKilled)
	end

	OnLastHitEvent(extend(keys, { killed_entity = killed_entity }))
end

-- A tree was cut down by tango, quelling blade, etc
local OnTreeCutEvent = CreateGameEvent 'OnTreeCut'
function barebones:OnTreeCut(keys)
	DebugPrint("[BAREBONES] OnTreeCut event")
	--PrintTable(keys)

	-- Tree coordinates on the map
	local treeX = keys.tree_x
	local treeY = keys.tree_y

	OnTreeCutEvent(keys)
end

-- A rune was activated by a player
function barebones:OnRuneActivated(keys)
	DebugPrint("[BAREBONES] OnRuneActivated event (not wired)")
	--PrintTable(keys)

	local playerID = keys.PlayerID
	local rune = keys.rune

	-- For Bounty Runes use BountyRuneFilter
	-- For modifying which runes spawn use RuneSpawnFilter (if it works)
	-- This event can be used for adding more effects to existing runes.
end

-- A player picked or randomed a hero, it actually happens on spawn (this is sometimes happening before OnHeroInGame).
function barebones:OnPlayerPickHero(keys)
	DebugPrint("[BAREBONES] OnPlayerPickHero event (not wired)")
	--PrintTable(keys)

	local hero_name = keys.hero
	local hero_entity
	if keys.heroindex then
		hero_entity = EntIndexToHScript(keys.heroindex)
	end
	local player
	if keys.player then
		player = EntIndexToHScript(keys.player)
	end
end

-- An entity died (an entity killed an entity)
local OnEntityKilledEvent = CreateGameEvent 'OnEntityKilled'
function barebones:OnEntityKilled(keys)
	--DebugPrint("[BAREBONES] An entity was killed.")
	--PrintTable(keys)

	-- Indexes:
	local killed_entity_index = keys.entindex_killed
	local attacker_entity_index = keys.entindex_attacker
	local inflictor_index = keys.entindex_inflictor -- it can be nil if not killed by an item/ability

	-- Find the entity that was killed
	local killed_unit
	if killed_entity_index then
		killed_unit = EntIndexToHScript(killed_entity_index)
	end

	-- Find the entity (killer) that killed the entity mentioned above
	local killer_unit
	if attacker_entity_index then
		killer_unit = EntIndexToHScript(attacker_entity_index)
	end

	if killed_unit == nil or killer_unit == nil then
		-- Don't continue if killer or killed entity doesn't exist
		return
	end

	-- Find the ability/item used to kill, or nil if not killed by an item/ability
	local killing_ability
	if inflictor_index then
		killing_ability = EntIndexToHScript(inflictor_index)
	end

	-- For Meepo clones, find the original
	if killed_unit:IsClone() then
		if killed_unit.GetCloneSource and killed_unit:GetCloneSource() then
			killed_unit = killed_unit:GetCloneSource()
		end
	end

	-- Killed Unit is a hero (not an illusion) and he is not reincarnating
	if killed_unit:IsRealHero() and not killed_unit:IsTempestDouble() and not killed_unit:IsReincarnating() and not killed_unit:IsSpiritBearCustom() then
		local respawn_time = CUSTOM_RESPAWN_TIME

		-- If hero is actually reincarnating don't change his respawn time:
		if not killed_unit:IsReincarnating() then
			killed_unit:SetTimeUntilRespawn(respawn_time)
		end
	end

	-- Remove dead non-hero units from selection -> fixing bugged ability/cast bar
	if killed_unit:IsIllusion() or (killed_unit:IsControllableByAnyPlayer() and not killed_unit:IsRealHero() and not killed_unit:IsCourier() and not killed_unit:IsClone() and not killed_unit:IsTempestDouble()) then
		local player = killed_unit:GetPlayerOwner()
		local playerID
		if not player then
			playerID = killed_unit:GetPlayerOwnerID()
		else
			playerID = player:GetPlayerID()
		end

		if Selection then
			PlayerResource:RemoveFromSelection(playerID, killed_unit)
		end
	end

	OnEntityKilledEvent(extend(keys, {
		killed_unit = killed_unit, killer_unit = killer_unit, killing_ability = killing_ability
	}))
end

-- This function is called once when the player fully connects and becomes "Ready" during Loading
function barebones:OnConnectFull(keys)
	DebugPrint("[BAREBONES] A Player fully connected. (not wired)")
	--PrintTable(keys)

	self:CaptureGameMode()

	-- PlayerResource:OnPlayerConnect(event) is custom-made; can be found in 'player_resource.lua' library
	PlayerResource:OnPlayerConnect(keys)
end

-- This function is called whenever a player changes their custom team selection during Custom Game Setup
function barebones:OnPlayerSelectedCustomTeam(keys)
	DebugPrint("[BAREBONES] OnPlayerSelectedCustomTeam event (not wired)")
	--PrintTable(keys)

	local playerID = keys.player_id
	local success = keys.success == 1
	local team = keys.team_id
end

-- This function is called whenever an NPC reaches its goal position/target (npc can be a lane creep, goal entity can be a path corner)
function barebones:OnNPCGoalReached(keys)
	DebugPrint("[BAREBONES] OnNPCGoalReached (not wired)")
	--PrintTable(keys)

	local goal_entity_index = keys
		.goal_entindex -- Entity index of the next goal entity on the path (if any) which the npc will now be pathing towards
	local next_goal_entity_index = keys
		.next_goal_entindex -- Entity index of the path goal entity which has been reached
	local npc_index = keys
		.npc_entindex -- Entity index of the npc which was following a path and has reached a goal entity

	local npc
	local goal_entity

	if npc_index and goal_entity_index then
		npc = EntIndexToHScript(npc_index)
		goal_entity = EntIndexToHScript(goal_entity_index)
	end

	local next_goal_entity
	if next_goal_entity_index then
		next_goal_entity = EntIndexToHScript(next_goal_entity_index)
	end

	if npc and goal_entity then
		-- Your code here
	end
end

-- This function is called whenever any player sends a chat message to team or to All
local OnPlayerUsedChatEvent = CreateGameEvent 'OnPlayerUsedChat'
function barebones:OnPlayerChat(keys)
	DebugPrint("[BAREBONES] A Player has used the chat")
	--PrintTable(keys)

	local team_only = keys.teamonly == 1
	local userID = keys.userid
	local playerID = keys.playerid
	local text = keys.text

	OnPlayerUsedChatEvent(extend(keys, {
		playerID = playerID, -- uniform naming
	}))
end

local OnItemObtainEvent = CreateGameEvent 'OnItemObtain'
local OnInventoryThinkEvent = CreateGameEvent 'OnInventoryThink'
function barebones:InventoryThink()
	for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:IsValidPlayerID(playerID) then
			local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
			if hero then
				for slot = 0, 14 do
					local item = hero:GetItemInSlot(slot)
					if item then
						if not item.is_tracked then
							DebugPrint("[BAREBONES] On item obtain: " .. item:GetName())
							OnItemObtainEvent({
								playerID = playerID,
								itemName = item:GetName(),
								item = item
							})
							item.is_tracked = true
						end
						OnInventoryThinkEvent({
							playerID = playerID,
							hero = hero,
							slot = slot,
							item = item,
						})
					end
				end
			end
		end
	end
	return 0.5
end
