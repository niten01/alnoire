StoryDriver = StoryDriver or {}

function StoryDriver:Init()
  GameEvents:OnActChange(bind(self.OnActChange, self))
  GameEvents:OnEntityKilled(bind(self.OnEntityKilled, self))
  GameEvents:OnPackWiped(bind(self.OnPackWiped, self))
  GameEvents:OnCancelLethalDamage(bind(self.OnCancelLethalDamage, self))
  self.activeStoryFights = {}
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
  local fwd = hero:GetForwardVector()
  hero = PlayerResource:ReplaceHeroWith(playerID, action.hero, 0, 0)
  hero:SetForwardVector(fwd)
end

function Handlers.change_act(playerID, action)
  DebugPrint("[ALNOIRE] Change act to: " .. action.act)
  GlobalState:SetAct(action.act)
end

function Handlers.open_door(playerID, action)
  DoorManager:Open(action.door)
end

function Handlers.give_item(playerID, action)
  local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
  if not hero then
    error("No hero")
  end
  if not action.itemName then
    error("No itemName")
  end
  local item = hero:AddItemByName(action.itemName)
  if not item then
    local playerHndl = PlayerResource:GetPlayer(playerID)
    item = CreateItem(action.itemName, playerHndl, hero)
    CreateItemOnPositionSync(hero:GetAbsOrigin(), item)
  end
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
  SpawnManager:SpawnNPC(action.spawn)
end

function Handlers.music_start(playerID, action)
  Music:StartCustomMusic(playerID, action.music)
end

function Handlers.music_stop(playerID, action)
  Music:StopCustomMusic(playerID)
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

function StoryDriver:StartFight(packName, nonLethalNPC)
  local pack = PackManager:GetPack(packName)
  assert(pack, "No pack to start fight with: " .. packName)
  for _, unit in ipairs(pack.units) do
    DebugPrint("[ALNOIRE] Starting fight with " .. unit:GetName())
    unit:RemoveModifierByName("modifier_story_npc")
    unit:SetTeam(DOTA_TEAM_BADGUYS)
  end

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

function StoryDriver:SetupAct2()
  fastRemoveNPC("npc_mystery")
  SpawnManager:SpawnNPC("spawner_mystery_2")
  SpawnManager:SpawnNPC("spawner_storyteller")

  SpawnManager:SpawnNPC("spawner_dream")
  triggerSetEnabled("trigger_black_creep", true)

  SpawnManager:SpawnNPC("spawner_genius")

  SpawnManager:SpawnNPC("spawner_concert_fan_ranged")
end

function StoryDriver:OnActChange(event)
  local act = event.act
  if act == 2 then
    self:SetupAct2()
  end
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
    while #self.activeStoryFights > 0 do
      local packName = table.remove(self.activeStoryFights, 1)
      PackManager:DeactivatePack(packName)
      PackManager:RespawnPack(packName)
    end
  end
end

function StoryDriver:OnCancelLethalDamage(event)
  while #self.activeStoryFights > 0 do
    local packName = table.remove(self.activeStoryFights, 1)
    PackManager:DeactivatePack(packName)
    PackManager:ResetPackPosition(packName)
  end
end

function StoryDriver:OnPackWiped(event)
  for i, packName in ipairs(self.activeStoryFights) do
    if packName == event.packName then
      table.remove(self.activeStoryFights, i)
      break
    end
  end

  if event.packName == "pack_concert_crowd" then
    GlobalState:Get().concert_crowd_beaten = true
  end
end

function StoryDriver:HasActiveFights()
  return #self.activeStoryFights > 0
end

function StoryDriver:HandleAction(playerID, action)
  local handler = Handlers[action.type]
  if not handler then
    error("Unhandled action type: " .. action.type)
  end

  handler(playerID, action)
end

return StoryDriver
