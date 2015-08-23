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

local resources = addon.resources
local round = resources.round
local db, global, realm, auras, frames, updateNameplateByGUID, playerTargetGUID, guidCasts

local playerGUID = UnitGUID( "player" )
local questionmarkIcon = "Inv_misc_questionmark"
addon.GUIDBuffs = {}
local guidBuffs = DocsUI_Nameplates.GUIDBuffs
addon.nameToGUIDs = {}
local nameToGUIDs = DocsUI_Nameplates.nameToGUIDs

local function checkFilter( spellName, fromPlayer, auraType ) -- Filter aura
    local list
    if auraType=="HELPFUL" then
        list = db.buffFilter.buffs
    elseif auraType=="HARMFUL" then
        list = db.buffFilter.debuffs
    else
        return nil
    end
    
    if list.never[spellName] then
        return nil
    elseif fromPlayer and list.my[spellName] then
        return list.my[spellName]
    elseif list.any[spellName] then
        return list.any[spellName]
    elseif fromPlayer and list.allMy then
        return 1
    elseif list.allAny then
        return 1
    else
        return nil
    end
end

local function deserialize( spellId )
    if global.spellList[spellId] then
        local success, icon, duration = addon:Deserialize( global.spellList[spellId] )
        if success then
            return icon, duration or 0
        end
	end
    
    return nil
end

local setDoUpdateMe = DocsUI_Nameplates.setDoUpdateMe
--[[ Update a nameplate ]]
local function update( GUID )
    setDoUpdateMe( GUID, "GUID", "onlyAura" )
end

--[[ Scan unit ]]
function addon.scanUnitAuras( unit, currentTargetGUID )
    if currentTargetGUID then playerTargetGUID = currentTargetGUID end
    if unit=="player" then return end
    
    local needsUpdate = false
    
    local GUID = UnitGUID( unit )
    
    guidBuffs[GUID] = guidBuffs[GUID] or {}
    
    for i=#guidBuffs[GUID],1,-1 do 
		tremove( guidBuffs[GUID], i )
	end
    
    local i = 1
	while UnitBuff( unit, i ) do
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitBuff( unit, i )
		icon = gsub( icon, "Interface\\Icons\\", "" )
		
        if not global.spellList[spellId] then
            local s = addon:Serialize( icon, duration > 0 and round( duration, 1 ) )
            if not global.spellList[spellId] or s:len()~=global.spellList[spellId]:len() then
                global.spellList[spellId] = s
            end
        end
        
        local fromPlayer = unitCaster and unitCaster=="player" and 1
        
        local priority = checkFilter( name, fromPlayer, "HELPFUL" )
        
        if priority then
            tinsert( guidBuffs[GUID], {
                name = name,
                icon = icon,
                expirationTime = expirationTime,
                startTime = expirationTime-duration,
                duration = duration,
                unitCaster = unitCaster,
                fromPlayer = fromPlayer,
                count = count,
                spellId = spellId,
                filter = "HELPFUL",
                priority = priority,
            } )
            
            needsUpdate = true
        end
        
        i = i+1
    end
    
    i = 1
	while UnitDebuff( unit, i ) do
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitDebuff( unit, i )
		icon = gsub( icon, "Interface\\Icons\\", "" )
		
        if not global.spellList[spellId] then
            local s = addon:Serialize( icon, duration > 0 and round( duration, 1 ) )
            if not global.spellList[spellId] or s:len()~=global.spellList[spellId]:len() then
                global.spellList[spellId] = s
            end
        end
        
        local fromPlayer = unitCaster and unitCaster=="player" and 1
        
        local priority = checkFilter( name, fromPlayer, "HARMFUL" )
        
        if priority then
            tinsert( guidBuffs[GUID], {
                name = name,
                icon = icon,
                expirationTime = expirationTime,
                startTime = expirationTime-duration,
                duration = duration,
                unitCaster = unitCaster,
                fromPlayer = fromPlayer,
                count = count,
                spellId = spellId,
                filter = "HARMFUL",
                priority = priority,
            } )
            
            needsUpdate = true
        end
        
        i = i+1
    end
    
    if needsUpdate then update( GUID ) end
end
local scanUnitAuras = addon.scanUnitAuras

--[[ Events ]]
function addon:SPELL_AURA_APPLIED( ... )
    --timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags
    local timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags = select( 1, ... )
    
    local spellId, spellName, spellSchool, auraType, amount  = select( 9, ... )
    
    if playerGUID==dstGUID or playerTargetGUID==dstGUID then return end
    
    local fromPlayer = srcGUID==playerGUID and 1
    
    if auraType=="DEBUFF" then
        auraType = "HARMFUL"
    elseif auraType=="BUFF" then
        auraType = "HELPFUL"
    end
    
    local priority = checkFilter( spellName, fromPlayer, auraType )
    
    if priority then
        if global.spellList[spellId] then
            local time = GetTime()
            local icon, duration = deserialize( spellId )
            if not icon then return false end
            
            guidBuffs[dstGUID] = guidBuffs[dstGUID] or {}
            
            tinsert( guidBuffs[dstGUID], {
                name = spellName,
                icon = icon,
                expirationTime = time+duration,
                startTime = time,
                duration = duration,
                unitCaster = srcGUID,
                fromPlayer = fromPlayer,
                count = 1,
                spellId = spellId,
                filter = auraType,
                priority = priority,
            } )
        else
            local time = GetTime()
            
            guidBuffs[dstGUID] = guidBuffs[dstGUID] or {}
            
            tinsert( guidBuffs[dstGUID], {
                name = spellName,
                icon = questionmarkIcon,
                expirationTime = 0,
                startTime = time,
                duration = 0,
                unitCaster = srcGUID,
                fromPlayer = fromPlayer,
                count = 1,
                spellId = spellId,
                filter = auraType,
                priority = priority,
            } )
        end
        
        update( dstGUID )
    end
end

function addon:SPELL_AURA_REMOVED( ... )
    --timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags
    local timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags = select( 1, ... )
    
    local spellId, spellName, spellSchool, auraType, amount  = select( 9, ... )
    
    if playerGUID==dstGUID or playerTargetGUID==dstGUID then return end
    
    if guidBuffs[dstGUID] then
        for i=#guidBuffs[dstGUID],1,-1 do
            if guidBuffs[dstGUID][i].spellId==spellId then
                tremove( guidBuffs[dstGUID], i )
                
                update( dstGUID )
                
                return
            end
        end
    end
end

function addon:SPELL_AURA_REFRESH( ... )
    --timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags
    local timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags = select( 1, ... )
    
    local spellId, spellName, spellSchool, auraType, amount  = select( 9, ... )
    
    if playerGUID==dstGUID or playerTargetGUID==dstGUID then return end
    
    if guidBuffs[dstGUID] then
        for i=#guidBuffs[dstGUID],1,-1 do
            if guidBuffs[dstGUID][i].spellId==spellId then
                local time = GetTime()
                
				guidBuffs[dstGUID][i].startTime	= time
				guidBuffs[dstGUID][i].expirationTime = time+guidBuffs[dstGUID][i].duration
                
                update( dstGUID )
                
                return
            end
        end
    end
end

function addon:SPELL_AURA_APPLIED_DOSE( ... )
    --timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags
    local timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags = select( 1, ... )
    
    local spellId, spellName, spellSchool, auraType, amount  = select( 9, ... )
    
    if playerGUID==dstGUID or playerTargetGUID==dstGUID then return end
    
    if global.spellList[spellId] and guidBuffs[dstGUID] then
		for i=#guidBuffs[dstGUID],1,-1 do
			if guidBuffs[dstGUID][i].spellId==spellId then
                guidBuffs[dstGUID][i].count = guidBuffs[dstGUID][i].count+1
				
                update( dstGUID )
                
				return
			end
		end
	end
	
	self:SPELL_AURA_APPLIED( ... )
end

function addon:SPELL_AURA_REMOVED_DOSE( ... )
    --timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags
    local timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags = select( 1, ... )
    
    local spellId, spellName, spellSchool, auraType, amount  = select( 9, ... )
    
    if playerGUID==dstGUID or playerTargetGUID==dstGUID then return end
    
    if global.spellList[spellId] and guidBuffs[dstGUID] then
		for i=#guidBuffs[dstGUID],1,-1 do
			if guidBuffs[dstGUID][i].spellId==spellId then
                guidBuffs[dstGUID][i].count = guidBuffs[dstGUID][i].count-1
				
                update( dstGUID )
                
				return
			end
		end
	end
	
	self:SPELL_AURA_APPLIED( ... )
end

function addon:SPELL_AURA_BROKEN_SPELL( ... )
    self:SPELL_AURA_REMOVED( ... )
end

function addon:SPELL_AURA_BROKEN( ... )
    self:SPELL_AURA_REMOVED( ... )
end

function addon:UNIT_DIED( ... )
    if guidBuffs[dstGUID] then
		for i=#guidBuffs[dstGUID],1,-1 do 
			tremove( guidBuffs[dstGUID], i )
		end
        
        update( dstGUID )
	end
end

function addon:UNIT_DESTROYED( ... )
    self:UNIT_DIED( ... )
end

function addon:UNIT_DISSIPATES( ... )
    self:UNIT_DIED( ... )
end

function addon:PARTY_KILL( ... )
    self:UNIT_DIED( ... )
end

function addon:COMBAT_LOG_EVENT_UNFILTERED( event, ... )
    --timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags
	local _, event  = ...
    
    --local timestamp, eventType, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags = select( 1, ... )
    --local spellId, spellName, spellSchool, auraType, amount  = select( 9, ... )
    --if ( UnitGUID( "target" )==srcGUID or UnitGUID( "target" )==dstGUID ) and ( not strfind( eventType, "AURA" ) and not strfind( eventType, "PERIODIC" ) and not strfind( eventType, "ENERGIZE" ) ) then p( tostring(eventType)..", "..tostring(srcName)..", "..tostring(dstName)..", "..tostring(srcGUID)..", "..tostring(dstGUID) ) end
    --p( tostring(eventType)..", "..tostring(srcName)..", "..tostring(dstName)..", "..tostring(srcGUID)..", "..tostring(dstGUID) )
    --p( tostring(eventType)..", "..tostring(spellName)..", "..tostring(spellId)..", "..tostring(timestamp)..", "..tostring(nil) )
    
    if addon[event] then
		addon[event]( self, ... )
	end
end

function addon:UNIT_AURA( self, unit )
    scanUnitAuras( unit )
end

--[[ Initialize ]]
function addon.initializeAuras()
    db = addon.db.profile
    frames = addon.frames
    realm = addon.db.realm
    global = addon.db.global
    guidCasts = addon.GUIDCasts
    
    updateNameplateByGUID = addon.updateNameplateByGUID
    
    addon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    addon:RegisterEvent("UNIT_AURA")
end