--[[
	Copyright (c) 2009, dr_AllCOM3
    All rights reserved.

    You're allowed to use this addon, free of monetary charge,
    but you are not allowed to modify, alter, or redistribute
    this addon without express, written permission of the author.
]]

local L = LibStub("AceLocale-3.0"):GetLocale("DocsUI_Nameplates")
local LSM = LibStub("LibSharedMedia-3.0")
local temp, temp2 = nil

--[[ Print ]]
local function p( text )
	ChatFrame3:AddMessage( tostring( text ) )
end

local db, global
local resources = DocsUI_Nameplates.resources
local optionFrames = {}
local greyTone = 0.15
local optionWidth = 150
local optionHeight = 20
local fontSizeTitle = 14
local fontSizeOption = 11
local borderSize = 10
DocsUI_Nameplates.configMode = false
local presetFrame

local font, fontb, fonti
local locale = GetLocale()
if locale=="enUS" or locale=="deDE" or locale=="frFR" then
    font = "Interface\\Addons\\DocsUI_Nameplates\\media\\font\\segoe_ui.ttf"
    fontb = "Interface\\Addons\\DocsUI_Nameplates\\media\\font\\segoe_ui_bold.ttf"
    fonti = "Interface\\Addons\\DocsUI_Nameplates\\media\\font\\segoe_ui_italic.ttf"
elseif locale=="koKR" then
    font = "Fonts\\2002.TTF"
    fontb = "Fonts\\2002B.TTF"
    fonti = "Fonts\\2002.TTF"
else
    font = "Fonts\\FRIZQT__.TTF"
    fontb = "Fonts\\FRIZQT__.TTF"
    fonti = "Fonts\\FRIZQT__.TTF"
end

local function presetDone()
    db.presetChosen = DocsUI_Nameplates.version
end

local function filterAddOnClick( self ) -- When clicking on the filter add button
    local name = db.buffFilter.filterName
    local my = db.buffFilter.filterOnlyMy
    local buff = db.buffFilter.filterBuff
    local debuff = db.buffFilter.filterDebuff
    local never = db.buffFilter.filterNeverShow
    local high = db.buffFilter.filterHigh
    local medium = db.buffFilter.filterMedium
    local low = db.buffFilter.filterLow
    local priority
    local list
    
    if not name or name=="" then return end
    
    if buff then
        if my then
            list = db.buffFilter.buffs.my
        elseif never then
            list = db.buffFilter.buffs.never
        else
            list = db.buffFilter.buffs.any
        end
    elseif debuff then
        if my then
            list = db.buffFilter.debuffs.my
        elseif never then
            list = db.buffFilter.debuffs.never
        else
            list = db.buffFilter.debuffs.any
        end
    end
    
    if high then
        priority = 3
    elseif medium then
        priority = 2
    else
        priority = 1
    end
    
    list[name] = priority
end

local function loadPresetBlizzard() -- Defaults to load for preset "Blizzard"
    db.font = "Friz Quadrata TT"
    db.fontb = "Friz Quadrata TT"
    db.fonti = "Friz Quadrata TT"
    db.texture = "Blizzard"
    db.border = "Blizzard Tooltip"
    db.borderColor = {r=0.4,g=0.4,b=0.4,a=1}
    if presetFrame.healthbar then
        db.showHpBar = true
        db.fontsizeHealth = 11
    end
    
    -- Follow up
    DocsUI_Nameplates:refreshNameplateLayouts()
    presetFrame:Hide()
end

local function loadPresetDoc() -- Defaults to load for preset "Doc"
    db.font = "Segoe UI"
    db.fontb = "Segoe UI Bold"
    db.fonti = "Segoe UI Italic"
    db.texture = "Doc"
    db.border = "Pixel"
    db.borderColor = {r=0,g=0,b=0,a=1}
    if presetFrame.healthbar then
        db.showHpBar = true
        db.fontsizeHealth = 11
    end
    
    -- Follow up
    DocsUI_Nameplates:refreshNameplateLayouts()
    presetFrame:Hide()
end

local function loadPresetCaith() -- Defaults to load for preset "Caith"
    db.font = "Caith"
    db.fontb = "Caith"
    db.fonti = "Caith"
    db.texture = "Caith"
    db.border = "Caith"
    db.borderColor = {r=1,g=1,b=1,a=1}
    if presetFrame.healthbar then
        db.showHpBar = true
        db.fontsizeHealth = 11
    end
    
    -- Follow up
    DocsUI_Nameplates:refreshNameplateLayouts()
    presetFrame:Hide()
end

local function loadPresetRoth() -- Defaults to load for preset "Roth"
    db.font = "Roth"
    db.fontb = "Roth"
    db.fonti = "Roth"
    db.texture = "Roth"
    db.border = "Roth"
    db.borderColor = {r=1,g=1,b=1,a=1}
    if presetFrame.healthbar then
        db.showHpBar = true
        db.fontsizeHealth = 11
    end
    
    -- Follow up
    DocsUI_Nameplates:refreshNameplateLayouts()
    presetFrame:Hide()
end

local function loadPresetLui() -- Defaults to load for preset "LUI"
    db.font = "LUI"
    db.fontb = "LUI"
    db.fonti = "LUI"
    db.texture = "LUI"
    db.border = "LUI"
    db.borderColor = {r=0,g=0,b=0,a=1}
    if presetFrame.healthbar then
        db.showHpBar = true
        db.fontsizeHealth = 11
    end
    
    -- Follow up
    DocsUI_Nameplates:refreshNameplateLayouts()
    presetFrame:Hide()
end

local function loadPresetTukui() -- Defaults to load for preset "TukUI"
    db.font = "TukUI"
    db.fontb = "TukUI"
    db.fonti = "TukUI"
    db.texture = "TukUI"
    db.border = "TukUI"
    db.borderColor = {r=0,g=0,b=0,a=1}
    if presetFrame.healthbar then
        db.showHpBar = true
        db.fontsizeHealth = 11
    end
    
    -- Follow up
    DocsUI_Nameplates:refreshNameplateLayouts()
    presetFrame:Hide()
end

local function spawnPresetFrame()
    local width = 256
    local height = 64
    
    presetFrame = CreateFrame( "Frame", "DocsUI_Nameplates_preset", UIParent )
    presetFrame:SetAlpha( 1 )
    presetFrame:SetPoint( "TOPLEFT", UIParent )
    presetFrame:SetPoint( "BOTTOMRIGHT", UIParent )
    presetFrame:EnableMouse( true )
    presetFrame:SetFrameStrata( "FULLSCREEN_DIALOG" ) 
    --tinsert( UISpecialFrames, presetFrame:GetName() )
    presetFrame:Hide()
    
    temp = presetFrame:CreateTexture( nil, "BACKGROUND" )
    temp:SetTexture( db.bg )
    temp:SetAllPoints( presetFrame )
    temp:SetVertexColor( 0, 0, 0, 0.75 )
    
    temp = CreateFrame( "Button", nil, presetFrame, "OptionsButtonTemplate" ) -- Close button
    temp:SetWidth( 80 )
    temp:SetHeight( 22 )
    temp:SetPoint( "TOPRIGHT", presetFrame, "TOPRIGHT", -20, -20 )
    temp:SetText( CLOSE )
    temp:SetScript( "OnClick", function( self )
        presetFrame:Hide()
        presetDone()
    end )
    
    temp = presetFrame:CreateTexture( nil, "OVERLAY" ) -- Logo
    temp:SetTexture( db.logo )
    temp:SetPoint( "TOP", presetFrame, "TOP", 0, -10 )
    temp:SetTexCoord( 0, 1, 0, 0.52 )
    temp:SetWidth( 512 )
    temp:SetHeight( 64 )
    temp:SetVertexColor( 1, 1, 1, 1 )
    
    -- Doc
    local doc = CreateFrame( "Button", nil, presetFrame )
    temp = doc
    temp:SetWidth( width*2+10 )
    temp:SetHeight( height*2+10 )
    temp:SetPoint( "TOP", presetFrame, "TOP", 0, -100 )
    temp:SetScript( "OnClick", function( self )
        loadPresetDoc()
        presetDone()
    end )
    temp:SetScript( "OnEnter", function( self )
        doc.highlight:Show()
    end )
    temp:SetScript( "OnLeave", function() doc.highlight:Hide() end )
    
    temp = doc:CreateTexture( nil, "BACKGROUND" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\preset\\doc" )
    temp:SetAllPoints( doc )
    temp:SetVertexColor( 1, 1, 1, 1 )
    
    temp = doc:CreateTexture( nil, "OVERLAY" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\preset\\doch" )
    temp:SetAllPoints( doc )
    temp:SetVertexColor( 1, 1, 1, 1 )
    temp:Hide()
    doc.highlight = temp
    
    -- Blizzard
    local blizzard = CreateFrame( "Button", nil, presetFrame )
    temp = blizzard
    temp:SetWidth( width )
    temp:SetHeight( height )
    temp:SetPoint( "TOPLEFT", doc, "BOTTOMLEFT", 0, -10 )
    temp:SetScript( "OnClick", function( self )
        loadPresetBlizzard()
        presetDone()
    end )
    temp:SetScript( "OnEnter", function( self )
        blizzard.highlight:Show()
    end )
    temp:SetScript( "OnLeave", function() blizzard.highlight:Hide() end )
    
    temp = blizzard:CreateTexture( nil, "BACKGROUND" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\preset\\blizzard" )
    temp:SetAllPoints( blizzard )
    temp:SetVertexColor( 1, 1, 1, 1 )
    
    temp = blizzard:CreateTexture( nil, "OVERLAY" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\preset\\blizzardh" )
    temp:SetAllPoints( blizzard )
    temp:SetVertexColor( 1, 1, 1, 1 )
    temp:Hide()
    blizzard.highlight = temp
    
    -- Caith
    local caith = CreateFrame( "Button", nil, presetFrame )
    temp = caith
    temp:SetWidth( width )
    temp:SetHeight( height )
    temp:SetPoint( "TOPRIGHT", doc, "BOTTOMRIGHT", 0, -10 )
    temp:SetScript( "OnClick", function( self )
        loadPresetCaith()
        presetDone()
    end )
    temp:SetScript( "OnEnter", function( self )
        caith.highlight:Show()
    end )
    temp:SetScript( "OnLeave", function() caith.highlight:Hide() end )
    
    temp = caith:CreateTexture( nil, "BACKGROUND" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\preset\\caith" )
    temp:SetAllPoints( caith )
    temp:SetVertexColor( 1, 1, 1, 1 )
    
    temp = caith:CreateTexture( nil, "OVERLAY" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\preset\\caithh" )
    temp:SetAllPoints( caith )
    temp:SetVertexColor( 1, 1, 1, 1 )
    temp:Hide()
    caith.highlight = temp
    
    -- Roth
    local roth = CreateFrame( "Button", nil, presetFrame )
    temp = roth
    temp:SetWidth( width )
    temp:SetHeight( height )
    temp:SetPoint( "TOPLEFT", blizzard, "BOTTOMLEFT", 0, -10 )
    temp:SetScript( "OnClick", function( self )
        loadPresetRoth()
        db.presetChosen = 1
    end )
    temp:SetScript( "OnEnter", function( self )
        roth.highlight:Show()
    end )
    temp:SetScript( "OnLeave", function() roth.highlight:Hide() end )
    
    temp = roth:CreateTexture( nil, "BACKGROUND" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\preset\\roth" )
    temp:SetAllPoints( roth )
    temp:SetVertexColor( 1, 1, 1, 1 )
    
    temp = roth:CreateTexture( nil, "OVERLAY" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\preset\\rothh" )
    temp:SetAllPoints( roth )
    temp:SetVertexColor( 1, 1, 1, 1 )
    temp:Hide()
    roth.highlight = temp
    
    -- LUI
    local lui = CreateFrame( "Button", nil, presetFrame )
    temp = lui
    temp:SetWidth( width )
    temp:SetHeight( height )
    temp:SetPoint( "TOPRIGHT", caith, "BOTTOMRIGHT", 0, -10 )
    temp:SetScript( "OnClick", function( self )
        loadPresetLui()
        presetDone()
    end )
    temp:SetScript( "OnEnter", function( self )
        lui.highlight:Show()
    end )
    temp:SetScript( "OnLeave", function() lui.highlight:Hide() end )
    
    temp = lui:CreateTexture( nil, "BACKGROUND" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\preset\\lui" )
    temp:SetAllPoints( lui )
    temp:SetVertexColor( 1, 1, 1, 1 )
    
    temp = lui:CreateTexture( nil, "OVERLAY" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\preset\\luih" )
    temp:SetAllPoints( lui )
    temp:SetVertexColor( 1, 1, 1, 1 )
    temp:Hide()
    lui.highlight = temp
    
    -- Tuk UI
    local tukui = CreateFrame( "Button", nil, presetFrame )
    temp = tukui
    temp:SetWidth( width )
    temp:SetHeight( height )
    temp:SetPoint( "TOPLEFT", roth, "BOTTOMLEFT", 0, -10 )
    temp:SetScript( "OnClick", function( self )
        loadPresetTukui()
        presetDone()
    end )
    temp:SetScript( "OnEnter", function( self )
        tukui.highlight:Show()
    end )
    temp:SetScript( "OnLeave", function() tukui.highlight:Hide() end )
    
    temp = tukui:CreateTexture( nil, "BACKGROUND" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\preset\\tukui" )
    temp:SetAllPoints( tukui )
    temp:SetVertexColor( 1, 1, 1, 1 )
    
    temp = tukui:CreateTexture( nil, "OVERLAY" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\preset\\tukuih" )
    temp:SetAllPoints( tukui )
    temp:SetVertexColor( 1, 1, 1, 1 )
    temp:Hide()
    tukui.highlight = temp
    
    -- Healthbar
    temp = CreateFrame( "CheckButton", nil, presetFrame, "OptionsCheckButtonTemplate" )
    temp:SetWidth( 64 )
    temp:SetHeight( 64 )
    temp:SetHitRectInsets(0, -width+64, 0, 0)
    temp:SetPoint( "TOPLEFT", presetFrame, "TOP", -width/3, -500 )
    local function onClick( self, button, down )
        local checked = self:GetChecked()
        
        presetFrame.healthbar = checked
    end
    temp:SetScript( "OnClick", onClick )
    temp:SetScript( "OnShow", function( self )
        self:SetChecked( false )
    end )
    temp:SetScript( "OnEnter", function( self )
        GameTooltip:SetOwner( self, "ANCHOR_LEFT" )
        GameTooltip:AddLine( "" )
        GameTooltip:Show()
    end )
    temp:SetScript( "OnLeave", function() GameTooltip:Hide() end )
    presetFrame.button = temp
    local button = temp
    
    temp = presetFrame:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
    temp:SetWidth( width*2-64 )
    temp:SetHeight( 64 )
    temp:SetPoint( "LEFT", button, "RIGHT", 0, 0 )
    temp:SetFont( font, fontSizeTitle*2 )
    temp:SetJustifyH( "LEFT" )
    temp:SetJustifyV( "CENTER" )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    temp:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
    temp:SetText( L["I want a healthbar"] )
end

function DocsUI_Nameplates:LoadPreset() -- Load preset
    InterfaceOptionsFrame:Hide()
    presetFrame:Show()
end

local info = {}
local function textureDropDownMenu( self, level ) -- Statusbar
    if not level then return end
    wipe( info )
    
    local list = LSM:List( "statusbar" )
    
    if level==1 then
        info.text = CLOSE
        info.notCheckable = 1
        UIDropDownMenu_AddButton( info, level )
        
        for i=1,ceil( #list/10 ) do
            -- Create the title of the menu
            info.text = i
            info.notCheckable = 1
            info.hasArrow = 1
            info.value = i
            UIDropDownMenu_AddButton( info, level )
        end
    elseif level==2 then
        for i=( UIDROPDOWNMENU_MENU_VALUE-1 )*10+1,min( UIDROPDOWNMENU_MENU_VALUE*10, #list ) do
            -- Create the title of the menu
            info.text = list[i]
            info.notCheckable = 1
            info.func = function()
                db.texture = list[i]
                
                -- Follow up
                DocsUI_Nameplates:refreshNameplateLayouts()
            end
            UIDropDownMenu_AddButton( info, level )
        end
    end
end

local function borderDropDownMenu( self, level ) -- Statusbar
    if not level then return end
    wipe( info )
    
    local list = LSM:List( "border" )
    
    if level==1 then
        info.text = CLOSE
        info.notCheckable = 1
        UIDropDownMenu_AddButton( info, level )
        
        for i=1,ceil( #list/10 ) do
            -- Create the title of the menu
            info.text = i
            info.notCheckable = 1
            info.hasArrow = 1
            info.value = i
            UIDropDownMenu_AddButton( info, level )
        end
    elseif level==2 then
        for i=( UIDROPDOWNMENU_MENU_VALUE-1 )*10+1,min( UIDROPDOWNMENU_MENU_VALUE*10, #list ) do
            -- Create the title of the menu
            info.text = list[i]
            info.notCheckable = 1
            info.func = function()
                db.border = list[i]
                
                -- Follow up
                DocsUI_Nameplates:refreshNameplateLayouts()
            end
            UIDropDownMenu_AddButton( info, level )
        end
    end
end

local function fontDropDownMenu( self, level ) -- Font
    if not level then return end
    wipe( info )
    
    local list = LSM:List( "font" )
    
    if level==1 then
        info.text = CLOSE
        info.notCheckable = 1
        UIDropDownMenu_AddButton( info, level )
        
        for i=1,ceil( #list/10 ) do
            -- Create the title of the menu
            info.text = i
            info.notCheckable = 1
            info.hasArrow = 1
            info.value = i
            UIDropDownMenu_AddButton( info, level )
        end
    elseif level==2 then
        for i=( UIDROPDOWNMENU_MENU_VALUE-1 )*10+1,min( UIDROPDOWNMENU_MENU_VALUE*10, #list ) do
            -- Create the title of the menu
            info.text = list[i]
            info.notCheckable = 1
            info.func = function()
                db.font = list[i]
                
                -- Follow up
                DocsUI_Nameplates:refreshNameplateLayouts()
            end
            UIDropDownMenu_AddButton( info, level )
        end
    end
end

local function fontbDropDownMenu( self, level ) -- Font Bold
    if not level then return end
    wipe( info )
    
    local list = LSM:List( "font" )
    
    if level==1 then
        info.text = CLOSE
        info.notCheckable = 1
        UIDropDownMenu_AddButton( info, level )
        
        for i=1,ceil( #list/10 ) do
            -- Create the title of the menu
            info.text = i
            info.notCheckable = 1
            info.hasArrow = 1
            info.value = i
            UIDropDownMenu_AddButton( info, level )
        end
    elseif level==2 then
        for i=( UIDROPDOWNMENU_MENU_VALUE-1 )*10+1,min( UIDROPDOWNMENU_MENU_VALUE*10, #list ) do
            -- Create the title of the menu
            info.text = list[i]
            info.notCheckable = 1
            info.func = function()
                db.fontb = list[i]
                
                -- Follow up
                DocsUI_Nameplates:refreshNameplateLayouts()
            end
            UIDropDownMenu_AddButton( info, level )
        end
    end
end

local function fontiDropDownMenu( self, level ) -- Font Italic
    if not level then return end
    wipe( info )
    
    local list = LSM:List( "font" )
    
    if level==1 then
        info.text = CLOSE
        info.notCheckable = 1
        UIDropDownMenu_AddButton( info, level )
        
        for i=1,ceil( #list/10 ) do
            -- Create the title of the menu
            info.text = i
            info.notCheckable = 1
            info.hasArrow = 1
            info.value = i
            UIDropDownMenu_AddButton( info, level )
        end
    elseif level==2 then
        for i=( UIDROPDOWNMENU_MENU_VALUE-1 )*10+1,min( UIDROPDOWNMENU_MENU_VALUE*10, #list ) do
            -- Create the title of the menu
            info.text = list[i]
            info.notCheckable = 1
            info.func = function()
                db.fonti = list[i]
                
                -- Follow up
                DocsUI_Nameplates:refreshNameplateLayouts()
            end
            UIDropDownMenu_AddButton( info, level )
        end
    end
end

local function outlineDropDownMenu( self, level ) -- Outline
    if not level then return end
    wipe( info )
    
    if level==1 then
        info.text = L["None"]
        info.notCheckable = 1
        --info.fontObject = nil
        info.func = function()
            db.outline = "NONE"
            
            -- Follow up
            DocsUI_Nameplates:refreshNameplateLayouts()
        end
        UIDropDownMenu_AddButton( info, level )
        
        info.text = L["Thin outline"]
        info.notCheckable = 1
        --info.fontObject = nil
        info.func = function()
            db.outline = "OUTLINE"
            
            -- Follow up
            DocsUI_Nameplates:refreshNameplateLayouts()
        end
        UIDropDownMenu_AddButton( info, level )
        
        info.text = L["Thick outline"]
        info.notCheckable = 1
        --info.fontObject = nil
        info.func = function()
            db.outline = "THICKOUTLINE"
            
            -- Follow up
            DocsUI_Nameplates:refreshNameplateLayouts()
        end
        UIDropDownMenu_AddButton( info, level )
    end
end

local function deleteBuffsDropDownMenu( self, level ) -- Delete Buffs
    if not level then return end
    wipe( info )
    
    if level==1 then
        info.text = CLOSE
        info.notCheckable = 1
        UIDropDownMenu_AddButton( info, level )
        
        info.text = "--- "..L["My"]
        info.notCheckable = 1
        UIDropDownMenu_AddButton( info, level )
        for i,v in pairs( db.buffFilter.buffs.my ) do
            info.text = "  "..i.." ("..v..")"
            info.notCheckable = 1
            info.arg1 = i
            info.arg2 = v
            info.func = function( self, arg1, arg2 )
                db.buffFilter.buffs.my[arg1] = nil
            end
            UIDropDownMenu_AddButton( info, level )
        end
        
        info.text = "--- "..L["Any"]
        info.notCheckable = 1
        UIDropDownMenu_AddButton( info, level )
        for i,v in pairs( db.buffFilter.buffs.any ) do
            info.text = "  "..i.." ("..v..")"
            info.notCheckable = 1
            info.arg1 = i
            info.arg2 = v
            info.func = function( self, arg1, arg2 )
                db.buffFilter.buffs.any[arg1] = nil
            end
            UIDropDownMenu_AddButton( info, level )
        end
        
        info.text = "--- "..L["Never show"]
        info.notCheckable = 1
        UIDropDownMenu_AddButton( info, level )
        for i,v in pairs( db.buffFilter.buffs.never ) do
            info.text = "  "..i.." ("..v..")"
            info.notCheckable = 1
            info.arg1 = i
            info.arg2 = v
            info.func = function( self, arg1, arg2 )
                db.buffFilter.buffs.never[arg1] = nil
            end
            UIDropDownMenu_AddButton( info, level )
        end
    end
end

local function deleteDebuffsDropDownMenu( self, level ) -- Delete Buffs
    if not level then return end
    wipe( info )
    
    if level==1 then
        info.text = CLOSE
        info.notCheckable = 1
        UIDropDownMenu_AddButton( info, level )
        
        info.text = "--- "..L["My"]
        info.notCheckable = 1
        UIDropDownMenu_AddButton( info, level )
        for i,v in pairs( db.buffFilter.debuffs.my ) do
            info.text = "  "..i.." ("..v..")"
            info.notCheckable = 1
            info.arg1 = i
            info.arg2 = v
            info.func = function( self, arg1, arg2 )
                db.buffFilter.debuffs.my[arg1] = nil
            end
            UIDropDownMenu_AddButton( info, level )
        end
        
        info.text = "--- "..L["Any"]
        info.notCheckable = 1
        UIDropDownMenu_AddButton( info, level )
        for i,v in pairs( db.buffFilter.debuffs.any ) do
            info.text = "  "..i.." ("..v..")"
            info.notCheckable = 1
            info.arg1 = i
            info.arg2 = v
            info.func = function( self, arg1, arg2 )
                db.buffFilter.debuffs.any[arg1] = nil
            end
            UIDropDownMenu_AddButton( info, level )
        end
        
        info.text = "--- "..L["Never show"]
        info.notCheckable = 1
        UIDropDownMenu_AddButton( info, level )
        for i,v in pairs( db.buffFilter.debuffs.never ) do
            info.text = "  "..i.." ("..v..")"
            info.notCheckable = 1
            info.arg1 = i
            info.arg2 = v
            info.func = function( self, arg1, arg2 )
                db.buffFilter.debuffs.never[arg1] = nil
            end
            UIDropDownMenu_AddButton( info, level )
        end
    end
end

local function deleteHiderDropDownMenu( self, level ) -- Delete hider entry
    if not level then return end
    wipe( info )
    
    if level==1 then
        info.text = CLOSE
        info.notCheckable = 1
        UIDropDownMenu_AddButton( info, level )
        
        for i,v in pairs( global.nameplateHider ) do
            info.text = i
            info.notCheckable = 1
            info.arg1 = i
            info.arg2 = v
            info.func = function( self, arg1, arg2 )
                global.nameplateHider[arg1] = nil
                
                -- Follow up
                DocsUI_Nameplates:refreshNameplateLayouts()
            end
            UIDropDownMenu_AddButton( info, level )
        end
    end
end

local function deleteReplacerDropDownMenu( self, level ) -- Delete replacer entry
    if not level then return end
    wipe( info )
    
    if level==1 then
        info.text = CLOSE
        info.notCheckable = 1
        UIDropDownMenu_AddButton( info, level )
        
        for i,v in pairs( global.nameReplacer ) do
            info.text = i..","..v
            info.notCheckable = 1
            info.arg1 = i
            info.arg2 = v
            info.func = function( self, arg1, arg2 )
                global.nameReplacer[arg1] = nil
                
                -- Follow up
                DocsUI_Nameplates:refreshNameplateLayouts()
            end
            UIDropDownMenu_AddButton( info, level )
        end
    end
end

local function deleteLFGDropDownMenu( self, level ) -- Delete replacer entry
    if not level then return end
    wipe( info )
    
    if level==1 then
        info.text = CLOSE
        info.notCheckable = 1
        UIDropDownMenu_AddButton( info, level )
        
        for i=1,#global.LFGList do
            info.text = global.LFGList[i]
            info.notCheckable = 1
            info.arg1 = i
            info.func = function( self, arg1 )
                global.LFGList[arg1] = nil
                
                -- Follow up
                DocsUI_Nameplates:refreshNameplateLayouts()
            end
            UIDropDownMenu_AddButton( info, level )
        end
    end
end

local function spawnContainer( self )
    temp = CreateFrame( "Frame", nil, self )
    temp:SetWidth( optionWidth+2*borderSize )
    temp:SetHeight( optionHeight*1+2*borderSize )
    --temp:SetPoint( "TOPLEFT", self, 50, -64 )
    temp:EnableMouse( true )
    temp:SetAlpha( 1 )
    --DocsUI_Nameplates.setBorder( temp )
    temp:SetScript( "OnShow", function( self )
        local max = #self.options
        
        if max<1 then
            self:SetWidth( optionWidth+2*borderSize )
            self:SetHeight( optionHeight*1+2*borderSize )
        else
            self:SetWidth( optionWidth+2*borderSize )
            self:SetHeight( optionHeight*max+2*borderSize )
        end
    end )
    local frame = temp
    frame.options = {}
    
    temp = frame:CreateTexture( nil, "BACKGROUND" )
    temp:SetTexture( db.bg )
    temp:SetAllPoints( frame )
    temp:SetVertexColor( greyTone, greyTone, greyTone, 1 )
    frame.bg = temp
    
    return frame
end

local function spawnTitle( self, title )
    title = title or "Title NYI"
    
    temp = self:CreateFontString( nil, "OVERLAY" )
    temp:SetWidth( optionWidth )
    temp:SetHeight( optionHeight )
    if #self.options>0 then
        temp:SetPoint( "TOPLEFT", self.options[#self.options], "BOTTOMLEFT", 0, 0 )
    else
        temp:SetPoint( "TOPLEFT", self, "TOPLEFT", borderSize, -borderSize )
    end
    temp:SetFont( fontb, fontSizeTitle )
    temp:SetJustifyH( "LEFT" )
    temp:SetJustifyV( "CENTER" )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    temp:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
    temp:SetText( title )
    
    tinsert( self.options, temp )
end

local function spawnText( self, text )
    text = text or "Text NYI"
    
    temp = self:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
    temp:SetWidth( optionWidth )
    temp:SetHeight( optionHeight )
    if #self.options>0 then
        temp:SetPoint( "TOPLEFT", self.options[#self.options], "BOTTOMLEFT", 0, 0 )
    else
        temp:SetPoint( "TOPLEFT", self, "TOPLEFT", borderSize, -borderSize )
    end
    temp:SetFont( font, fontSizeOption )
    temp:SetJustifyH( "LEFT" )
    temp:SetJustifyV( "CENTER" )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    temp:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
    temp:SetText( text )
    
    tinsert( self.options, temp )
end

local function spawnCheckbox( self, text, database, key, tooltip, group )
    text = text or "Text NYI"
    database = database or {}
    key = key or "test"
    tooltip = tooltip or "Tooltip NYI"
    local parent = self
    
    temp = CreateFrame( "Frame", nil, self )
    temp:SetWidth( optionWidth )
    temp:SetHeight( optionHeight )
    if #self.options>0 then
        temp:SetPoint( "TOPLEFT", self.options[#self.options], "BOTTOMLEFT", 0, 0 )
    else
        temp:SetPoint( "TOPLEFT", self, "TOPLEFT", borderSize, -borderSize )
    end
    temp:SetAlpha( 1 )
    local frame = temp
    
    if group then frame.group = group end
    frame.database = database
    frame.key = key
    
    temp = CreateFrame( "CheckButton", nil, frame, "OptionsCheckButtonTemplate" )
    temp:SetWidth( optionHeight )
    temp:SetHeight( optionHeight )
    temp:SetHitRectInsets(0, -optionWidth+optionHeight, 0, 0)
    temp:SetPoint( "LEFT", frame, "LEFT", 0, 0 )
    local function onClick( self, button, down )
        local checked = self:GetChecked()
        
        for i=1,#parent.options do
            if parent.options[i].group and parent.options[i].group==group then
                parent.options[i].button:SetChecked( nil )
                parent.options[i].database[parent.options[i].key] = parent.options[i].button:GetChecked() or false
            end
        end
        
        database[key] = checked or false -- Do not make option==nil or the default value will be loaded again!
        
        self:SetChecked( database[key] )
        
        -- Follow up
        DocsUI_Nameplates:refreshNameplateLayouts()
    end
    temp:SetScript( "OnClick", onClick )
    temp:SetScript( "OnShow", function( self )
        self:SetChecked( database[key] )
    end )
    temp:SetScript( "OnEnter", function( self )
        GameTooltip:SetOwner( self, "ANCHOR_LEFT" )
        GameTooltip:AddLine( tooltip )
        GameTooltip:Show()
    end )
    temp:SetScript( "OnLeave", function() GameTooltip:Hide() end )
    frame.button = temp
    local button = temp
    
    temp = frame:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
    temp:SetWidth( optionWidth-optionHeight )
    temp:SetHeight( optionHeight )
    temp:SetPoint( "LEFT", button, "RIGHT", 0, 0 )
    temp:SetFont( font, fontSizeOption )
    temp:SetJustifyH( "LEFT" )
    temp:SetJustifyV( "CENTER" )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    temp:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
    temp:SetText( text )
    
    tinsert( self.options, frame )
end

local function spawnDropdown( self, text, tooltip, dropDownFunction )
    text = text or "Text NYI"
    database = database or {}
    key = key or "test"
    tooltip = tooltip or "Tooltip NYI"
    local parent = self
    local name = key.."DropDownMenu"
    
    local dropDown = CreateFrame( "Frame", nil )
    dropDown.displayMode = "MENU"
    dropDown.initialize = dropDownFunction or nil
    
    temp = CreateFrame( "Button", nil, self )
    temp:SetWidth( optionWidth )
    temp:SetHeight( optionHeight )
    if #self.options>0 then
        temp:SetPoint( "TOPLEFT", self.options[#self.options], "BOTTOMLEFT", 0, 0 )
    else
        temp:SetPoint( "TOPLEFT", self, "TOPLEFT", borderSize, -borderSize )
    end
    temp:SetAlpha( 1 )
    temp:SetScript( "OnClick", function( self )
        ToggleDropDownMenu( 1, nil, dropDown, self, 0, 0 )
    end )
    temp:SetScript( "OnEnter", function( self )
        GameTooltip:SetOwner( self, "ANCHOR_LEFT" )
        GameTooltip:AddLine( tooltip )
        GameTooltip:Show()
    end )
    temp:SetScript( "OnLeave", function() GameTooltip:Hide() end )
    local frame = temp
    
    temp = frame:CreateTexture( nil, "BACKGROUND" )
    temp:SetWidth( optionHeight )
    temp:SetHeight( optionHeight )
    temp:SetTexture( "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up" )
    temp:SetPoint( "LEFT", frame, "LEFT", 0, 0 )
    frame.bg = temp
    local bg = temp
    
    temp = frame:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
    temp:SetWidth( optionWidth-optionHeight )
    temp:SetHeight( optionHeight )
    temp:SetPoint( "LEFT", bg, "RIGHT", 0, 0 )
    temp:SetFont( font, fontSizeOption )
    temp:SetJustifyH( "LEFT" )
    temp:SetJustifyV( "CENTER" )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    temp:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
    temp:SetText( text )
    
    tinsert( self.options, frame )
end

local function spawnSlider( self, text, variable, tooltip, min, max, step )
    text = text or "Text NYI"
    database = database or {}
    key = key or nil
    tooltip = tooltip or "Tooltip NYI"
    if min==1 then min = 2 end
    step = step or 1
    
    temp = CreateFrame( "Frame", nil, self )
    temp:SetWidth( optionWidth )
    temp:SetHeight( optionHeight*1 )
    if #self.options>0 then
        temp:SetPoint( "TOPLEFT", self.options[#self.options], "BOTTOMLEFT", 0, 0 )
    else
        temp:SetPoint( "TOPLEFT", self, "TOPLEFT", borderSize, -borderSize )
    end
    temp:SetAlpha( 1 )
    local frame = temp
    
    if variable then frame.variable = variable end
    
    temp = CreateFrame( "Slider", "DocsUI_Nameplates_slider_"..variable, frame, "OptionsSliderTemplate" )
    temp:EnableMouseWheel( true )
    temp:SetWidth( optionWidth )
    temp:SetHeight( optionHeight*0.5 )
    temp:SetPoint( "LEFT", frame, "LEFT", 0, 0 )
    temp:SetMinMaxValues( min, max )
    temp:SetValueStep( step )
    temp:SetValue( db[frame.variable] )
    local function onValueChanged( self, stp )
        db[frame.variable] = resources.round( self:GetValue(), 3 )
        
        getglobal( frame.slider:GetName() .. "Text" ):SetText( text.." ("..db[frame.variable]..")" )
        
        -- Follow up
        DocsUI_Nameplates:refreshNameplateLayouts()
    end
    local function onMouseWheel( self, stp )
        stp = resources.round( step*stp, 3 )
            
        if ( db[frame.variable]+stp )<min or ( db[frame.variable]+stp )>max then
            db[frame.variable] = db[frame.variable]
        else
            db[frame.variable] = db[frame.variable]+stp
        end
        
        frame.slider:SetValue( db[frame.variable] )
        
        getglobal( frame.slider:GetName() .. "Text" ):SetText( text.." ("..db[frame.variable]..")" )
        
        -- Follow up
        DocsUI_Nameplates:refreshNameplateLayouts()
    end
    temp:SetScript( "OnValueChanged", onValueChanged )
    temp:SetScript( "OnMouseWheel", onMouseWheel )
    temp:SetScript( "OnShow", function( self )
        frame.slider:SetValue( db[frame.variable] )
        
        getglobal( frame.slider:GetName() .. "Text" ):SetText( text.." ("..db[frame.variable]..")" )
    end )
    temp:SetScript( "OnEnter", function( self )
        GameTooltip:SetOwner( self, "ANCHOR_BOTTOMRIGHT" )
        GameTooltip:AddLine( tooltip )
        GameTooltip:Show()
    end )
    temp:SetScript( "OnLeave", function() GameTooltip:Hide() end )
    frame.slider = temp
    
    temp = getglobal( frame.slider:GetName() .. "Low" )
    temp:SetText( min )
    temp:SetFont( font, fontSizeOption-1 )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    temp:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
    
    temp = getglobal( frame.slider:GetName() .. "High" )
    temp:SetText( max )
    temp:SetFont( font, fontSizeOption-1 )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    temp:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
    
    temp = getglobal( frame.slider:GetName() .. "Text" )
    temp:SetText( text.." ("..frame.slider:GetValue()..")" )
    temp:SetFont( font, fontSizeOption )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    temp:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
    
    tinsert( self.options, frame )
end

local function spawnColorpicker( self, text, database, key, tooltip )
    text = text or "Text NYI"
    database = database or {}
    key = key or "test"
    tooltip = tooltip or "Tooltip NYI"
    local parent = self
    
    local function ColorSwatch_OnClick( self )
		HideUIPanel( ColorPickerFrame )
		
        ColorPickerFrame:SetFrameStrata( "FULLSCREEN_DIALOG" )
        
        ColorPickerFrame.previousValues = { db[key].r, db[key].g, db[key].b, db[key].a }
        
        ColorPickerFrame.func = function()
            local r, g, b = ColorPickerFrame:GetColorRGB()
            local a = 1 - OpacitySliderFrame:GetValue()
            
            self.texture:SetVertexColor( r, g, b, a or 1 )
            db[key].r = r
            db[key].g = g
            db[key].b = b
            db[key].a = a
            
            -- Follow up
            DocsUI_Nameplates:refreshNameplateLayouts()
        end
        
        ColorPickerFrame.hasOpacity = true
        ColorPickerFrame.opacityFunc = function()
            local r, g, b = ColorPickerFrame:GetColorRGB()
            local a = 1 - OpacitySliderFrame:GetValue()
            
            self.texture:SetVertexColor( r, g, b, a or 1 )
            db[key].r = r
            db[key].g = g
            db[key].b = b
            db[key].a = a
            
            -- Follow up
            DocsUI_Nameplates:refreshNameplateLayouts()
        end
        
        local r, g, b, a = db[key].r, db[key].g, db[key].b, db[key].a
        ColorPickerFrame.opacity = 1-( a or 0 )
        ColorPickerFrame:SetColorRGB( r, g, b )
        
        ColorPickerFrame.cancelFunc = function()
            local r, g, b, a = unpack( ColorPickerFrame.previousValues )
            
            self.texture:SetVertexColor( r, g, b, a or 1 )
            db[key].r = r
            db[key].g = g
            db[key].b = b
            db[key].a = a
            
            -- Follow up
            DocsUI_Nameplates:refreshNameplateLayouts()
        end
        
        ShowUIPanel( ColorPickerFrame )
	end
    
    temp = CreateFrame( "Button", nil, self )
    temp:SetWidth( optionWidth )
    temp:SetHeight( optionHeight )
    if #self.options>0 then
        temp:SetPoint( "TOPLEFT", self.options[#self.options], "BOTTOMLEFT", 0, 0 )
    else
        temp:SetPoint( "TOPLEFT", self, "TOPLEFT", borderSize, -borderSize )
    end
    temp:SetAlpha( 1 )
    temp:SetScript( "OnClick", ColorSwatch_OnClick )
    temp:SetScript( "OnShow", function( self )
        self.texture:SetVertexColor( db[key].r, db[key].g, db[key].b, db[key].a )
    end )
    temp:SetScript( "OnEnter", function( self )
        GameTooltip:SetOwner( self, "ANCHOR_LEFT" )
        GameTooltip:AddLine( tooltip )
        GameTooltip:Show()
    end )
    temp:SetScript( "OnLeave", function() GameTooltip:Hide() end )
    local frame = temp
    
    temp = frame:CreateTexture( nil, "BACKGROUND" )
    temp:SetWidth( optionHeight-4 )
    temp:SetHeight( optionHeight-4 )
    temp:SetTexture( "Tileset\\Generic\\Checkers" )
    temp:SetPoint( "LEFT", frame, "LEFT", 4, 0 )
    frame.bg = temp
    local bg = temp
    
    temp = frame:CreateTexture( nil, "OVERLAY" )
    temp:SetWidth( optionHeight+2 )
    temp:SetHeight( optionHeight+2 )
    temp:SetTexture( "Interface\\ChatFrame\\ChatFrameColorSwatch" )
    temp:SetPoint( "CENTER", bg, "CENTER", 0, 0 )
    frame.texture = temp
    local texture = temp
    
    temp = frame:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
    temp:SetWidth( optionWidth-optionHeight )
    temp:SetHeight( optionHeight )
    temp:SetPoint( "LEFT", bg, "RIGHT", 4, 0 )
    temp:SetFont( font, fontSizeOption )
    temp:SetJustifyH( "LEFT" )
    temp:SetJustifyV( "CENTER" )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    temp:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
    temp:SetText( text )
    
    tinsert( self.options, frame )
end

local function spawnButton( self, text, tooltip, onClick )
    text = text or "Text NYI"
    tooltip = tooltip or "Tooltip NYI"
    onClick = onClick or nil
    local parent = self
    
    temp = CreateFrame( "Button", nil, self )
    temp:SetWidth( optionWidth )
    temp:SetHeight( optionHeight )
    if #self.options>0 then
        temp:SetPoint( "TOPLEFT", self.options[#self.options], "BOTTOMLEFT", 0, 0 )
    else
        temp:SetPoint( "TOPLEFT", self, "TOPLEFT", borderSize, -borderSize )
    end
    temp:SetAlpha( 1 )
    local button = temp
    temp:SetScript( "OnClick", onClick )
    temp:SetScript( "OnEnter", function( self )
        button.texture:SetVertexColor( 1,1,1,0.33 )
        
        GameTooltip:SetOwner( self, "ANCHOR_LEFT" )
        GameTooltip:AddLine( tooltip )
        GameTooltip:Show()
    end )
    temp:SetScript( "OnLeave", function()
        button.texture:SetVertexColor( 1,1,1,0.1 )
        
        GameTooltip:Hide()
    end )
    temp:SetScript( "OnMouseDown", function()
        button.texture:SetVertexColor( 0,1,0,0.33 )
    end )
    temp:SetScript( "OnMouseUp", function()
        button.texture:SetVertexColor( 1,1,1,0.33 )
    end )
    
    temp = button:CreateTexture( nil, "OVERLAY" )
    temp:SetTexture( "Interface\\Addons\\DocsUI_Nameplates\\media\\bg" )
    temp:SetAllPoints( button )
    temp:SetVertexColor( 1,1,1,0.1 )
    button.texture = temp
    local texture = temp
    
    temp = button:CreateFontString( nil, "OVERLAY", "GameFontNormal" )
    temp:SetWidth( optionWidth )
    temp:SetHeight( optionHeight )
    temp:SetPoint( "CENTER", button, "CENTER", 0, 0 )
    temp:SetFont( font, fontSizeOption )
    temp:SetJustifyH( "CENTER" )
    temp:SetJustifyV( "CENTER" )
    temp:SetShadowColor( 0,0,0,1 )
    temp:SetShadowOffset( 1,-1 )
    temp:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
    temp:SetText( text )
    
    tinsert( self.options, temp )
end

local function spawnEditbox( self, text, database, key, tooltip )
    text = text or "Text NYI"
    database = database or {}
    key = key or "test"
    tooltip = tooltip or "Tooltip NYI"
    local parent = self
    
    temp = CreateFrame( "EditBox", nil, self, "InputBoxTemplate" )
    temp:SetWidth( optionWidth )
    temp:SetHeight( optionHeight )
    if #self.options>0 then
        temp:SetPoint( "TOPLEFT", self.options[#self.options], "BOTTOMLEFT", 0, 0 )
    else
        temp:SetPoint( "TOPLEFT", self, "TOPLEFT", borderSize, -borderSize )
    end
    temp:SetAlpha( 1 )
    temp:SetAutoFocus( false )
    local frame = temp
    temp:SetScript( "OnShow", function( self )
        self:SetText( text )
        self:HighlightText()
    end )
    temp:SetScript( "OnEnter", function( self )
        GameTooltip:SetOwner( self, "ANCHOR_LEFT" )
        GameTooltip:AddLine( tooltip )
        GameTooltip:Show()
    end )
    temp:SetScript( "OnLeave", function( self ) GameTooltip:Hide() end )
    temp:SetScript( "OnMouseUp", function( self )
        self:SetText("")
    end )
    temp:SetScript( "OnEnterPressed", function( self )
        local n = self:GetText()
        if n and n~=text then
            database[key] = n
        else
            database[key] = nil
        end
        filterAddOnClick( self )
        
        self:SetText("")
        self:ClearFocus()
    end )
    
    --frame.font:SetFont( font, fontSizeOption-1 )
    --frame.font:SetShadowColor( 0,0,0,1 )
    --frame.font:SetShadowOffset( 1,-1 )
    --frame.font:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
    
    tinsert( self.options, frame )
end

local function spawnEditbox2( self, text, database, key, tooltip )
    text = text or "Text NYI"
    database = database or {}
    key = key or "test"
    tooltip = tooltip or "Tooltip NYI"
    local parent = self
    
    temp = CreateFrame( "EditBox", nil, self, "InputBoxTemplate" )
    temp:SetWidth( optionWidth )
    temp:SetHeight( optionHeight )
    if #self.options>0 then
        temp:SetPoint( "TOPLEFT", self.options[#self.options], "BOTTOMLEFT", 0, 0 )
    else
        temp:SetPoint( "TOPLEFT", self, "TOPLEFT", borderSize, -borderSize )
    end
    temp:SetAlpha( 1 )
    temp:SetAutoFocus( false )
    local frame = temp
    temp:SetScript( "OnShow", function( self )
        self:SetText( text )
        self:HighlightText()
    end )
    temp:SetScript( "OnEnter", function( self )
        GameTooltip:SetOwner( self, "ANCHOR_LEFT" )
        GameTooltip:AddLine( tooltip )
        GameTooltip:Show()
    end )
    temp:SetScript( "OnLeave", function( self ) GameTooltip:Hide() end )
    temp:SetScript( "OnMouseUp", function( self )
        self:SetText("")
    end )
    temp:SetScript( "OnEnterPressed", function( self )
        local n = self:GetText()
        if n and n~=text then
            database[key][n] = true
        else
            database[key][n] = nil
        end
        
        self:SetText("")
        self:ClearFocus()
        
        -- Follow up
        DocsUI_Nameplates:refreshNameplateLayouts()
    end )
    
    tinsert( self.options, frame )
end

local function spawnEditbox3( self, text, database, key, tooltip )
    text = text or "Text NYI"
    database = database or {}
    key = key or "test"
    tooltip = tooltip or "Tooltip NYI"
    local parent = self
    
    temp = CreateFrame( "EditBox", nil, self, "InputBoxTemplate" )
    temp:SetWidth( optionWidth )
    temp:SetHeight( optionHeight )
    if #self.options>0 then
        temp:SetPoint( "TOPLEFT", self.options[#self.options], "BOTTOMLEFT", 0, 0 )
    else
        temp:SetPoint( "TOPLEFT", self, "TOPLEFT", borderSize, -borderSize )
    end
    temp:SetAlpha( 1 )
    temp:SetAutoFocus( false )
    local frame = temp
    temp:SetScript( "OnShow", function( self )
        self:SetText( text )
        self:HighlightText()
    end )
    temp:SetScript( "OnEnter", function( self )
        GameTooltip:SetOwner( self, "ANCHOR_LEFT" )
        GameTooltip:AddLine( tooltip )
        GameTooltip:Show()
    end )
    temp:SetScript( "OnLeave", function( self ) GameTooltip:Hide() end )
    temp:SetScript( "OnMouseUp", function( self )
        self:SetText("")
    end )
    temp:SetScript( "OnEnterPressed", function( self )
        local n = self:GetText()
        if n and n~=text and strfind( n, "," ) then
            local a, b = strsplit( ",", n )
            
            database[key][a] = b
        else
            --database[key][n] = nil
        end
        
        self:SetText("")
        self:ClearFocus()
        
        -- Follow up
        DocsUI_Nameplates:refreshNameplateLayouts()
    end )
    
    tinsert( self.options, frame )
end

local function spawnEditbox4( self, text, database, key, tooltip )
    text = text or "Text NYI"
    database = database or {}
    key = key or "test"
    tooltip = tooltip or "Tooltip NYI"
    local parent = self
    
    temp = CreateFrame( "EditBox", nil, self, "InputBoxTemplate" )
    temp:SetWidth( optionWidth )
    temp:SetHeight( optionHeight )
    if #self.options>0 then
        temp:SetPoint( "TOPLEFT", self.options[#self.options], "BOTTOMLEFT", 0, 0 )
    else
        temp:SetPoint( "TOPLEFT", self, "TOPLEFT", borderSize, -borderSize )
    end
    temp:SetAlpha( 1 )
    temp:SetAutoFocus( false )
    local frame = temp
    temp:SetScript( "OnShow", function( self )
        self:SetText( text )
        self:HighlightText()
    end )
    temp:SetScript( "OnEnter", function( self )
        GameTooltip:SetOwner( self, "ANCHOR_LEFT" )
        GameTooltip:AddLine( tooltip )
        GameTooltip:Show()
    end )
    temp:SetScript( "OnLeave", function( self ) GameTooltip:Hide() end )
    temp:SetScript( "OnMouseUp", function( self )
        self:SetText("")
    end )
    temp:SetScript( "OnEnterPressed", function( self )
        local n = self:GetText()
        if n and n~=text then
            tinsert( database[key], n )
        end
        
        self:SetText("")
        self:ClearFocus()
    end )
    
    --frame.font:SetFont( font, fontSizeOption-1 )
    --frame.font:SetShadowColor( 0,0,0,1 )
    --frame.font:SetShadowOffset( 1,-1 )
    --frame.font:SetTextColor( db.fontColor.r,db.fontColor.g,db.fontColor.b,db.fontColor.a )
    
    tinsert( self.options, frame )
end

local function createFrames() -- Options are created here
    global = DocsUI_Nameplates.db.global
    
    temp = CreateFrame( "Frame", "DocsUI_Nameplates_options", UIParent )
    temp:Hide()
    --temp:EnableMouse( true )
    temp:SetFrameStrata( "FULLSCREEN_DIALOG" )
    temp:SetAlpha( 1 )
    temp:SetPoint( "TOPLEFT", UIParent )
    temp:SetPoint( "BOTTOMRIGHT", UIParent )
    temp:SetScript( "OnShow", function( self )
        db = DocsUI_Nameplates.db.profile
        
        DocsUI_Nameplates.configMode = true
        
        DocsUI_Nameplates:refreshNameplateLayouts()
    end )
    temp:SetScript( "OnHide", function( self )
        DocsUI_Nameplates.configMode = false
        
        DocsUI_Nameplates:refreshNameplateLayouts()
    end )
    tinsert( UISpecialFrames, temp:GetName() )
    optionFrames.main = temp
    
    --[[temp = optionFrames.main:CreateTexture( nil, "BACKGROUND" )
    temp:SetTexture( db.bg )
    temp:SetAllPoints( optionFrames.main )
    temp:SetVertexColor( 0, 0, 0, 0.5 )
    optionFrames.main.bg = temp]]
    
    temp = optionFrames.main:CreateTexture( nil, "OVERLAY" )
    temp:SetTexture( db.logo )
    temp:SetPoint( "TOP", optionFrames.main, "TOP", 0, -10 )
    temp:SetTexCoord( 0, 1, 0, 0.52 )
    temp:SetWidth( 512 )
    temp:SetHeight( 64 )
    temp:SetVertexColor( 1, 1, 1, 1 )
    optionFrames.main.logo = temp
    
    temp = CreateFrame( "Button", nil, optionFrames.main, "OptionsButtonTemplate" )
    temp:SetWidth( 80 )
    temp:SetHeight( 22 )
    temp:SetPoint( "TOPRIGHT", optionFrames.main, "TOPRIGHT", -20, -20 )
    temp:SetText( CLOSE )
    temp:SetScript( "OnClick", function( self )
        optionFrames.main:Hide()
    end )
    local close = temp
    
    temp = CreateFrame( "Button", nil, optionFrames.main, "OptionsButtonTemplate" )
    temp:SetWidth( 80 )
    temp:SetHeight( 22 )
    temp:SetPoint( "TOPRIGHT", close, "TOPLEFT", -20, 0 )
    temp:SetText( L["Profiles"] )
    temp:SetScript( "OnClick", function( self )
        optionFrames.main:Hide()
        
        InterfaceOptionsFrame_OpenToCategory("DocsNameplates")
    end )
    local profiles = temp
    
    temp = CreateFrame( "Button", nil, optionFrames.main, "OptionsButtonTemplate" )
    temp:SetWidth( 80 )
    temp:SetHeight( 22 )
    temp:SetPoint( "TOPRIGHT", profiles, "TOPLEFT", -20, 0 )
    temp:SetText( L["Presets"] )
    temp:SetScript( "OnClick", function( self )
        optionFrames.main:Hide()
        
        DocsUI_Nameplates:LoadPreset()
    end )
    
    -- Layout
    optionFrames.main.layout = spawnContainer( optionFrames.main )
    optionFrames.main.layout:SetPoint( "TOPLEFT", optionFrames.main, 50, -80 )
    spawnTitle( optionFrames.main.layout, L["Layout"] )
    
    spawnCheckbox( optionFrames.main.layout, GUILD, db, "guildName", L["guildName"] )
    spawnCheckbox( optionFrames.main.layout, L["Social"].." "..L["icon"], db, "socialIcon", L["socialIcon"] )
    spawnCheckbox( optionFrames.main.layout, L["Class"].." "..L["icon"], db, "classIcon", L["classIcon"] )
    spawnCheckbox( optionFrames.main.layout, L["Role"].." "..L["icon"], db, "roleIcon", L["roleIcon"] )
    spawnCheckbox( optionFrames.main.layout, L["Unknown"].." "..L["icon"], db, "unknownIcon", L["unknownIcon"] )
    spawnCheckbox( optionFrames.main.layout, L["Debug"], db, "debugMode", L["debugMode"] )
    spawnTitle( optionFrames.main.layout, L["Textures"] )
    spawnDropdown( optionFrames.main.layout, L["Statusbar"], L["StatusbarTt"], textureDropDownMenu )
    spawnDropdown( optionFrames.main.layout, L["Border"], L["StatusbarTt"], borderDropDownMenu )
    spawnTitle( optionFrames.main.layout, L["Size"] )
    spawnSlider( optionFrames.main.layout, HEALTH.." "..L["Height"], "height", L["scale_tt"], 2, 50, 1 )
    spawnSlider( optionFrames.main.layout, HEALTH.." "..L["Width"], "width", L["scale_tt"], 10, 200, 1 )
    spawnSlider( optionFrames.main.layout, L["Castbar"].." "..L["Height"], "heightCast", L["scale_tt"], 2, 50, 1 )
    spawnSlider( optionFrames.main.layout, L["Castbar"].." "..L["Width"], "widthCast", L["scale_tt"], 10, 200, 1 )
    spawnSlider( optionFrames.main.layout, L["Scale"], "scale", L["scale_tt"], 0.2, 4, 0.05 )
    spawnSlider( optionFrames.main.layout, L["Scale"].." "..L["Buffs"], "scaleBuffs", L["scale_tt"], 0.2, 4, 0.05 )
    spawnTitle( optionFrames.main.layout, L["Miscellaneous"] )
    spawnCheckbox( optionFrames.main.layout, L["Combatlog fix"], db, "combatLogFix", L["combatLogFix"] )
    spawnCheckbox( optionFrames.main.layout, L["Combatlog print"], db, "combatLogFixPrint", L["combatLogFixPrint"] )
    
    -- Font
    optionFrames.main.font = spawnContainer( optionFrames.main )
    optionFrames.main.font:SetPoint( "TOPLEFT", optionFrames.main.layout, "BOTTOMLEFT", 0, -borderSize )
    spawnTitle( optionFrames.main.font, L["Font"] )
    spawnDropdown( optionFrames.main.font, L["Normal"], L["fontTt"], fontDropDownMenu )
    spawnDropdown( optionFrames.main.font, L["Bold"], L["fontTt"], fontbDropDownMenu )
    spawnDropdown( optionFrames.main.font, L["Italic"], L["fontTt"], fontiDropDownMenu )
    spawnSlider( optionFrames.main.font, L["Name"], "fontsizeName", L["size_tt"], 8, 28 )
    spawnSlider( optionFrames.main.font, L["Guild"], "fontsizeGuild", L["size_tt"], 8, 28 )
    spawnSlider( optionFrames.main.font, HEALTH, "fontsizeHealth", L["size_tt"], 8, 28 )
    spawnSlider( optionFrames.main.font, L["Castbar"], "fontsizeCast", L["size_tt"], 8, 28 )
    spawnSlider( optionFrames.main.font, L["Buffs"], "fontsizeBuffs", L["size_tt"], 8, 28 )
    spawnDropdown( optionFrames.main.font, L["Outline"], L["fontTt"], outlineDropDownMenu )
    
    -- Colors
    optionFrames.main.colors = spawnContainer( optionFrames.main )
    optionFrames.main.colors:SetPoint( "TOPLEFT", optionFrames.main.layout, "TOPRIGHT", borderSize, 0 )
    spawnTitle( optionFrames.main.colors, L["Color"] )
    spawnColorpicker( optionFrames.main.colors, L["Font"], db, "fontColor", L["colorTt"] )
    spawnColorpicker( optionFrames.main.colors, L["Custom"], db, "customColor", L["colorTt"] )
    spawnColorpicker( optionFrames.main.colors, L["Background"], db, "bgColor", L["colorTt"] )
    spawnColorpicker( optionFrames.main.colors, L["Border"], db, "borderColor", L["colorTt"] )
    spawnColorpicker( optionFrames.main.colors, L["Threat"].." "..L["very safe"], db, "colorThreatVerySafe", L["colorTt"] )
    spawnColorpicker( optionFrames.main.colors, L["Threat"].." "..L["safe"], db, "colorThreatSafe", L["colorTt"] )
    spawnColorpicker( optionFrames.main.colors, L["Threat"].." "..L["unsafe"], db, "colorThreatUnsafe", L["colorTt"] )
    spawnColorpicker( optionFrames.main.colors, L["Threat"].." "..L["alert"], db, "colorThreatAlert", L["colorTt"] )
    spawnColorpicker( optionFrames.main.colors, L["Threat"].." "..L["tanked"], db, "colorThreatTanked", L["colorTt"] )
    spawnColorpicker( optionFrames.main.colors, L["Castbar"], db, "castColor", L["colorTt"] )
    
    -- LFG
    optionFrames.main.lfg = spawnContainer( optionFrames.main )
    optionFrames.main.lfg:SetPoint( "TOPLEFT", optionFrames.main.colors, "BOTTOMLEFT", 0, -borderSize )
    spawnTitle( optionFrames.main.lfg, L["LFG"] )
    spawnCheckbox( optionFrames.main.lfg, L["Enabled"], db, "lfgIcon", L["lfgIcon"] )
    spawnEditbox4( optionFrames.main.lfg, "", global, "LFGList", L["LFGName"] )
    spawnTitle( optionFrames.main.lfg, L["Delete"] )
    spawnDropdown( optionFrames.main.lfg, L["LFG"], L["LFGDeleteTt"], deleteLFGDropDownMenu )
    
    -- Arena
    optionFrames.main.arena = spawnContainer( optionFrames.main )
    optionFrames.main.arena:SetPoint( "TOPLEFT", optionFrames.main.lfg, "BOTTOMLEFT", 0, -borderSize )
    spawnTitle( optionFrames.main.arena, ARENA )
    spawnCheckbox( optionFrames.main.arena, L["tot"], db, "tot", L["tot"] )
    
    -- Health
    optionFrames.main.health = spawnContainer( optionFrames.main )
    optionFrames.main.health:SetPoint( "TOPLEFT", optionFrames.main.colors, "TOPRIGHT", borderSize, 0 )
    spawnTitle( optionFrames.main.health, HEALTH )
    spawnCheckbox( optionFrames.main.health, HEALTH.." "..L["percent"], db, "showHpPercent", L["showHpPercent"], "hpNumber" )
    spawnCheckbox( optionFrames.main.health, HEALTH.." "..L["absolut"], db, "showHpAbsolut", L["showHpAbsolut"], "hpNumber" )
    spawnCheckbox( optionFrames.main.health, L["Healthbar"], db, "showHpBar", L["showHpBar"] )
    spawnText( optionFrames.main.health, L["Color"] )
    spawnCheckbox( optionFrames.main.health, L["Custom"], db, "healthBarColorCustom", L["healthBarColorCustom"] )
    spawnCheckbox( optionFrames.main.health, L["Threat"], db, "threatEnabled", L["threatEnabled"] )
    spawnCheckbox( optionFrames.main.health, L["PvP"], db, "healthBarColorPvP", L["healthBarColorPvP"] )
    spawnCheckbox( optionFrames.main.health, L["Class"], db, "healthBarColorClass", L["healthBarColorClass"] )
    spawnText( optionFrames.main.health, L["Visibility"] )
    spawnCheckbox( optionFrames.main.health, L["Friend"].." "..L["PvE"], db, "healthBarFriendPve", L["healthBar"] )
    spawnCheckbox( optionFrames.main.health, L["Enemy"].." "..L["PvE"], db, "healthBarEnemyPve", L["healthBar"] )
    spawnCheckbox( optionFrames.main.health, L["Friend"].." "..L["PvE"].." "..L["combat"], db, "healthBarFriendPveCombat", L["healthBar"] )
    spawnCheckbox( optionFrames.main.health, L["Enemy"].." "..L["PvE"].." "..L["combat"], db, "healthBarEnemyPveCombat", L["healthBar"] )
    spawnCheckbox( optionFrames.main.health, L["Friend"].." "..L["PvP"], db, "healthBarFriendPvp", L["healthBar"] )
    spawnCheckbox( optionFrames.main.health, L["Enemy"].." "..L["PvP"], db, "healthBarEnemyPvp", L["healthBar"] )
    
    -- Castbar
    optionFrames.main.cast = spawnContainer( optionFrames.main )
    optionFrames.main.cast:SetPoint( "TOPLEFT", optionFrames.main.health, "BOTTOMLEFT", 0, -borderSize )
    spawnTitle( optionFrames.main.cast, L["Castbar"] )
    spawnCheckbox( optionFrames.main.cast, L["Non-Targets"], db, "castBarNonTargets", L["castBarNonTargets"] )
    spawnText( optionFrames.main.cast, L["Visibility"] )
    spawnCheckbox( optionFrames.main.cast, L["Friend"].." "..L["PvE"], db, "castBarFriendPve", L["castBar"] )
    spawnCheckbox( optionFrames.main.cast, L["Enemy"].." "..L["PvE"], db, "castBarEnemyPve", L["castBar"] )
    spawnCheckbox( optionFrames.main.cast, L["Friend"].." "..L["PvE"].." "..L["combat"], db, "castBarFriendPveCombat", L["castBar"] )
    spawnCheckbox( optionFrames.main.cast, L["Enemy"].." "..L["PvE"].." "..L["combat"], db, "castBarEnemyPveCombat", L["castBar"] )
    spawnCheckbox( optionFrames.main.cast, L["Friend"].." "..L["PvP"], db, "castBarFriendPvp", L["castBar"] )
    spawnCheckbox( optionFrames.main.cast, L["Enemy"].." "..L["PvP"], db, "castBarEnemyPvp", L["castBar"] )
    
    -- Visibility
    optionFrames.main.visibility = spawnContainer( optionFrames.main )
    optionFrames.main.visibility:SetPoint( "TOPRIGHT", optionFrames.main, -50, -80 )
    spawnTitle( optionFrames.main.visibility, L["Visibility"] )
    spawnCheckbox( optionFrames.main.visibility, L["Overlap"], db, "allowOverlap", L["allowOverlap"] )
    spawnTitle( optionFrames.main.visibility, L["PvE"] )
    spawnCheckbox( optionFrames.main.visibility, L["Friend"].." "..L["Unit"], db, "visibilityPveFriendUnit", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Friend"].." "..L["Pet"], db, "visibilityPveFriendPet", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Friend"].." "..L["Guardian"], db, "visibilityPveFriendGuardian", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Friend"].." "..L["Totem"], db, "visibilityPveFriendTotem", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Enemy"].." "..L["Unit"], db, "visibilityPveEnemyUnit", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Enemy"].." "..L["Pet"], db, "visibilityPveEnemyPet", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Enemy"].." "..L["Guardian"], db, "visibilityPveEnemyGuardian", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Enemy"].." "..L["Totem"], db, "visibilityPveEnemyTotem", L["visibilityTt"] )
    spawnTitle( optionFrames.main.visibility, L["PvE"].." "..L["combat"] )
    spawnCheckbox( optionFrames.main.visibility, L["Friend"].." "..L["Unit"], db, "visibilityPvecombatFriendUnit", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Friend"].." "..L["Pet"], db, "visibilityPvecombatFriendPet", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Friend"].." "..L["Guardian"], db, "visibilityPvecombatFriendGuardian", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Friend"].." "..L["Totem"], db, "visibilityPvecombatFriendTotem", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Enemy"].." "..L["Unit"], db, "visibilityPvecombatEnemyUnit", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Enemy"].." "..L["Pet"], db, "visibilityPvecombatEnemyPet", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Enemy"].." "..L["Guardian"], db, "visibilityPvecombatEnemyGuardian", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Enemy"].." "..L["Totem"], db, "visibilityPvecombatEnemyTotem", L["visibilityTt"] )
    spawnTitle( optionFrames.main.visibility, L["PvP"] )
    spawnCheckbox( optionFrames.main.visibility, L["Friend"].." "..L["Unit"], db, "visibilityPvpFriendUnit", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Friend"].." "..L["Pet"], db, "visibilityPvpFriendPet", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Friend"].." "..L["Guardian"], db, "visibilityPvpFriendGuardian", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Friend"].." "..L["Totem"], db, "visibilityPvpFriendTotem", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Enemy"].." "..L["Unit"], db, "visibilityPvpEnemyUnit", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Enemy"].." "..L["Pet"], db, "visibilityPvpEnemyPet", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Enemy"].." "..L["Guardian"], db, "visibilityPvpEnemyGuardian", L["visibilityTt"] )
    spawnCheckbox( optionFrames.main.visibility, L["Enemy"].." "..L["Totem"], db, "visibilityPvpEnemyTotem", L["visibilityTt"] )
    
    -- Buffs
    optionFrames.main.buffs = spawnContainer( optionFrames.main )
    optionFrames.main.buffs:SetPoint( "TOPRIGHT", optionFrames.main.visibility, "TOPLEFT", -borderSize, 0 )
    spawnTitle( optionFrames.main.buffs, L["Buffs"] )
    spawnSlider( optionFrames.main.buffs, L["Number"], "buffsNumber", L["buffsNumber"], 1, 12 )
    spawnCheckbox( optionFrames.main.buffs, L["Friend"].." "..L["PvE"], db, "buffsFriendPve", L["buffsTt"] )
    spawnCheckbox( optionFrames.main.buffs, L["Enemy"].." "..L["PvE"], db, "buffsEnemyPve", L["buffsTt"] )
    spawnCheckbox( optionFrames.main.buffs, L["Friend"].." "..L["PvE"].." "..L["combat"], db, "buffsFriendPveCombat", L["buffsTt"] )
    spawnCheckbox( optionFrames.main.buffs, L["Enemy"].." "..L["PvE"].." "..L["combat"], db, "buffsEnemyPveCombat", L["buffsTt"] )
    spawnCheckbox( optionFrames.main.buffs, L["Friend"].." "..L["PvP"], db, "buffsFriendPvp", L["buffsTt"] )
    spawnCheckbox( optionFrames.main.buffs, L["Enemy"].." "..L["PvP"], db, "buffsEnemyPvp", L["buffsTt"] )
    spawnCheckbox( optionFrames.main.buffs, L["All my buffs"], db.buffFilter.buffs, "allMy", L["allMyBuffs"] )
    spawnCheckbox( optionFrames.main.buffs, L["All my debuffs"], db.buffFilter.debuffs, "allMy", L["allMyDebuffs"] )
    spawnCheckbox( optionFrames.main.buffs, L["All any buffs"], db.buffFilter.buffs, "allAny", L["allAnyBuffs"] )
    spawnCheckbox( optionFrames.main.buffs, L["All any debuffs"], db.buffFilter.debuffs, "allAny", L["allAnyDebuffs"] )
    
    -- Hider
    optionFrames.main.hider = spawnContainer( optionFrames.main )
    optionFrames.main.hider:SetPoint( "TOPLEFT", optionFrames.main.buffs, "BOTTOMLEFT", 0, -borderSize )
    spawnTitle( optionFrames.main.hider, L["Hider"] )
    spawnEditbox2( optionFrames.main.hider, L["Name"], global, "nameplateHider", L["hiderName"] )
    spawnTitle( optionFrames.main.hider, L["Delete"] )
    spawnDropdown( optionFrames.main.hider, L["Hider"], L["hiderDeleteTt"], deleteHiderDropDownMenu )
    
    -- Name replacer
    optionFrames.main.short = spawnContainer( optionFrames.main )
    optionFrames.main.short:SetPoint( "TOPLEFT", optionFrames.main.hider, "BOTTOMLEFT", 0, -borderSize )
    spawnTitle( optionFrames.main.short, L["Name replacer"] )
    spawnEditbox3( optionFrames.main.short, L["Name,Replacement"], global, "nameReplacer", L["replacerName"] )
    spawnTitle( optionFrames.main.short, L["Delete"] )
    spawnDropdown( optionFrames.main.short, L["Hider"], L["replacerDeleteTt"], deleteReplacerDropDownMenu )
    
    -- Filter
    optionFrames.main.filter = spawnContainer( optionFrames.main )
    optionFrames.main.filter:SetPoint( "TOPRIGHT", optionFrames.main.buffs, "TOPLEFT", -borderSize, 0 )
    spawnTitle( optionFrames.main.filter, L["Delete"] )
    spawnDropdown( optionFrames.main.filter, L["Buffs"], L["deleteTt"], deleteBuffsDropDownMenu )
    spawnDropdown( optionFrames.main.filter, L["Debuffs"], L["deleteTt"], deleteDebuffsDropDownMenu )
    spawnTitle( optionFrames.main.filter, L["Filter"] )--als ein element
    spawnEditbox( optionFrames.main.filter, L["Name"], db.buffFilter, "filterName", L["filterName"] )
    --spawnButton( optionFrames.main.filter, L["Add"], L["filterAdd"], filterAddOnClick )
    spawnCheckbox( optionFrames.main.filter, L["Only my"], db.buffFilter, "filterOnlyMy", L["filterOnlyMy"] )
    spawnCheckbox( optionFrames.main.filter, L["Buff"], db.buffFilter, "filterBuff", L["filterBuff"] )
    spawnCheckbox( optionFrames.main.filter, L["Debuff"], db.buffFilter, "filterDebuff", L["filterDebuff"] )
    spawnCheckbox( optionFrames.main.filter, L["Never show"], db.buffFilter, "filterNeverShow", L["filterNeverShow"] )
    spawnCheckbox( optionFrames.main.filter, L["High"].." "..L["priority"], db.buffFilter, "filterHigh", L["priorityTt"], "priority" )
    spawnCheckbox( optionFrames.main.filter, L["Medium"].." "..L["priority"], db.buffFilter, "filterMedium", L["priorityTt"], "priority" )
    spawnCheckbox( optionFrames.main.filter, L["Low"].." "..L["priority"], db.buffFilter, "filterLow", L["priorityTt"], "priority" )
    
end


local function blizzardOptions() -- Spawn the options
    DocsUI_Nameplates.options = {
        type = "group",
        args = {
            optionsDocsUI_Nameplates = {
                name = "DocsNameplates",
                desc = "DocsNameplates",
                type = "group",
                order = 0,
                args = {
                    i = {
                        type="description",
                        image=db.logo,
                        imageWidth = 256,
                        imageHeight = 32,
                        imageCoords = {0,1,0,0.52},
                        name="",
                        order=0,
                    },
                    config = {
                        type="execute",
                        name=L["Config"],
                        desc="/docsnp  /np",
                        func=function( self )
                            InterfaceOptionsFrame:Hide()
                            DocsUI_Nameplates.optionFrame.main:Show()
                        end,
                        order=1,
                    },
                },
            },
            
        },
    }
end

function DocsUI_Nameplates:SpawnOptions() -- Spawn the options
    db = DocsUI_Nameplates.db.profile
    
    createFrames()
    blizzardOptions()
    
    DocsUI_Nameplates.optionFrame = optionFrames
    
    spawnPresetFrame()
end