local QuestStatus = require('modules.quest.quest_status')

return {
    entries = {
        npc_xavier = {
            q_test_quest = {
                { status = QuestStatus.INACTIVE, start = "d_0" },
                { status = QuestStatus.ACTIVE,   start = "d_2" },
            },
            flag = {
                first_met = true
            }
        }
    },
    nodes = {
        d_0 = {
            speakerName = "xaviersobased",
            speakerNPC = "npc_xavier",
            text = "erm",
            choices = {
                {
                    text = "...",
                    next = "d_1"
                }
            }
        },
        d_1 = {
            speakerName = "xaviersobased",
            speakerNPC = "npc_xavier",
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
        d_3 = {
            speakerName = "PIDOR",
            speakerNPC = "npc_xavier",
            text = "vse2",
            choices = {
                {
                    text = "ura",
                    actions = {
                        quest_end = { { questID = "q_test_quest" }, }
                    }
                }
            }
        },
    }
}
