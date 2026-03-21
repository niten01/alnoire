if barebones == nil then
	_G.barebones = class({})
else
	DebugPrint(
		"[BAREBONES] barebones class name is already in use, change the name if this is the first time you launch the game!")
	DebugPrint("[BAREBONES] If this is not your first time, you probably used script_reload in console.")
end

require('internal.utils')
require('internal.ai_utils')

require('libraries.timers')          -- Core lua library
require('libraries.player_resource') -- Core lua library
require('gamemode')                  -- Core barebones file

function Precache(context)
	local precache = require('internal.precache')

	for _, unit in ipairs(precache.units) do
		PrecacheUnitByNameSync(unit, context)
	end

	for _, model in ipairs(precache.models) do
		PrecacheModel(model, context)
	end

	for _, sound in ipairs(precache.sounds) do
		PrecacheResource("soundfile", sound, context)
	end

	for _, particle in ipairs(precache.particles) do
		PrecacheResource("particle", particle, context)
	end

	for _, pf in ipairs(precache.particleFolders) do
		PrecacheResource("particle_folder", pf, context)
	end
end

-- Create the game mode when we activate
function Activate()
	DebugPrint("[BAREBONES] Activating ...")
	barebones:InitGameMode()
end
