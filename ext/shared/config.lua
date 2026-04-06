-- Spaghetti code by iamadeadpixel
Events:Subscribe('Level:LoadingInfo', function(screenInfo)
	if screenInfo == "Running" or screenInfo == "Blocking on shader creation" or screenInfo == "Loading done" then
		print("*** config loaded ***");
	end
end)

-- -------------
-- Here you can turn on, or off modules.

Config = {
	votekick = true, -- if true, player can use the!votekick command (Kick the player)
	voteban = true, -- if true, player can use the !voteban command (Perma ban a player)
	votetban = true, -- if true, player can use the !votetban command (Timebans a player)
	voterban = true, -- if true, player can use the !voterban command (round bans a player)
}

--[[
players who are protected against a voteban.
Most of time this should be server admins, and trusted players
]]

whitelist = {
	"iamadeadpixel",
}
