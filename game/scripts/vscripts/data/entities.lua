return {
    ------------------------------------------------------------
    --- Spawners
    ------------------------------------------------------------
    spawner = {
        __common = {
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
            first_met_global = false,
            first_met_in_act = false,
            beaten = false,
            can_give_quest = false,
        },
    }
}
