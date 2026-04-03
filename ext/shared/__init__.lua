---@class voteban
voteban = class 'voteban'

function voteban:__init()
    Events:Subscribe('Extension:Loaded', self, self.OnExtensionLoaded)
end

function voteban:OnExtensionLoaded()
    print("Initializing voteban")
    self.m_HotReloadTimer = 0
    self.m_IsHotReload = self:GetIsHotReload()
    self:RegisterEvents()
end

function voteban:RegisterEvents()
    Events:Subscribe('Engine:Init', self, self.OnEngineInit)
    Events:Subscribe('Level:Destroy', self, self.OnLevelDestroy)
end

function voteban:OnEngineInit()
    self.m_config = require('__shared/config')
    self.m_functions = require('__shared/functions')
    self.m_timers = require('__shared/timers')
    self.m_tablestuff = require('__shared/tablestuff')
    self.m_playerstuff = require('__shared/playerstuff')
    self.m_votetime = require('__shared/votetime')
    self.m_votekick = require('__shared/votekick')
    self.m_voteban = require('__shared/voteban')
    self.m_votetban = require('__shared/votetban')
    self.m_voterban = require('__shared/voterban')
end

function voteban:OnLevelDestroy()
    print("********* data whiped on level destroy *********");

    local s_OldMemory = math.floor(collectgarbage("count") / 1024)
    collectgarbage('collect')
    print("*Collecting Garbage on Level Destroy: " ..
        math.floor(collectgarbage("count") / 1024) .. " MB | Old Memory: " .. s_OldMemory .. " MB")
end

function voteban:GetIsHotReload()
    if #SharedUtils:GetContentPackages() == 0 then
        return false
    else
        return true
    end
end

voteban()
