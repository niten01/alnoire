Quest = Quest or class {}

--[[
--  Quest format:
--  {
--    id = "q_quest_id",
--    name = "Quest Name",
--    steps = {
--      {
--        id = "q_step_01",
--        objectives = {
--          { type = "talk", npc = "npc_someone" },
--          { type = "kill", npc = "npc_someone", count = 3 },
--          ...
--        }
--      }, ...
--    }
--  }
--
--]]

function Quest:Init(game)
  self.game = game
  self.quests = LoadKeyValues("data/quests.txt")
  self.playerQuestState = {}
end

function Quest:StartQuestForAll(questID)
  for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
    if PlayerResource:IsValidPlayerID(playerID) and PlayerResource:GetPlayer(playerID) then
      local quest = self.quests[questID]
      if not quest then
        print("??? Invalid quest ID")
        return
      end

      self.playerQuestState[playerID][questID] = {
        status = "active",
        stepIdx = 0,
      }
    end
  end
end

return Quest
