--[[
	Copyright (c) 2009, dr_AllCOM3
    All rights reserved.

    You're allowed to use this addon, free of monetary charge,
    but you are not allowed to modify, alter, or redistribute
    this addon without express, written permission of the author.
]]

local L = LibStub( "AceLocale-3.0" ):GetLocale( "DocsUI_Nameplates" )
local LSM = LibStub( "LibSharedMedia-3.0" )
local temp,temp2
local addon = DocsUI_Nameplates

local function p( text ) -- Print
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

local db, frames, realm, global, playerList, guidBuffs, guidCasts, scanUnitAuras, bossplateUpdate, party, raid, guild, bnet, friend, arena, battleground, isTank, time, tanks
local isInInstance, isInArena, isInBattleground, isInSanctuary, hasGroup, playerTargetGUID, unitIsDifferent, tankMode, configMode

local update = {}
local resources = addon.resources
local playerName = UnitName( "player" )
local _, playerClass = UnitClass( "player" )
local playerGuild = GetGuildInfo( "player" )
local playerLevel = UnitLevel( "player" )
local playerGUID = UnitGUID( "player" )
local playerTarget = false
local realmName = GetRealmName()
addon.inCombat = false
local inCombat = addon.inCombat
addon.isInPve = true
local isInPve = addon.isInPve
addon.isInPvp = false
local isInPvp = addon.isInPvp
local tankMode = false
local tankModeCheckFrequency = 10
local temporaryList = {}
local framesShown = {}
addon.framesShown = framesShown
local lfgList = {}
local whisperList = {}
addon.GUIDThreat = {}
local guidThreat = addon.GUIDThreat

local doUpdate = 0
local function setDoUpdate( number ) doUpdate = max( doUpdate, number ) end
local doUpdateThreat = 0
local function setDoUpdateThreat( number ) doUpdateThreat = max( doUpdateThreat, number ) end
local doUpdateNext = { frames = {}, name = {}, GUID = {} }
local function setDoUpdateMe( object, type, option )
    if type=="frame" then
        tinsert( doUpdateNext.frames, { object, option } )
        --doUpdateNext.frames[object] = option or true
    elseif type=="name" then
        tinsert( doUpdateNext.name, { object, option } )
        --doUpdateNext.name[object] = option or true
    elseif type=="GUID" then
        tinsert( doUpdateNext.GUID, { object, option } )
        --doUpdateNext.GUID[object] = option or true
    end
end
addon.setDoUpdateMe = setDoUpdateMe

local tooltipScan = CreateFrame( "GameTooltip", "DocsScanningTooltip", UIParent, "GameTooltipTemplate" )
DocsScanningTooltip:SetOwner( WorldFrame, "ANCHOR_NONE" )

local function setVisibility() -- Set nameplate visibility
    -- isInPve, isInPvp, inCombat
    
    if db.threatEnabled then
        SetCVar( "threatWarning", 3)
    else
        SetCVar( "threatWarning", 0)
    end
    
--~     if db.allowOverlap then
--~         SetCVar( "nameplateAllowOverlap", 1)
--~     else
--~         SetCVar( "nameplateAllowOverlap", 0)
--~     end
    
    if isInPve and not inCombat then
        -- Friend
        if db.visibilityPveFriendUnit then
            SetCVar( "nameplateShowFriends", 1)
        else
            SetCVar( "nameplateShowFriends", 0)
        end
        if db.visibilityPveFriendPet then
            SetCVar( "nameplateShowFriendlyPets", 1)
        else
            SetCVar( "nameplateShowFriendlyPets", 0)
        end
        if db.visibilityPveFriendGuardian then
            SetCVar( "nameplateShowFriendlyGuardians", 1)
        else
            SetCVar( "nameplateShowFriendlyGuardians", 0)
        end
        if db.visibilityPveFriendTotem then
            SetCVar( "nameplateShowFriendlyTotems", 1)
        else
            SetCVar( "nameplateShowFriendlyTotems", 0)
        end
        
        -- Enemy
        if db.visibilityPveEnemyUnit then
            SetCVar( "nameplateShowEnemies", 1)
        else
            SetCVar( "nameplateShowEnemies", 0)
        end
        if db.visibilityPveEnemyPet then
            SetCVar( "nameplateShowEnemyPets", 1)
        else
            SetCVar( "nameplateShowEnemyPets", 0)
        end
        if db.visibilityPveEnemyGuardian then
            SetCVar( "nameplateShowEnemyGuardians", 1)
        else
            SetCVar( "nameplateShowEnemyGuardians", 0)
        end
        if db.visibilityPveEnemyTotem then
            SetCVar( "nameplateShowEnemyTotems", 1)
        else
            SetCVar( "nameplateShowEnemyTotems", 0)
        end
    elseif isInPve then
        -- Friend
        if db.visibilityPvecombatFriendUnit then
            SetCVar( "nameplateShowFriends", 1)
        else
            SetCVar( "nameplateShowFriends", 0)
        end
        if db.visibilityPvecombatFriendPet then
            SetCVar( "nameplateShowFriendlyPets", 1)
        else
            SetCVar( "nameplateShowFriendlyPets", 0)
        end
        if db.visibilityPvecombatFriendGuardian then
            SetCVar( "nameplateShowFriendlyGuardians", 1)
        else
            SetCVar( "nameplateShowFriendlyGuardians", 0)
        end
        if db.visibilityPvecombatFriendTotem then
            SetCVar( "nameplateShowFriendlyTotems", 1)
        else
            SetCVar( "nameplateShowFriendlyTotems", 0)
        end
        
        -- Enemy
        if db.visibilityPvecombatEnemyUnit then
            SetCVar( "nameplateShowEnemies", 1)
        else
            SetCVar( "nameplateShowEnemies", 0)
        end
        if db.visibilityPvecombatEnemyPet then
            SetCVar( "nameplateShowEnemyPets", 1)
        else
            SetCVar( "nameplateShowEnemyPets", 0)
        end
        if db.visibilityPvecombatEnemyGuardian then
            SetCVar( "nameplateShowEnemyGuardians", 1)
        else
            SetCVar( "nameplateShowEnemyGuardians", 0)
        end
        if db.visibilityPvecombatEnemyTotem then
            SetCVar( "nameplateShowEnemyTotems", 1)
        else
            SetCVar( "nameplateShowEnemyTotems", 0)
        end
    elseif isInPvp then
        -- Friend
        if db.visibilityPvpFriendUnit then
            SetCVar( "nameplateShowFriends", 1)
        else
            SetCVar( "nameplateShowFriends", 0)
        end
        if db.visibilityPvpFriendPet then
            SetCVar( "nameplateShowFriendlyPets", 1)
        else
            SetCVar( "nameplateShowFriendlyPets", 0)
        end
        if db.visibilityPvpFriendGuardian then
            SetCVar( "nameplateShowFriendlyGuardians", 1)
        else
            SetCVar( "nameplateShowFriendlyGuardians", 0)
        end
        if db.visibilityPvpFriendTotem then
            SetCVar( "nameplateShowFriendlyTotems", 1)
        else
            SetCVar( "nameplateShowFriendlyTotems", 0)
        end
        
        -- Enemy
        if db.visibilityPvpEnemyUnit then
            SetCVar( "nameplateShowEnemies", 1)
        else
            SetCVar( "nameplateShowEnemies", 0)
        end
        if db.visibilityPvpEnemyPet then
            SetCVar( "nameplateShowEnemyPets", 1)
        else
            SetCVar( "nameplateShowEnemyPets", 0)
        end
        if db.visibilityPvpEnemyGuardian then
            SetCVar( "nameplateShowEnemyGuardians", 1)
        else
            SetCVar( "nameplateShowEnemyGuardians", 0)
        end
        if db.visibilityPvpEnemyTotem then
            SetCVar( "nameplateShowEnemyTotems", 1)
        else
            SetCVar( "nameplateShowEnemyTotems", 0)
        end
    end
end
addon.setVisibility = setVisibility

local function softReset() -- Just deletes some savedData values to cause a refresh when setDoUpdate
    for i=1,#frames do
        frames[i].nameplate.savedData.maxHealthIs = nil
        frames[i].nameplate.savedData.levelIs = nil
    end
    
    setDoUpdate( 1 )
end

--[[ Updates ]]
function addon:updateNameplate( option ) -- onUpdate. Options: "onlyAura"
    local nameplate = self.nameplate
    local data = nameplate.data
    local savedData = nameplate.savedData
    time = GetTime()
    
    if option=="onlyHp" then
        update.hp( nameplate, "onlyHp" )
        update.color( nameplate, "onlyHp" )
        
        if nameplate.updateCounterHp then nameplate.updateCounterHp = nameplate.updateCounterHp+1 end
        update.debug( nameplate )
    elseif option=="onlyThreat" then
        update.threat( nameplate, "onlyThreat" )
        update.color( nameplate, "onlyThreat" )
        
        if nameplate.updateCounterThreat then nameplate.updateCounterThreat = nameplate.updateCounterThreat+1 end
        update.debug( nameplate )
    elseif option=="onlyCast" then
        update.cast( nameplate, "onlyCast" )
        
        if nameplate.updateCounterCast then nameplate.updateCounterCast = nameplate.updateCounterCast+1 end
        update.debug( nameplate )
    elseif option=="onlyAura" then
        update.auras( nameplate )
        
        if nameplate.updateCounterAura then nameplate.updateCounterAura = nameplate.updateCounterAura+1 end
        update.debug( nameplate )
    else
        update.collectDynamicData( nameplate )
        
        if global.nameplateHider[data.nameIs] then
            nameplate:Hide()
            
            return
        else
            nameplate:Show()
        end
        
        data.alphaIs = nameplate.alpha
        data.isTarget = playerTarget and data.alphaIs==1
        if data.isTarget then data.GUID = playerTargetGUID end
        
        unitIsDifferent = false
        -- Check if the unit has changed
        for index,value in pairs( data ) do
            if index~="healthIs" and savedData[index]~=value then--
                unitIsDifferent = true
                
                break
            end
        end
        
        update.highlight( nameplate )
        update.alpha( nameplate )
        update.size( self )
        update.mouseover( nameplate )
        update.unknownIcon( nameplate )
        update.threat( nameplate )
        update.name( nameplate )
        update.tot( nameplate )
        update.guild( nameplate )
        update.hp( nameplate )
        update.level( nameplate )
        update.cast( nameplate )
        update.socialIcon( nameplate )
        update.raidIcon( nameplate )
        update.classIcon( nameplate )
        update.roleIcon( nameplate )
        update.totemIcon( nameplate )
        update.lfgIcon( nameplate )
        update.chatIcon( nameplate )
        update.auras( nameplate )
        update.color( nameplate )
        
        update.bossplates( nameplate )
        
        -- Save data
        for index,value in pairs( data ) do
            savedData[index] = value
        end
        
        if nameplate.updateCounter then nameplate.updateCounter = nameplate.updateCounter+1 end
        update.debug( nameplate, self )
    end
end
local updateNameplate = addon.updateNameplate

function addon.updateNameplateByIndex( index )
    updateNameplate( frames[i] )
end
local updateNameplateByIndex = addon.updateNameplateByIndex

function addon.updateNameplateByName( name )
    for index,value in pairs( framesShown ) do
        if name==value.nameplate.data.nameIs then
            updateNameplate( value )
        end
    end
end
local updateNameplateByName = addon.updateNameplateByName
update.auras = function() end

function addon.updateNameplateByRaidIcon( index, GUID )
    if not index or not GUID then return end
    
    for i,v in pairs( framesShown ) do
        if index==v.nameplate.data.hasRaidIcon then
            v.nameplate.data.GUID = GUID
            updateNameplate( v )
            
            return
        end
    end
end
local updateNameplateByRaidIcon = addon.updateNameplateByRaidIcon

function addon.updateNameplateByGUID( GUID, option ) -- Options: "onlyAura"
    for index,value in pairs( framesShown ) do
        if GUID and value.nameplate.data.GUID and GUID==value.nameplate.data.GUID then
            updateNameplate( value, option )
                
            return
        end
    end
end
local updateNameplateByGUID = addon.updateNameplateByGUID

function addon:onShowNameplate() -- onShow
    local nameplate = self.nameplate
    local data = nameplate.data
    local savedData = nameplate.savedData
    time = GetTime()
    
    update.collectFixedData( nameplate )
    update.collectDynamicData( nameplate )
    
    if global.nameplateHider[data.nameIs] then
        nameplate:Hide()
        
        return
    else
        nameplate:Show()
    end
    
    data.isCasting = false
    nameplate.cast:Hide()
    if playerTarget then
        nameplate.alpha = db.alpha -- To prevent flashing from 1 to 0.5.
    else
        nameplate.alpha = self:GetAlpha()
    end
    data.alphaIs = nameplate.alpha
    data.isTarget = false
    
    nameplate:SetFrameLevel( 11 )
    self.width = nameplate.originalWidth
    self.height = nameplate.originalHeight
    
    nameplate.updateCounter = 0
    nameplate.updateCounterAura = 0
    nameplate.updateCounterCast = 0
    nameplate.updateCounterHp = 0
    nameplate.updateCounterThreat = 0
    
    framesShown[self] = self
    
    unitIsDifferent = true
    
    update.highlight( nameplate )
    update.alpha( nameplate )
    --update.size( self )
    update.mouseover( nameplate )
    update.unknownIcon( nameplate )
    update.threat( nameplate )
    update.name( nameplate )
    update.tot( nameplate )
    update.guild( nameplate )
    update.hp( nameplate )
    update.level( nameplate )
    update.cast( nameplate )
    update.socialIcon( nameplate )
    update.raidIcon( nameplate )
    update.classIcon( nameplate )
    update.roleIcon( nameplate )
    update.totemIcon( nameplate )
    update.threat( nameplate )
    update.auras( nameplate )
    update.bossplates( nameplate )
    update.debug( nameplate )
    
    --updateNameplate( self ) -- Update right now or you can see the frame change.
    setDoUpdateMe( self, "frame" )
end
local onHideNameplate = addon.onHideNameplate

function addon:onHideNameplate() -- onHide
    local nameplate = self.nameplate
    
    wipe( nameplate.data )
    wipe( nameplate.savedData )
    
    framesShown[self] = nil
    
    nameplate.highlight:Hide()
    nameplate.cast:Hide()
end
local onHideNameplate = addon.onHideNameplate
--[[ Helper functions ]]
local function formatTime( time )
    if time>60 then
        time = floor( time/60 ).."m"
    elseif time>=3 then
        time = floor( time )
    else
        time = resources.round( time, 1 )
    end
    
    return time
end

local function getRaidIconIndex( raidIcon )
    -- ULx, ULy, LLx, LLy, URx, URy, LRx, LRy
    -- "Interface\\TargetingFrame\\UI-RaidTargetingIcons"
    if not raidIcon:IsShown() then return nil end
    
    local ULx,ULy,LLx,LLy,URx,URy,LRx,LRy = raidIcon:GetTexCoord()
    
    for i=1,8 do
        if resources.raidIconTextureCoords[i][1]==ULx and
        resources.raidIconTextureCoords[i][2]==ULy and
        resources.raidIconTextureCoords[i][3]==LLx and
        resources.raidIconTextureCoords[i][4]==LLy and
        resources.raidIconTextureCoords[i][5]==URx and
        resources.raidIconTextureCoords[i][6]==URy and
        resources.raidIconTextureCoords[i][7]==LRx and
        resources.raidIconTextureCoords[i][8]==LRy then
            return i
        end
    end
    
    return nil
end

local function reactionAndType( red, green, blue, data )
    if red < .01 and blue < .01 and green > .99 then
        return "FRIENDLY", "NPC" 
    elseif red < .01 and blue > .99 and green < .01 then
        return "FRIENDLY", "PLAYER"
    elseif red > .99 and blue < .01 and green > .99 then
        return "NEUTRAL", "NPC"
    elseif red > .99 and blue < .01 and green < .01 then
        return "HOSTILE", "NPC"
    else
        return "HOSTILE", "PLAYER"
    end
end

local function getUnitCombatStatus( r, g, b )
    return r>.5 and g<.5
end

local function threatByColor( threatGlow )
	local redCan, greenCan, blueCan, alphaCan = threatGlow:GetVertexColor()
	
	if not threatGlow:IsShown() then return "LOW" end
	if greenCan > .7 then return "MEDIUM" end
	if redCan > .7 then return "HIGH" end
end

local function getRole( data )
    -- "TANK" "HEALER" "DAMAGER"
    
    if not data.nameIs then return nil end
    
    local name = strlower( data.nameIs )
    
    if data.reaction=="HOSTILE" and data.type~="PLAYER" and data.isCasting and data.castingName and ( not global.casterList[name] or not global.healerList[name] ) then
        local castName = strlower( data.castingName )
        
        for i=1,#db.healingSpells do
            if strfind( castName,db.healingSpells[i] ) then
                global.healerList[name] = true
                break
            end
        end
        
        global.casterList[name] = true
    end
    
    if global.healerList[name] then
        return "HEALER"
    elseif global.casterList[name] then
        return "DAMAGER"
    elseif false then
        return "TANK"
    else
        return nil
    end
end

local function colorToString(r,g,b)
    return "C"..math.floor((100*r) + 0.5)..math.floor((100*g) + 0.5)..math.floor((100*b) + 0.5)
end
local classByColor = {}
for classname,color in pairs( RAID_CLASS_COLORS ) do 
    classByColor[colorToString(color.r, color.g, color.b)] = classname
end
local function getClassAndRole( data )
    local c, r
    
    if isInInstance~="none" and data.type~="PLAYER" and data.reaction=="HOSTILE" then c, r = resources.factionChampClassAndRole( data.nameIs ) end
    
    if data.type=="PLAYER" and data.reaction=="HOSTILE" then
        c = classByColor[colorToString( data.red, data.green, data.blue )] or nil
    elseif data.type=="PLAYER" and data.class then
        c = data.class
    end
    
    if not r and data.reaction=="HOSTILE" then
        if data.isBoss then
            r = "BOSS"
        else
            r = getRole( data ) or nil
        end
    end
    
    return c, r
end

local function getTotem( name )
    for i=1,#resources.totems do
        if strfind( name, resources.totems[i].name ) then
            return resources.totems[i].texture
        end
    end
    
    return nil
end

local function filterName( name )
    name = strlower( name )
    for i=1,#db.nameplateHider do
        if name==db.nameplateHider[i] then
            return true
        end
    end
    
    return false
end

local function collectUnitInfo( unit )
    if not UnitExists( unit ) then return end
    
    local GUID = UnitGUID( unit )
    local name, rlm = UnitName( unit )
    local _, class = UnitClass( unit )
    local guildName = GetGuildInfo( unit )
    local isPlayer = UnitIsPlayer( unit )
    
    if not name or name==UNKNOWN then return end
    
    if isPlayer and not rlm then
        playerList[name] = GUID
        playerList[GUID] = addon:Serialize( name, GUID, class, guildName or "NONE", rlm or realmName )
    end
    
    if isPlayer then
        temporaryList[name] = GUID
        temporaryList[GUID] = addon:Serialize( name, GUID, class or nil, guildName or "NONE", rlm or realmName or "NONE" )
    end
    
    if UnitClassification( unit )=="worldboss" then
        temporaryList[name] = GUID
        temporaryList[GUID] = addon:Serialize( name, GUID, class or nil, guildName or "NONE", rlm or realmName or "NONE" )
    end
end

local function checkHealthbarNotVisible( data )
    if isInSanctuary or data.isTotem then
        return true
    elseif isInPve then
        if inCombat then
            if ( not db.healthBarFriendPveCombat and data.layout=="FRIEND" ) or ( not db.healthBarEnemyPveCombat and data.layout=="ENEMY" ) then
                return true
            end
        else
            if ( not db.healthBarFriendPve and data.layout=="FRIEND" ) or ( not db.healthBarEnemyPve and data.layout=="ENEMY" ) then
                return true
            end
        end
    elseif isInPvp then
        if ( not db.healthBarFriendPvp and data.layout=="FRIEND" ) or ( not db.healthBarEnemyPvp and data.layout=="ENEMY" ) then
            return true
        end
    end
    
    return false
end

local function checkCastbarNotVisible( data )
    if data.isTotem then
        return true
    elseif isInPve then
        if inCombat then
            if ( not db.castBarFriendPveCombat and data.layout=="FRIEND" ) or ( not db.castBarEnemyPveCombat and data.layout=="ENEMY" ) then
                return true
            end
        else
            if ( not db.castBarFriendPve and data.layout=="FRIEND" ) or ( not db.castBarEnemyPve and data.layout=="ENEMY" ) then
                return true
            end
        end
    elseif isInPvp then
        if ( not db.castBarFriendPvp and data.layout=="FRIEND" ) or ( not db.castBarEnemyPvp and data.layout=="ENEMY" ) then
            return true
        end
    end
    
    return false
end

local function checkBuffsNotVisible( data )
    if data.isTotem then
        return true
    elseif isInPve then
        if inCombat then
            if ( not db.buffsFriendPveCombat and data.layout=="FRIEND" ) or ( not db.buffsEnemyPveCombat and data.layout=="ENEMY" ) then
                return true
            end
        else
            if ( not db.buffsFriendPve and data.layout=="FRIEND" ) or ( not db.buffsEnemyPve and data.layout=="ENEMY" ) then
                return true
            end
        end
    elseif isInPvp then
        if ( not db.buffsFriendPvp and data.layout=="FRIEND" ) or ( not db.buffsEnemyPvp and data.layout=="ENEMY" ) then
            return true
        end
    else
        return false
    end
end

local function isNPCGrey( level )
    local r, g, b = unpack( resources.getLevelColor( level, playerLevel ) )
    
    return r==0.5 and g==0.5 and b==0.5
end

local function checkTankMode()
    if playerClass=="DEATHKNIGHT" then
        tankMode = UnitBuff( "player", GetSpellInfo( 48263 ) ) or false -- Blood Presence
    elseif playerClass=="PALADIN" then
        tankMode = UnitBuff( "player", GetSpellInfo( 25780 ) ) or false -- Righteous Fury
    elseif playerClass=="WARRIOR" then
        tankMode = GetShapeshiftForm()==2 or false -- Defensive Stance 
    elseif playerClass=="DRUID" then
        tankMode = GetShapeshiftForm()==1 or false -- Bear/Dire Bear Form 
    else
        tankMode = false
    end
end

--[[ Modify and update elements ]]
function update:collectFixedData()
    local data = self.data
    local savedData = self.savedData
    
    -- Fixed data
    data.nameIs = self.regions.nameText:GetText()
    data.nameIsReplacement = global.nameReplacer[data.nameIs] or nil
    data.isBoss = self.regions.dangerSkull:IsShown()
    data.isElite = self.regions.eliteIcon:IsShown()
    data.isTotem = getTotem( data.nameIs )
end

function update:collectDynamicData()
    local data = self.data
    local savedData = self.savedData
    
    -- Dynamic data
    _, data.maxHealthIs = self.children.healthBar:GetMinMaxValues()
    data.healthIs = self.children.healthBar:GetValue()
    data.levelIs = tonumber( self.regions.levelText:GetText() ) or 999
    data.isInCombat = getUnitCombatStatus( self.regions.nameText:GetTextColor() )
    data.hasRaidIcon = getRaidIconIndex( self.regions.raidIcon )
    data.raidIcon = self.regions.raidIcon
    if inCombat then data.threatState = threatByColor( self.regions.threatGlow ) else data.threatState = "LOW" end
    
    if temporaryList[data.nameIs] then
        data.GUID = temporaryList[data.nameIs]
        
        local success, _, _, class, guild, _ = addon:Deserialize( temporaryList[data.GUID] )
        if success then
            data.class = class
            data.guild = guild
        end
    elseif playerList[data.nameIs] then
        data.GUID = playerList[data.nameIs]
        
        local success, _, _, class, guild, _ = addon:Deserialize( playerList[data.GUID] )
        if success then
            data.class = class
            data.guild = guild
        end
    else
        if not inCombat and data.type~="PLAYER" and global.npcList[data.nameIs] then
            data.guild = global.npcList[data.nameIs]
        else
            data.guild = nil
        end
    end
    
    data.red, data.green, data.blue = self.children.healthBar:GetStatusBarColor()
    data.reaction, data.type = reactionAndType( data.red, data.green, data.blue, data )
    if not inCombat and isInSanctuary and data.reaction=="HOSTILE" then data.reaction = "FRIENDLY" end
    data.class, data.role = getClassAndRole( data )
    
    if data.reaction=="FRIENDLY" then
        data.layout = "FRIEND"
    elseif data.reaction=="NEUTRAL" then
        if global.agressiveList[data.nameIs] then
            data.layout = "ENEMY"
        else
            data.layout = "FRIEND"
        end
    else
        data.layout = "ENEMY"
    end
    
    data.healthNotVisible = checkHealthbarNotVisible( data )
    
    data.isCasting = self.children.castBar:IsShown()
    if data.isCasting then
        data.iscastingUninterruptable = self.regions.castNostop:IsShown()
        data.castIconTexture = self.regions.spellIcon:GetTexture()
        _, data.castingMax = self.children.castBar:GetMinMaxValues()
        data.castingTime = self.children.castBar:GetValue()
        data.castingName = UnitCastingInfo( "target" ) or UnitChannelInfo( "target" )
    end
    
    if inCombat and data.reaction=="NEUTRAL" and data.isInCombat and data.healthIs<data.maxHealthIs then -- Turn neutral target into agressive
        if not global.agressiveList[data.nameIs] then global.agressiveList[data.nameIs] = true end
    end
    
    data.isMouseover = self.highlight:IsShown()
    if data.isMouseover then data.GUID = UnitGUID( "mouseover" ) end
end

function update:color( option )
    if option=="onlyHp" then
        --return --TODO
    end
    
    if option=="onlyThreat" then
        --return
    end
    
    local namer, nameg, nameb, guildr, guildg, guildb, hpr, hpg, hpb
    
    if isInPvp then
        if db.healthBarColorPvP then
            if self.data.layout=="FRIEND" then
                if self.data.class then
                    namer, nameg, nameb = RAID_CLASS_COLORS[self.data.class].r, RAID_CLASS_COLORS[self.data.class].g, RAID_CLASS_COLORS[self.data.class].b
                else
                    namer, nameg, nameb = 0/255, 174/255, 239/255
                end
                hpNumberr, hpNumberg, hpNumberb = 0/255, 174/255, 239/255
            else
                if self.data.class then
                    namer, nameg, nameb = RAID_CLASS_COLORS[self.data.class].r, RAID_CLASS_COLORS[self.data.class].g, RAID_CLASS_COLORS[self.data.class].b
                else
                    namer, nameg, nameb = 255/255, 0/255, 0/255
                end
                hpNumberr, hpNumberg, hpNumberb = 255/255, 0/255, 0/255
            end
        elseif self.data.class then
            namer, nameg, nameb = RAID_CLASS_COLORS[self.data.class].r, RAID_CLASS_COLORS[self.data.class].g, RAID_CLASS_COLORS[self.data.class].b
            hpNumberr, hpNumberg, hpNumberb = RAID_CLASS_COLORS[self.data.class].r, RAID_CLASS_COLORS[self.data.class].g, RAID_CLASS_COLORS[self.data.class].b
        else
            namer, nameg, nameb = resources.darkenColor( self.data.red, self.data.green, self.data.blue )
            hpNumberr, hpNumberg, hpNumberb = resources.darkenColor( self.data.red, self.data.green, self.data.blue )
        end
    else
        if self.data.type=="PLAYER" or self.data.class then -- "PLAYER"
            if self.data.class then
                namer, nameg, nameb = RAID_CLASS_COLORS[self.data.class].r, RAID_CLASS_COLORS[self.data.class].g, RAID_CLASS_COLORS[self.data.class].b
                if raid[self.data.nameIs] then guildr, guildg, guildb = resources.getSocialColor( "raid" )
                    elseif party[self.data.nameIs] then guildr, guildg, guildb = resources.getSocialColor( "party" )
                    elseif guild[self.data.nameIs] then guildr, guildg, guildb = resources.getSocialColor( "guild" )
                    elseif bnet[self.data.nameIs] then guildr, guildg, guildb = resources.getSocialColor( "bnet" )
                    elseif friend[self.data.nameIs] then guildr, guildg, guildb = resources.getSocialColor( "friend" )
                    else guildr, guildg, guildb = resources.lightenColor( self.data.red, self.data.green, self.data.blue ) end
                hpNumberr, hpNumberg, hpNumberb = RAID_CLASS_COLORS[self.data.class].r, RAID_CLASS_COLORS[self.data.class].g, RAID_CLASS_COLORS[self.data.class].b
            elseif raid[self.data.nameIs] then
                namer, nameg, nameb = resources.getSocialColor( "raid" )
                guildr, guildg, guildb = resources.getSocialColor( "raid" )
                hpNumberr, hpNumberg, hpNumberb = resources.lightenColor( self.data.red, self.data.green, self.data.blue )
            elseif party[self.data.nameIs] then
                namer, nameg, nameb = resources.getSocialColor( "party" )
                guildr, guildg, guildb = resources.getSocialColor( "party" )
                hpNumberr, hpNumberg, hpNumberb = resources.lightenColor( self.data.red, self.data.green, self.data.blue )
            elseif guild[self.data.nameIs] then
                namer, nameg, nameb = resources.getSocialColor( "guild" )
                guildr, guildg, guildb = resources.getSocialColor( "guild" )
                hpNumberr, hpNumberg, hpNumberb = resources.lightenColor( self.data.red, self.data.green, self.data.blue )
            elseif bnet[self.data.nameIs] then
                namer, nameg, nameb = resources.getSocialColor( "bnet" )
                guildr, guildg, guildb = resources.getSocialColor( "bnet" )
                hpNumberr, hpNumberg, hpNumberb = resources.lightenColor( self.data.red, self.data.green, self.data.blue )
            elseif friend[self.data.nameIs] then
                namer, nameg, nameb = resources.getSocialColor( "friend" )
                guildr, guildg, guildb = resources.getSocialColor( "friend" )
                hpNumberr, hpNumberg, hpNumberb = resources.lightenColor( self.data.red, self.data.green, self.data.blue )
            else
                namer, nameg, nameb = resources.lightenColor( self.data.red, self.data.green, self.data.blue )
                guildr, guildg, guildb = resources.lightenColor( self.data.red, self.data.green, self.data.blue )
                hpNumberr, hpNumberg, hpNumberb = resources.lightenColor( self.data.red, self.data.green, self.data.blue )
            end
        elseif self.data.type~="PLAYER" and self.data.layout=="FRIEND" then -- "FRIEND"
            namer, nameg, nameb = resources.darkenColor( self.data.red, self.data.green, self.data.blue )
            guildr, guildg, guildb = resources.darkenColor( self.data.red, self.data.green, self.data.blue )
            hpNumberr, hpNumberg, hpNumberb = resources.darkenColor( self.data.red, self.data.green, self.data.blue )
        else
            if not inCombat or not db.threatEnabled or self.data.threatState==0 then -- "ENEMY"
                if self.data.levelIs and isNPCGrey( self.data.levelIs ) then -- Lowlvl
                    namer, nameg, nameb = unpack( resources.getLevelColor( self.data.levelIs, playerLevel ) )
                    guildr, guildg, guildb = unpack( resources.getLevelColor( self.data.levelIs, playerLevel ) )
                    hpNumberr, hpNumberg, hpNumberb = resources.darkenColor( unpack( resources.getLevelColor( self.data.levelIs, playerLevel ) ) )
                else -- Normal color
                    namer, nameg, nameb = resources.lightenColor( self.data.red, self.data.green, self.data.blue )
                    guildr, guildg, guildb = resources.lightenColor( self.data.red, self.data.green, self.data.blue )
                    hpNumberr, hpNumberg, hpNumberb = resources.darkenColor( self.data.red, self.data.green, self.data.blue )
                end
            else -- Threat coloring
                local perc = self.data.threatPercent
                
                if perc then
                    local r, g, b
                    
                    if self.data.threatIsTanked then
                        r, g, b = db.colorThreatTanked.r,db.colorThreatTanked.g,db.colorThreatTanked.b
                    elseif perc<60 then
                        r, g, b = db.colorThreatVerySafe.r,db.colorThreatVerySafe.g,db.colorThreatVerySafe.b
                    elseif perc<80 then
                        r, g, b = resources.colorGradient( ( perc-60 )/20/100, db.colorThreatSafe, db.colorThreatUnsafe )
                        --self.tot:SetText( tostring(round(( perc-60 )/20/100,2))..", "..tostring(perc) )
                    elseif perc<100 then
                        r, g, b = resources.colorGradient( ( perc-80 )/20/100, db.colorThreatUnsafe, db.colorThreatAlert )
                        --self.tot:SetText( tostring(round(( perc-80 )/20/100,2))..", "..tostring(perc) )
                    else
                        r, g, b = db.colorThreatAlert.r,db.colorThreatAlert.g,db.colorThreatAlert.b
                    end
                    
                    namer, nameg, nameb = resources.lightenColor( r,g,b )
                    hpNumberr, hpNumberg, hpNumberb = r, g, b
                else -- or normal color
                    namer, nameg, nameb = resources.lightenColor( self.data.red, self.data.green, self.data.blue )
                    guildr, guildg, guildb = resources.lightenColor( self.data.red, self.data.green, self.data.blue )
                    hpNumberr, hpNumberg, hpNumberb = self.data.red, self.data.green, self.data.blue
                end
            end
        end
    end
    
    if self.name.r~=namer or self.name.g~=nameg or self.name.b~=nameb then
        self.name:SetTextColor( namer, nameg, nameb )
        self.name.r = namer
        self.name.g = namer
        self.name.b = namer
    end
    if self.guild.r~=guildr or self.guild.g~=guildg or self.guild.b~=guildb then
        self.guild:SetTextColor( guildr, guildg, guildb )
        self.guild.r = guildr
        self.guild.g = guildr
        self.guild.b = guildr
    end
    if not self.data.healthNotVisible and ( self.hpNumber.r~=hpNumberr or self.hpNumber.g~=hpNumberg or self.hpNumber.b~=hpNumberb ) then
        if db.showHpBar then
            if db.healthBarColorCustom then
                self.hp:SetStatusBarColor( db.customColor.r,db.customColor.g,db.customColor.b )
            else
                self.hp:SetStatusBarColor( hpNumberr, hpNumberg, hpNumberb )
            end
        end
        self.hpNumber:SetTextColor( hpNumberr, hpNumberg, hpNumberb )
        self.hpNumber.r = hpNumberr
        self.hpNumber.g = hpNumberr
        self.hpNumber.b = hpNumberr
    end
end
function update:name()
    if self.data.isTotem then
        if self.name.value~=nil then
            self.name:SetText( nil )
            self.name.value = nil
        end
        
        return
    end
    
    local text = self.data.nameIsReplacement or self.data.nameIs
    
    if self.name.value~=text then
        self.name:SetText( text )
        self.name.value = text
    end
    
    if ( isInPvp and self.data.layout=="ENEMY" ) or self.data.isBoss then
        if self.name.font~=db.fontb then
            self.name:SetFont( LSM:Fetch("font", db.fontb), db.fontsizeName, db.outline )
            self.name.font = db.fontb
        end
    else
        if self.name.font~=db.font then
            self.name:SetFont( LSM:Fetch("font", db.font), db.fontsizeName, db.outline )
            self.name.font = db.font
        end
    end
end

function update:tot()
    if not db.tot then return end
    
    if not self.data.tot or self.data.isTotem or not isInArena then
        if self.tot.value~=nil then
            self.tot:SetText( nil )
            self.tot.value = nil
        end
        
        return
    end
    
    local text = "["..self.data.tot.."]"
    
    if self.tot.value~=text then
        self.tot:SetText( text )
        self.tot.value = text
    end
    
    local r, g, b
    if self.data.totClass then
        r, g, b = RAID_CLASS_COLORS[self.data.totClass].r, RAID_CLASS_COLORS[self.data.totClass].g, RAID_CLASS_COLORS[self.data.totClass].b
    else
        r, g, b = 0.5, 0.5, 0.5
    end
    if self.tot.r~=r or self.tot.g~=g or self.tot.b~=b then
        self.tot:SetTextColor( r, g, b )
        self.tot.r = r
        self.tot.r = g
        self.tot.r = b
    end
end

function update:guild()
    if not db.guildName or self.data.isTotem or inCombat or isInPvp or self.data.layout=="ENEMY" or not self.data.healthNotVisible or not self.data.guild or self.data.guild=="NONE" or ( isInInstance~="none" and self.data.type=="PLAYER" ) then
        if self.guild.value~=nil then
            self.guild:SetText( nil )
            self.guild.value = nil
        end
        
        return
    end
    
    local text = "<"..self.data.guild..">"
    
    if self.guild.value~=text then
        self.guild:SetText( text )
        self.guild.value = text
    end
end

function update:socialIcon()
    if not db.socialIcon or self.data.hasRaidIcon or self.data.isTotem or inCombat or isInPvp or isInInstance~="none" or self.data.layout=="ENEMY" or not self.data.class then
        if self.socialIcon.visible then
            self.socialIcon:Hide()
            self.socialIcon.visible = false
        end
        
        return
    end
    
    local r, g, b
    if raid[self.data.nameIs] then
        r, g, b = resources.getSocialColor( "raid" )
    elseif party[self.data.nameIs] then
        r, g, b = resources.getSocialColor( "party" )
    elseif guild[self.data.nameIs] then
        r, g, b = resources.getSocialColor( "guild" )
    elseif bnet[self.data.nameIs] then
        r, g, b = resources.getSocialColor( "bnet" )
    elseif friend[self.data.nameIs] then
        r, g, b = resources.getSocialColor( "friend" )
    else
        if self.socialIcon.visible then
            self.socialIcon:Hide()
            self.socialIcon.visible = false
        end
        
        return
    end
    
    if not self.socialIcon.visible then
        self.socialIcon:Show()
        self.socialIcon.visible = true
        if self.socialIcon.r~=r or self.socialIcon.g~=g or self.socialIcon.b~=b then
            self.socialIcon:SetVertexColor( r, g, b )
            self.socialIcon.r = r
            self.socialIcon.g = g
            self.socialIcon.b = b
        end
    end
end

function update:hp( option )
    local text
    
    if option=="onlyHp" and not self.data.healthNotVisible then
        local healthIs = self.children.healthBar:GetValue()
        local _, maxHealthIs = self.children.healthBar:GetMinMaxValues()
        
        if db.showHpPercent then
            local perc = min( ( healthIs/maxHealthIs )*100, 100 )
            
            if perc<1 or self.data.isBoss then
                text = resources.round( ( healthIs/maxHealthIs )*100, 1 )
            else
                text = floor( ( healthIs/maxHealthIs )*100 )
            end
        else
            text = resources.siValue( healthIs )
        end
        
        if db.showHpBar and self.hp.value~=healthIs then
            self.hp:SetValue( healthIs )
            self.hp.value = healthIs
        end
        if self.hpNumber.value~=text then
            self.hpNumber:SetText( text )
            self.hpNumber.value = text
        end
        
        return
    end
    
    if addon.configMode then
        self.data.healthIs = random( 10, 90 )
        self.data.maxHealthIs = 100
    end
    
    if self.data.healthNotVisible then
        if self.hp.visible then
            self.hp:Hide()
            self.hp.visible = false
        end
        
        if self.hpNumber.value~=nil then
            self.hpNumber:SetText( nil )
            self.hpNumber.value = nil
        end
        
        return
    end
    
    if db.showHpBar then
        if not self.hp.visible then
            self.hp:Show()
            self.hp.visible = true
        end
        
        if self.hpNumberBg.visible then
            self.hpNumberBg:Hide()
            self.hpNumberBg.visible = false
        end
    else
        if self.hp.visible then
            self.hp:Hide()
            self.hp.visible = false
        end
        
        if not self.hpNumberBg.visible then
            self.hpNumberBg:Show()
            self.hpNumberBg.visible = true
        end
    end
    
    if self.hp.max~=self.data.maxHealthIs then
        self.hp:SetMinMaxValues( 0, self.data.maxHealthIs )
        self.hp.max = self.data.maxHealthIs
    end
    
    if db.showHpPercent then
        local perc = min( ( self.data.healthIs/self.data.maxHealthIs )*100, 100 )
        
        if perc<1 or self.data.isBoss then
            text = resources.round( ( self.data.healthIs/self.data.maxHealthIs )*100, 1 )
        else
            text = floor( ( self.data.healthIs/self.data.maxHealthIs )*100 )
        end
    else
        text = resources.siValue( self.data.healthIs )
    end
    
    if db.showHpBar and self.hp.value~=self.data.healthIs then
        self.hp:SetValue( self.data.healthIs )
        self.hp.value = self.data.healthIs
    end
    
    if self.hpNumber.value~=text then
        self.hpNumber:SetText( text )
        self.hpNumber.value = text
    end
end

function update:level()
    if self.data.type=="PLAYER" or self.data.isBoss or self.data.isTotem or self.data.layout=="FRIEND" or isInInstance~="none" or isInPvp then
        if self.level.value~=nil then
            self.level:SetText( nil )
            self.level.value = nil
        end
        
        return
    end
    
    local text = self.data.levelIs
    if text and self.data.isElite then text = text.."+" end
    
    if self.level.value~=text then
        self.level:SetText( text )
        self.level.value = text
    end
    
    local r, g, b = unpack( resources.getLevelColor( self.data.levelIs, playerLevel ) )
    if self.level.r~=r or self.level.g~=g or self.level.b~=b then
        self.level:SetTextColor( r, g, b )
        self.level.r = r
        self.level.g = g
        self.level.b = b
    end
end

function update:cast( option )
    if addon.configMode and self.data.layout~="FRIEND" then
        self.data.isCasting = true
        self.data.castingMax = 2
        self.data.castingTime = 1.1
        self.data.castingName = "Config Spell"
    end
    
    if self.data.GUID and guidCasts[self.data.GUID] then
        if guidCasts[self.data.GUID].isCasting and not checkCastbarNotVisible( self.data ) then
            self.cast:SetMinMaxValues( 0, guidCasts[self.data.GUID].max ) --TODO speed improvements here
            self.cast:SetValue( guidCasts[self.data.GUID].value )
            self.cast.time:SetText( resources.round( guidCasts[self.data.GUID].value, 1 ) )
            self.cast.text:SetText( guidCasts[self.data.GUID].name )
            
            self.cast.icon.texture2:SetTexture( guidCasts[self.data.GUID].icon or "Interface\\Icons\\Inv_misc_questionmark" )
            
            if guidCasts[self.data.GUID].notInterruptible then
                self.cast:SetStatusBarColor( 0.5,0.5,0.5,0.75 )
            else
                self.cast:SetStatusBarColor( db.castColor.r,db.castColor.g,db.castColor.b,db.castColor.a )
            end
            
            self.cast.list = guidCasts[self.data.GUID]
            self.cast.lastUpdate = 0
            
            if not self.cast.visible then
                self.cast:Show()
                self.cast.visible = true
                if db.showHpBar then
                    self.cast:SetPoint( "TOP", self.hp, "BOTTOM", 0, -db.spacingFixed*2 )
                else
                    self.cast:SetPoint( "TOP", self.hpNumber, "BOTTOM", 0, -db.spacingFixed*2 )
                end
            end
        else
            guidCasts[self.data.GUID].isCasting = false
            
            self.cast.list = nil
            self.cast.lastUpdate = 0
            
            if self.cast.visible then
                self.cast:Hide()
                self.cast.visible = false
            end
        end
    end
end

function update:raidIcon()
    if self.data.hasRaidIcon then
        if not self.raidIcon.visible then
            self.raidIcon:Show()
            self.raidIcon.visible = true
        end
        
        self.raidIcon:SetTexCoord( self.data.raidIcon:GetTexCoord() )
    else
        if self.raidIcon.visible then
            self.raidIcon:Hide()
            self.raidIcon.visible = false
        end
    end
end

function update:classIcon()
    if self.data.isTotem or self.data.layout=="FRIEND" or not db.classIcon or not self.data.class then
        if self.classIcon.visible then
            self.classIcon:Hide()
            self.classIcon.visible = false
        end
        
        return
    end
    
    if self.data.class then
        if not self.classIcon.visible then
            self.classIcon:Show()
            self.classIcon.visible = true
        end
        
        local coords = resources.classIcon[self.data.class]
        self.classIcon:SetTexCoord( coords[1], coords[2], coords[3], coords[4] )
    end
end

function update:roleIcon()
    if not db.roleIcon or not self.data.role or self.data.isTotem or self.data.layout=="FRIEND" or self.data.type=="PLAYER" then
        if self.roleIcon.visible then
            self.roleIcon:Hide()
            self.roleIcon.visible = false
        end
        
        return
    end
    
    local role = resources.roleTextureCoords[self.data.role]
    
    if type( role )=="table" then
        if not self.roleIcon.visible then
            self.roleIcon:Show()
            self.roleIcon.visible = trur
        end
        
        self.roleIcon:SetTexCoord( unpack( resources.roleTextureCoords[self.data.role] ) )
    else
        if self.roleIcon.visible then
            self.roleIcon:Hide()
            self.roleIcon.visible = false
        end
    end
end

function update:totemIcon()
    if self.data.isTotem then
        if not self.totemIcon.visible then
            self.totemIcon:Show()
            self.totemIcon.visible = true
        end
        
        local text = self.data.isTotem
        if self.totemIcon.value~=text then
            self.totemIcon:SetTexture( text )
            self.totemIcon.value = text
        end
    else
        if self.totemIcon.visible then
            self.totemIcon:Hide()
            self.totemIcon.visible = false
        end
    end
end

function update:unknownIcon()
    if not db.unknownIcon or self.data.isTotem or self.data.GUID or ( self.data.type~="PLAYER" and self.data.layout=="FRIEND" and global.npcList[self.data.nameIs] ) then
        if self.unknownIcon.visible then
            self.unknownIcon:Hide()
            self.unknownIcon.visible = false
        end
    else
        if not self.unknownIcon.visible then
            self.unknownIcon:Show()
            self.unknownIcon.visible = true
        end
    end
end

function update:lfgIcon()
    if db.lfgIcon and lfgList[self.data.nameIs] then
        if not self.lfgIcon.visible then
            self.lfgIcon:Show()
            self.lfgIcon.visible = true
        end
    else
        if self.lfgIcon.visible then
            self.lfgIcon:Hide()
            self.lfgIcon.visible = false
        end
    end
end

function update:chatIcon()
    local w = whisperList[self.data.nameIs]
    
    if not inCombat and w and w+120>time then
        if not self.chatIcon.visible then
            self.chatIcon:Show()
            self.chatIcon.visible = true
        end
    else
        w = nil
        
        if self.chatIcon.visible then
            self.chatIcon:Hide()
            self.chatIcon.visible = false
        end
    end
end

function update:threat( option )
    if option=="onlyThreat" and db.threatEnabled then
        self.data.threatState = threatByColor( self.regions.threatGlow )
    end
    
    if addon.configMode and db.threatEnabled and self.data.layout~="FRIEND" then
        self.data.threatState = "HIGH"
    elseif not db.threatEnabled or not inCombat or self.data.class or self.data.isTotem or self.data.layout=="FRIEND" or ( playerClass~="HUNTER" and not hasGroup ) then
        self.data.threatState = 0
        
        return
    end
    
    if tankMode then
        if not self.data.threatState or self.data.threatState=="HIGH" then
            self.data.threatState = 1
        elseif self.data.threatState=="MEDIUM" then
            self.data.threatState = 2
        elseif self.data.threatState=="LOW" then
            self.data.threatState = 3
        end
    else
        if not self.data.threatState or self.data.threatState=="LOW" then
            self.data.threatState = 1
        elseif self.data.threatState=="MEDIUM" then
            self.data.threatState = 2
        elseif self.data.threatState=="HIGH" then
            self.data.threatState = 3
        end
    end
    
    local list = guidThreat[self.data.GUID]
    if list then
        if tankMode then
            if list.isTanked then
                self.data.threatIsTanked = true
            else
                self.data.threatIsTanked = false
                
                if list.player==100 or self.data.threatState==3 then
                    self.data.threatPercent = 0
                else
                    self.data.threatPercent = list.groupMember
                end
            end
        else
            if list.player==100 or self.data.threatState==3 then
                self.data.threatPercent = 100
            else
                self.data.threatPercent = list.player
            end
        end
        
        --self.tot:SetText( round(list.player)..", "..round(list.groupMember) )
    else
        if self.data.threatState==1 then
            self.data.threatPercent = 0
        elseif self.data.threatState==2 then
            self.data.threatPercent = 90
        elseif self.data.threatState==3 then
            self.data.threatPercent = 100
        end
        
        --self.tot:SetText( "??" )
    end
end

function update:size() -- self = frame
    local width, height
    
    if inCombat then
        return
    elseif self.nameplate.data.layout=="FRIEND" then
        width = self.nameplate.originalWidth/3.8
        height = self.nameplate.originalHeight/2
    else
        width = self.nameplate.originalWidth
        height = self.nameplate.originalHeight
    end
    
    if self.width~=width then
        self:SetWidth( width )
        self.width = width
    end
    if self.height~=height then
        self:SetHeight( height )
        self.height = height
    end
end

function update:highlight()
    if self.data.healthNotVisible then -- Highlight over name
        self.highlight:ClearAllPoints()
        self.highlight:SetAllPoints( self.name )
    else -- Highlight on hp
        self.highlight:ClearAllPoints()
        
        if db.showHpBar then
            self.highlight:SetAllPoints( self.hp )
        else
            self.highlight:SetAllPoints( self.hpNumber )
            
        end
    end
end

function update:alpha()
    --TODO alpha speichern?
    if self.data.isTarget then
        self:SetAlpha( 1 )
    else
        if self.data.isTotem then
            self:SetAlpha( 1 )
        elseif self.data.hasRaidIcon then
            self:SetAlpha( 1 )
        elseif self.data.alphaIs<1 then
            self:SetAlpha( db.alpha )
        else
            self:SetAlpha( 1 )
        end
    end
end

function update:mouseover() -- and target
    if self.data.isTarget then
        if not self.targetHighlight.visible then
            self.targetHighlight:ClearAllPoints()
            
            if not self.data.healthNotVisible then
                if db.showHpBar then
                    --self.targetHighlight:SetPoint( "TOPLEFT", self.hp, "TOPLEFT", -2, 2 )
                    --self.targetHighlight:SetPoint( "BOTTOMRIGHT", self.hp, "BOTTOMRIGHT", 2, -2 )
                    self.hp.border:SetBackdropBorderColor( 1,1,1,1 )
                else
                    self.targetHighlight:SetPoint( "TOPLEFT", self.hpNumber, "TOPLEFT", -2, 2 )
                    self.targetHighlight:SetPoint( "BOTTOMRIGHT", self.hpNumber, "BOTTOMRIGHT", 2, -2 )
                    self.targetHighlight:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\highlightTarget" )
                    self.targetHighlight:Show() -- TODO optimieren
                    self.targetHighlight.visible = true
                end
            else
                self.targetHighlight:SetPoint( "TOPLEFT", self.name, "TOPLEFT", -2, 2 )
                self.targetHighlight:SetPoint( "BOTTOMRIGHT", self.name, "BOTTOMRIGHT", 2, -2 )
                self.targetHighlight:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\highlightTargetName" )
                self.targetHighlight:Show() -- TODO optimieren
                self.targetHighlight.visible = true
            end
        end
        
        if self.frameLevel~=22 then
            self:SetFrameLevel( 22 )
            self.frameLevel = 22
        end
    elseif self.data.isMouseover then
        if self.targetHighlight.visible then
            self.targetHighlight:Hide()
            self.targetHighlight.visible = false
        end
        
        if self.frameLevel~=24 then
            self:SetFrameLevel( 24 )
            self.frameLevel = 24
        end
        
        self.hp.border:SetBackdropBorderColor( db.borderColor.r,db.borderColor.g,db.borderColor.b,db.borderColor.a ) --TODO optimieren
        
        self.data.GUID = UnitGUID( "mouseover" )
    else
        if self.targetHighlight.visible then
            self.targetHighlight:Hide()
            self.targetHighlight.visible = false
        end
        
        if self.frameLevel~=12 then
            self:SetFrameLevel( 12 )
            self.frameLevel = 12
        end
        
        self.hp.border:SetBackdropBorderColor( db.borderColor.r,db.borderColor.g,db.borderColor.b,db.borderColor.a )
    end
end

function update:auras()
    if checkBuffsNotVisible( self.data ) then
        for i=1,db.buffsNumber do
            if self.buffs[i].visible then
                self.buffs[i].expirationTime = 0
                self.buffs[i]:Hide()
                self.buffs[i].visible = false
            end
            
            if self.debuffs[i].visible then
                self.debuffs[i].expirationTime = 0
                self.debuffs[i]:Hide()
                self.debuffs[i].visible = false
            end
        end
        
        return
    end
    
    if addon.configMode then return end
    
    local GUID = self.data.GUID
    
    if GUID and guidBuffs[GUID] then
        for i=1,#guidBuffs[GUID] do
            if guidBuffs[GUID][i] then
                if guidBuffs[GUID][i].expirationTime and guidBuffs[GUID][i].expirationTime>0 and time>guidBuffs[GUID][i].expirationTime then
                    tremove( guidBuffs[GUID], i )
                end
            end
        end
        
        sort( guidBuffs[GUID], function( a, b ) 
            if a and b then 
                if a.priority==b.priority then
                    if a.expirationTime==b.expirationTime then
                        return a.name<b.name
                    else
                        return ( a.expirationTime or 0 )<( b.expirationTime or 0 )
                    end
                else
                    return a.priority>b.priority
                end
            end 
        end )
        
        local counterBuffs = 1
        local counterDebuffs = 1
        for i=1,#guidBuffs[GUID] do
            if counterBuffs<=db.buffsNumber and guidBuffs[GUID][i].filter=="HELPFUL" then
                self.buffs[counterBuffs].spellName = guidBuffs[GUID][i].name or ""
                self.buffs[counterBuffs].expirationTime = guidBuffs[GUID][i].expirationTime or 0
                self.buffs[counterBuffs].duration = guidBuffs[GUID][i].duration or 1
                self.buffs[counterBuffs].count = guidBuffs[GUID][i].count or 0
                self.buffs[counterBuffs].filter = guidBuffs[GUID][i].filter
                
                local icon = "Interface\\Icons\\"..guidBuffs[GUID][i].icon
                if self.buffs[counterBuffs].icon~=icon then
                    self.buffs[counterBuffs].icon:SetTexture( icon )
                end
                
                if not self.buffs[counterBuffs].visible then
                    self.buffs[counterBuffs]:Show()
                    self.buffs[counterBuffs].visible = true
                end
                local c = self.buffs[counterBuffs].count
                if c>1 then
                    self.buffs[counterBuffs].counter:SetText( c )
                else
                    self.buffs[counterBuffs].counter:SetText( nil )
                end
                local e = self.buffs[counterBuffs].expirationTime
                if e>0 then
                    self.buffs[counterBuffs].time:SetText( formatTime( e-time ) )
                else
                    self.buffs[counterBuffs].time:SetText( nil )
                end
                
                counterBuffs = counterBuffs+1
            elseif counterDebuffs<=db.buffsNumber and guidBuffs[GUID][i].filter=="HARMFUL" then
                self.debuffs[counterDebuffs].spellName = guidBuffs[GUID][i].name or ""
                self.debuffs[counterDebuffs].expirationTime = guidBuffs[GUID][i].expirationTime or 0
                self.debuffs[counterDebuffs].duration = guidBuffs[GUID][i].duration or 1
                self.debuffs[counterDebuffs].count = guidBuffs[GUID][i].count or 0
                self.debuffs[counterDebuffs].filter = guidBuffs[GUID][i].filter
                
                local icon = "Interface\\Icons\\"..guidBuffs[GUID][i].icon
                if self.debuffs[counterDebuffs].icon~=icon then
                    self.debuffs[counterDebuffs].icon:SetTexture( icon )
                end
                
                if not self.debuffs[counterDebuffs].visible then
                    self.debuffs[counterDebuffs]:Show()
                    self.debuffs[counterDebuffs].visible = true
                end
                local c = self.debuffs[counterDebuffs].count
                if c>1 then
                    self.debuffs[counterDebuffs].counter:SetText( c )
                else
                    self.debuffs[counterDebuffs].counter:SetText( nil )
                end
                self.debuffs[counterDebuffs].time:SetText( formatTime( self.debuffs[counterDebuffs].expirationTime-time ) )
                
                counterDebuffs = counterDebuffs+1
            else
                break
            end
        end
        
        for i=counterBuffs,db.buffsNumber do
            if self.buffs[i].visible then
                self.buffs[i].expirationTime = 0
                self.buffs[i]:Hide()
                self.buffs[i].visible = false
            end
        end
        
        for i=counterDebuffs,db.buffsNumber do
            if self.debuffs[i].visible then
                self.debuffs[i].expirationTime = 0
                self.debuffs[i]:Hide()
                self.debuffs[i].visible = false
            end
        end
    else
        for i=1,db.buffsNumber do
            if self.buffs[i].visible then
                self.buffs[i].expirationTime = 0
                self.buffs[i]:Hide()
                self.buffs[i].visible = false
            end
            
            if self.debuffs[i].visible then
                self.debuffs[i].expirationTime = 0
                self.debuffs[i]:Hide()
                self.debuffs[i].visible = false
            end
        end
    end
end

function update:bossplates()
    bossplateUpdate( self )
end

function update:debug( frame )
    if not db.debugMode then --TODO debug option
        self.debug.bg:Hide()
        self.debug.text:SetText( nil )
        
        return
    else
        self.debug.bg:Show()
    end
    
    local text = ""
    
    text = text.."Frame: "
    text = text..tostring( self.number )
    text = text.."\n"
    
    text = text.."Updates: "
    text = text..tostring( self.updateCounter )
    text = text.."\n"
    
    text = text.."Updates (hp): "
    text = text..tostring( self.updateCounterHp )
    text = text.."\n"
    
    text = text.."Updates (threat): "
    text = text..tostring( self.updateCounterThreat )
    text = text.."\n"
    
    text = text.."Updates (aura): "
    text = text..tostring( self.updateCounterAura )
    text = text.."\n"
    
    text = text.."Updates (cast): "
    text = text..tostring( self.updateCounterCast )
    text = text.."\n"
    
    text = text.."GUID: "
    text = text..tostring( self.data.GUID )
    text = text.."\n"
    
    text = text.."Threat: "
    text = text..tostring( tostring( self.data.threatPercent ).." ("..tostring( self.data.threatState )..")".." ("..tostring( self.data.threatIsTanked )..")" )  --self.data.threatIsTanked
    text = text.."\n"
    
    --[[
    if self.data.list then
        text = text.."List: "
        if temporaryList[self.data.nameIs] then
            text = text..tostring( "temporaryList" )
        elseif playerList[self.data.nameIs] then
            text = text..tostring( "playerList" )
        end
        text = text.."\n"
    end
    ]]
    --[[
    text = text.."Layout: "
    text = text..tostring( tostring( self.data.layout ) )
    text = text.."\n"
    ]]
    --[[
    text = text.."hasRaidIcon: "
    text = text..tostring( self.data.hasRaidIcon )
    text = text.."\n"
    ]]
    --[[
    if self.data.GUID and guidBuffs[self.data.GUID] then
        text = text.."Buffs: "
        for i=1,#guidBuffs[self.data.GUID] do
            if guidBuffs[self.data.GUID][i].filter=="HELPFUL" then
                text = text..tostring( guidBuffs[self.data.GUID][i].name )..", "
            end
        end
        text = text.."\n"
        
        text = text.."Debuffs: "
        for i=1,#guidBuffs[self.data.GUID] do
            if guidBuffs[self.data.GUID][i].filter=="HARMFUL" then
                text = text..tostring( guidBuffs[self.data.GUID][i].name )..", "
            end
        end
        text = text.."\n"
    end
    ]]
    self.debug.text:SetText( text )
end

--[[ Set up the nameplate ]]
local overlayType = "Texture"
local overlayBorderTexture = "Interface\\Tooltips\\Nameplate-Border"
local function isValidFrame( frame )
    if frame:GetName() then
        return false
    end

    overlayRegion = select( 2, frame:GetRegions() )
    
    if overlayRegion and overlayRegion:GetObjectType()==overlayType and overlayRegion:GetTexture()==overlayBorderTexture then
        frame.isNameplate = true
        return true
    end
    
    return false
end

local function onCreateChildFrames( ... )
    for i=1, select( "#", ... ) do 
		local frame = select( i, ... )
		if isValidFrame( frame ) and not frame.nameplate then addon.createNewNameplate( frame ) end
    end
end

--[[ OnUpdate nameplate ]]
local nameplatesUpdater = CreateFrame( "Frame", nil, WorldFrame )
nameplatesUpdater:SetFrameStrata( "TOOLTIP" ) -- When parented to WorldFrame, causes OnUpdate to run close to last.
local lastUpdateThreat = 0
local lastUpdateTankMode = 0
local wframe = WorldFrame
local numChildren = -1
local function onUpdate( self, elapsed ) -- onUpdate
	lastUpdateThreat = lastUpdateThreat + elapsed
    lastUpdateTankMode = lastUpdateTankMode + elapsed
    
    if true then -- No delay allowed
		local curChildren = wframe:GetNumChildren()
        if curChildren~=numChildren then
            numChildren = curChildren
            onCreateChildFrames( wframe:GetChildren() )
        end
        
        if playerTarget then
            for index,value in pairs( framesShown ) do
                local alpha = value:GetAlpha()
                
                value.nameplate.alpha = alpha or 1 -- Set nameplate alpha.
                if alpha~=1 then value:SetAlpha( 1 ) end -- Set to 1 to allow child frames to use their full alpha range.
            end
        end
        
        for i=#doUpdateNext.frames,1,-1 do
            updateNameplate( doUpdateNext.frames[i][1], doUpdateNext.frames[i][2] )
            tremove( doUpdateNext.frames, i )
        end
        
        for i=#doUpdateNext.name,1,-1 do
            updateNameplateByName( doUpdateNext.name[i][1], doUpdateNext.name[i][2] )
            tremove( doUpdateNext.name, i )
        end
        
        for i=#doUpdateNext.GUID,1,-1 do
            updateNameplateByGUID( doUpdateNext.GUID[i][1], doUpdateNext.GUID[i][2] )
            tremove( doUpdateNext.GUID, i )
        end
        
--~         for index,value in pairs( doUpdateNext.frames ) do
--~             updateNameplate( index, value )
--~             
--~             doUpdateNext.frames[index] = nil
--~         end
        
--~         for index,value in pairs( doUpdateNext.name ) do
--~             updateNameplateByName( index, value )
--~             
--~             doUpdateNext.name[index] = nil
--~         end
        
--~         for index,value in pairs( doUpdateNext.GUID ) do
--~             updateNameplateByGUID( index, value )
--~             
--~             doUpdateNext.GUID[index] = nil
--~         end
        
        if doUpdateThreat>0 then
            doUpdateThreat = doUpdateThreat-1
            
            for index,value in pairs( framesShown ) do
                updateNameplate( value, "onlyThreat" )
            end
        end
        
        if doUpdate>0 then
            doUpdate = doUpdate-1
            
            for index,value in pairs( framesShown ) do
                updateNameplate( value )
            end
        end
	end
    
    if inCombat and lastUpdateThreat>1 then
        local unitId
        
        if UnitInRaid( "player" ) then
            unitId = "raid"
            groupSize = GetNumRaidMembers()-1
        elseif UnitInParty( "player" ) then
            unitId = "party"
            groupSize = GetNumPartyMembers()
        end
        
        if unitId then
            for i=1,groupSize do
                addon:UNIT_THREAT_LIST_UPDATE( "UNIT_THREAT_LIST_UPDATE (onUpdate)", unitId..i.."target" )
            end
        end
        
        lastUpdateThreat = 0
    end
    
    if lastUpdateTankMode>5 then
        checkTankMode()
        
        lastUpdateTanks = 0
    end
end

--[[ Events ]]
function addon:PLAYER_LEVEL_UP()
    playerLevel = UnitLevel( "player" )
end

function addon:UPDATE_MOUSEOVER_UNIT()
    if UnitExists( "mouseover" ) then
        scanUnitAuras( "mouseover", playerTargetGUID )
        
        local GUID = UnitGUID( "mouseover" )
        local name, rlm = UnitName( "mouseover" )
        
        if not inCombat then
            local isPlayer = UnitIsPlayer( "mouseover" )
            local reaction = UnitReaction( "mouseover", "player" ) -- 4 is neutral
            
            if not isPlayer then
                DocsScanningTooltip:ClearLines()
                DocsScanningTooltip:SetUnit( "mouseover" )
                local text = DocsScanningTooltipTextLeft3:GetText()
                
                if text then
                    _, text = strsplit( " ", text )
                    
                    if text=="??" or tonumber( text ) then
                        global.npcList[name] = DocsScanningTooltipTextLeft2:GetText()
                    else
                        global.npcList[name] = "NONE"
                    end
                else
                    global.npcList[name] = "NONE"
                end
                
                if UnitClassification( "mouseover" )=="worldboss" then collectUnitInfo( "mouseover" ) end
            else
                collectUnitInfo( "mouseover" )
            end
        else
            collectUnitInfo( "mouseover" )
            
            addon:UNIT_THREAT_LIST_UPDATE( "UNIT_THREAT_LIST_UPDATE", "mouseover" )
        end
        
        if UnitCastingInfo( "mouseover" ) or UnitChannelInfo( "mouseover" ) then addon:UNIT_SPELLCAST_START( "UNIT_SPELLCAST_START", "mouseover" ) end
        
        --setDoUpdateMe( name, "name" ) -- We have to delay it or every plate with that name will be the target.
    end
    
    setDoUpdate( 1 )
end

function addon:PLAYER_REGEN_ENABLED()
    inCombat = false
    
    wipe( whisperList )
    wipe( guidCasts )
    
    addon:bossDisable()
    
    setVisibility()
    softReset()
end

function addon:PLAYER_REGEN_DISABLED()
    inCombat = true
    
    wipe( whisperList )
    wipe( guidCasts )
    
    if isInPve and ( isInInstance~="none" or db.debugMode ) then
        addon:bossCheck()
    end
    
    setVisibility()
    softReset()
end

function addon:PLAYER_TARGET_CHANGED()
    if UnitExists( "target" )==1 then
        playerTarget = UnitName( "target" ) or "UNKNOWN"
        playerTargetGUID = UnitGUID( "target" )
        
        collectUnitInfo( "target" )
        
        scanUnitAuras( "target", playerTargetGUID )
        
        if UnitCastingInfo( "target" ) then addon:UNIT_SPELLCAST_START( "UNIT_SPELLCAST_START", "target" ) end
        
        addon:UNIT_THREAT_LIST_UPDATE( "UNIT_THREAT_LIST_UPDATE", "target" )
    else
        playerTarget = false
        playerTargetGUID = nil
        
        for index,value in pairs( framesShown ) do
            value.nameplate.alpha = 1 -- Reset nameplate alpha
        end
    end
    
    softReset()
end

function addon:RAID_TARGET_UPDATE()
    for i=1,#frames do
        frames[i].nameplate.data.hasRaidIcon = false
        
        if frames[i].nameplate.raidIcon.visible then
            frames[i].nameplate.raidIcon:Hide()
            frames[i].nameplate.raidIcon.visible = false
        end
    end
    
    setDoUpdate( 1 )
end

function addon:UNIT_TARGET( event, unit ) -- 0.5s delay
    if not UnitExists( unit ) or UnitIsUnit( "player", unit ) then return end
    
    local unitTarget = unit.."target"
    local raidIconIndex = GetRaidTargetIndex( unitTarget )
    
    if raidIconIndex and raidIconIndex>0 then
        updateNameplateByRaidIcon( raidIconIndex, UnitGUID( unitTarget ) )
    end
    
    if UnitIsPlayer( unitTarget ) then
        collectUnitInfo( unitTarget )
    end
    
    if isInArena and strfind( unit, "arena" ) then
        local GUID = UnitGUID( unit )
        
        for index,value in pairs( frames ) do
            if GUID and value.nameplate.data.GUID and GUID==value.nameplate.data.GUID then
                if unitTarget then
                    value.nameplate.data.tot = UnitName( unitTarget )
                    _, value.nameplate.data.totClass = UnitClass( unitTarget )
                else
                    value.nameplate.data.tot = nil
                end
                
                updateNameplate( value, option )
                    
                return
            end
        end
    end
    
    addon:UNIT_THREAT_LIST_UPDATE( "UNIT_THREAT_LIST_UPDATE (UNIT_TARGET)", unitTarget )
end

function addon:UNIT_THREAT_LIST_UPDATE( event, unit )
    --p(GetTime().."  "..event.."  "..tostring(unit))
    if not UnitExists( unit ) then return end
    
    local unitId, groupSize
    if UnitInRaid( "player" ) then
        unitId = "raid"
        groupSize = GetNumRaidMembers()-1
    elseif UnitInParty( "player" ) then
        unitId = "party"
        groupSize = GetNumPartyMembers()
    end
    
    if not unitId then return end
    
    local _, _, player = UnitDetailedThreatSituation( "player", unit )
    
    if not player then return end
    
    local groupMember = 0
    local isTanked = false
    for i=1,groupSize do
        local id = unitId..i
        
        local _, _, threat = UnitDetailedThreatSituation( id, unit )
        
        if threat and threat>groupMember then groupMember = threat end
        
        if threat and tanks[id] and threat>player then isTanked = true end
    end
    
    if player and groupMember then
        local GUID = UnitGUID( unit )
        
        guidThreat[GUID] = guidThreat[GUID] or {}
        guidThreat[GUID].player = player
        guidThreat[GUID].groupMember = groupMember
        guidThreat[GUID].isTanked = isTanked
    end
    
    setDoUpdateThreat( 1 )
end

local zoneCheckFrame = CreateFrame( "Frame", nil, WorldFrame )
zoneCheckFrame:SetFrameStrata( "TOOLTIP" )
zoneCheckFrame:Hide()
zoneCheckFrame.lastUpdate = 0
local function zoneCheckFrameOnUpdate( self, elapsed ) -- Checks what type of instance we are in
	if self.lastUpdate+elapsed>self.lastUpdate+1 then
        self.lastUpdate = 0
    else
        self.lastUpdate = self.lastUpdate+elapsed
    end
	
    if self.lastUpdate>5 then
        self:Hide()
        
        setVisibility() --TODO force refresh instead
        softReset()
        
        return
    elseif self.lastUpdate>1 then
        local isIn, type = IsInInstance()
        
        isInInstance = type or "none"
        isInSanctuary = UnitIsPVPSanctuary( "player" )
        hasGroup = GetNumPartyMembers()>1 or false
        
        if type=="pvp" then
            isInBattleground = true
            isInPvp = true
            
            isInPve = false
        elseif type=="arena" then
            isInArena = true
            isInPvp = true
            
            isInPve = false
        else
            isInPve = true
            isInPvp = false
            
            isInArena = false
            isInBattleground = false
        end
    end
end
zoneCheckFrame:SetScript( "OnUpdate", zoneCheckFrameOnUpdate )
local function zoneCheck()
    if GetGuildInfo( "player" ) then GuildRoster() end
    
    zoneCheckFrame.lastUpdate = 0
    zoneCheckFrame:Show()
end

function addon:ZONE_CHANGED()
    zoneCheck()
end

function addon:ZONE_CHANGED_INDOORS()
    zoneCheck()
end

function addon:ZONE_CHANGED_NEW_AREA()
    zoneCheck()
    
    wipe( temporaryList )
    wipe( guidCasts )
    
    if db.combatLogFix then CombatLogClearEntries() end
end

addon.raid = {}
addon.tanks = {}
local function checkRaidMembers()
    local raid = addon.raid
    
    wipe( raid )
    wipe( tanks )
    
    for i=1,GetNumRaidMembers() do
        local unit = "raid"..i
        
        collectUnitInfo( unit )
        
        local GUID = UnitGUID( unit )
        local name, rlm = UnitName( unit )
        local _, class = UnitClass( unit )
        local guildName = GetGuildInfo( unit )
        
        raid[GUID] = raid[GUID] or {}
        
        raid[GUID].name = name
        raid[GUID].class = class
        raid[GUID].realm = rlm or realmName
        raid[GUID].guild = guildName or "NONE"
        raid[GUID].unit = unit
        
        raid[name] = GUID
        raid[unit] = name
        
        local _, _, _, _, _, _, _, _, _, role, _ = GetRaidRosterInfo( i )
        if role=="MAINTANK" then
            tanks[unit] = name
            tanks[name] = unit
        end
    end
    
    setDoUpdate( 1 )
end

addon.party = {}
local function checkPartyMembers()
    local party = addon.party
    
    wipe( party )
    
    for i=1,GetNumPartyMembers() do
        local unit = "party"..i
        
        collectUnitInfo( unit )
        
        local GUID = UnitGUID( unit )
        local name, rlm = UnitName( unit )
        local _, class = UnitClass( unit )
        local guildName = GetGuildInfo( unit )
        
        party[GUID] = party[GUID] or {}
        
        party[GUID].name = name
        party[GUID].class = class
        party[GUID].realm = rlm or realmName
        party[GUID].guild = guildName or "NONE"
        party[GUID].unit = unit
        
        party[name] = GUID
        party[unit] = name
    end
    
    hasGroup = GetNumPartyMembers()>1 or false
    
    setDoUpdate( 1 )
end

addon.arena = {}
local function checkArenaMembers()
    local arena = addon.arena
    
    wipe( arena )
    
    local i = 1
    while UnitExists( "arena"..i ) do
        local unit = "arena"..i
        
        collectUnitInfo( unit )
        
        local GUID = UnitGUID( unit )
        local name, rlm = UnitName( unit )
        local _, class = UnitClass( unit )
        local guildName = GetGuildInfo( unit )
        
        arena[GUID] = arena[GUID] or {}
        
        arena[GUID].name = name
        arena[GUID].class = class
        arena[GUID].realm = rlm or realmName
        arena[GUID].guild = guildName or "NONE"
        arena[GUID].unit = unit
        
        arena[name] = GUID
        arena[unit] = name
        
        i = i+1
    end
    
    setDoUpdate( 1 )
end

addon.battleground = {}

addon.guild = {}
local function checkGuildMembers()
    wipe( addon.guild )
    
    for i=1,GetNumGuildMembers() do
        local name = GetGuildRosterInfo(i)
        
        if name then addon.guild[name] = true end
    end
end

addon.bnet = {}
local function checkBnetFriends()
    wipe( addon.bnet )
    
    for i=1,BNGetNumFriends() do
        local presenceID, givenName, surname, toonName = BNGetFriendInfo( i )
        
        if toonName then addon.bnet[toonName] = true end
    end
end

addon.friend = {}
local function checkFriendMembers()
    wipe( addon.friend )
    
    for i=1,GetNumFriends() do
        local name = GetFriendInfo(i)
        
        if name then addon.friend[name] = true end
    end
end

function addon:RAID_ROSTER_UPDATE()
    checkRaidMembers()
    checkPartyMembers()
    checkGuildMembers()
    checkFriendMembers()
    checkBnetFriends()
    checkArenaMembers()
    
    setDoUpdate( 1 )
end
function addon:PARTY_MEMBERS_CHANGED()
    checkRaidMembers()
    checkPartyMembers()
    checkGuildMembers()
    checkFriendMembers()
    checkBnetFriends()
    checkArenaMembers()
    
    setDoUpdate( 1 )
end
function addon:GUILD_ROSTER_UPDATE()
    checkRaidMembers()
    checkPartyMembers()
    checkGuildMembers()
    checkFriendMembers()
    checkBnetFriends()
    checkArenaMembers()
    
    setDoUpdate( 1 )
end
function addon:FRIENDLIST_UPDATE()
    checkRaidMembers()
    checkPartyMembers()
    checkGuildMembers()
    checkFriendMembers()
    checkBnetFriends()
    checkArenaMembers()
    
    setDoUpdate( 1 )
end
function addon:BN_FRIEND_TOON_ONLINE()
    checkRaidMembers()
    checkPartyMembers()
    checkGuildMembers()
    checkFriendMembers()
    checkBnetFriends()
    checkArenaMembers()
    
    setDoUpdate( 1 )
end

function addon:PLAYER_ENTERING_WORLD()
    checkRaidMembers()
    checkPartyMembers()
    checkGuildMembers()
    checkFriendMembers()
    checkBnetFriends()
    checkArenaMembers()
    
    zoneCheck()
    
    if db.combatLogFix then CombatLogClearEntries() end
    
    wipe( lfgList )
    wipe( whisperList )
    
    setDoUpdate( 1 )
end

function addon:CHAT_MSG_CHANNEL( event, msg, sender, language, channelName, target, chatFlag, zoneID, channelNumber )
    if zoneID==2 or zoneID==26 then -- 2: Trade, 26: LFG
        local text = strlower( msg )
        
        for i=1,#global.LFGList do
            if strfind( strlower( text ), strlower( global.LFGList[i] ) ) then
                lfgList[sender] = msg
                
                setDoUpdate( 1 )
                
                break
            end
        end
    end
end

function addon:CHAT_MSG_WHISPER( event, msg, sender, language, chatFlag )
    if msg then
        whisperList[sender] = GetTime()
        
        if not inCombat then softReset() end
    end
end

--[[ Initialize ]]
function addon:initializeUpdater()
    -- Variables
    db = addon.db.profile
    realm = addon.db.realm
    global = addon.db.global
    playerList = realm.playerList
    raid = addon.raid
    party = addon.party
    guild = addon.guild
    bnet = addon.bnet
    friend = addon.friend
    arena = addon.arena
    battleground = addon.battleground
    isTank = addon.isTank
    guidBuffs = addon.GUIDBuffs
    guidCasts = addon.GUIDCasts
    scanUnitAuras = addon.scanUnitAuras
    bossplateUpdate = addon.updateBossplate
    frames = addon.frames
    tanks = addon.tanks
    
    isInPvp = false
    isInPve = true
    local _, type = IsInInstance()
    isInInstance = type or "none"
    isInBattleground = false
    isInArena = false
    isInSanctuary = false
    hasGroup = false
    
    -- Events.  "CURSOR_UPDATE" fires too often
    self:RegisterEvent( "PLAYER_REGEN_ENABLED" )
    self:RegisterEvent( "PLAYER_REGEN_DISABLED" )
    self:RegisterEvent( "PLAYER_TARGET_CHANGED" )
    self:RegisterEvent( "RAID_TARGET_UPDATE" )
    self:RegisterEvent( "UNIT_THREAT_LIST_UPDATE" )
    self:RegisterEvent( "UPDATE_MOUSEOVER_UNIT" )
    self:RegisterEvent( "ZONE_CHANGED" )
    self:RegisterEvent( "ZONE_CHANGED_INDOORS" )
    self:RegisterEvent( "ZONE_CHANGED_NEW_AREA" )
    self:RegisterEvent( "PLAYER_ENTERING_WORLD" )
    self:RegisterEvent( "PLAYER_LEVEL_UP" )
    self:RegisterEvent( "UNIT_TARGET" )
    self:RegisterEvent( "RAID_ROSTER_UPDATE" )
    self:RegisterEvent( "PARTY_MEMBERS_CHANGED" )
    self:RegisterEvent( "GUILD_ROSTER_UPDATE" )
    self:RegisterEvent( "FRIENDLIST_UPDATE" )
    self:RegisterEvent( "BN_FRIEND_TOON_ONLINE" )
    self:RegisterEvent( "CHAT_MSG_CHANNEL" )
    self:RegisterEvent( "CHAT_MSG_WHISPER" )
    
    -- Other files
    addon:initializeAuras()
    addon:initializeCast()
    addon:initializeBossplateUpdater()
    
    addon.initializeBossplateUpdater()
    bossplateUpdate = addon.updateBossplate
    
    -- OnUpdate
    nameplatesUpdater:SetScript( "OnUpdate", onUpdate )
    setDoUpdate( 1 )
end