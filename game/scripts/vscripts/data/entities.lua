return {
    ------------------------------------------------------------
    --- Spawners
    ------------------------------------------------------------
    spawner = {
        __common = {
            team = DOTA_TEAM_GOODGUYS
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
            deferred = true,
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
    },

    packs = {
        __common = {
            rangeFastTickRate = 1000,
            rangeRetreat = 1000,
            rangeAggro = 500,
            state = "idle",
        },

        pack_forest_1 = {
            foes = {
                {
                    unitName = "npc_ogre",
                    spawnPoint = "spawn_point_1",
                },
                {
                    unit = "npc_ogre",
                    spawnPoint = "spawn_point_1",
                },
                {
                    unit = "npc_ogre",
                    spawnPoint = "spawn_point_1",
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
            modifiers_on_player_kill = nil,
        },
        npc_monkey_king = {
            modifiers_on_player_kill = { "modifier_story_npc" }
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
            },
        },
        door_forest_1_shortcut = {
            clipEntity = "clip_door_forest_1_shortcut",
            openAnimation = "cf_palace_door_open",
            requiresButtons = {
                "button_forest_1_shortcut"
            },
        },
    },

    ------------------------------------------------------------
    --- Buttons
    ------------------------------------------------------------
    button = {
        button_forest_1_shortcut = {
            trigger = "button_trigger_forest_1_shortcut"
        }
    },
}
