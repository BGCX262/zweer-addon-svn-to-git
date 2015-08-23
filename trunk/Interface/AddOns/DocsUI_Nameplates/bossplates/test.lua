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

local db, frames, boss, defileTarget, defileTargetFrame, defileAnnounced
local resources = DocsUI_Nameplates.resources
local frame = CreateFrame( "Frame" )

local list = {
    boss = "Unbound Seer",--Unbound Seer
    
    SPELL_AURA_APPLIED = {
        [58667] = true,--Ley Curse
        [58600] = true,--Restricted Flight Area (Dalaran)
    },
    
    SPELL_CAST_START = {
        [GetSpellInfo( 72762 )] = true,--Defile
        [GetSpellInfo( 38204 )] = true,--Arcane Bolt
    },
    
    SPELL_CAST_SUCCESS = {
        [GetSpellInfo( 38204 )] = true,--Arcane Bolt
        [GetSpellInfo( 72762 )] = true,--Defile
    },
}

local nameToGUID = {}
local function getNameToGUID()
    wipe( nameToGUID )
    
    for i=1,GetNumRaidMembers() do
        local unit = "raid"..i
        
        nameToGUID[UnitName( unit )] = UnitGUID( unit )
    end
end

local cleanUpFrame = CreateFrame( "Frame" )
local lastUpdateCleanUp = 0
local function onUpdate( self, elapsed )
	lastUpdateCleanUp = lastUpdateCleanUp + elapsed
    
	if lastUpdateCleanUp>5 then
		for i=1,#frames do
            if frames[i].nameplate.alertIcon:IsShown() then frames[i].nameplate.alertIcon:Hide() end
        end
        
        cleanUpFrame:SetScript( "OnUpdate", nil )
        frame:SetScript("OnUpdate", nil)
        
        lastUpdateCleanUp = 0
	end
end

local function cleanUp() -- Hide warnings
    lastUpdateCleanUp = 0
    
    defileTargetFrame = nil
    
    cleanUpFrame:SetScript( "OnUpdate", onUpdate )
end

local function announceDefile( name, hasChanged )
    defileAnnounced = true
    
    if name then
        p( "Defile -->> "..name )
        
        if defileTargetFrame then
            if defileTargetFrame.nameplate.alertIcon:IsShown() then defileTargetFrame.nameplate.alertIcon:Hide() end
        end
        
        for i=1,#frames do
            if frames[i].nameplate.data.nameIs==name then
                if not frames[i].nameplate.alertIcon:IsShown() then
                    frames[i].nameplate.alertIcon:Show()
                    
                    frames[i].nameplate.alertIcon:SetVertexColor( 1, 0, 0, 1 )
                    
                    defileTargetFrame = frames[i]
                end
                
                break
            end
        end
        
        cleanUp()
    end
end

local lastUpdateCheck = 0
local lastUpdateFinal = 0
local function onUpdate( self, elapsed )  -- OnUpdate
	lastUpdateCheck = lastUpdateCheck + elapsed
    lastUpdateFinal = lastUpdateFinal + elapsed
    
	if not defileAnnounced and lastUpdateCheck and lastUpdateCheck>0.1 then
        defileTarget = UnitName( "focustarget" )
        
        announceDefile( defileTarget )
        
        lastUpdateFinal = 0
        
        lastUpdateCheck = 0
    end
    
    if lastUpdateFinal and lastUpdateFinal<0.33 then
        if defileTarget~=UnitName( "focustarget" ) then
            defileTarget = UnitName( "focustarget" )
            
            p( "defile readjusted -> "..defileTarget )
            
            announceDefile( defileTarget, true )
            
            frame:SetScript("OnUpdate", nil)
        end
        
        lastUpdateCheck = 0
    end
end

function frame:UNIT_SPELLCAST_START( event, unit, spell )
    --p(unit.."_SPELLCAST_START "..spell.." "..tostring(list.SPELL_CAST_START[spell]))
    
    if unit=="focus" and list.SPELL_CAST_START[spell] and UnitName( "focustarget" ) then
        --p("UNIT_SPELLCAST_START "..spell)
        
        lastUpdateFinal = 1
        defileAnnounced = false
        frame:SetScript( "OnUpdate", onUpdate )
    end
end

function list.update( self ) -- Update
    if defileTarget and self.data.nameIs==defileTarget then
        if not self.alertIcon:IsShown() then
            self.alertIcon:Show()
            
            self.alertIcon:SetVertexColor( 1, 0, 0, 1 )
        end
    end
end

function list.initialize() -- Initialize
    db = DocsUI_Nameplates.db.profile
    
    frames = DocsUI_Nameplates.frames
    
    getNameToGUID()
    
    frame:SetScript( "OnEvent", function( self, event, ... )
        frame[event]( combatLog, event, ... )
    end )
    frame:RegisterEvent( "UNIT_SPELLCAST_START" )
    
    p("initialize")
end

function list.disable() -- Disable
    frame:SetScript( "OnEvent", nil )
    frame:UnregisterEvent( "UNIT_SPELLCAST_START" )
    
    p("disable")
end

DocsUI_Nameplates.bossList.test = list