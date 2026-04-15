-- Spaghetti code by iamadeadpixel
Events:Subscribe('Level:LoadingInfo', function(screenInfo)
    if screenInfo == "Running" or screenInfo == "Blocking on shader creation" or screenInfo == "Loading done" then
        print("*** Functions loaded ***");
    end
end)

-- -------------
-- This code is ripped from the ingameadmin mod
function string:split(sep)
    sep, fields = sep or ":", {}
    pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) fields[#fields + 1] = c end)
    return fields
end -- end of function call

-- -------------

function reset_vote_data(player, targetplayer)
    -- Reseting vote data
    targetplayer = nil
    s_message = nil
    ban_message = nil
    yesVotes = 0;
    noVotes = 0;
    vote_treshhold = 0
    vb_voteplayers = {}
    vb_votetype = {}
    vb_treshhold = true

    cancelvote = {}
    start__timerfunction = false

    trigger_timer = false
    init_vote = false
    votekick_function = false
    voteban_function = false
    votetban_function = false
    voterban_function = false

    print("Resetting vote stuff")
end -- end of function call

-- -------------

-- This stuff is triggered when the vote countdown ends
-- it resets some base variables, and continues
function votekick(player, targetplayer)
    init_vote = false
    votekick_function = false
    print("")
    print("Messages after votekick function call:")
    print("Player table: " .. targetplayer)
    print("Message:" .. s_message)
    print("")
    endvote(player, targetplayer)
end

-- -------------

function voteban(player, targetplayer)
    init_vote = false
    voteban_function = false
    print("")
    print("Messages after voteban function call:")
    print("Player table: " .. targetplayer)
    print("Message:" .. s_message)
    print("")
    endvote(player, targetplayer)
end

-- -------------

function votetban(player, targetplayer)
    init_vote = false
    votetban_function = false
    print("")
    print("Messages after votetban function call:")
    print("Player table: " .. targetplayer)
    print("Message:" .. s_message)
    print("")
    endvote(player, targetplayer)
end

-- -------------

function voterban(player, targetplayer)
    init_vote = false
    voterban_function = false
    print("")
    print("Messages after voterban function call:")
    print("Player table: " .. targetplayer)
    print("Message:" .. s_message)
    print("")
    endvote(player, targetplayer)
end

-- -------------
-- Here the real fun begins
-- We counts the votes, check it its got the minimum
-- Compares values ,and continue if all passes
function endvote(player, targetplayer)
    local players = PlayerManager:GetPlayerCount()
    print(bantype ..
        " outcome YES:" ..
        yesVotes .. " - NO:" .. noVotes .. " Vote treshhold:" .. vote_treshhold .. "/" .. vote_min_treshhold + 2) -- We need to cheat here
    ChatManager:SendMessage(bantype ..
        " outcome YES:" ..
        yesVotes .. " - NO:" .. noVotes .. " Vote treshhold:" .. vote_treshhold .. "/" .. vote_min_treshhold + 2) -- We need to cheat here
    print("Players vote against " .. targetplayer)
    print("Kick reason given for player:" .. s_message)
    --

    --[[
Let see what type of vote we got here with its outcome
]]
    --
    -- if nobody votes,player stays
    if yesVotes == 0 and noVotes == 0 then
        print("NO VOTES: Player " .. targetplayer .. " stays")
        ChatManager:SendMessage("NO VOTES: Player " .. targetplayer .. " stays")
        reset_vote_data(player, targetplayer)
        return
    end
    --
    -- if not enough votes, no need to run the rest of the script.
    if vote_treshhold <= min_treshhold then
        print("Not enough votes, " .. targetplayer .. " stays")
        ChatManager:SendMessage("Not enough votes, " .. targetplayer .. " stays")
        print(bantype ..
            " outcome YES:" .. yesVotes ..
            " - NO:" .. noVotes .. " Vote treshhold:" .. vote_treshhold .. "/" .. vote_min_treshhold + 2) -- We need to cheat here
        ChatManager:SendMessage(bantype ..
            " outcome YES:" .. yesVotes .. " - NO:" ..
            noVotes .. " Vote treshhold:" .. vote_treshhold .. "/" .. vote_min_treshhold + 2) -- We need to cheat here
        reset_vote_data(player, targetplayer)
        return
    end
    -- If votes are equal,player stays
    if yesVotes == noVotes then
        print("DRAW: Vote canceled, YES:" ..
            yesVotes .. " - NO:" .. noVotes)
        ChatManager:SendMessage("DRAW: Vote canceled, YES:" ..
            yesVotes .. " - NO:" .. noVotes)
        print("Player " .. targetplayer .. " stays")
        ChatManager:SendMessage("Player " .. targetplayer .. " stays")
        reset_vote_data(player, targetplayer)
        return
    end
    --
    if noVotes >= vote_min_treshhold and yesVotes <= vote_min_treshhold then
        print(bantype .. ": No voters win, " .. targetplayer .. " got lucky this time")
        ChatManager:SendMessage(bantype .. ": No voters win, " .. targetplayer .. " got lucky this time")
        reset_vote_data(player, targetplayer)
        return
    end

    -- -----

    if bantype == "votekick" then
        print("votekick function")
        --
        if yesVotes >= vote_min_treshhold and noVotes <= vote_min_treshhold then
            print(bantype .. ": Yes voters win, " .. targetplayer .. " got kicked from the server")
            print("Kick reason given for player:" .. s_message)
            ChatManager:SendMessage(bantype .. ": Yes voters win, " .. targetplayer .. " got kicked from the server")
            ChatManager:SendMessage("Kick reason given for player:" .. s_message)
            RCON:SendCommand('admin.kickPlayer', { targetplayer, (s_message) })
            reset_vote_data(player, targetplayer)
            return
        end
    end

    -- -----

    if bantype == "voteban" then
        print("voteban function")
        --
        if yesVotes >= vote_min_treshhold and noVotes <= vote_min_treshhold then
            ban_message = (targetplayer .. " :" .. s_message)
            print(bantype .. ": Yes voters win, " .. targetplayer .. " got banned from the server")
            print("Ban reason given for player:" .. ban_message)
            ChatManager:SendMessage(bantype .. ": Yes voters win, " .. targetplayer .. " got banned from the server")
            ChatManager:SendMessage("Ban reason given for player:" .. ban_message)

            RCON:SendCommand('banList.add', { "guid", tostring(targetguid), "perm", ban_message }) -- permban
            RCON:SendCommand('banlist.save')                                                       -- Save the ban to banlist.txt
            RCON:SendCommand('banlist.list')                                                       -- Reload banlist.txt (usefull whit procon)
            reset_vote_data(player, targetplayer)
            return
        end
    end

    -- -----

    if bantype == "votetban" then
        print("votetban function")
        --
        if yesVotes >= vote_min_treshhold and noVotes <= vote_min_treshhold then
            ban_message = (targetplayer .. " :" .. s_message)
            print(bantype .. ": Yes voters win, " .. targetplayer .. " got Timebanned from the server")
            print("Timeban reason given for player:" .. ban_message)
            ChatManager:SendMessage(bantype .. ": Yes voters win, " .. targetplayer .. " got Timebanned from the server")
            ChatManager:SendMessage("Timeban reason given for player:" .. ban_message)

            RCON:SendCommand('banList.add', { "guid", tostring(targetguid), "seconds", "" .. timeban .. "", ban_message })
            RCON:SendCommand('banlist.save') -- Save the ban to banlist.txt
            RCON:SendCommand('banlist.list') -- Reload banlist.txt (usefull whit procon)
            reset_vote_data(player, targetplayer)
            return
        end
    end

    -- -----

    if bantype == "voterban" then
        print("voterban function")
        --
        if yesVotes >= vote_min_treshhold and noVotes <= vote_min_treshhold then
            ban_message = (targetplayer .. " :" .. s_message)
            print(bantype .. ": Yes voters win, " .. targetplayer .. " got Timebanned from the server")
            print("Timeban reason given for player:" .. ban_message)
            ChatManager:SendMessage(bantype .. ": Yes voters win, " .. targetplayer .. " got Timebanned from the server")
            ChatManager:SendMessage("Timeban reason given for player:" .. ban_message)

            RCON:SendCommand('banList.add', { "guid", tostring(targetguid), "rounds", "" .. roundban .. "", ban_message })
            RCON:SendCommand('banlist.save') -- Save the ban to banlist.txt
            RCON:SendCommand('banlist.list') -- Reload banlist.txt (usefull whit procon)
            reset_vote_data(player, targetplayer)
            return
        end
    end
end -- end of function call
