local QuestStatus = require('modules.quest.quest_status')

return {
    entries = {
        npc_dota_creature_gnoll_assassin = {
            q_test_quest = {
                { status = QuestStatus.INACTIVE, start = "d_1" },
                { status = QuestStatus.ACTIVE, start = "d_2" },
            },
        }
    },
    nodes = {
        d_1 = {
            speakerName = "PIDOR",
            speakerNPC = "npc_dota_creature_gnoll_assassin",
            text = "salam brat",
            choices = {
                {
                    text = "accept quest",
                    actions = {
                        quest_start = { { questID = "q_test_quest" } }
                    }
                },
                {
                    next = nil, -- explicit
                    text = "ne"
                }
            }
        },
        d_2 = {
            speakerName = "PIDOR",
            speakerNPC = "npc_dota_creature_gnoll_assassin",
            text = "vse?",
            choices = {
                {
                    text = "ura",
                    actions = {
                        quest_end = { { questID = "q_test_quest" }, }
                    }
                }
            }
        }
    }
}
