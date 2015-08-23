--[[
	Copyright (c) 2009, dr_AllCOM3
    All rights reserved.

    You're allowed to use this addon, free of monetary charge,
    but you are not allowed to modify, alter, or redistribute
    this addon without express, written permission of the author.
]]

local L = LibStub("AceLocale-3.0"):GetLocale("DocsUI_Nameplates")
local LSM = LibStub("LibSharedMedia-3.0")
local db
local temp,temp2 = nil

--[[ Print ]]
local function p( text )
	ChatFrame3:AddMessage( tostring( text ) )
end

local realmName = GetRealmName()
local realm
local resources = DocsUI_Nameplates.resources

local function processOldData()
    local s
    
    local spellList = DocsUI_Nameplates.db.global.spellList
    for index,value in pairs( spellList ) do
        if type( value )=="table" then
            s = DocsUI_Nameplates:Serialize( value.icon, value.duration and value.duration > 0 and resources.round( value.duration, 1 ) )
            
            spellList[index] = s
        end
    end
    
    local playerList = realm.playerList
    for index,value in pairs( playerList ) do
        if type( value )=="table" then
            s = DocsUI_Nameplates:Serialize( value.GUID, value.name, value.class, value.guild, value.realm )
            
            playerList[index] = s
        end
    end
    
    realm.guildList = nil
    
    db.dataConverted = 1
end

-- On Command
function DocsUI_Nameplates:Command( param )
	DocsUI_Nameplates.optionFrame.main:Show()
    
    --InterfaceOptionsFrame_OpenToCategory("DocsUI_Nameplates")
end

--[[ OnInitialize ]]
function DocsUI_Nameplates:OnInitialize()
    -- 4.01 fix
    SetCVar( "bloattest", 1 )
    SetCVar( "spreadnameplates", 0 )
    SetCVar( "bloatnameplates", 0 )
    SetCVar( "bloatthreat", 0 )
    
    -- DB
	self.db = LibStub( "AceDB-3.0" ):New( "DocsUI_NameplatesDB", self.defaults )
    self.db.RegisterCallback( self, "OnProfileChanged", DocsUI_Nameplates.OnProfileChange )
    self.db.RegisterCallback( self, "OnProfileCopied", DocsUI_Nameplates.OnProfileChange )
    self.db.RegisterCallback( self, "OnProfileReset", DocsUI_Nameplates.OnProfileChange )
    self.db.RegisterCallback( self, "OnProfileDeleted", DocsUI_Nameplates.OnProfileChange )
    
    -- Options
    self:SpawnOptions()
    if self.options then
        LibStub( "AceConfig-3.0" ):RegisterOptionsTable( "DocsNameplates", self.options )
        LibStub( "AceConfigDialog-3.0" ):AddToBlizOptions( "DocsNameplates", "DocsNameplates" )
    end
    
    -- Profiles
    local AceDBOptions = LibStub("AceDBOptions-3.0", true)
	if self.options and AceDBOptions then
		self.options.args.profiles = AceDBOptions:GetOptionsTable( self.db )
		self.options.args.profiles.order = 999
	end
    
    -- Command
    self:RegisterChatCommand("docsnp", "Command")
    self:RegisterChatCommand("np", "Command")
    
    -- LibSharedMedia
    LSM:Register("font", "Segoe UI",					        [[Interface\Addons\DocsUI_Nameplates\media\font\segoe_ui.ttf]])
    LSM:Register("font", "Segoe UI Bold",					    [[Interface\Addons\DocsUI_Nameplates\media\font\segoe_ui_bold.ttf]])
    LSM:Register("font", "Segoe UI Italic",					    [[Interface\Addons\DocsUI_Nameplates\media\font\segoe_ui_italic.ttf]])
    LSM:Register("font", "Caith",					            [[Interface\Addons\DocsUI_Nameplates\media\font\caith.ttf]])
    LSM:Register("font", "Roth",					            [[Interface\Addons\DocsUI_Nameplates\media\font\roth.ttf]])
    LSM:Register("font", "TukUI",					            [[Interface\Addons\DocsUI_Nameplates\media\font\tukui.ttf]])
    LSM:Register("font", "LUI",					                [[Interface\Addons\DocsUI_Nameplates\media\font\lui.ttf]])
    
    LSM:Register("statusbar", "Doc",			                [[Interface\Addons\DocsUI_Nameplates\media\statusbar\statusbar]])
    LSM:Register("statusbar", "Caith",					        [[Interface\Addons\DocsUI_Nameplates\media\statusbar\caith]])
    LSM:Register("statusbar", "Roth",					        [[Interface\Addons\DocsUI_Nameplates\media\statusbar\roth]])
    LSM:Register("statusbar", "TukUI",					        [[Interface\Addons\DocsUI_Nameplates\media\statusbar\tukui]])
    LSM:Register("statusbar", "LUI",					        [[Interface\Addons\DocsUI_Nameplates\media\statusbar\lui]])
    
    LSM:Register("border", "Pixel",			                    [[Interface\Addons\DocsUI_Nameplates\media\border\fer12]])
    LSM:Register("border", "Caith",					            [[Interface\Addons\DocsUI_Nameplates\media\border\caith]])
    LSM:Register("border", "Roth",					            [[Interface\Addons\DocsUI_Nameplates\media\border\roth]])
    LSM:Register("border", "TukUI",					            [[Interface\Addons\DocsUI_Nameplates\media\border\tukui]])
    LSM:Register("border", "LUI",					            [[Interface\Addons\DocsUI_Nameplates\media\border\lui]])
    
end    
    
--[[ OnEnable ]]
function DocsUI_Nameplates:OnEnable()
    db = DocsUI_Nameplates.db.profile
    realm = DocsUI_Nameplates.db.realm
    
    -- Convert pre-4.0 data
    if not db.dataConverted or db.dataConverted<1 then
        processOldData()
    end
    if realm.guildList then realm.guildList = nil end -- Delete the old 3.0 guild list.
    
    -- Register events
    self:RegisterEvent( "CVAR_UPDATE" )
    self:RegisterEvent( "PLAYER_LOGIN" )
    
    -- Other files
    self:initializeUpdater()
    
    -- CVars
    self:setVisibility()
    SetCVar( "ShowClassColorInNameplate", 1)
    SetCVar( "showVKeyCastbar", 1)
    
    -- Keybindings
    local bindingFrame = CreateFrame( "Frame" )
    temp = GetBindingKey( "NAMEPLATES" )
    if temp then SetOverrideBinding( bindingFrame, false, temp, "NAMEPLATES_OVERRIDE" ) end
    temp = GetBindingKey( "FRIENDNAMEPLATES" )
    if temp then SetOverrideBinding( bindingFrame, false, temp, "FRIENDNAMEPLATES_OVERRIDE" ) end
    temp = GetBindingKey( "ALLNAMEPLATES" )
    if temp then SetOverrideBinding( bindingFrame, false, temp, "ALLNAMEPLATES_OVERRIDE" ) end
    
    -- Choose preset
    if not db.presetChosen then
        DocsUI_Nameplates.LoadPreset()
    end
    
    -- Logo
    DocsUI_Nameplates:SpawnLogo()
end
--[[ OnDisable ]]
function DocsUI_Nameplates:OnDisable()
	
end

-- CVAR_UPDATE
function DocsUI_Nameplates:CVAR_UPDATE(event, cvar, value)
    if cvar=="UNIT_NAMEPLATES_SHOW_FRIENDS" then
        if tonumber(value)~=1 then
            SetCVar( "nameplateShowFriends", 0)
        else
            SetCVar( "nameplateShowFriends", 1)
        end
    elseif cvar=="UNIT_NAMEPLATES_SHOW_FRIENDLY_PETS" then
        if tonumber(value)~=1 then
            SetCVar( "nameplateShowFriendlyPets", 0)
        else
            SetCVar( "nameplateShowFriendlyPets", 1)
        end
    elseif cvar=="UNIT_NAMEPLATES_SHOW_FRIENDLY_GUARDIANS" then
        if tonumber(value)~=1 then
            SetCVar( "nameplateShowFriendlyGuardians", 0)
        else
            SetCVar( "nameplateShowFriendlyGuardians", 1)
        end
    elseif cvar=="UNIT_NAMEPLATES_SHOW_FRIENDLY_TOTEMS" then
        if tonumber(value)~=1 then
            SetCVar( "nameplateShowFriendlyTotems", 0)
        else
            SetCVar( "nameplateShowFriendlyTotems", 1)
        end
    elseif cvar=="UNIT_NAMEPLATES_SHOW_ENEMIES" then
        if tonumber(value)~=1 then
            SetCVar( "nameplateShowEnemies", 0)
        else
            SetCVar( "nameplateShowEnemies", 1)
        end
    elseif cvar=="UNIT_NAMEPLATES_SHOW_ENEMY_PETS" then
        if tonumber(value)~=1 then
            SetCVar( "nameplateShowEnemyPets", 0)
        else
            SetCVar( "nameplateShowEnemyPets", 1)
        end
    elseif cvar=="UNIT_NAMEPLATES_SHOW_ENEMY_GUARDIANS" then
        if tonumber(value)~=1 then
            SetCVar( "nameplateShowEnemyGuardians", 0)
        else
            SetCVar( "nameplateShowEnemyGuardians", 1)
        end
    elseif cvar=="UNIT_NAMEPLATES_SHOW_ENEMY_TOTEMS" then
        if tonumber(value)~=1 then
            SetCVar( "nameplateShowEnemyTotems", 0)
        else
            SetCVar( "nameplateShowEnemyTotems", 1)
        end
    elseif cvar=="UNIT_NAMEPLATES_ALLOW_OVERLAP" then
--~         if tonumber(value)~=1 then
--~             SetCVar( "nameplateAllowOverlap", 0)
--~         else
--~             SetCVar( "nameplateAllowOverlap", 1)
--~         end
    end
end
-- PLAYER_LOGIN
function DocsUI_Nameplates:PLAYER_LOGIN()
    
end

-- Logo
function DocsUI_Nameplates:SpawnLogo()
    local function onUpdate( self, elapsed )
        self.lastUpdate = self.lastUpdate+elapsed
        
        if self.lastUpdate>4 then
            self.alpha = self.alpha-0.05
            
            if self.alpha==0 then
                self:Hide()
                
                self.lastUpdate = 0
            else
                self:SetAlpha( self.alpha )
            end
        end
    end
    
    local frame = CreateFrame( "Frame", nil, UIParent )
    frame:SetPoint( "TOP", UIParent )
    frame:SetWidth( 512 )
    frame:SetHeight( 64 )
    frame.alpha = 1
    frame.lastUpdate = 0
    frame:SetScript( "OnUpdate", onUpdate )
    
    temp = frame:CreateTexture( nil, "OVERLAY" ) -- Logo
    temp:SetTexture( db.logo )
    temp:SetPoint( "TOP", frame, "TOP", 0, -50 )
    temp:SetTexCoord( 0, 1, 0, 0.52 )
    temp:SetWidth( 512 )
    temp:SetHeight( 64 )
    temp:SetVertexColor( 1, 1, 1, 1 )
end

-- Cpu time
function DocsUI_Nameplates:cpu()
    temp = UIParent:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
    temp:SetWidth( 300 )
    temp:SetHeight( 30 )
    temp:SetPoint( "TOP", UIParent, "TOP", -200, -20 )
    local display = temp
    
    temp = UIParent:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
    temp:SetWidth( 300 )
    temp:SetHeight( 30 )
    temp:SetPoint( "TOP", display, "BOTTOM", 0, 0 )
    local display2 = temp
    
    local function round( num, idp ) --number, decimal places
        local mult = 10^( idp or 0 )
        return math.floor( num * mult + 0.5 ) / mult
    end
    
    local lastCpu = 0
    local maxCpu = 0
    
    local frame = CreateFrame( "Frame" )
    local lastUpdate = 0
    local lastUpdate2 = 0
    local function onUpdate( self, elapsed )
        lastUpdate = lastUpdate + elapsed
        lastUpdate2 = lastUpdate2 + elapsed
        
        if lastUpdate>1 then
            UpdateAddOnCPUUsage()
            
            local cpuSelf = 0
            local total = 0
            for i=1,GetNumAddOns() do
                local name = GetAddOnInfo( i )
                
                local cpu = GetAddOnCPUUsage( name )
                
                if name=="DocsUI_Nameplates" then
                    cpuSelf = cpu
                end
                
                total = total+cpu
            end
            
            --display:SetText( round( cpuSelf/total*100, 1 ) )
            display:SetText( "DocsUI_Nameplates CPU/s: "..round( ( cpuSelf-lastCpu ), 2 ) )
            lastCpu = cpuSelf
            maxCpu = max( maxCpu, cpuSelf )
            
            lastUpdate = 0
        end
        
        if lastUpdate2>10 then
            --display2:SetText( "DocsUI_Nameplates CPU/10s: "..round( maxCpu, 2 ) )
            maxCpu = 0
            
            lastUpdate2 = 0
        end
    end
    
    frame:SetScript( "OnUpdate", onUpdate )
end

function DocsUI_Nameplates:test()
    local frames = {}
    
    for i=1,20 do
        local frame = CreateFrame( "Frame" )
        frame:SetWidth( db.fontsizeName*2 )
        frame:SetHeight( db.fontsizeName*2 )
        frame:SetPoint( "CENTER", UIParent )
        frame:SetAlpha(1)
        
        temp = frame:CreateTexture( nil, "OVERLAY" )
        temp:SetWidth( db.fontsizeName*2 )
        temp:SetHeight( db.fontsizeName*2 )
        temp:SetTexCoord( 0.1,0.9,0.1,0.9 )
        temp:SetPoint( "CENTER", frame )
        temp:SetTexture( "Interface\\Icons\\Inv_misc_questionmark" )
        
        temp = frame:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
        temp:SetWidth( db.fontsizeName*2 )
        temp:SetHeight( db.fontsizeName*2 )
        temp:SetPoint( "CENTER", frame )
        temp:SetText("A")
        frame.text = temp
        
        tinsert(frames, frame)
    end
    
    --[[
    local start = GetTime()
    p("Start")
    for i=1,100000 do
        for j=1,#frames do
            frames[j]:SetAlpha(1)
        end
    end
    p("Finished after "..GetTime()-start.."s")
    p("---")
    
    local start = GetTime()
    p("Start")
    for i=1,100000 do
        for j=1,#frames do
            if frames[j]:GetAlpha()~=1 then frames[j]:SetAlpha(1) end
        end
    end
    p("Finished after "..GetTime()-start.."s")
    p("---")
    ]]
    --[[
    local table = {}
    
    local start = GetTime()
    p("Start")
    for i=1,100000 do
        if "str"=="str" then  end
    end
    p("Finished after "..GetTime()-start.."s")
    p("---")
    
    wipe(table)
    
    local start = GetTime()
    p("Start")
    for i=1,100000 do
        if strlower("str")=="str" then  end
    end
    p("Finished after "..GetTime()-start.."s")
    p("---")
    ]]
    --[[
    for i=1,200 do
        local frame = CreateFrame( "Frame" )
        frame:SetWidth( db.fontsizeName*2 )
        frame:SetHeight( db.fontsizeName*2 )
        frame:SetPoint( "CENTER", UIParent )
        frame:SetAlpha(1)
        
        temp = frame:CreateTexture( nil, "OVERLAY" )
        temp:SetWidth( db.fontsizeName*2 )
        temp:SetHeight( db.fontsizeName*2 )
        temp:SetTexCoord( 0.1,0.9,0.1,0.9 )
        temp:SetPoint( "CENTER", frame )
        temp:SetTexture( "Interface\\Icons\\Inv_misc_questionmark" )
        
        temp = frame:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
        temp:SetWidth( db.fontsizeName*2 )
        temp:SetHeight( db.fontsizeName*2 )
        temp:SetPoint( "CENTER", frame )
        temp:SetText("A")
        frame.text = temp
        
        tinsert(frames, frame)
    end]]
    
    local t = {}
    local c = 1
    while c>#t and c<20000 do
        t[c] = true
        c=c+1
        p(c)
    end
end