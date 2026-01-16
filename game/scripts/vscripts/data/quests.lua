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
        }
    }
}