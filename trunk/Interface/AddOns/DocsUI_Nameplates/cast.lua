--[[
	Copyright (c) 2009, dr_AllCOM3
    All rights reserved.

    You're allowed to use this addon, free of monetary charge,
    but you are not allowed to modify, alter, or redistribute
    this addon without express, written permission of the author.
]]

local L = LibStub( "AceLocale-3.0"):GetLocale("DocsUI_Nameplates" )
local LSM = LibStub( "LibSharedMedia-3.0" )
local temp,temp2
local addon = DocsUI_Nameplates

--[[ Print ]]
local function p( text )
	ChatFrame3:AddMessage( tostring( text ) )
end

local UnitGUID = UnitGUID
local UnitAura = UnitAura
local UnitBuff = UnitBuff
local UnitDebuff = UnitDebuff
local UnitExists = UnitExists
local UnitIsPlayer = UnitIsPlayer
local UnitClassification = UnitClassification
local unpack = unpack
local tonumber = tonumber
local tostring = tostring
local ipairs = ipairs
local next = next
local pairs	= pairs
local sort = sort
local strfind = strfind
local strlower = strlower
local tremove = tremove
local tinsert = tinsert
local format = format
local floor = floor
local wipe = wipe

local resources = DocsUI_Nameplates.resources
local db, global, realm, frames, updateNameplateByGUID, playerTargetGUID
local lastEvent
addon.GUIDCasts = {}
local guidCasts = addon.GUIDCasts

local playerGUID = UnitGUID( "player" )

--[[ Combat log fix ]]
-- Credit to Shadowed
-- http://www.wowinterface.com/downloads/info16001-CombatLogFix.html
local function checkTimeout( self, elapsed )
	self.timeout = self.timeout-elapsed
	
    if self.timeout>0 then return end
    
	self:Hide()
	
	-- If the last combat log event was within a second of the cast succeeding, we're fine
	if lastEvent and ( GetTime()-lastEvent ) <= 1 then return end

	-- Try and narrow it down
	if db.combatLogFixPrint then
		local msg
        
        msg = format( "%d filtered/%d events found. Cleared combat log, as it broke.", CombatLogGetNumEntries(), CombatLogGetNumEntries( true ) )
        
        ChatFrame1:AddMessage( msg )
	end
	
	CombatLogClearEntries()
end

local combatLog = CreateFrame( "Frame" )
combatLog:SetScript( "OnEvent", function( self, event, ... )
    combatLog[event]( combatLog, event, ... )
end )
combatLog:RegisterEvent( "COMBAT_LOG_EVENT_UNFILTERED" )
combatLog:SetScript( "OnUpdate", checkTimeout )
combatLog:Hide()

function combatLog:COMBAT_LOG_EVENT_UNFILTERED( ... )
    lastEvent = GetTime()
end

--[[ Update a nameplate ]]
local setDoUpdateMe = DocsUI_Nameplates.setDoUpdateMe
function update( GUID )
    setDoUpdateMe( GUID, "GUID", "onlyCast" )
end

local function castStart( event, unit, spellName, channel )
    if not db.castBarNonTargets or unit=="player" then return end
    
    local GUID = UnitGUID( unit )
    
    guidCasts[GUID] = guidCasts[GUID] or {}
    
    local name, subText, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible
    if not channel then
        name, subText, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo( unit )
    else
        name, subText, text, texture, startTime, endTime, isTradeSkill, notInterruptible = UnitChannelInfo( unit )
    end
    local time = GetTime()
    
    if not startTime or not endTime or not name or not GUID then return end
    
    guidCasts[GUID].name = name
    guidCasts[GUID].icon = texture
    guidCasts[GUID].start = startTime
    guidCasts[GUID].value = max( time-startTime/1000, 0 )
    guidCasts[GUID].max = ( endTime-startTime )/1000
    guidCasts[GUID].notInterruptible = notInterruptible
    guidCasts[GUID].isCasting = true
    guidCasts[GUID].channel = channel or false
    guidCasts[GUID].GUID = GUID
    guidCasts[GUID].unit = unit
    
    update( GUID )
end

local function castStop( event, unit )
    if unit=="player" then return end
    
    local GUID = UnitGUID( unit )
    
    guidCasts[GUID] = guidCasts[GUID] or {}
    
    if not guidCasts[GUID].unit or unit~=guidCasts[GUID].unit or ( guidCasts[GUID].channel and event=="UNIT_SPELLCAST_SUCCEEDED" ) then return end
    
    guidCasts[GUID].isCasting = false
    guidCasts[GUID].channel = false
    guidCasts[GUID].realUnit = false
    
    update( GUID )
end

--[[ Events ]]
function addon:UNIT_SPELLCAST_START( event, unit, spellName, spellRank )
    castStart( event, unit, spellName )
end

function addon:UNIT_SPELLCAST_DELAYED( event, unit, spellName, spellRank )
    castStart( event, unit, spellName )
end

function addon:UNIT_SPELLCAST_STOP( event, unit, spellName, spellRank )
    castStop( event, unit )
end

function addon:UNIT_SPELLCAST_FAILED( event, unit, spellName, spellRank )
    castStop( event, unit )
end

function addon:UNIT_SPELLCAST_FAILED_QUIET( event, unit, spellName, spellRank )
    castStop( event, unit )
end

function addon:UNIT_SPELLCAST_INTERRUPTED( event, unit, spellName, spellRank )
    castStop( event, unit )
end

function addon:UNIT_SPELLCAST_SUCCEEDED( event, unit, spellName, spellRank )
    if unit=="player" and db.combatLogFix then combatLog.timeout = 0.50; combatLog:Show() end
    
    castStop( event, unit )
end

function addon:UNIT_SPELLCAST_CHANNEL_START( event, unit, spellName, spellRank )
    castStart( event, unit, spellName, "channel" )
end

function addon:UNIT_SPELLCAST_CHANNEL_UPDATE( event, unit, spellName, spellRank )
    castStart( event, unit, spellName, "channel" )
end

function addon:UNIT_SPELLCAST_CHANNEL_STOP( event, unit, spellName, spellRank )
    castStop( event, unit )
end

--[[ Initialize ]]
function addon.initializeCast()
    db = addon.db.profile
    frames = addon.frames
    realm = addon.db.realm
    global = addon.db.global
    
    addon:RegisterEvent("UNIT_SPELLCAST_START")
    addon:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
    addon:RegisterEvent("UNIT_SPELLCAST_DELAYED")
    addon:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
    addon:RegisterEvent("UNIT_SPELLCAST_STOP")
    addon:RegisterEvent("UNIT_SPELLCAST_FAILED")
    addon:RegisterEvent("UNIT_SPELLCAST_FAILED_QUIET")
    addon:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
    addon:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
    addon:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
end