--[[
	Copyright (c) 2009, dr_AllCOM3
    All rights reserved.

    You're allowed to use this addon, free of monetary charge,
    but you are not allowed to modify, alter, or redistribute
    this addon without express, written permission of the author.
]]

local L = LibStub( "AceLocale-3.0" ):GetLocale( "DocsUI_Nameplates" )
local LSM = LibStub( "LibSharedMedia-3.0" )
local temp,temp2,tempList = nil

--[[ Print ]]
local function p( text )
	ChatFrame3:AddMessage( tostring( text ) )
end

local UnitAura = UnitAura
local UnitExists = UnitExists
local strlower = strlower
local unpack = unpack
local tonumber = tonumber
local tostring = tostring
local ipairs = ipairs
local next = next
local pairs	= pairs
local sort = sort
local strfind = strfind
local tremove = tremove
local tinsert = tinsert
local UnitGUID = UnitGUID
local UnitBuff = UnitBuff
local UnitDebuff = UnitDebuff
local UnitIsPlayer = UnitIsPlayer
local UnitClassification = UnitClassification
local format = format
local floor = floor
local wipe = wipe

local db, frames
DocsUI_Nameplates.bossList = { currentBoss = nil }
local boss = DocsUI_Nameplates.bossList.currentBoss
local bossList = DocsUI_Nameplates.bossList

--[[ Hide everything ]]
function DocsUI_Nameplates:hideBossStuff()
    for i=1,#frames do
        local self = frames[i].nameplate
        
        if self.alertIcon:IsShown() then self.alertIcon:Hide() end
    end
end

--[[ Update the bossplate frame ]]
function DocsUI_Nameplates.updateBossplate( frame )
    if boss and boss.update then boss.update( frame ) end
end

--[[ OnUpdate ]]
local updater = CreateFrame( "Frame", nil, UIParent )
local lastUpdate = 0
local function onUpdate( self, elapsed )
	lastUpdate = lastUpdate + elapsed
    
	if lastUpdate>2 then
		DocsUI_Nameplates:bossCheck( "checkAgain" )
        
        updater:SetScript( "OnUpdate", nil )
        
        lastUpdate = 0
	end
end
--[[ Check which boss we're fighting ]]
function DocsUI_Nameplates:bossCheck( option )
    if option~="checkAgain" and not boss then
        updater:SetScript( "OnUpdate", onUpdate )
    else
        return
    end
    
    --p( "Checking... ("..tostring(option)..")" )
    
    for i=1,GetNumRaidMembers() do
        local nameTarget = UnitName( "raid"..i.."target" )
        
        if nameTarget then
            for index,value in pairs( DocsUI_Nameplates.bossList ) do
                if nameTarget==value.boss then
                    DocsUI_Nameplates.hideBossStuff()
                    boss = value
                    boss.initialize()
                    --p( "Boss found: "..tostring( boss.boss ) )
                    return
                end
            end
        end
    end
    
    if db.debugMode then
        local nameTarget = UnitName( "target" )
        
        if nameTarget then
            for index,value in pairs( DocsUI_Nameplates.bossList ) do
                if nameTarget==value.boss then
                    DocsUI_Nameplates.hideBossStuff()
                    boss = value
                    boss.initialize()
                    --p( "Boss found (debug): "..tostring( boss.boss ) )
                    return
                end
            end
        end
        
        --p( "(debug): No boss found." )
    end
    
    --p( "No boss found." )
    boss = nil
end

--[[ Disable the boss ]]
function DocsUI_Nameplates.bossDisable()
    if boss then boss.disable() end
    
    DocsUI_Nameplates.hideBossStuff()
    DocsUI_Nameplates.bossList.currentBoss = nil
end

--[[ Initialize ]]
function DocsUI_Nameplates.initializeBossplateUpdater()
    db = DocsUI_Nameplates.db.profile
    
    frames = DocsUI_Nameplates.frames
end