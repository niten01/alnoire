Actions = Actions or {}

function Actions:Init()
end

local Handlers = {}

function Handlers.quest_start(playerID, action)
  Quest:StartQuestForAll(action.questID)
end

function Handlers.quest_reject(playerID, action)
  Quest:RejectQuest(playerID, action.questID)
end

function Handlers.quest_end(playerID, action)
  Quest:CompleteQuestForAll(action.questID)
end

function Handlers.fight_start(playerID, action)
  if not action.npc then
    error("Fight action has no target npc")
    return
  end
  for _, ent in ipairs(Entities:FindAllByName(action.npc)) do
    DebugPrint("[ALNOIRE] Starting fight with " .. ent:GetName())
    ent:RemoveModifierByName("modifier_story_npc")
    if action.target == "talk" and not ent:HasModifier("modifier_story_lethal_damage_tracking") then
      ent:AddNewModifier(ent, nil, "modifier_story_lethal_damage_tracking", { duration = -1 })
    end
  end
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

function Handlers.remove(playerID, action)
  if not action.npc then
    error("No npc for remove action")
  end
  for _, ent in ipairs(Entities:FindAllByName(action.npc)) do
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

function Actions:Handle(playerID, action)
  local handler = Handlers[action.type]
  if not handler then
    error("Unhandled action type: " .. action.type)
  end

  handler(playerID, action)
end

return Actions
