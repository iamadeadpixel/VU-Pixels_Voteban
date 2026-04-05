-- Spaghetti code by iamadeadpixel

Events:Subscribe('Level:LoadingInfo', function(screenInfo)
    if screenInfo == "Running" or screenInfo == "Blocking on shader creation" or screenInfo == "Loading done" then
        print("*** votetime loaded ***");
    end
end)

-- ----
--[[
	Lets set the init_vote to true,
	on startup this was set to false
	when it is set to true here, no other vote can be started
]]

Events:Subscribe('Player:Chat', function(player, recipientMask, message)
    if init_vote == true and message == "!yes" then
        if vb_voteplayers[player.name] then
            print("Player " .. player.name .. " already voted for " .. vb_votetype[player.name])
            ChatManager:SendMessage("Player " .. player.name .. " already voted for " .. vb_votetype[player.name], player)
            return
        end

        print("Player " .. player.name .. " voted YES against " .. targetplayer)
        ChatManager:SendMessage("Player " .. player.name .. " voted YES against " .. targetplayer)
        vb_voteplayers[player.name] = true
        yesVotes = yesVotes + 1
        vote_treshhold = vote_treshhold + 1
        vb_votetype[player.name] = "yes"
        print(bantype ..
        " outcome YES:" .. yesVotes ..
        " - NO:" .. noVotes .. " Vote treshhold:" .. vote_treshhold .. "/" .. vote_min_treshhold + 2)                                                   -- We need to cheat here
        ChatManager:SendMessage(bantype ..
        " outcome YES:" .. yesVotes .. " - NO:" ..
        noVotes .. " Vote treshhold:" .. vote_treshhold .. "/" .. vote_min_treshhold + 2)                                                               -- We need to cheat here
    end
end)
-- ----
Events:Subscribe('Player:Chat', function(player, recipientMask, message)
    if init_vote == true and message == "!no" then
        if vb_voteplayers[player.name] then
            print("Player " .. player.name .. " already voted for " .. vb_votetype[player.name])
            ChatManager:SendMessage("Player " .. player.name .. " already voted for " .. vb_votetype[player.name], player)
            return
        end

        print("Player " .. player.name .. " voted NO against " .. targetplayer)
        ChatManager:SendMessage("Player " .. player.name .. " voted NO against " .. targetplayer)
        vb_voteplayers[player.name] = true
        noVotes = noVotes + 1
        vote_treshhold = vote_treshhold + 1
        vb_votetype[player.name] = "no"
        print(bantype ..
            " outcome YES:" ..
            yesVotes .. " - NO:" .. noVotes .. " Vote treshhold:" .. vote_treshhold .. "/" .. vote_min_treshhold + 2) -- We need to cheat here
        ChatManager:SendMessage(bantype ..
            " outcome YES:" ..
            yesVotes .. " - NO:" .. noVotes .. " Vote treshhold:" .. vote_treshhold .. "/" .. vote_min_treshhold + 2) -- We need to cheat here
    end
end)
