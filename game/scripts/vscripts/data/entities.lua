return {
    ------------------------------------------------------------
    --- Spawners
    ------------------------------------------------------------
    spawner = {
        __common = {
            team = DOTA_TEAM_GOODGUYS
        },

        spawner_subway_city = {
            npc = "npc_subway_city",
            modifiers = { "modifier_story_npc" },
        },
        spawner_subway_ski = {
            npc = "npc_subway_ski",
            modifiers = { "modifier_story_npc" },
        },
        spawner_subway_village = {
            npc = "npc_subway_village",
            modifiers = { "modifier_story_npc" },
        },
        spawner_subway_concert = {
            npc = "npc_subway_concert",
            modifiers = { "modifier_story_npc" },
        },
        spawner_subway_ghetto = {
            npc = "npc_subway_ghetto",
            modifiers = { "modifier_story_npc" },
        },

        spawner_xavier = {
            npc = "npc_xavier",
            modifiers = { "modifier_story_npc" },
        },
        spawner_shooter = {
            npc = "npc_shooter",
            deferred = true,
        },
        spawner_gorilla = {
            npc = "npc_gorilla",
            modifiers = { "modifier_story_npc" },
            deferred = true,
            team = DOTA_TEAM_BADGUYS,
        },
        spawner_blue_prince = {
            npc = "npc_blue_prince",
            modifiers = { "modifier_story_npc" },
        },
        spawner_tormentor = {
            npc = "npc_tormentor",
            modifiers = { "modifier_story_npc" },
        },
        spawner_shamanka = {
            npc = "npc_shamanka",
            modifiers = { "modifier_story_npc" },
        },
        spawner_gate_troll_left = {
            npc = "npc_gate_troll_biruk",
            modifiers = { "modifier_story_npc" },
            team = DOTA_TEAM_BADGUYS,
        },
        spawner_gate_troll_right = {
            npc = "npc_gate_troll_diruk",
            modifiers = { "modifier_story_npc" },
            team = DOTA_TEAM_BADGUYS,
        },
        spawner_gate_troll_center = {
            npc = "npc_gate_troll_uruk",
            modifiers = { "modifier_story_npc" },
            team = DOTA_TEAM_BADGUYS,
        },
        spawner_guide_city_entrance = {
            npc = "npc_guide",
            modifiers = { "modifier_story_npc" },
        },
        spawner_creep_rogach = {
            npc = "npc_creep_rogach",
            modifiers = { "modifier_story_npc" },
        },
        spawner_creep_bob = {
            npc = "npc_creep_bob",
            modifiers = { "modifier_story_npc" },
        },
        spawner_mustache = {
            npc = "npc_mustache",
            modifiers = { "modifier_story_npc" },
        },
        spawner_monkey_king = {
            npc = "npc_monkey_king",
            modifiers = { "modifier_story_npc" },
            team = DOTA_TEAM_BADGUYS,
        },
        spawner_brewmaster = {
            npc = "npc_brewmaster",
            modifiers = { "modifier_story_npc" },
        },
        spawner_ogre_magi = {
            npc = "npc_ogre_magi",
            modifiers = { "modifier_story_npc" },
        },
        spawner_ogre_bruiser = {
            npc = "npc_ogre_bruiser",
            modifiers = { "modifier_story_npc" },
            team = DOTA_TEAM_BADGUYS,
        },
        spawner_rape_victim = {
            npc = "npc_rape_victim",
            modifiers = { "modifier_story_npc" },
        },
        spawner_rape_victim_2 = {
            npc = "npc_rape_victim",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_predvestnik = {
            npc = "npc_predvestnik",
            modifiers = { "modifier_story_npc" },
        },
        spawner_mystery = {
            npc = "npc_mystery",
            modifiers = { "modifier_story_npc" },
        },
        spawner_templar_assasin = {
            npc = "npc_templar_assasin",
            modifiers = { "modifier_story_npc" },
        },
        spawner_alchemist = {
            npc = "npc_alchemist",
            modifiers = { "modifier_story_npc" },
        },
        spawner_scientist = {
            npc = "npc_scientist",
            modifiers = { "modifier_story_npc" },
        },
        spawner_red = {
            npc = "npc_red",
            modifiers = { "modifier_story_npc" },
            team = DOTA_TEAM_BADGUYS,
            deferred = true,
        },
        spawner_concert_guard = {
            npc = "npc_concert_guard",
            modifiers = { "modifier_story_npc" },
        },

    },

    pack = {
        __common = {
            rangeFastTickRate = 2000,
            rangeRetreat = 1300,
            rangeAggro = 600,
            state = "idle",
            isStory = false,
            thinker = "default"
        },

        pack_forest_act1_lizards = {
            foes = {
                {
                    unitName="npc_jungle_venomancer",
                    spawnPoint =  "spawn_point_lizzards_venomancer",
                },
                {
                    unitName="npc_jungle_creep_melee",
                    spawnPoint =  "spawn_point_lizzards_creep_melee",
                },
                {
                    unitName="npc_jungle_creep_range",
                    spawnPoint =  "spawn_point_lizzards_creep_range",
                }
            }
        },

        pack_forest_act1_axe = {
            thinker = "axe",
            foes = {
                {
                    unitName="npc_jungle_axe",
                    spawnPoint =  "spawn_point_axe_axe",
                },
                {
                    unitName="npc_jungle_sisipisi",
                    spawnPoint =  "spawn_point_axe_sisipisi",
                },
            }
        }
    },

    ------------------------------------------------------------
    --- Zones
    ------------------------------------------------------------
    zone = {
        zone_prologue = { musicSet = "silence", respawnPoint = "respawn_prologue" },
        zone_forest_1 = { musicSet = "forest", respawnPoint = "respawn_forest_1" },
        zone_city = { musicSet = "city", respawnPoint = "respawn_city", },
        zone_wastelands = { musicSet = "wastelands", respawnPoint = "respawn_wastelands" },
        zone_ghetto = { musicSet = "ghetto", respawnPoint = "respawn_ghetto" },
    },

    ------------------------------------------------------------
    --- NPCs
    ------------------------------------------------------------
    npc = {
        __common = {
            first_met_global = true,
            first_met_in_act = true,
            beaten = false,
            can_give_quest = false,
        },
    },

    ------------------------------------------------------------
    --- Doors
    ------------------------------------------------------------
    door = {
        door_prologue = {
            clipEntity = "clip_door_prologue",
            openAnimation = "cf_palace_door_open",
        },
        door_clash_royale = {
            clipEntity = "clip_door_clash_royale",
            openAnimation = "open",
        },
        door_forest_1_reward = {
            clipEntity = "clip_door_forest_1_reward",
            openAnimation = "cf_palace_door_open",
            requiresButtons = {
                "button_forest_1_reward_1",
                "button_forest_1_reward_2",
                "button_forest_1_reward_3",
                "button_forest_1_reward_4",
                "button_forest_1_reward_5",
            },
        },
        door_forest_1_shortcut = {
            clipEntity = "clip_door_forest_1_shortcut",
            openAnimation = "cf_palace_door_open",
            requiresButtons = {
                "button_forest_1_shortcut"
            },
        },
        door_village = {
            clipEntity = "clip_door_village"
        },
        door_concert = {
            clipEntity = "clip_door_concert"
        },
        door_ski = {
            clipEntity = "clip_door_ski"
        },
    },

    ------------------------------------------------------------
    --- Buttons
    ------------------------------------------------------------
    button = {
        button_forest_1_shortcut = {
            trigger = "button_trigger_forest_1_shortcut"
        },

        button_forest_1_reward_1 = {
            trigger = "button_trigger_forest_1_reward_1"
        },
        button_forest_1_reward_2 = {
            trigger = "button_trigger_forest_1_reward_2"
        },
        button_forest_1_reward_3 = {
            trigger = "button_trigger_forest_1_reward_3"
        },
        button_forest_1_reward_4 = {
            trigger = "button_trigger_forest_1_reward_4"
        },
        button_forest_1_reward_5 = {
            trigger = "button_trigger_forest_1_reward_5"
        },
    },
}
