StoryDriver = StoryDriver or {}

function StoryDriver:Init()
  GameEvents:OnActChange(bind(self.OnActChange, self))
  GameEvents:OnEntityKilled(bind(self.OnEntityKilled, self))
  GameEvents:OnPackWiped(bind(self.OnPackWiped, self))
  GameEvents:OnCancelLethalDamage(bind(self.OnCancelLethalDamage, self))
  GameEvents:OnGameInProgress(bind(self.OnGameInProgress, self))
  self.activeStoryFights = {}

  ChatCommand:LinkDevCommand("-startfight", function(event, args)
    self:StartFight(args[1], args[2])
  end)

  ChatCommand:LinkDevCommand("-class", function(event, args)
    self:HandleAction(event.playerID, {
      type = "change_hero",
      hero = args[1] and "npc_dota_hero_sanya_" .. tostring(args[1]) or "npc_dota_hero_sanya"
    })
  end)

  ChatCommand:LinkDevCommand("-finale", function(event, args)
    self:HandleAction(event.playerID, {
      type = "start_city_finale_cutscene",
    })
  end)

  ChatCommand:LinkDevCommand("-bc", function(event, args)
    BarrelClick:BuildArena()
    BarrelClick:Start(event.playerID)
  end)

  ChatCommand:LinkDevCommand("-sfx", function(event, args)
    self:HandleAction(event.playerID, {
      type = "sfx",
      sound = args[1]
    })
  end)
end

local function fastRemoveNPC(name)
  for _, ent in ipairs(Entities:FindAllByName(name)) do
    ent:RemoveSelf()
  end
end

local function prettyRemoveNPC(name)
  for _, ent in ipairs(Entities:FindAllByName(name)) do
    DebugPrint("[ALNOIRE] Remove " .. ent:GetName())
    local pfx = ParticleManager:CreateParticle(
      "particles/action_remove_smoke.vpcf",
      PATTACH_ABSORIGIN_FOLLOW, ent)
    ParticleManager:SetParticleControl(pfx, 1, ent:GetAbsOrigin())
    ParticleManager:SetParticleControl(pfx, 3, ent:GetAbsOrigin())
    Timers:CreateTimer(0.01, function()
      ent:RemoveSelf()
    end)
    Timers:CreateTimer(3, function()
      ParticleManager:ReleaseParticleIndex(pfx)
    end)
  end
end

local function triggerSetEnabled(name, enable)
  for _, ent in ipairs(Entities:FindAllByName(name)) do
    if enable or enable == nil then
      DebugPrint("[ALNOIRE] Enable trigger: " .. name)
      ent:Enable()
    else
      DebugPrint("[ALNOIRE] Disable trigger: " .. name)
      ent:Disable()
    end
  end
end

local function giveDrop(npcData)
  while TableLength(npcData.drop) > 0 do
    local itemName = table.remove(npcData.drop, 1)
    local item = CreateItem(itemName, nil, nil)
    local ent = Entities:FindByName(nil, npcData.name)
    if not ent then
      error("Could not find entity do give drop: " .. npcData.name)
    end
    local pos = ent:GetAbsOrigin() + RandomVector(100)
    CreateItemOnPositionSync(pos, item)
  end
end

local Handlers = {}

function Handlers.quest_start(playerID, action)
  Quest:StartQuestForAll(action.questID)
end

function Handlers.quest_reject(playerID, action)
  Quest:RejectQuest(action.questID)
end

function Handlers.quest_end(playerID, action)
  Quest:CompleteQuestForAll(action.questID)
end

-- { pack = "pack_abc", nonLethalNPC = "npc_someone" (optional) }
function Handlers.fight_start(playerID, action)
  assert(not action.npc, "Legacy fight_start action, rewrite to pack")
  assert(action.pack, "No pack specified for fight_start action")

  StoryDriver:StartFight(action.pack, action.nonLethalNPC)
end

function Handlers.change_hero(playerID, action)
  local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
  if not hero then error("No hero") end
  local hadDialogue = hero:HasModifier("modifier_dialogue_player")
  local fwd = hero:GetForwardVector()
  local newHero = PlayerResource:ReplaceHeroWith(playerID, action.hero, 0, 0)
  newHero:SetForwardVector(fwd)
  if hadDialogue then
    newHero:AddNewModifier(nil, nil, "modifier_dialogue_player", { duration = -1 })
  end
  hero:RemoveSelf()
  Timers:CreateTimer(1.0, function()
    local player = PlayerResource:GetPlayer(playerID)
    assert(player)
    CustomGameEventManager:Send_ServerToPlayer(player, "flow_bar_force_update", {})
  end)
end

function Handlers.change_act(playerID, action)
  DebugPrint("[ALNOIRE] Change act to: " .. action.act)
  GlobalState:SetAct(action.act)
end

-- { door = "door_abc" }
function Handlers.open_door(playerID, action)
  DoorManager:Open(action.door)
end

function Handlers.give_item(playerID, action)
  assert(action.itemName, "No itemName")
  local item = SafeGiveItem(playerID, action.itemName)
  item:SetCombineLocked(true)
end

function Handlers.kill(playerID, action)
  if not action.npc then
    error("No npc for kill action")
  end
  for _, ent in ipairs(Entities:FindAllByName(action.npc)) do
    DebugPrint("[ALNOIRE] Kill " .. ent:GetName())
    ent:ForceKill(false)
  end
end

local OnNPCRemoveEvent = CreateGameEvent 'OnNPCRemove'
function Handlers.remove(playerID, action)
  if not action.npc then
    error("No npc for remove action")
  end
  prettyRemoveNPC(action.npc)
  OnNPCRemoveEvent {
    playerID = playerID,
    npc = action.npc
  }
end

function Handlers.set_var(playerID, action)
  DebugPrint("[ALNOIRE] Set global var " .. action.var .. " to " .. tostring(action.value))
  GlobalState:Get()[action.var] = action.value
end

function Handlers.teleport(playerID, action)
  if not action.target then
    error("No teleport target")
  end

  local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
  if not hero then
    error("No hero")
  end

  local targets = Entities:FindAllByName(action.target)
  if TableLength(targets) > 1 then
    error("Multiple targets match: " .. action.target)
  end
  if TableLength(targets) == 0 then
    error("No such target: " .. action.target)
  end

  local tgt = targets[1]
  local pos = tgt:GetAbsOrigin()
  local fwd = tgt:GetForwardVector()
  hero:SetAbsOrigin(pos)
  hero:SetForwardVector(fwd)
  CenterCameraOnUnit(playerID, hero)
  DebugPrint("[ALNOIRE] Teleported to " .. action.target)
end

-- { attacker = "npc_abc" }
function Handlers.die(playerID, action)
  local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
  if not hero then
    error("No hero")
  end

  local attacker = nil
  if action.attacker then
    local ents = Entities:FindAllByName(action.attacker)
    if TableLength(ents) == 0 then
      error("No attacker found: " .. action.attacker)
    end
    if TableLength(ents) > 1 then
      DebugPrint("[???] Multiple attackers found, choosing first")
    end
    attacker = ents[1]
  end
  hero:Kill(nil, attacker)
end

function Handlers.spawn(playerID, action)
  assert(action.spawn)
  SpawnManager:SpawnNPC(action.spawn)
end

function Handlers.music_start(playerID, action)
  Music:StartCustomMusic(playerID, action.music)
end

function Handlers.music_stop(playerID, action)
  Music:StopCustomMusic(playerID)
end

function Handlers.island_explode(playerID, action)
  local npc = Entities:FindByName(nil, "npc_bomb")
  if not npc then
    npc = Entities:FindByName(nil, "npc_bomb_place")
  end
  assert(npc)
  npc:EmitSound("sfx.island_explode")
end

function Handlers.take_item(playerID, action)
  local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
  if not hero then
    error("No hero")
  end

  local item = hero:FindItemInInventory(action.itemName)
  if not item then
    error("Player has no item to remove: " .. action.itemName)
  end
  hero:RemoveItem(item)
end

function Handlers.setup_gorilla_scene(playerID, action)
  fastRemoveNPC("npc_rape_victim")
  SpawnManager:SpawnNPC("spawner_gorilla")
  SpawnManager:SpawnNPC("spawner_rape_victim_2")
  Timers:CreateTimer(0.5, function()
    for _, ent in ipairs(Entities:FindAllByName("npc_rape_victim")) do
      AddAnimationTranslate(ent, "torment")
    end

    for _, ent in ipairs(Entities:FindAllByName("npc_gorilla")) do
      AddAnimationTranslate(ent, "torment")
    end
  end)


  triggerSetEnabled("trigger_gorilla", true)
  fastRemoveNPC("npc_guide")
  SpawnManager:SpawnNPC("spawner_guide_forest_entrance")
  triggerSetEnabled("trigger_after_gorilla", true)

  DoorManager:Close("door_city_forest")
end

function Handlers.gorilla_fight_start(playerID, action)
  for _, ent in ipairs(Entities:FindAllByName("npc_gorilla")) do
    RemoveAnimationTranslate(ent)
  end
end

function Handlers.win(playerID, action)
  GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
end

function Handlers.green_test_start(playerID, action)
  GlobalState:Get().green_test_tried = true
  for _, ent in ipairs(Entities:FindAllByName("npc_green")) do
    DebugPrint("[ALNOIRE] Starting green strength test")
    ent:RemoveModifierByName("modifier_story_npc")
    ent:SetTeam(DOTA_TEAM_BADGUYS)
    if not ent:HasModifier("modifier_story_weak_hit_tracking") then
      ent:AddNewModifier(ent, nil, "modifier_story_weak_hit_tracking", { duration = -1 })
    end
  end
end

function Handlers.force_give_drop(playerID, action)
  local npcData = EntityData:ByName(action.npc)
  if not npcData then
    error("No such npc to give drop from: " .. action.npc)
  end

  giveDrop(npcData)
end

function Handlers.setup_island_second_encounter(playerID, action)
  triggerSetEnabled("trigger_island_fourth")
  DoorManager:Open("door_island_secret")
end

function Handlers.add_modifier(playerID, action)
  assert(action.modifier)
  local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
  assert(hero)
  if not hero:HasModifier(action.modifier) then
    hero:AddNewModifier(nil, nil, action.modifier, { duration = -1 })
  end
end

function Handlers.add_demon_power(playerID, action)
  local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
  assert(hero)
  if hero:GetUnitName() == "npc_dota_hero_sanya_rapper" then
    hero:AddNewModifier(hero, nil, "modifier_demon_power_rapper", { duration = -1 })
  elseif hero:GetUnitName() == "npc_dota_hero_sanya_towel_master" then
    hero:AddNewModifier(hero, nil, "modifier_demon_power_towel_master", { duration = -1 })
  elseif hero:GetUnitName() == "npc_dota_hero_sanya_logarithmus" then
    hero:AddNewModifier(hero, nil, "modifier_demon_power_logarithmus", { duration = -1 })
  else
    assert(false, "[???] demon power not implemented")
  end
end

function Handlers.give_xavier_percocet(playerID, action)
  local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
  assert(hero)
  if hero:GetUnitName() == "npc_dota_hero_sanya_rapper" then
    SafeGiveItem(playerID, "item_lean_power_rapper")
  elseif hero:GetUnitName() == "npc_dota_hero_sanya_towel_master" then
    SafeGiveItem(playerID, "item_lean_power_towel_master")
  elseif hero:GetUnitName() == "npc_dota_hero_sanya_logarithmus" then
    SafeGiveItem(playerID, "item_lean_power_logarithmus")
  else
    assert(false, "[???] percocet not implemented")
  end
end

function Handlers.happy_cat_fireworks(playerID, action)
  local cats = Entities:FindByName(nil, "npc_cat_barrel")
  assert(cats)
  local pfx1 = ParticleManager:CreateParticle("particles/themed_fx/cny_fireworks_rockets_a.vpcf",
    PATTACH_ABSORIGIN_FOLLOW, cats)
  local pfx2 = ParticleManager:CreateParticle("particles/themed_fx/cny_fireworks_rockets_b.vpcf",
    PATTACH_ABSORIGIN_FOLLOW, cats)
  Timers:CreateTimer(5, function()
    ParticleManager:ReleaseParticleIndex(pfx1)
    ParticleManager:ReleaseParticleIndex(pfx2)
  end)
end

function Handlers.fill_flask(playerID, action)
  FlaskManager:RefillFlask(playerID)
end

function Handlers.derek_transition(playerID, action)
  local npc = Entities:FindByName(nil, "npc_derek")
  assert(npc)
  local ai = npc:FindModifierByName("modifier_derek_ai")
  assert(ai)
  ai:Transition()
end

function Handlers.george_transition(playerID, action)
  local npc = Entities:FindByName(nil, "npc_george")
  assert(npc)
  local ai = npc:FindModifierByName("modifier_george_ai")
  assert(ai)
  ai:Transition()
end

function Handlers.setup_guide_finale(playerID, action)
  GameRules:SetTimeOfDay(0.3)

  fastRemoveNPC("npc_guide")
  fastRemoveNPC("npc_george")
  SpawnManager:SpawnNPC("spawner_guide_finale")
  triggerSetEnabled("trigger_guide_finale", true)
end

function Handlers.start_city_finale_cutscene(playerID, action)
  prettyRemoveNPC("npc_guide")
  SpawnManager:SpawnNPC("spawner_guide_forest_entrance")
  CityCutscene:Start(playerID)

  fastRemoveNPC("npc_xavier")
  SpawnManager:SpawnNPC("spawner_xavier_ending")
  triggerSetEnabled("trigger_ending_1", true)
  triggerSetEnabled("trigger_ending_2", true)
  triggerSetEnabled("trigger_ending_3", true)
  SpawnManager:SpawnNPC("spawner_shooter_hall_1")
  SpawnManager:SpawnNPC("spawner_shooter_hall_2")
  SpawnManager:SpawnNPC("spawner_shooter_hall_3")
end

function Handlers.start_final_walk(playerID, action)
  Music:StartCustomMusic(playerID, "music.ending.finale")
  local player = PlayerResource:GetPlayer(playerID)
  assert(player)
  CustomGameEventManager:Send_ServerToPlayer(player, "cutscene_show_bars", {})

  local wp = Entities:FindByName(nil, "ending_waypoint")
  assert(wp)
  local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
  assert(hero)
  local xavier = Entities:FindByName(nil, "npc_xavier")
  assert(xavier)
  CenterCameraOnUnit(playerID, hero)
  -- PlayerResource:SetCameraTarget(playerID, hero)
  -- GameRules:GetGameModeEntity():SetCameraSmoothCountOverride(30)
  hero:MoveToPosition(wp:GetAbsOrigin())
  xavier:MoveToPosition(wp:GetAbsOrigin())

  hero:AddNewModifier(nil, nil, "modifier_cutscene_player", { duration = -1, ms = 100 })
  xavier:AddNewModifier(nil, nil, "modifier_cutscene_player", { duration = -1, ms = 100 })
  Timers:CreateTimer(17, function()
    CustomGameEventManager:Send_ServerToPlayer(player, "cutscene_show_fade", {})
    GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
  end)
end

function Handlers.build_barrel_click(playerID, action)
  prettyRemoveNPC("npc_brewmaster_good")
  SpawnManager:SpawnNPC("spawner_brewmaster_minigame")
  BarrelClick:BuildArena()
end

function Handlers.start_barrel_click(playerID, action)
  BarrelClick:Start(playerID)
end

function Handlers.disable_clash_royale(playerID, action)
  triggerSetEnabled("trigger_clash_arena", false)
end

function StoryDriver:StartFight(packName, nonLethalNPC)
  local pack = PackManager:GetPack(packName)
  assert(pack, "No pack to start fight with: " .. packName)
  PackManager:ForAllAliveUnits(pack, function(unit)
    DebugPrint("[ALNOIRE] Starting fight with " .. unit:GetName())
    unit:RemoveModifierByName("modifier_story_npc")
    unit:SetTeam(DOTA_TEAM_BADGUYS)
  end)

  PackManager:ActivatePack(packName)

  if nonLethalNPC then
    local ent = Entities:FindByName(nil, nonLethalNPC)
    assert(ent, "No such ent to add non-lethal tracking: " .. nonLethalNPC)
    if not ent:HasModifier("modifier_story_lethal_damage_tracking") then
      ent:AddNewModifier(ent, nil, "modifier_story_lethal_damage_tracking", { duration = -1 })
    end
  end

  table.insert(self.activeStoryFights, packName)
end

function StoryDriver:StopFight(activeFightIdx)
  local packName = table.remove(self.activeStoryFights, activeFightIdx)
  local pack = PackManager:GetPack(packName)
  assert(pack)
  PackManager:ForAllAliveUnits(pack, function(unit)
    unit:AddNewModifier(unit, nil, "modifier_story_npc", { duration = -1 })
  end)
  PackManager:DeactivatePack(packName)
end

function StoryDriver:OnEntityKilled(event)
  local victim = event.killed_unit

  -- try give drop
  local victimNPCData = EntityData:ByName(victim:GetName())
  if victimNPCData and victimNPCData.drop then
    giveDrop(victimNPCData)
  end

  -- handle fight end
  if victim:IsRealHero() and not victim:IsSpiritBearCustom() then
    Timers:CreateTimer(5, function()
      for i = #self.activeStoryFights, 1, -1 do
        local packName = self.activeStoryFights[i]
        local pack = PackManager:GetPack(packName)
        assert(pack)
        if not pack.stayActivatedOnPlayerDeath then
          self:StopFight(1)
          PackManager:RespawnPack(packName)
        end
      end
    end)
  end
end

-- { unit: <unitHScript>, attackerPlayerID: 2 }
function StoryDriver:OnCancelLethalDamage(event)
  local unit = event.unit
  for i = #self.activeStoryFights, 1, -1 do
    local packName = self.activeStoryFights[i]
    if unit.packTargetData and unit.packTargetData.name == packName then
      PackManager:ResetPackPosition(packName)
      PackManager:GiveRewards(packName)
      self:StopFight(i)
      local hero = PlayerResource:GetBarebonesAssignedHero(event.attackerPlayerID)
      assert(hero)
      hero:SetAbsOrigin(unit:GetAbsOrigin() + unit:GetForwardVector() * 150)
      hero:FaceTowards(unit:GetAbsOrigin())
      CenterCameraOnUnit(event.attackerPlayerID, unit)
      break
    end
  end
end

function StoryDriver:OnPackWiped(event)
  for i, packName in ipairs(self.activeStoryFights) do
    if packName == event.packName then
      self:StopFight(i)
      break
    end
  end

  if event.packName == "pack_concert_crowd" then
    GlobalState:Get().concert_crowd_beaten = true
  end
end

function StoryDriver:SetupAct2()
  GameRules:SetTimeOfDay(0.8)

  fastRemoveNPC("npc_mystery")
  SpawnManager:SpawnNPC("spawner_mystery_2")
  SpawnManager:SpawnNPC("spawner_storyteller")
  SpawnManager:SpawnNPC("spawner_leader")

  SpawnManager:SpawnNPC("spawner_dream")
  triggerSetEnabled("trigger_black_creep", true)
  triggerSetEnabled("zone_concert_entrance", false)
  triggerSetEnabled("zone_concert_muted", true)

  SpawnManager:SpawnNPC("spawner_genius")

  SpawnManager:SpawnNPC("spawner_concert_fan_ranged")
  SpawnManager:SpawnNPC("spawner_concert_fan_melee")
  SpawnManager:SpawnNPC("spawner_concert_wk")
  SpawnManager:SpawnNPC("spawner_concert_meepo")
  SpawnManager:SpawnNPC("spawner_concert_lina")
  SpawnManager:SpawnNPC("spawner_concert_legion")

  if GlobalState:Get().freed_island_creeps then
    SpawnManager:SpawnNPC("spawner_killer")
    triggerSetEnabled("trigger_epstein_killer", true)
  end
end

local QuestStatus = require('modules.quest.quest_status')
function StoryDriver:SetupAct3()
  GameRules:SetTimeOfDay(0.3)

  fastRemoveNPC("npc_xavier")
  DoorManager:Close("door_concert")
  triggerSetEnabled("zone_concert_entrance", true)
  triggerSetEnabled("zone_concert_muted", false)

  fastRemoveNPC("npc_dream")
  SpawnManager:SpawnNPC("spawner_dream")
  -- if Quest:GetQuestState("q_concert").status == QuestStatus.COMPLETED then
  -- end
  SpawnManager:SpawnNPC("spawner_gangster")
  SpawnManager:SpawnNPC("spawner_ghetto_ranged")
  SpawnManager:SpawnNPC("spawner_ghetto_melee")

  SpawnManager:SpawnNPC("spawner_gangster_2")
  SpawnManager:SpawnNPC("spawner_ghetto_ranged_2")
  SpawnManager:SpawnNPC("spawner_ghetto_melee_2")

  SpawnManager:SpawnNPC("spawner_gangster_3")
  SpawnManager:SpawnNPC("spawner_ghetto_ranged_3")
  SpawnManager:SpawnNPC("spawner_ghetto_melee_3")

  if GlobalState:Get().freed_island_creeps then
    SpawnManager:SpawnNPC("spawner_cat_barrel_city")
  end
end

function StoryDriver:SetupAct4()
  GameRules:SetTimeOfDay(0.8)

  fastRemoveNPC("npc_mustache")
  triggerSetEnabled("trigger_usach_stopit", false)

  SpawnManager:SpawnNPC("spawner_wasteland")
  local mustacheCorpseEnt = Entities:FindByName(nil, "mustache_corpse")
  assert(mustacheCorpseEnt)
  DoEntFireByInstanceHandle(mustacheCorpseEnt, "Enable", "", 0, nil, nil)

  fastRemoveNPC("npc_shamanka")
  fastRemoveNPC("npc_storyteller")
end

function StoryDriver:OnGameInProgress()
  if not IsServer() then return end

  if GetMapName() == "fight_test" then
    Timers:CreateTimer(2, function()
      for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        if PlayerResource:IsRealPlayer(playerID) and PlayerResource:IsValidPlayerID(playerID) then
          local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
          if not hero then error("No hero") end
          local fwd = hero:GetForwardVector()
          local newHero = PlayerResource:ReplaceHeroWith(playerID, "npc_dota_hero_sanya_towel_master", 0, 0)
          newHero:SetForwardVector(fwd)
          hero:RemoveSelf()
          newHero:HeroLevelUp(false)
          newHero:HeroLevelUp(false)
          newHero:HeroLevelUp(false)
          newHero:HeroLevelUp(false)
          newHero:HeroLevelUp(false)
          newHero:HeroLevelUp(false)
        end
      end
      -- SpawnManager:SpawnNPC("spawner_gorilla")
      -- StoryDriver:StartFight("pack_gorilla")
    end)
  end
end

function StoryDriver:OnActChange(event)
  local act = event.act
  if act == 2 then
    self:SetupAct2()
  elseif act == 3 then
    self:SetupAct3()
  elseif act == 4 then
    self:SetupAct4()
  end
end

function StoryDriver:HandleAction(playerID, action)
  local handler = Handlers[action.type]
  if not handler then
    error("Unhandled action type: " .. action.type)
  end

  handler(playerID, action)
end

return StoryDriver
