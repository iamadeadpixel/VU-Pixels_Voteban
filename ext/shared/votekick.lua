-- Spaghetti code by iamadeadpixel
Events:Subscribe('Level:LoadingInfo', function(screenInfo)
    if screenInfo == "Running" or screenInfo == "Blocking on shader creation" or screenInfo == "Loading done" then
        print("*** votekick loaded ***");
    end
end)

-- -------------

Events:Subscribe('Player:Chat', function(player, recipientMask, message)
    -- This code is ripped from the ingameadmin mod
    if message == '' or player == nil then
        return
    end

    -- lowerkey the message
    message = message:lower()

    -- split the message into parts
    s_Parts = message:split(' ')

    -- check if the first key is not a "!"
    if s_Parts[1]:sub(1, 1) ~= "!" then
        return
    end
    -- only if it starts with "!" we go on

    if s_Parts[1] == '!votekick' then
        local currentplayers = PlayerManager:GetPlayerCount()
        if currentplayers <= vote_min_treshhold then
            print("Not enough player to start a vote (" .. currentplayers .. "/" .. vote_min_treshhold .. ")")
            ChatManager:SendMessage(
                "Not enough player to start a vote (" .. currentplayers .. "/" .. vote_min_treshhold .. ")", player)
            return
        end

        if not Config.votekick then
            ChatManager:SendMessage("VoteKICK is disabled")
            print("VoteKICK disabled")
            return
        end

        if Config.votekick then
            -- First we check of there is already a vote in progress
            -- Why here ?,else the vote type could be changed
            if init_vote == true then
                print("Sorry,already a vote in progress")
                ChatManager:SendMessage("Sorry,already a vote in progress")
                return
            end

            bantype = "votekick"

            -- print the chat input to console
            print("")
            print('Chat: ' .. player.name .. ': ' .. message)
            print("")

            -- If no name given, report back
            if s_Parts[2] == nil then
                ChatManager:SendMessage("Error: We need a name here", player)
                print("Error: We need a name here")
                return
            end

            -- Here we check if the player is in tabledata,and report also the GUID
            if s_Parts[2] ~= nil then
                print("")
                print("Finding the correct player we have in tables")

                for name, fetchguid in pairs(vb_fetchplayerguid) do
                    if string.match(name:lower(), s_Parts[2]:lower()) then
                        targetplayer = name
                        targetguid = ((fetchguid):gsub("-", ""))
                        print("Found matching playername " .. targetplayer .. " with " .. targetguid .. " as Guid")
                        ChatManager:SendMessage("Matching player found " .. targetplayer .. " - GUID:" .. targetguid,
                            player)
                        --
                    elseif not string.match(name:lower(), s_Parts[2]:lower()) then
                        print("Player not in tables")
                        ChatManager:SendMessage("no matching player found (" .. s_Parts[2] .. ")", player)
                        return
                    end
                    --
                    print("Check if " .. vb_fetchplayername[player.name] .. " is in the whitelist.")
                    for _, vb_whitelist in pairs(whitelist) do
                        if vb_whitelist == vb_fetchplayername[player.name] then
                            whitelist_player = vb_whitelist
                            print("Found:" .. whitelist_player .. ", is in the 'whitelist table'")
                            ChatManager:SendMessage("Protected players cant be banned")
                            reset_vote_data(player, targetplayer)
                            return -- If the player was in the whitelist, here it ends.
                        end
                    end
                    --
                    -- Lets check if a reason is given
                    if s_Parts[3] == nil then
                        print("Error: No reason given")
                        ChatManager:SendMessage("Error: No reason given")
                        return
                    end
                    --
                    if s_Parts[3] ~= nil then
                        ss_message = (s_Parts[1] .. " " .. s_Parts[2])
                        s_message = ((message):gsub(ss_message, ""))

                        print(bantype .. " Reason given for targetplayer:" .. targetplayer .. ":" .. s_message)
                        ChatManager:SendMessage(bantype .. " " .. targetplayer .. " Reason:" .. s_message)
                        --
                    end
                    --[[
		Here start the countdown timer
		]]
                    if trigger_timer == false then
                        init_vote = true
                        countdown_time = 180 -- time in seconds (180)
                        start__timerfunction = true
                        trigger_timer = true
                        votekick_function = true
                        print("Starting countdown for voteban on targetplayer:" .. targetplayer .. ":" .. s_message)
                        print("Players do Yes or no on the current vote running against " .. targetplayer)
                        print(bantype .. " outcome YES:" .. yesVotes .. " - NO:" .. noVotes)
                        ChatManager:SendMessage("Type !yes or !no to start the " ..
                            bantype .. " against " .. targetplayer)
                    end
                end
            end
        end
    end
    --
end) -- End of chat event.
