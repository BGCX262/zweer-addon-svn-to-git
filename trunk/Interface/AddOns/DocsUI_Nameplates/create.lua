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

local db, level, guidCasts
local resources = DocsUI_Nameplates.resources
local frameNumberCounter = 0
local INVISIBLE_TEXTURE = "Interface\\Addons\\DocsUI_Nameplates\\media\\invisible2x2"
local spacing
local backdrop

function round( num, idp ) --number, decimal places
	local mult = 10^( idp or 0 )
	return math.floor( num * mult + 0.5 ) / mult
end

local function getSocialColor( social )
    if social=="raid" then
        return 255/255, 127/255, 0/255
    elseif social=="party" then
        return 166/255, 166/255, 255/255
    elseif social=="guild" then
        return 64/255, 255/255, 64/255
    elseif social=="bnet" then
        return 115/255, 199/255, 255/255
    elseif social=="friend" then
        return 254/255, 222/255, 41/255
    else
        return 255/255, 255/255, 255/255
    end
end

local function formatTime( time )
    if time>60 then
        time = floor( time/60 ).."m"
    elseif time>=3 then
        time = floor( time )
    else
        time = round( time, 1 )
    end
    
    return time
end

local function createImprovedStatusbar( self, existingBar ) -- Creates a texture that acts like a statusbar. This gets rid of the ugly tiling.
    local function UpdateBar( self )
        local fraction = .01
        local range = self.MaxVal-self.MinVal 
        local value = self.Value-self.MinVal
        local barsize = self.Dim or 100
        
        if range>0 and value>0 and range>=value then
            fraction = value/range
        else
            fraction = .0001
        end
        
        if self.Orientation=="VERTICAL" then 
            self.Bar:SetHeight( barsize*fraction )
            self.Bar:SetTexCoord( 0, 1, 1-fraction, 1 )
        else 
            self.Bar:SetWidth( barsize*fraction ) 
            self.Bar:SetTexCoord( 0, fraction, 0, 1 )
        end
    end
    
    local function UpdateSize( self ) 
        if self.Orientation=="VERTICAL" then
            self.Dim = self:GetHeight()
        else
            self.Dim = self:GetWidth()
        end
        
        UpdateBar( self ) 
    end
    
    local function SetValue( self, value )
        if value>=self.MinVal and value<=self.MaxVal then self.Value = value end
        
        UpdateBar( self ) 
    end
    
    local function SetMinMaxValues( self, minval, maxval )
        if maxval>minval then
            self.MinVal = minval
            self.MaxVal = maxval
        else 
            self.MinVal = 0
            self.MaxVal = 100
        end
        
        if self.Value>self.MaxVal then self.Value = self.MaxVal
        elseif self.Value<self.MinVal then self.Value = self.MinVal end
        
        UpdateBar( self ) 
    end
    
    local function SetOrientation( self, orientation ) 
        if orientation=="VERTICAL" then
            self.Orientation = orientation
            self.Bar:ClearAllPoints()
            self.Bar:SetPoint( "BOTTOMLEFT" )
            self.Bar:SetPoint( "BOTTOMRIGHT" )
        else
            self.Orientation = "HORIZONTAL"
            self.Bar:ClearAllPoints()
            self.Bar:SetPoint( "TOPLEFT" )
            self.Bar:SetPoint( "BOTTOMLEFT" )
        end
        
        UpdateSize( self )
    end
    
    local function SetStatusBarColor( self, r, g, b, a )
        self.Bar:SetVertexColor( r, g, b, a )
    end
    
    local function SetStatusBarTexture( self, texture )
        self.Bar:SetTexture( texture )
    end
    
    local function SetDrawLayer( self, layer )
        self.Bar:SetDrawLayer( layer )
    end
    
    local statusbar
    if not existingBar then
        statusbar = CreateFrame( "Frame", nil, self )
    else
        statusbar = existingBar
    end
    statusbar:SetWidth( db.width )
    statusbar:SetHeight( db.height )
    
    if not statusbar.Bar then
        temp = statusbar:CreateTexture( nil, "ARTWORK" )
    else
        temp = statusbar.Bar
    end
    statusbar.Bar = temp
    
    if not statusbar.border then
        statusbar.border = CreateFrame( "Frame", nil, statusbar )
    end
    statusbar.border:SetPoint( "TOPLEFT", statusbar, "TOPLEFT", -db.borderSize, db.borderSize )
    statusbar.border:SetPoint( "BOTTOMRIGHT", statusbar, "BOTTOMRIGHT", db.borderSize, -db.borderSize )
    
    statusbar.Value = 100
    statusbar.MinVal = 0
    statusbar.MaxVal = 100
    statusbar.Orientation = "HORIZONTAL"
    statusbar.UpdateSize = UpdateSize
	statusbar.SetValue = SetValue
	statusbar.SetMinMaxValues = SetMinMaxValues
	statusbar.SetOrientation = SetOrientation
	statusbar.SetStatusBarColor = SetStatusBarColor
	statusbar.SetStatusBarTexture = SetStatusBarTexture
    statusbar.SetDrawLayer = SetDrawLayer
    
    statusbar:SetFrameLevel( level )
    statusbar:SetOrientation( "HORIZONTAL" )
    statusbar:SetStatusBarTexture( LSM:Fetch( "statusbar", db.texture ) )
    
    statusbar:SetScript( "OnSizeChanged", UpdateSize )
	UpdateSize( statusbar )
    
    return statusbar
end

--[[ Refresh nameplate layouts ]]
function DocsUI_Nameplates:refreshNameplateLayouts()
    for i=1,#DocsUI_Nameplates.frames do
        DocsUI_Nameplates.createNewNameplate( DocsUI_Nameplates.frames[i], "refresh" )
        DocsUI_Nameplates.onHideNameplate( DocsUI_Nameplates.frames[i] )
    end
    
    for i=1,#DocsUI_Nameplates.frames do
        if DocsUI_Nameplates.frames[i]:IsShown() then
            DocsUI_Nameplates.onShowNameplate( DocsUI_Nameplates.frames[i] )
        end
    end
    
    DocsUI_Nameplates:setVisibility()
end

function DocsUI_Nameplates:OnProfileChange()
    DocsUI_Nameplates:initializeUpdater()
    
    DocsUI_Nameplates:refreshNameplateLayouts()
    
    -- Choose preset
    if not db.presetChosen or db.presetChosen<DocsUI_Nameplates.version then
        DocsUI_Nameplates.LoadPreset()
    end
end

--[[ Create nameplate elements ]]
local create = {}
function create:test()
    
end

function create:name()
    local fontSize = db.fontsizeName
    
    if not self.name then
        temp = self:CreateFontString( nil, "ARTWORK", "GameFontNormal" )
    else
        temp = self.name
    end
    temp:SetPoint( "TOP", self, "TOP", 0, 0 )
    temp:SetFont( LSM:Fetch("font", db.font), fontSize, db.outline )
    temp:SetJustifyH( "CENTER" )
    temp:SetJustifyV( "CENTER" )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    self.name = temp
end

function create:tot()
    local fontSize = db.fontsize-2
    
    if not self.tot then
        temp = self:CreateFontString( nil, "ARTWORK", "GameFontNormal" )
    else
        temp = self.tot
    end
    temp:SetWidth( db.width*4 )
    temp:SetHeight( fontSize )
    temp:ClearAllPoints()
    temp:SetPoint( "BOTTOM", self.name, "TOP", 0, 1 )
    temp:SetFont( LSM:Fetch("font", db.font), fontSize )
    temp:SetJustifyH( "CENTER" )
    temp:SetJustifyV( "CENTER" )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    --temp:Hide()
    self.tot = temp
end

function create:guild()
    local fontSize = db.fontsizeGuild
    
    if not self.guild then
        temp = self:CreateFontString( nil, "ARTWORK", "GameFontNormal" )
    else
        temp = self.guild
    end
    temp:SetWidth( 60*4 )
    temp:SetHeight( fontSize )
    temp:ClearAllPoints()
    temp:SetPoint( "TOP", self.name, "BOTTOM", 0, 0 )
    temp:SetFont( LSM:Fetch("font", db.fonti), fontSize, db.outline )
    temp:SetJustifyH( "CENTER" )
    temp:SetJustifyV( "CENTER" )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    --temp:Hide()
    self.guild = temp
end

function create:hp()
    if not self.hpNumber then
        temp = self:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
    else
        temp = self.hpNumber
    end
    temp:SetPoint( "TOP", self.name, "BOTTOM", 0, 0 )
    temp:SetFont( LSM:Fetch( "font", db.fontb ), db.fontsizeHealth )
    temp:SetJustifyH( "CENTER" )
    temp:SetJustifyV( "CENTER" )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    self.hpNumber = temp
    
    if not self.hpNumberBg then
        temp = self:CreateTexture( nil, "BORDER" )
    else
        temp = self.hpNumberBg
    end
    temp:SetAllPoints( self.hpNumber )
    temp:SetTexture( "Interface\\Buttons\\WHITE8X8" )
    temp:SetVertexColor( db.bgColor.r,db.bgColor.g,db.bgColor.b,db.bgColor.a )
    temp.visible = false
    temp:Hide()
    self.hpNumberBg = temp
    
    self.hp = createImprovedStatusbar( self, self.hp )
    self.hp:SetWidth( db.width )
    self.hp:SetHeight( db.height )
    self.hp:SetPoint( "CENTER", self.hpNumber, "CENTER", 0, 0 )
    self.hp.border:SetBackdrop( backdrop )
    self.hp.border:SetBackdropBorderColor( db.borderColor.r,db.borderColor.g,db.borderColor.b,db.borderColor.a )
    self.hp:SetStatusBarColor( 1, 1, 1, 1 )
    self.hp:UpdateSize( self.hp )
    self.hp.visible = false
    self.hp:Hide()
    
    if not self.hpBg then
        temp = self.hp:CreateTexture( nil, "BORDER" )
    else
        temp = self.hpBg
    end
    temp:SetAllPoints( self.hp )
    temp:SetTexture( "Interface\\Buttons\\WHITE8X8" )
    temp:SetVertexColor( db.bgColor.r,db.bgColor.g,db.bgColor.b,db.bgColor.a )
    self.hpBg = temp
end

function create:level()
    local fontSize = db.fontsizeName
    
    if not self.level then
        temp = self:CreateFontString( nil, "BORDER", "GameFontNormal" )
    else
        temp = self.level
    end
    if db.showHpBar then
        temp:SetPoint( "LEFT", self.hp, "RIGHT", spacing, 0 )
    else
        temp:SetPoint( "LEFT", self.hpNumber, "RIGHT", spacing, 0 )
    end
    temp:SetFont( LSM:Fetch("font", db.fontb), fontSize, db.outline )
    temp:SetJustifyH( "LEFT" )
    temp:SetJustifyV( "CENTER" )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    self.level = temp
end

local function buffOnUpdate( self, elapsed )
    self.lastUpdate = self.lastUpdate+elapsed
    
    if self.lastUpdate>0.1 then
        local t = GetTime()
        
        if self.count>1 and self.counter.saved~=self.count then
            self.counter:SetText( self.count )
            self.counter.saved = self.count
        elseif not self.count or self.count<=1 then
            self.counter:SetText( nil )
            self.counter.saved = -1
        end
        
        if self.expirationTime>0 then
            if t>self.expirationTime then
                self:Hide()
                
                self.frame:update( "onlyAura" )
            else
                local time = formatTime( self.expirationTime-t )
                
                if time~=self.time.saved then
                    self.time:SetText( time )
                    self.time.saved = time
                end
            end
        else
            self.time:SetText( nil )
        end
        
        self.lastUpdate = 0
    end
end
function create:buffs( frame )
    local nameplate = self
    self.buffs = self.buffs or {}
    local list = self.buffs
    
    for i=1,db.buffsNumber do
        local buff
        if not list[i] then
            buff = CreateFrame( "Frame", nil, self )
            tinsert( list, buff )
        else
            buff = list[i]
        end
        buff:Hide()
        buff:SetWidth( 12 )
        buff:SetHeight( 12 )
        buff:ClearAllPoints()
        if i==1 then
            if db.showHpBar then
                buff:SetPoint( "RIGHT", self.hp, "LEFT", 0, 0 )
            else
                buff:SetPoint( "RIGHT", self.hpNumber, "LEFT", 0, 0 )
            end
        else
            buff:SetPoint( "RIGHT", list[i-1], "LEFT", -spacing*2, 0 )
        end
--~         buff.border:SetBackdrop( { 
--~             bgFile = nil, 
--~             edgeFile = LSM:Fetch( "border", db.border ), tile = true, tileSize = 16, edgeSize = 12, 
--~             insets = { left = 4, right = 4, top = 4, bottom = 4 },
--~         } ) -- "Interface/Tooltips/UI-Tooltip-Border"
--~         buff.border:SetBackdropBorderColor( db.borderColor.r,db.borderColor.g,db.borderColor.b,db.borderColor.a )
        buff:SetScale( db.scaleBuffs )
        buff.frame = frame
        
        local icon
        if not buff.icon then
            icon = buff:CreateTexture( nil, "ARTWORK" )
        else
            icon = buff.icon
        end
        icon:ClearAllPoints()
        icon:SetAllPoints( buff )
        icon:SetTexCoord( 0.1,0.9,0.1,0.9 )
        buff.icon = icon
        
        local time
        if not buff.time then
            time = buff:CreateFontString( nil, "ARTWORK", "GameFontNormal" )
        else
            time = buff.time
        end
        time:ClearAllPoints()
        time:SetPoint( "CENTER", buff, "BOTTOM", 0, 0 )
        time:SetFont( LSM:Fetch( "font", db.font ), db.fontsizeBuffs, "THINOUTLINE" )
        time:SetJustifyH( "CENTER" )
        time:SetJustifyV( "CENTER" )
        time:SetShadowColor( 0,0,0,1 )
        time:SetShadowOffset( 1,-1 )
        time:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
        buff.time = time
        
        local counter
        if not buff.counter then
            counter = buff:CreateFontString( nil, "ARTWORK", "GameFontNormal" )
        else
            counter = buff.counter
        end
        counter:ClearAllPoints()
        counter:SetPoint( "CENTER", buff, "TOP", 0, spacing )
        counter:SetFont( LSM:Fetch( "font", db.fontb ), db.fontsizeBuffs, "THINOUTLINE" )
        counter:SetJustifyH( "CENTER" )
        counter:SetJustifyV( "CENTER" )
        counter:SetShadowColor( 0,0,0,1 )
        counter:SetShadowOffset( 1,-1 )
        counter:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
        counter.saved = -1
        buff.counter = counter
        
        buff.index = nil
        
        buff.lastUpdate = 0
        buff:SetScript( "OnUpdate", buffOnUpdate )
        
        buff.expirationTime = 0
        buff:Hide()
        buff.visible = false
    end
end

function create:debuffs( frame )
    local nameplate = self
    self.debuffs = self.debuffs or {}
    local list = self.debuffs
    
    for i=1,db.buffsNumber do
        local buff
        if not list[i] then
            buff = CreateFrame( "Frame", nil, self )
            tinsert( list, buff )
        else
            buff = list[i]
        end
        buff:Hide()
        buff:SetWidth( 12 )
        buff:SetHeight( 12 )
        buff:ClearAllPoints()
        if i==1 then
            if db.showHpBar then
                buff:SetPoint( "LEFT", self.hp, "RIGHT", 0, 0 )
            else
                buff:SetPoint( "LEFT", self.hpNumber, "RIGHT", 0, 0 )
            end
        else
            buff:SetPoint( "LEFT", list[i-1], "RIGHT", spacing*2, 0 )
        end
        buff:SetScale( db.scaleBuffs )
        buff.frame = frame
        
        local icon
        if not buff.icon then
            icon = buff:CreateTexture( nil, "ARTWORK" )
        else
            icon = buff.icon
        end
        icon:ClearAllPoints()
        icon:SetAllPoints( buff )
        icon:SetTexCoord( 0.1,0.9,0.1,0.9 )
        buff.icon = icon
        
        local time
        if not buff.time then
            time = buff:CreateFontString( nil, "ARTWORK", "GameFontNormal" )
        else
            time = buff.time
        end
        time:ClearAllPoints()
        time:SetPoint( "CENTER", buff, "BOTTOM", 0, 0 )
        time:SetFont( LSM:Fetch( "font", db.font ), db.fontsizeBuffs, "THINOUTLINE" )
        time:SetJustifyH( "CENTER" )
        time:SetJustifyV( "CENTER" )
        time:SetShadowColor( 0,0,0,1 )
        time:SetShadowOffset( 1,-1 )
        time:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
        buff.time = time
        
        local counter
        if not buff.counter then
            counter = buff:CreateFontString( nil, "ARTWORK", "GameFontNormal" )
        else
            counter = buff.counter
        end
        counter:ClearAllPoints()
        counter:SetPoint( "CENTER", buff, "TOP", 0, spacing )
        counter:SetFont( LSM:Fetch( "font", db.fontb ), db.fontsizeBuffs, "THINOUTLINE" )
        counter:SetJustifyH( "CENTER" )
        counter:SetJustifyV( "CENTER" )
        counter:SetShadowColor( 0,0,0,1 )
        counter:SetShadowOffset( 1,-1 )
        counter:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
        counter.saved = -1
        buff.counter = counter
        
        buff.index = nil
        
        buff.lastUpdate = 0
        buff:SetScript( "OnUpdate", buffOnUpdate )
        
        buff.expirationTime = 0
        buff:Hide()
        buff.visible = false
    end
end

function create:cast()
    local function onUpdate( self, elapsed )
        self.lastUpdate = self.lastUpdate+elapsed
        
        if self.lastUpdate>0.025 then
            self.list.value = self.list.value+self.lastUpdate
            
            self:SetValue( self.list.value )
            self.time:SetText( resources.round( self.list.value, 1 ) )
            
            self.lastUpdate = 0
        end
        
        if self.list.value>10 or self.list.value>self.list.max then
            if self.visible then
                self:Hide()
                self.visible = false
            end
            
            self.list.isCasting = false
            
            self.list = nil
            self.lastUpdate = 0
        end
    end
    
    local function onShow( self )
        
    end
    
    local function onHide( self )
        
    end
    
    local fontSize = db.fontsizeCast
    
    self.cast = createImprovedStatusbar( self, self.cast )
    self.cast:SetWidth( db.widthCast )
    self.cast:SetHeight( db.heightCast )
    self.cast:SetPoint( "TOP", self.hpNumber, "BOTTOM", 0, -spacing*2 )
    self.cast.border:SetBackdrop( backdrop )
    self.cast.border:SetBackdropBorderColor( db.borderColor.r,db.borderColor.g,db.borderColor.b,db.borderColor.a )
    self.cast:SetStatusBarColor( db.castColor.r,db.castColor.g,db.castColor.b,db.castColor.a )
    self.cast:UpdateSize()
    self.cast:SetScript( "OnUpdate", onUpdate )
    self.cast.lastUpdate = 0
    
    if not self.cast.bg then
        temp = self.cast:CreateTexture( nil, "BACKGROUND" )
    else
        temp = self.cast.bg
    end
    temp:SetAllPoints( self.cast )
    temp:SetTexture( LSM:Fetch( "statusbar", db.texture ) )
    temp:SetVertexColor( db.bgColor.r, db.bgColor.g, db.bgColor.b, 0.5 )
    self.cast.bg = temp
    
    if not self.cast.time then
        temp = self.cast:CreateFontString( nil, "ARTWORK", "GameFontNormal" )
    else
        temp = self.cast.time
    end
    --temp:SetWidth( 60 )
    --temp:SetHeight( db.height )
    temp:SetPoint( "LEFT", self.cast, "RIGHT", spacing, 0 )
    temp:SetFont( LSM:Fetch("font", db.fontb), fontSize-1, db.outline )
    temp:SetJustifyH( "LEFT" )
    temp:SetJustifyV( "CENTER" )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    temp:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
    self.cast.time = temp
    
    if not self.cast.icon then
        temp = CreateFrame( "Frame", nil, self.cast )
    else
        temp = self.cast.icon
    end
    temp:SetWidth( 16 )
    temp:SetHeight( 16 )
    temp:SetPoint( "TOPRIGHT", self.cast, "TOPLEFT", -spacing*2, 0 )
    DocsUI_Nameplates.setBorder( temp )
    self.cast.icon = temp
    
    if not self.cast.icon.texture2 then
        temp = self.cast.icon:CreateTexture( nil, "BORDER" )
    else
        temp = self.cast.icon.texture2
    end
    temp:SetAllPoints( self.cast.icon )
    temp:SetTexCoord( 0.1,0.9,0.1,0.9 )
    temp:SetTexture( "Interface\\Icons\\Inv_misc_questionmark" )
    self.cast.icon.texture2 = temp
    
    if not self.cast.icon.texture then
        temp = self.regions.spellIcon
    else
        temp = self.cast.icon.texture
    end
    temp:SetParent( self.cast.icon )
    temp:SetDrawLayer("ARTWORK")
    temp:SetAllPoints( self.cast.icon )
    temp:SetTexCoord( 0.1,0.9,0.1,0.9 )
    self.cast.icon.texture = temp
    
    if not self.cast.text then
        temp = self.cast:CreateFontString( nil, "ARTWORK", "GameFontNormal" )
    else
        temp = self.cast.text
    end
    --temp:SetWidth( 120 )
    --temp:SetHeight( fontSize )
    temp:SetPoint( "TOPLEFT", self.cast, "BOTTOMLEFT", 0, -spacing )
    temp:SetFont( LSM:Fetch( "font", db.font ), fontSize-2, db.outline )
    temp:SetJustifyH( "LEFT" )
    temp:SetJustifyV( "CENTER" )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    temp:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
    self.cast.text = temp
end

function create:raidIcon()
    if not self.raidIcon then
        temp = self:CreateTexture( nil, "BORDER" )
    else
        temp = self.raidIcon
    end
    temp:SetWidth( 32 )
    temp:SetHeight( 32 )
    temp:SetPoint( "BOTTOM", self.name, "TOP", 0, -10 )
    temp:SetTexture( self.regions.raidIcon:GetTexture() )
    temp:Hide()
    self.raidIcon = temp
end

function create:classIcon()
    if not self.classIcon then
        temp = self:CreateTexture( nil, "BORDER" )
    else
        temp = self.classIcon
    end
    temp:SetWidth( 12 )
    temp:SetHeight( 12 )
    temp:SetPoint( "RIGHT", self.name, "LEFT", -spacing, 0 )
    temp:SetTexture( "Interface\\WorldStateFrame\\Icons-Classes" )
    temp:Hide()
    self.classIcon = temp
end

function create:roleIcon()
    if not self.roleIcon then
        temp = self:CreateTexture( nil, "BORDER" )
    else
        temp = self.roleIcon
    end
    temp:SetWidth( 12 )
    temp:SetHeight( 12 )
    temp:SetPoint( "RIGHT", self.hp, "LEFT", -spacing, 0 )
    temp:SetTexture( "Interface\\LFGFrame\\LFGRole" )
    temp:Hide()
    self.roleIcon = temp
end

function create:totemIcon()
    if not self.totemIcon then
        temp = self:CreateTexture( nil, "BORDER" )
    else
        temp = self.totemIcon
    end
    temp:SetWidth( 25 )
    temp:SetHeight( 25 )
    temp:SetPoint( "TOP", self, "TOP", 0, 0 )
    temp:SetTexture( "Interface\\Icons\\Mail_gmicon" )
    temp:SetTexCoord( 0.1,0.9,0.1,0.9 )
    temp:Hide()
    self.totemIcon = temp
end

function create:unknownIcon()
    if not self.unknownIcon then
        temp = self:CreateTexture( nil, "BORDER" )
    else
        temp = self.unknownIcon
    end
    temp:SetWidth( 20 )
    temp:SetHeight( 20 )
    temp:SetPoint( "CENTER", self.name, "TOP", 0, spacing*2 )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\unknown" )
    temp:SetVertexColor( 0.25,0.99,0.99,1 )
    temp:Hide()
    self.unknownIcon = temp
end

function create:socialIcon()
    if not self.socialIcon then
        temp = self:CreateTexture( nil, "BORDER" )
    else
        temp = self.socialIcon
    end
    temp:SetWidth( 25 )
    temp:SetHeight( 25 )
    temp:SetPoint( "BOTTOM", self.name, "TOP", 0, -spacing*2 )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\social" )
    temp:SetVertexColor( 1, 1, 1, 1 )
    temp:Hide()
    self.socialIcon = temp
end

function create:chatIcon()
    if not self.chatIcon then
        temp = self:CreateTexture( nil, "BORDER" )
    else
        temp = self.chatIcon
    end
    temp:SetWidth( 25 )
    temp:SetHeight( 25 )
    temp:SetPoint( "RIGHT", self.socialIcon, "LEFT", 0, 0 )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\chat" )
    temp:SetVertexColor( 255/255, 128/255, 255/255, 1 )
    temp:Hide()
    self.chatIcon = temp
end

function create:lfgIcon()
    local r, g, b = 255/255, 191/255, 191/255
    
    if not self.lfgIcon then
        temp = self:CreateTexture( nil, "BORDER" )
    else
        temp = self.lfgIcon
    end
    temp:SetWidth( 25 )
    temp:SetHeight( 25 )
    temp:SetPoint( "LEFT", self.socialIcon, "RIGHT", 0, 0 )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\lfg" )
    temp:SetVertexColor( r, g, b, 1 )
    temp:Hide()
    self.lfgIcon = temp
    
    local fontSize = db.fontsize-2
    
    if not self.lfgIconText then
        temp = self:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
    else
        temp = self.lfgIconText
    end
    temp:SetWidth( 60*4 )
    temp:SetHeight( fontSize*3.5 )
    temp:ClearAllPoints()
    temp:SetPoint( "LEFT", self.lfgIcon, "RIGHT", 0, 0 )
    temp:SetFont( LSM:Fetch("font", db.font), fontSize, db.outline )
    temp:SetJustifyH( "LEFT" )
    temp:SetJustifyV( "CENTER" )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    temp:SetTextColor( r, g, b, 1 )
    temp:Hide()
    self.lfgIconText = temp
end

function create:targetIcon()
    if not self.targetIcon then
        temp = self:CreateTexture( nil, "BORDER" )
    else
        temp = self.targetIcon
    end
    temp:SetWidth( 40 )
    temp:SetHeight( 40 )
    temp:SetPoint( "BOTTOM", self, "TOP", 0, -spacing*2 )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\target" )
    temp:Hide()
    self.targetIcon = temp
end

function create:alertIcon()
    if not self.alertIcon then
        temp = self:CreateTexture( nil, "BORDER" )
    else
        temp = self.alertIcon
    end
    temp:SetWidth( 120 )
    temp:SetHeight( 120 )
    temp:SetPoint( "CENTER", self, "CENTER", 0, 0 )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\alert" )
    temp:SetVertexColor( 1, 0, 0, 1 )
    temp:Hide()
    self.alertIcon = temp
end

function create:avoidIcon()
    if not self.avoidIcon then
        temp = self:CreateTexture( nil, "BORDER" )
    else
        temp = self.avoidIcon
    end
    temp:SetWidth( 120 )
    temp:SetHeight( 120 )
    temp:SetPoint( "CENTER", self, "CENTER", 0, 0 )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\avoid" )
    temp:SetVertexColor( 1, 0, 0, 1 )
    temp:Hide()
    self.avoidIcon = temp
end

function create:threat()
    
end

function create:targetHighlight()
    if not self.targetHighlight then
        temp = self:CreateTexture( nil, "OVERLAY" )
    else
        temp = self.targetHighlight
    end
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\highlightTarget" )
    temp:SetPoint( "TOPLEFT", self.hpNumber, "TOPLEFT", -2, 2 )
    temp:SetPoint( "BOTTOMRIGHT", self.hpNumber, "BOTTOMRIGHT", 2, -2 )
    temp:SetVertexColor( 1, 1, 1, 0.75 )
    temp:Hide()
    self.targetHighlight = temp
end

function create:combo()
    if true then return end
    
    local size = 8
    
    if not self.combo then
        self.combo = {}
    end
    local combo = self.combo
    
    temp = self:CreateTexture( nil, "OVERLAY" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\combo1" )
    temp:SetWidth( size )
    temp:SetHeight( size )
    temp:SetPoint( "BOTTOMLEFT", self.hp, "TOPLEFT", 0, 0 )
    temp:SetVertexColor( 0.66,0.66,1,1 )
    --temp:Hide()
    combo[1] = temp
    
    temp = self:CreateTexture( nil, "OVERLAY" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\combo2" )
    temp:SetWidth( size )
    temp:SetHeight( size )
    temp:SetPoint( "LEFT", combo[1], "RIGHT", 0, 0 )
    temp:SetVertexColor( 1,1,0.66,1 )
    --temp:Hide()
    combo[2] = temp
    
    temp = self:CreateTexture( nil, "OVERLAY" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\combo3" )
    temp:SetWidth( size )
    temp:SetHeight( size )
    temp:SetPoint( "LEFT", combo[2], "RIGHT", 0, 0 )
    temp:SetVertexColor( 1,1,0.66,1 )
    --temp:Hide()
    combo[3] = temp
    
    temp = self:CreateTexture( nil, "OVERLAY" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\combo4" )
    temp:SetWidth( size )
    temp:SetHeight( size )
    temp:SetPoint( "LEFT", combo[3], "RIGHT", 0, 0 )
    temp:SetVertexColor( 1,1,0.66,1 )
    --temp:Hide()
    combo[4] = temp
    
    temp = self:CreateTexture( nil, "OVERLAY" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\combo5" )
    temp:SetWidth( size )
    temp:SetHeight( size )
    temp:SetPoint( "LEFT", combo[4], "RIGHT", 0, 0 )
    temp:SetVertexColor( 1,1,0.66,1 )
    --temp:Hide()
    combo[5] = temp
    
end

function create:debug()
    -- self = self
    
    self.debug = self.debug or {}
    local debug = self.debug
    
    local fontSize = db.fontsizeGuild
    
    if not debug.text then
        temp = self:CreateFontString( nil, "OVERLAY" )
    else
        temp = debug.text
    end
    temp:SetPoint( "TOPLEFT", self, "BOTTOMLEFT", 0, -spacing )
    temp:SetFont( LSM:Fetch("font", db.font), fontSize )
    temp:SetJustifyH( "LEFT" )
    temp:SetJustifyV( "CENTER" )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    temp:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
    debug.text = temp
    
    if not debug.bg then
        temp = self:CreateTexture( nil, "BORDER" )
    else
        temp = debug.bg
    end
    temp:SetAllPoints( self )
    temp:SetTexture( LSM:Fetch( "statusbar", db.texture ) )
    temp:SetVertexColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,0.33 )
    temp:Hide()
    debug.bg = temp
end

DocsUI_Nameplates.frames = {}
--[[ Set up the nameplate ]]
function DocsUI_Nameplates:createNewNameplate( refresh )
    local frame = self
    level = frame:GetFrameLevel()
    
    db = DocsUI_Nameplates.db.profile
    spacing = db.spacingFixed
    guidCasts = DocsUI_Nameplates.GUIDCasts
    local edgeSize
    if db.border=="TukUI" or db.border=="LUI" then edgeSize = 3
    else edgeSize = 8 end
    backdrop = { 
            bgFile = nil, 
            edgeFile = LSM:Fetch( "border", db.border ), tile = true, tileSize = 16, edgeSize = edgeSize, 
            insets = { left = 4, right = 4, top = 4, bottom = 4 },
        } -- "Interface/Tooltips/UI-Tooltip-Border"
    
    -- Main frame
    local nameplate
    if not frame.nameplate then
        nameplate = CreateFrame( "Frame", nil, frame )
        --nameplate:SetFrameStrata( "BACKGROUND" )
        nameplate:SetAlpha( 1 )
        nameplate:SetAllPoints( frame )
        nameplate:EnableDrawLayer( "HIGHLIGHT" )
        
        nameplate.data = {}
        nameplate.savedData = {}
        nameplate.originalWidth = floor( 221 )--frame:GetWidth() --With 4.0 width on creating is different from width on show...
        nameplate.originalHeight = floor( 55 )--frame:GetHeight() --Same for height
        nameplate.alpha = 1
        if not nameplate.number then
            frameNumberCounter = frameNumberCounter+1
            nameplate.number = frameNumberCounter
        end
        nameplate.updateCounter = 0
        frame.update = DocsUI_Nameplates.updateNameplate
        frame.onShow = DocsUI_Nameplates.onShowNameplate
        frame.onHide = DocsUI_Nameplates.onHideNameplate
        frame.setDoUpdateMe = DocsUI_Nameplates.setDoUpdateMe
        
        -- Original nameplate
        nameplate.children = {}
        local child = nameplate.children
        nameplate.regions = {}
        local reg = nameplate.regions
        child.healthBar, child.castBar = frame:GetChildren()
        
        reg.threatGlow, reg.healthBorder, reg.castBorder, reg.castNostop, reg.spellIcon, reg.highlightTexture, reg.nameText, reg.levelText, reg.dangerSkull, reg.raidIcon, reg.eliteIcon = frame:GetRegions()
        
        child.healthBar:SetStatusBarTexture( INVISIBLE_TEXTURE )
        child.castBar:SetStatusBarTexture( INVISIBLE_TEXTURE )
        
        for index,region in pairs( reg ) do region:SetParent( nameplate ) end
        
        reg.threatGlow:SetTexCoord( 0, 0, 0, 0 )
        reg.healthBorder:SetTexCoord( 0, 0, 0, 0 )
        reg.castBorder:SetTexCoord( 0, 0, 0, 0 )
        reg.castNostop:SetTexCoord( 0, 0, 0, 0 )
        nameplate.highlight = reg.highlightTexture
        nameplate.highlight:SetTexture( LSM:Fetch( "statusbar", "Doc" ) ) -- "Interface\\Buttons\\WHITE8X8"
        nameplate.highlight:SetVertexColor( 1,1,1,0.6 )
        reg.nameText:SetWidth( 000.1 )
        reg.levelText:SetWidth( 000.1 )
        reg.dangerSkull:SetTexCoord( 0, 0, 0, 0 )
        reg.raidIcon:SetAlpha( 0 )
        reg.eliteIcon:SetTexCoord( 0, 0, 0, 0 )
        
        -- Hooks
        frame:HookScript( "OnShow", function()
            frame:onShow()
        end )
        frame:HookScript( "OnHide", function()
            frame:onHide()
        end )
        
        child.healthBar:HookScript( "OnValueChanged", function()
            frame:setDoUpdateMe( "frame", "onlyHp" )
        end )
        
        --[[child.castBar:HookScript( "OnShow", function()
            frame:update()
        end )
        child.castBar:HookScript( "OnHide", function()
            frame:update()
        end )
        child.castBar:HookScript( "OnValueChanged", function()
            frame:setDoUpdateMe( "frame", "onlyCast" )
        end )]]
        local _, _, _, enabled = GetAddOnInfo( "!!!_VirtualPlates" )
        if enabled then
            child.healthBar:HookScript("OnSizeChanged", function() nameplate:SetScale( frame:GetScale() ) end) -- This is for Virtual Plates compatability
        end
    else
        nameplate = frame.nameplate
    end
    frame.nameplate = nameplate
    nameplate:SetScale( db.scale )
    
    create.name( nameplate )
    create.tot( nameplate )
    create.guild( nameplate )
    create.hp( nameplate )
    create.level( nameplate )
    create.threat( nameplate )
    create.targetHighlight( nameplate )
    create.buffs( nameplate, frame )
    create.debuffs( nameplate, frame )
    create.cast( nameplate )
    create.socialIcon( nameplate )
    create.chatIcon( nameplate )
    create.lfgIcon( nameplate )
    create.targetIcon( nameplate )
    create.alertIcon( nameplate )
    create.avoidIcon( nameplate )
    create.raidIcon( nameplate )
    create.classIcon( nameplate )
    create.roleIcon( nameplate )
    create.totemIcon( nameplate )
    create.unknownIcon( nameplate )
    create.combo( nameplate )
    create.debug( nameplate )
    --create.test( nameplate )
    
    if refresh then
        local time = GetTime()
        
        wipe( nameplate.data )
        wipe( nameplate.savedData )
        
        local buffTime = 60
        for i=1,db.buffsNumber do
            -- Test buffs
            nameplate.buffs[i].spellName = "Test"
            nameplate.buffs[i].expirationTime = time+buffTime
            nameplate.buffs[i].duration = buffTime
            nameplate.buffs[i].count = random( 0, 3 )
            nameplate.buffs[i].filter = "HELPFUL"
            
            nameplate.buffs[i].icon:SetTexture( "Interface\\Icons\\Spell_chargepositive" )
            
            nameplate.buffs[i]:Show()
            nameplate.buffs[i].visible = true
            
            -- Test debuffs
            nameplate.debuffs[i].spellName = "Test"
            nameplate.debuffs[i].expirationTime = time+buffTime
            nameplate.debuffs[i].duration = buffTime
            nameplate.debuffs[i].count = random( 0, 3 )
            nameplate.debuffs[i].filter = "HARMFUL"
            
            nameplate.debuffs[i].icon:SetTexture( "Interface\\Icons\\Spell_chargenegative" )
            
            nameplate.debuffs[i]:Show()
            nameplate.debuffs[i].visible = true
        end
        
        for i=db.buffsNumber+1,12 do
            if nameplate.buffs[i] then
                nameplate.buffs[i]:Hide()
                nameplate.buffs[i].visible = false
                
                nameplate.debuffs[i]:Hide()
                nameplate.debuffs[i].visible = false
            end
        end
    end
    
    DocsUI_Nameplates.frames[nameplate.number] = frame
    
    frame:onShow()
end