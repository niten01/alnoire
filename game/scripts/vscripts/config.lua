local M = {}

M.ANIMATION_TRANSLATE_THINKER_INTERVAL = 0.1
M.ANIMATION_TRANSLATE_AGRESSIVE_RADIUS = 500

return setmetatable({}, {
    __index=M,
    __newindex = function(_, k, _) 
        error("Attempt to modify config variable: " .. tostring(k), 2)
    end,
    __metatable = false
})