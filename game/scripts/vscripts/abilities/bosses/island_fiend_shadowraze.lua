require("abilities.bosses.island_fiend_shadowraze_common")

--------------------------------------------------------------------------------
shadow_fiend_shadowraze_a_lua = class({})
shadow_fiend_shadowraze_b_lua = class({})
shadow_fiend_shadowraze_c_lua = class({})

function shadow_fiend_shadowraze_a_lua:OnSpellStart()
    if not IsServer() then return end
    shadowraze.OnSpellStart(self)
end

function shadow_fiend_shadowraze_b_lua:OnSpellStart()
    if not IsServer() then return end
    shadowraze.OnSpellStart(self)
end

function shadow_fiend_shadowraze_c_lua:OnSpellStart()
    if not IsServer() then return end
    shadowraze.OnSpellStart(self)
end

--------------------------------------------------------------------------------

