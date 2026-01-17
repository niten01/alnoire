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
        giver = "npc_nigg",
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
                    { type = "talk", npc = "npc_nigg" }
                }
            },
        }
    }
}