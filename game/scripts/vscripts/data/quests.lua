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
        name = "High top",
        acts = { 2 },
        showExclamation = true,
        steps = {
            {
                description = "Добудь билеты у перекупа",
                objectives = {
                    { type = "get_item", item = "item_concert_ticket" }
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
        giver = "npc_subway_fake",
        name = "jevacation",
        acts = { 1, 2 },
        steps = {
            {
                description = "Сбеги с острова",
                objectives = {
                    { type = "come", trigger = "trigger_island_fight_1" }
                }
            },
            {
                description = "Победи охранника",
                objectives = {
                    { type = "kill", npc = "npc_island_guard" }
                }
            },
            {
                description = "Воспользуйся подземным тоннелем",
                objectives = {
                    { type = "manual" }
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
                description = "Найди секретный проход",
                objectives = {
                    { type = "come", trigger = "trigger_island_fifth" }
                }
            },
            {
                description = "Изучи территорию",
                objectives = {
                    { type = "come", trigger = "trigger_demons" }
                }
            },
            {
                description = "Одолей демонов",
                objectives = {
                    { type = "kill", npc = "npc_shadow_demon_island" },
                    { type = "kill", npc = "npc_shadow_fiend_island" },
                }
            },
            {
                description = "Заложи бомбу",
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
                    { type = "remove", npc = "npc_red" },
                    { type = "remove", npc = "npc_green" },
                    { type = "remove", npc = "npc_blue" },

                },
                postStepActions = {
                    { type = "spawn", spawn = "spawner_brewmaster" }
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
                    { type = "get_item", item = "item_crystal_ball" }
                }
            },
            {
                description = "Верни шар предвестнику",
                objectives = {
                    { type = "talk", npc = "npc_predvestnik" }
                },
                postStepActions = {
                    { type = "setup_gorilla_scene" }
                }
            },
            {
                description = "Сообщи о предсказании гиду",
                objectives = {
                    { type = "kill", npc = "npc_gorilla" }
                },
                postStepActions = {
                    { type = "open_door", door = "door_city_forest" }
                }
            },
            {
                description = "Сообщи о предсказании гиду",
                objectives = {
                    { type = "talk", npc = "npc_guide" }
                },
                postStepActions = {
                    { type = "change_act", act = 2 }
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
                },
                postStepActions = {
                    { type = "change_act", act = 3 }
                }
            },
        }
    },
    q_main_quest_act_3 = {
        giver = "npc_leader",
        name = "Великий ключ",
        steps = {
            {
                description =
                "Восстанови Ключ Пустошей",
                objectives = {
                    { type = "get_item", item = "item_key" }
                }
            },
            {
                description = "Вернись к Главе",
                objectives = {
                    { type = "talk", npc = "npc_leader" }
                },
                postStepActions = {
                    { type = "change_act", act = 4 }
                }
            },
        }
    },
    q_ghetto = {
        giver = "npc_dream",
        name = "O'Block",
        acts = { 3 },
        requires = { "q_concert" },
        showExclamation = true,
        noFireworks = true,
        onAccept = {
            { type = "open_door", door = "door_ghetto" },
        },
        steps = {
            {
                description = "Забери из гетто lean",
                objectives = {
                    { type = "get_item", item = "item_lean" }
                }
            },
            {
                description = "Отдай lean крипу",
                objectives = {
                    { type = "manual" }
                }
            },
        }
    },
    q_main_quest_act_4 = {
        giver = "npc_leader",
        name = "Судьба",
        steps = {
            {
                description =
                "Иди в Пустошь и покончи с Дереком",
                objectives = {
                    { type = "talk", npc = "npc_derek" }
                }
            },
            {
                description = "Осмотри пещеру около входа в Королевство (Carcer Immortalium)",
                objectives = {
                    { type = "talk", npc = "npc_george" }
                }
            },
            {
                description = "Одолей Короля",
                objectives = {
                    { type = "talk", npc = "npc_george" }
                }
            },
            {
                description = "Соверши сделку с Богом",
                objectives = {
                    { type = "talk", npc = "npc_tormentor" }
                }
            },
            {
                description = "Вернись в реальный мир",
                objectives = {
                    { type = "trigger", trigger = "trigger_portal_escape" }
                }
            },
        }
    },
}
