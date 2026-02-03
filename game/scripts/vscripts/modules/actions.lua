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
  for _, ent in ipairs(Entities:FindAllByName(action.npc)) do
    DebugPrint("[ALNOIRE] Starting fight with " .. ent:GetName())
    ent:RemoveModifierByName("modifier_story_npc")
    if action.target == "beat" and not ent:HasModifier("modifier_lethal_damage_tracking") then
      ent:AddNewModifier(nil, nil, "modifier_lethal_damage_tracking", { duration = -1 })
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

function Handlers.open_door(playerID, action)
  DoorManager:Open(action.door)
end

function Handlers.give_item(playerID, action)
  DebugPrint("[???] TODO give_item")
end

function Actions:Handle(playerID, action)
  local handler = Handlers[action.type]
  if not handler then
    error("Unhandled action type: " .. action.type)
  end

  handler(playerID, action)
end

return Actions
