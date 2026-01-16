return {
    q_test_quest = {
        giver = "npc_tiny",
        name = "Королевская взбучка",
        steps = {
            {
                description = "Иди на арену.",
                objectives = {
                    { type = "come", trigger = "trigger_clash_royal" }
                }
            },
            {
                description = "Уничтожь владения Красного Принца.",
                objectives = {
                    { type = "kill", npc = "npc_tron" }
                }
            },
            {
                description = "Вернись к Синему Принцу.",
                objectives = {
                    { type = "talk", npc = "npc_blue_prince" }
                }
            },
        }
    }
}