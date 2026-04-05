Events:Subscribe('Level:LoadingInfo', function(screenInfo)
  if screenInfo == "Running" or screenInfo == "Blocking on shader creation" or screenInfo == "Loading done" then
    print("*** Table stuff loaded ***");
    trigger_timer = false
    vb_voteplayers = {}
    vb_votetype = {}

    targetplayer = {}
    init_vote = false
    vb_treshhold = false
    yesVotes = 0;
    noVotes = 0;
    vote_treshhold = 0 -- DO NOT CHANGE THIS !

    --[[
    The stuff below can be changed

    ]]
    timeban = 86400   -- 24 hours timeban
    roundban = 4      -- 2 rounds a player will be banned
    min_treshhold = 6 -- Minimum players that need to vote that count fair enough to hold the vote

    --[[
    minimum amount players that need to be on the server to start a vote
    If you use funbots, THIS wil count to, so keep this in mind when setting the treshhold
]]
    vote_min_treshhold = 9;

    --[[
  This is not yet used, the min_treshhold works already as i wanted
    vote_max_treshhold = 8; -- maximum amount players on the server as treshhold counts as outcome for the vote to be executed
    ]]

    s_MaxPlayersRCON = RCON:SendCommand('vars.maxPlayers')
    server_MaxPlayers = tonumber(s_MaxPlayersRCON[2])
  end
end)
