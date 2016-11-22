-- Simple module loader.
-- Place in ReplicatedStorage.
-- Modules may go in any location within the SearchLocations table.
-- Names cannot be shared; this uses a recursive search. Call the function with a series of strings corresponding to module names.
-- They will be loaded if found; nil will be returned in their place otherwise.
local SearchLocations = {
	script, 
	game.StarterPlayer.StarterCharacterScripts,
	game.StarterPlayer.StarterPlayerScripts,
	game.ServerScriptService:FindFirstChild("Modules"),
	game.ReplicatedStorage:FindFirstChild("Modules"),
}

return function(...)
	local results = {}
	
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		
		for _, searchLocation in pairs(SearchLocations) do
			local object = searchLocation:FindFirstChild(name, true)
			
			if object ~= nil then
				table.insert(results, require(object))
				break
			end
		end
	end
		
	return unpack(results)
end
