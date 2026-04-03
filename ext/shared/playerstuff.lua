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

	print("playername:" .. vb_fetchplayername[name])
	print("playerguid:" .. vb_fetchplayerguid[name])
end)

-- -------------

Events:Subscribe('Player:Left', function(player) -- player.name
	print("Removing player " .. vb_fetchplayername[player.name] .. " from tables")
	print("PRE Dumping players from list")

	for place, vb_fetchplayer in pairs(vb_fetchplayername) do
		print("Found:" .. vb_fetchplayer .. " in the 'player table'")
	end

	vb_fetchplayerguid[player.name] = nil
	vb_fetchplayername[player.name] = nil
	vb_voteplayers[player.name] = nil
	CountPlayers = CountPlayers - 1

	print("")
	print("POST Dumping players from list")
	print("")

	for place, vb_fetchplayer in pairs(vb_fetchplayername) do
		print("Found:" .. vb_fetchplayer .. " in the 'player table'")
	end

	print("End of listed players on server (" .. CountPlayers .. ")")
end)
