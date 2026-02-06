return {
    q_reach_city = {
        giver = "npc_shamanka",
        name = "Оплот цивилизации",
        acts = { 0 },
        steps = {
            {
                description = "Доберись до Королевства",
                objectives = {
                    { type = "kill", npc = "npc_gate_troll_uruk" },
                    { type = "kill", npc = "npc_gate_troll_biruk" },
                    { type = "kill", npc = "npc_gate_troll_diruk" },
                },
                postStepActions = {
                    { type = "open_door", door = "door_prologue" }
                }
            },
            {
                description = "Доберись до Королевства",
                objectives = {
                    { type = "talk", npc = "npc_guide" },
                },
                postStepActions = {
                    { type = "change_act", act = 1 }
                }
            },
        }
    },
    q_clash_royale = {
        giver = "npc_blue_prince",
        name = "Королевская взбучка",
        acts = { 1 },
        showExclamation = true,
        steps = {
            {
                description = "Иди на арену",
                objectives = {
                    { type = "come", trigger = "trigger_clash_arena" }
                }
            },
            {
                description = "Уничтожь владения Красного Принца",
                objectives = {
                    { type = "kill", npc = "npc_dota_custom_king_tower_bad" }
                }
            },
            {
                description = "Вернись к Синему Принцу",
                objectives = {
                    { type = "talk", npc = "npc_blue_prince" }
                },
            },
        }
    },
    q_concert = {
        giver = "npc_dream",
        name = "O'Block",
        acts = { 2 },
        showExclamation = true,
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
                    { type = "talk", npc = "npc_dream" }
                }
            },
        }
    },
    q_ogres = {
        giver = "npc_ogre_magi",
        acts = { 1 },
        name = "Братство и ум",
        showExclamation = true,
        noFireworks = true,
        steps = {
            {
                description = "Найди Огра-громилу",
                objectives = {
                    { type = "talk", npc = "npc_ogre_bruiser" }
                }
            },
            {
                description = "Победи Огра-громилу",
                objectives = {
                    { type = "beat", npc = "npc_ogre_bruiser" }
                }
            },
            {
                description = "Поговори с Огром-громилой",
                objectives = {
                    { type = "talk", npc = "npc_ogre_bruiser" }
                }
            },
            {
                description = "Вернись к сиамским ограм",
                objectives = {
                    { type = "talk", npc = "npc_ogre_magi" }
                }
            },
        }
    },
    q_island_escape = {
        giver = "trigger_Epstein",
        name = "Побег от кумира",
        acts = { 1, 2 },
        steps = {
            {
                description = "Сбеги с острова",
                objectives = {
                    { type = "come", trigger = "trigger_tp_at_home" }
                }
            },
        }
    },
    q_island_explosion = {
        giver = "npc_cat_barrel",
        name = "Epstein's blow job",
        acts = { 3 },
        steps = {
            {
                description = "Найди секретный проход и заложи бомбу",
                objectives = {
                    { type = "come", trigger = "trigger_bomb" }
                }
            },
            {
                description = "Вернись к подрывникам",
                objectives = {
                    { type = "talk", npc = "npc_cat_barrel" }
                }
            },
        }
    },
    q_pandas = {
        giver = "npc_brewmaster",
        name = "Три оттенка",
        acts = { 1, 2, 3 },
        showExclamation = true,
        steps = {
            {
                description = "Найди Красного, Зелёного и Синего",
                objectives = {
                    { type = "talk", npc = "npc_red" },
                    { type = "talk", npc = "npc_green" },
                    { type = "talk", npc = "npc_blue" },

                }
            },
            {
                description = "Вернись к панде",
                objectives = {
                    { type = "talk", npc = "npc_brewmaster" }
                }
            },
        }
    },
    q_main_quest_act_1 = {
        giver = "npc_guide",
        name = "Предвестие катастрофы",
        steps = {
            {
                description = "Найди предвестника апокалипсиса в Заброшенном лесу и узнай что грядёт",
                objectives = {
                    { type = "talk", npc = "npc_predvestnik" }
                }
            },
            {
                description = "Найди способ починить шар для предсказаний",
                objectives = {
                    { type = "talk", npc = "npc_tinker" }
                }
            },
            {
                description = "Почини шар и верни предвестнику",
                objectives = {
                    { type = "talk", npc = "npc_predvestnik" }
                }
            },
            {
                description = "Сообщи о предсказании гиду",
                objectives = {
                    { type = "talk", npc = "npc_guide" }
                }
            },
        }
    },
    q_main_quest_act_2 = {
        giver = "npc_guide",
        name = "Выживший",
        steps = {
            {
                description = "Найди загадочного крипа и узнай, что ему нужно",
                objectives = {
                    { type = "talk", npc = "npc_mystery" }
                }
            },
            {
                description = "Встреться с Главой",
                objectives = {
                    { type = "talk", npc = "npc_leader" }
                }
            },
            {
                description = "Найди выжившего в Снежных горах",
                objectives = {
                    { type = "talk", npc = "npc_hermit" }
                }
            },
            {
                description = "Расскажи о ключе Главе",
                objectives = {
                    { type = "talk", npc = "npc_leader" }
                }
            },
        }
    },

}
