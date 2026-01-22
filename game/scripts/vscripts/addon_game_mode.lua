if barebones == nil then
	_G.barebones = class({})
else
	DebugPrint(
	"[BAREBONES] barebones class name is already in use, change the name if this is the first time you launch the game!")
	DebugPrint("[BAREBONES] If this is not your first time, you probably used script_reload in console.")
end

require('internal.util')
require('internal.entity_data')

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
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
end

-- Create the game mode when we activate
function Activate()
	DebugPrint("[BAREBONES] Activating ...")
	barebones:InitGameMode()
end
