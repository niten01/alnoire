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
    },

    ------------------------------------------------------------
    --- Zones
    ------------------------------------------------------------
    zone = {
        zone_forest = { musicSet = "forest" },
        zone_city = { musicSet = "city" },
        zone_wastelands = { musicSet = "wastelands" },
        zone_ghetto = { musicSet = "ghetto" },
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
