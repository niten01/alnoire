return {
    q_clash_royal = {
        giver = "npc_tiny",
        name = "Королевская взбучка",
        steps = {
            {
                description = "Иди на арену",
                objectives = {
                    { type = "come", trigger = "trigger_clash_royal" }
                }
            },
            {
                description = "Уничтожь владения Красного Принца",
                objectives = {
                    { type = "kill", npc = "npc_tron" }
                }
            },
            {
                description = "Вернись к Синему Принцу",
                objectives = {
                    { type = "talk", npc = "npc_blue_prince" }
                }
            },
        }
    },
     q_nigger = {
        giver = "npc_nig",
        name = "O'Block",
        steps = {
            {
                description = "Добудь билеты у перекупа",
                objectives = {
                    { type = "take", trigger = "trigger_ticket" }
                }
            },
            {
                description = "Отдай билет крипу",
                objectives = {
                    { type = "talk", npc = "npc_nig" }
                }
            },
        }
    },
     q_ogre_magi = {
        giver = "npc_ogre_magi",
        name = "Братство и ум",
        steps = {
            {
                description = "Найди Огра-громилу",
                objectives = {
                    { type = "talk", npc = "npc_ogre_bruiser" }
                }
            },
            {
                description = "Вернись к Огр-магу",
                objectives = {
                    { type = "talk", npc = "npc_ogre_magi" }
                }
            },
        }
    },
}