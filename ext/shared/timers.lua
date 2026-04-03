-- Spaghetti code by iamadeadpixel
Events:Subscribe('Level:LoadingInfo', function(screenInfo)
    if screenInfo == "Running" or screenInfo == "Blocking on shader creation" or screenInfo == "Loading done" then
        print("*** Timers loaded ***");
    end
end)

trigger_start_timer = os.time()
trigger_wait_timer = 1

Events:Subscribe('Player:Update', function(player, deltaTime)
    trigger_end_timer = os.time()
    trigger_elapsed_timer = os.difftime(trigger_end_timer, trigger_start_timer)
    trigger_elapsed_timer = math.floor(trigger_elapsed_timer)
    if trigger_elapsed_timer >= trigger_wait_timer then
        if start__timerfunction == true then
            --
            if countdown_time == 180 then
                print("3 minutes left for the " .. bantype)
                ChatManager:SendMessage("3 minutes left for the " .. bantype)
            end
            if countdown_time == 120 then
                print("2 minutes left for the " .. bantype)
                ChatManager:SendMessage("2 minutes left for the " .. bantype)
            end

            if countdown_time == 90 then
                print("90 seconds left for the " .. bantype)
                ChatManager:SendMessage("90 seconds left for the " .. bantype)
            end

            if countdown_time == 60 then
                print("60 seconds left for the " .. bantype)
                ChatManager:SendMessage("60 seconds left for the " .. bantype)
            end

            if countdown_time == 45 then
                print("45 seconds left for the " .. bantype)
                ChatManager:SendMessage("45 seconds left for the " .. bantype)
            end

            if countdown_time == 30 then
                print("30 seconds left for the " .. bantype)
                ChatManager:SendMessage("30 seconds left for the " .. bantype)
            end

            if countdown_time <= 10 then
                print(countdown_time .. " seconds left")
                ChatManager:SendMessage(countdown_time .. " seconds left")
            end
            --
            countdown_time = countdown_time - 1

            if countdown_time == 0 then
                start__timerfunction = false -- ensure it runs only 1 time
                if voteban_function then voteban(player, targetplayer); end
                if votetban_function then votetban(player, targetplayer); end
                if voterban_function then voterban(player, targetplayer); end
                if votekick_function then votekick(player, targetplayer); end
                trigger_timer = false
            end

            trigger_start_timer = os.time()
        end
    end
end)
