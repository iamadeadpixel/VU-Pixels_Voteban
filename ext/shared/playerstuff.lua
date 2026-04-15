-- Spaghetti code by iamadeadpixel
Events:Subscribe('Level:LoadingInfo', function(screenInfo)
	if screenInfo == "Running" or screenInfo == "Blocking on shader creation" or screenInfo == "Loading done" then
		print("*** Playerstuff loaded ***");
	end
end)

-- -------------

--[[
This stuff is set on server startup
And should basicly never be wiped on reload or nextmap load.
]]

CountPlayers = 0
vb_fetchplayername = {} -- value is name
vb_fetchplayerguid = {} -- value is guid

-- -------------

Events:Subscribe('Player:Joining', function(name, playerGuid, ipAddress, accountGuid)
	vb_fetchplayerguid[name] = tostring(accountGuid)
	vb_fetchplayername[name] = name
	CountPlayers = CountPlayers + 1
end)

-- -------------

Events:Subscribe('Player:Left', function(player) -- player.name
	vb_fetchplayerguid[player.name] = nil
	vb_fetchplayername[player.name] = nil
	vb_voteplayers[player.name] = nil
	cancelvote[player.name] = nil
	CountPlayers = CountPlayers - 1
end)
