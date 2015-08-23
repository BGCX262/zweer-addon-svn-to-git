local addonName = ...
local BUTTON_HEIGHT, ICON_SIZE, GAP, TEXT_OFFSET, SIMPLE_BAR_WIDTH, ASCII_LENGTH, FONT_SIZE, MAX_ENTRIES =
           14,          13,     10,      3,            110,             30,          11
local f = CreateFrame("Frame", "AraReputation", UIParent)
local configMenu, options, ColorPickerChange, ColorPickerCancel, OpenColorPicker, SetOption, textures
local factions, config, char, UpdateTablet, UpdateBar = {}
local updateBeforeBlizzard, watchedFaction, watchedIndex, focusedButton
local sliderValue, hasSlider, c, nbEntries = 0
local defaultTexture = "Interface\\TargetingFrame\\UI-StatusBar"
local defaultConfig = {
	scale = 1.1,
	blockDisplay = "text",
	asciiBar = "dualColors",
	textFaction = true,
	textStanding = true,
	textPerc = true,
	textValues = false,
	barTexture = defaultTexture,
	blizzardColors = FACTION_BAR_COLORS,
	asciiColors = {
		{ r= .54, g= 0,   b= 0   }, -- hated
		{ r= 1,   g= .10, b= .1  }, -- hostile
		{ r= 1,   g= .55, b= 0   }, -- unfriendly
		{ r= .87, g= .87, b= .87 }, -- neutral
		{ r= 1,   g= 1,   b= 0   }, -- friendly
		{ r= .1,  g= .9,  b= .1  }, -- honored
		{ r= .25, g= .41, b= .88 }, -- revered
		{ r= .6,  g= .2,  b= .8  }, -- exalted
		{ r= .4,  g= 0,   b= .6  }, -- past exalted
	},
}
local defaultCharConfig = {
	collapsedHeaders = {},
}
local defaultColor = { r=.8, g=.8, b=.8 }
local GetFactionInfo, FACTION_INACTIVE, GUILD_REPUTATION =
	GetFactionInfo, FACTION_INACTIVE, GUILD_REPUTATION

local levels = { FACTION_STANDING_LABEL1, FACTION_STANDING_LABEL2, FACTION_STANDING_LABEL3, FACTION_STANDING_LABEL4, FACTION_STANDING_LABEL5, FACTION_STANDING_LABEL6, FACTION_STANDING_LABEL7, FACTION_STANDING_LABEL8 }
local colors = { "8b0000", "ff1919", "ff8c00", "dddddd", "ffff00", "19e619", "4169e1", "9932cc", "67009a" }
local nameColors = { "ff1919", "ff1919", "ffff00", "19ff19", "19ff19", "19ff19", "19ff19", "19ff19" }

local tt, startingRep, info = {}, {}, {}
local tables = setmetatable( {}, { __mode = "k" } )

local function new(...)
	local t = next(tables)
	if t then tables[t] = nil else t = {} end
	for i = 1, select( "#", ... ), 2 do
		local key, value = select( i, ... )
		t[key] = value
	end
	return t
end

local highlight = f:CreateTexture()
highlight:SetTexture"Interface\\QuestFrame\\UI-QuestTitleHighlight"
highlight:SetBlendMode"ADD"
highlight:SetAlpha(0)


local function Menu_OnEnter(self)
	if self and self.rep then
		highlight:SetAllPoints(self)
		highlight:SetAlpha(1)
		self.hovered = true
		if not config.showSeparateValues and not config.showRawInstead then self.fs:SetText(self.rep.textValue) end
	end
end

local function Menu_OnLeave(self)
	highlight:ClearAllPoints()
	if self and self.rep then
		self.hovered = nil
		highlight:SetAlpha(0)
		if not config.showSeparateValues and not config.showRawInstead then self.fs:SetText(levels[self.rep.level]) end
	end
	if not f:IsMouseOver() then f:Hide() end
end


local orgSetWatchedFactionIndex = SetWatchedFactionIndex
function SetWatchedFactionIndex(...)
	orgSetWatchedFactionIndex(...)
	watchedFaction = GetFactionInfo(...)
	watchedIndex = ...
	updateBeforeBlizzard = true
	UpdateBar()
end


local function Faction_OnClick(self, button)
	local rep = self.rep
	if rep.header and not IsControlKeyDown() then
		if rep.collapsed then ExpandFactionHeader(rep.index) else CollapseFactionHeader(rep.index) end
		char.collapsedHeaders[rep.name] = not rep.collapsed
		UpdateTablet()
	elseif button == "MiddleButton" then
		if rep.inactive then SetFactionActive(rep.index) else SetFactionInactive(rep.index) end
		UpdateTablet()
	elseif button == "RightButton" then
		if not rep.showValue then return end
		ChatFrame_OpenChat(rep.name.." - "..levels[rep.level].." - "..rep.textValue, DEFAULT_CHAT_FRAME)
	else
		SetWatchedFactionIndex( GetWatchedFactionInfo() == rep.name and 0 or rep.index)
		if focusedButton and focusedButton.rep.name then focusedButton.faction:SetText( (rep.header and "|cffffffff" or "|cffffd100")..focusedButton.rep.name ) end
		if watchedIndex ~= 0 then self.faction:SetText( "|cffe67319"..rep.name ) end
		focusedButton = self
	end
end


local function Scroll(self, delta)
	if IsControlKeyDown() then
		config.scale = config.scale - delta * 0.05
		return UpdateTablet()
	end
	slider:SetValue( sliderValue - delta * (IsModifierKeyDown() and 10 or 3) )
end

local buttons = setmetatable( {}, { __index = function(table, index)
	local button = CreateFrame("Button", nil, f)
	rawset( table, index, button )

	button:RegisterForClicks"AnyUp"
	button:SetHeight( BUTTON_HEIGHT )
	button:SetScript("OnEnter", Menu_OnEnter)
	button:SetScript("OnLeave", Menu_OnLeave)
	button:EnableMouseWheel(true)
	button:SetScript( "OnMouseWheel", Scroll)

	button.icon = button:CreateTexture()
	button.icon:SetWidth(ICON_SIZE) button.icon:SetHeight(ICON_SIZE)
	button.icon:SetPoint( "LEFT", button, "LEFT" )

	button.faction = button:CreateFontString(nil, "OVERLAY", "SystemFont_Shadow_Med1")
	button.faction:SetFont( "Fonts\\FRIZQT__.TTF", FONT_SIZE )
	button.faction:SetPoint("LEFT", button.icon, "RIGHT", TEXT_OFFSET, 0)

	button.fs = button:CreateFontString(nil, "OVERLAY", "SystemFont_Shadow_Med1")
	button.fs:SetFont( "Fonts\\FRIZQT__.TTF", FONT_SIZE )
	button.fs:SetWidth(SIMPLE_BAR_WIDTH)
	button.fs:SetJustifyH"CENTER"

	button.bar = button:CreateTexture(nil, "OVERLAY", button)
	button.bar:SetWidth(SIMPLE_BAR_WIDTH) button.bar:SetHeight(BUTTON_HEIGHT-4)
	button.bar:SetPoint("LEFT", button.fs, "LEFT")

	button.bg = button:CreateTexture(nil, "BACKGROUND")
	button.bg:SetWidth(SIMPLE_BAR_WIDTH+2) button.bg:SetHeight(BUTTON_HEIGHT-2)
	button.bg:SetTexture(0,0,0,.5)
	button.bg:SetPoint("LEFT", button.fs, "LEFT", -1, 0)

	button.values = button:CreateFontString(nil, "OVERLAY")
	button.values:SetFont( "Fonts\\FRIZQT__.TTF", FONT_SIZE )
	button.values:SetJustifyH"CENTER"
	button.values:SetPoint("LEFT", button.fs, "RIGHT", GAP, 0 )
	button.values:SetTextColor(1, .82, 0)

	button.session = button:CreateFontString(nil, "OVERLAY")
	button.session:SetFont( "Fonts\\FRIZQT__.TTF", FONT_SIZE )
	button.session:SetJustifyH"RIGHT"
	button.session:SetTextColor(1, .82, 0)

	button.togo = button:CreateFontString(nil, "OVERLAY")
	button.togo:SetFont( "Fonts\\FRIZQT__.TTF", FONT_SIZE )
	button.togo:SetJustifyH"RIGHT"
	button.togo:SetTextColor(1, .82, 0)

	return button
end } )


local function UpdateScrollButtons(nbEntries)
	for i=1, #buttons do buttons[i]:Hide() end
	for i=1, nbEntries do
		button = buttons[sliderValue+i]
		button:SetPoint("TOPLEFT", f, "TOPLEFT", GAP, BUTTON_HEIGHT*(1-i) - GAP)
		button:Show()
	end
end

local function AddHint(hint)
	nbEntries = nbEntries + 1
	button = buttons[nbEntries]
	button:SetScript("OnClick", nil)
	button.rep = nil
	button.icon:SetTexture""
	button.faction:SetText(hint)
	button.bar:Hide() button.bg:Hide() button.fs:Hide() button.values:Hide() button.togo:Hide() button.session:Hide()
	button.icon:SetPoint("LEFT", button, "LEFT", -ICON_SIZE-TEXT_OFFSET, 0)
end

UpdateTablet = function(self)
	CloseDropDownMenus()
	f:SetScale( config.scale )
	MAX_ENTRIES = floor( (UIParent:GetHeight() / config.scale - GAP*2) / BUTTON_HEIGHT - 4 / config.scale )

	local menuFactionWidth, menuValuesWidth, menuToGoWidth, menuSessionWidth = 0, 0, 0, 0
	local itemFactionWidth, itemValuesWidth, itemToGoWidth, itemSessionWidth, button, inactive

	for i = 1, #factions do
		tables[wipe(factions[i])] = true
		factions[i] = nil
	end

	local inactive, skip, skipChild
	nbEntries = 0

	for i = 1, GetNumFactions() do
		local name, showValue, level, minVal, maxVal, value, atWar, canBeAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo(i)
		if isHeader and not (isChild and skipChild) then
			skip = char.collapsedHeaders[name]
			skipChild = skip and not isChild
		end
		if not skip or isHeader and not isChild or isHeader and isChild and not skipChild then
			nbEntries = nbEntries + 1
			showValue = not isHeader or hasRep
			if isHeader and name == FACTION_INACTIVE then inactive = true end
			isCollapsed = char.collapsedHeaders[name] or isCollapsed
			factions[#factions+1] = new(
				"index", i,
				"name",	name,
				"header", isHeader,
				"showValue", showValue,
				"level", level,
				"collapsed", isCollapsed,
				"inactive", inactive,
				"textValue", format("%i / %i", value-minVal, maxVal-minVal)
			)
			button = buttons[nbEntries]
			button:SetScript("OnClick", Faction_OnClick)
			button.rep = factions[#factions]
			button.faction:SetText( (name == watchedFaction and "|cffe67319" or isHeader and "|cffffffff" or "|cffffd100")..name )
			if name == watchedFaction then focusedButton = button end

			if showValue then
				local perc = (value - minVal) / (maxVal - minVal)
				local color = config.asciiColorsInstead and config.asciiColors[level] or config.blizzardColors[level]
				button.bar:SetVertexColor( color.r, color.g, color.b )
				button.bar:SetWidth( SIMPLE_BAR_WIDTH * (perc == 0 and 0.0001 or perc) )
				button.bar:SetTexture(config.barTexture)
				button.fs:SetText( (button.hovered and not config.showSeparateValues or config.showRawInstead and not config.showSeparateValues) and button.rep.textValue or levels[level] )
				button.bar:Show() button.fs:Show()
				if config.showSeparateValues then button.values:SetText(button.rep.textValue) end
				if config.showRepToGo then button.togo:SetText( button.rep.level == 8 and "-" or maxVal - value ) end
				if config.showSessionGain then
					if not startingRep[name] then startingRep[name] = value end
					local gain = value - startingRep[name]
					button.session:SetText( gain == 0 and "-" or gain)
				end
			else
				button.bar:Hide() button.fs:Hide() button.bg:Hide()
				if nbEntries > 1 then button.values:Hide() button.togo:Hide() button.session:Hide() end
			end
			button.icon:SetTexture(not isHeader and "" or isCollapsed and "Interface\\Buttons\\UI-PlusButton-UP" or "Interface\\Buttons\\UI-MinusButton-UP")
			button.icon:SetPoint("LEFT", button, "LEFT", isChild and ICON_SIZE + TEXT_OFFSET or 0, 0)

			if nbEntries == 1 then
				button.togo:SetText("|cffffffffTo Go")
				button.session:SetText("|cffffffffSession")
			end
			itemFactionWidth = button.faction:GetStringWidth() + (isChild and ICON_SIZE + TEXT_OFFSET or 0)
			if itemFactionWidth > menuFactionWidth then menuFactionWidth = itemFactionWidth end
			itemValuesWidth = button.values:GetStringWidth()
			if itemValuesWidth > menuValuesWidth then menuValuesWidth = itemValuesWidth end
			itemToGoWidth = button.togo:GetStringWidth()
			if itemToGoWidth > menuToGoWidth then menuToGoWidth = itemToGoWidth end
			itemSessionWidth = button.session:GetStringWidth()
			if itemSessionWidth > menuSessionWidth then menuSessionWidth = itemSessionWidth end
		end
	end

	if config.showHints then
		AddHint""
		AddHint"|cffff8020Click |cff33ff33to |cffffd100watch faction |cff33ff33or |cffffffffexpand/collapse|cff33ff33."
		AddHint"|cffff8020Right-Click |cff33ff33to copy to chatbox."
		AddHint"|cffff8020Middle-Click |cff33ff33to move to active/inactive."
		AddHint"|cffff8020Ctrl+MouseWheel |cff33ff33to resize tooltip."
	end

	local valuesX = ICON_SIZE + TEXT_OFFSET + menuFactionWidth + GAP
	local togoX =  valuesX + SIMPLE_BAR_WIDTH + (config.showSeparateValues and GAP + menuValuesWidth or 0)
	local sessionX = togoX + (config.showRepToGo and GAP + menuToGoWidth or 0)
	local buttonWidth = sessionX + (config.showSessionGain and GAP + menuSessionWidth + TEXT_OFFSET or 0)

	for i=1, nbEntries do
		button = buttons[i]
		button:SetWidth(buttonWidth)
		button.fs:SetPoint("LEFT", button, "LEFT", valuesX, 0)
		if button.rep then
			if button.rep.showValue then button.bg:Show() else button.bg:Hide() end
			if button.rep.showValue or i == 1 then
				if config.showSeparateValues then
					button.values:SetWidth(menuValuesWidth)
					button.values:Show()
				else	button.values:Hide() end
				if config.showRepToGo then
					button.togo:SetPoint("LEFT", button, "LEFT", togoX, 0)
					button.togo:SetWidth(menuToGoWidth+GAP)
					button.togo:Show()
				else	button.togo:Hide() end
				if config.showSessionGain then
					button.session:SetPoint("LEFT", button, "LEFT", sessionX, 0)
					button.session:SetWidth(menuSessionWidth+GAP)
					button.session:Show()
				else	button.session:Hide() end
			end
		end
	end

	local maxEntries = math.min(MAX_ENTRIES, nbEntries)
	local maxValue = math.max( 0, nbEntries - MAX_ENTRIES )
	slider:SetMinMaxValues( 0, maxValue )
	slider:SetValue( math.min( sliderValue, maxValue ) )
	hasSlider = nbEntries > MAX_ENTRIES
	if hasSlider then slider:Show() else slider:Hide() end

	UpdateScrollButtons(maxEntries)
	if hasSlider then
		slider:SetHeight(BUTTON_HEIGHT*(MAX_ENTRIES+1))
		slider:SetPoint("TOPRIGHT", f, "TOPRIGHT", -8, BUTTON_HEIGHT*.5 - GAP)
	end
	f:SetWidth( buttonWidth + GAP*2 + (hasSlider and 16 + TEXT_OFFSET*2 or 0) )
	f:SetHeight( BUTTON_HEIGHT * maxEntries + GAP*2 )

	for i = nbEntries+1, #buttons do buttons[i]:Hide() end

	if not (f.onBlock or f:IsMouseOver()) then f:Hide() end
end


local function Block_OnClick(self, button)
	if button == "LeftButton" then
		ToggleCharacter"ReputationFrame"
	elseif button == "RightButton" then
		f:Hide()
		if not configMenu then f:SetupConfigMenu() end
		configMenu.scale = UIParent:GetScale()
		ToggleDropDownMenu(1, nil, configMenu, self, 0, 0)
	end
end


local block = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("|cffffb366Ara|r Reputations", {
	type = "data source",
	icon = UnitFactionGroup"player" == "Horde" and "Interface\\Icons\\Spell_Misc_HellifrePVPThrallmarFavor" or "Interface\\Icons\\Spell_Misc_HellifrePVPHonorHoldFavor",
	iconCoords = { 0.075, 0.925, 0.075, 0.925 },
	text = "No Faction",
	OnEnter = function(frame)
		CloseDropDownMenus()
		f.onBlock = true
		f:Show()
		f:ClearAllPoints()
		local showBelow = select(2, frame:GetCenter()) > UIParent:GetHeight()/2
		f:SetPoint(showBelow and "TOP" or "BOTTOM", frame, showBelow and "BOTTOM" or "TOP")
		if Skinner then Skinner:applySkin(f) end
		UpdateTablet()
	end,
	OnLeave = function()
		f.onBlock = nil
		if not f:IsMouseOver() then f:Hide() end
	end,
	OnClick = Block_OnClick
} )

local firstCall = true

UpdateBar = function()
	if firstCall then
		for i=1, GetNumFactions() do
			local name, _, _, _, _, value, _, _, isHeader, _, hasRep = GetFactionInfo(i)
			if not isHeader or hasRep then startingRep[name] = value end
		end
		firstCall = false
	end

	local name, _, level, minVal, maxVal, value
	if updateBeforeBlizzard then
		updateBeforeBlizzard = false
		name, _, level, minVal, maxVal, value = GetFactionInfo(watchedIndex)
	else	name, level, minVal, maxVal, value = GetWatchedFactionInfo() end

	if not name then
		block.text = "No Faction"
		return
	end

	local c1, c2 = config.asciiColors[level], config.asciiColors[level+1]
	local perc = (value - minVal) / (maxVal - minVal)

	if config.blockDisplay == "text" then
		local asciiColor = config.asciiColors[level]
		asciiColor = format("|cff%.2x%.2x%.2x", asciiColor.r*255, asciiColor.g*255, asciiColor.b*255)
		if config.textStanding then
			tt[#tt+1] = (#tt>0 and "" or asciiColor)..levels[level].."|r"
		end
		if config.textPerc then
			tt[#tt+1] = format("%s%i%%|r", #tt>0 and "" or asciiColor, floor(perc*100))
		end
		if config.textValues then
			tt[#tt+1] = format("%s%i/%i|r", #tt>0 and "" or asciiColor, value - minVal, maxVal - minVal)
		end
		if config.textToGo and level < 8 then
			tt[#tt+1] = format("%s%i to go|r",  #tt>0 and "" or asciiColor, maxVal - value)
		end
		if config.textSession then
			if not startingRep[name] then startingRep[name] = value end
			local gain = value - startingRep[name]
			tt[#tt+1] = format("%sSession %s%i|r",  #tt>0 and "" or asciiColor, gain >= 0 and "+" or "", gain)
		end
		if config.textFaction then
			local color = config.blizzardColors[level]
			tinsert(tt,1, format("|cff%.2x%.2x%.2x%s|r", color.r*255, color.g*255, color.b*255, name) )
		end
		block.text = table.concat(tt, " - ")
		wipe(tt)
	elseif config.blockDisplay == "ascii" then
		local steps = perc * ASCII_LENGTH
		if config.asciiBar == "singleColor" then c1 = defaultColor end
		block.text = format( "|cff%.2x%.2x%.2x%s|cff%.2x%.2x%.2x%s",
			c2.r*255, c2.g*255, c2.b*255, strrep("||", steps),
			c1.r*255, c1.g*255, c1.b*255, strrep("||", ASCII_LENGTH-steps) )
	end
end


local fsInc = FACTION_STANDING_INCREASED:gsub("%%d", "([0-9]+)"):gsub("%%s", "(.*)")
local fsDec = FACTION_STANDING_DECREASED:gsub("%%d", "([0-9]+)"):gsub("%%s", "(.*)")

function f:CHAT_MSG_COMBAT_FACTION_CHANGE(msg)
	local faction, value, neg = msg:match(fsInc)
	if not faction then
		faction, value = msg:match(fsDec)
		if not faction then return end
		neg = true
	end
	if tonumber(faction) then faction, value = value, tonumber(faction) else value = tonumber(value) end
	if faction == GUILD_REPUTATION then faction = GetGuildInfo"player" end

	if not neg and config.autoSwitch then
		for i = 1, GetNumFactions() do
			if GetFactionInfo(i) == faction then
				return SetWatchedFactionIndex(i)
			end
		end
	end
	if faction == watchedFaction then UpdateBar() end
end


function f:SetupConfigMenu()
	configMenu = CreateFrame("Frame", "AraReputationConfigMenu")
	configMenu.displayMode = "MENU"

	options = {
	{ text = ("|cffffb366Ara|r Reputations (%s)"):format( GetAddOnMetadata(addonName, "Version") ), isTitle = true },
	{ text = "Block Display", submenu = {
		{ text = "ASCII Bar", radio = "blockDisplay", val = "ascii", submenu = {
			{ text = "Single Color", radio = "asciiBar", val = "singleColor" },
			{ text = "Dual Colors",  radio = "asciiBar", val = "dualColors" }, } },
		{ text = "Text", radio = "blockDisplay", val = "text", submenu = {
			{ text = "Faction", check = "textFaction" },
			{ text = "Standing", check = "textStanding" },
			{ text = "Percentage", check = "textPerc" },
			{ text = "Raw Numbers", check = "textValues" },
			{ text = "Reputation To Go", check = "textToGo" },
			{ text = "Session Gain", check = "textSession" } } } } },
	{ text = "Tooltip Columns", submenu = {
		{ text = "Show Raw Numbers instead of Standing", check = "showRawInstead" },
		{ text = "Show Separate Raw Numbers", check = "showSeparateValues" },
		{ text = "Show Reputation To Go", check = "showRepToGo" },
		{ text = "Show Session Gain", check = "showSessionGain" } } },
	{ text = "Bar Texture", submenu = "textures" },
	{ text = "Blizzard Colors", submenu = {
		{ text = levels[1], color = "blizzardColors", index = 1 },
		{ text = levels[2], color = "blizzardColors", index = 2 },
		{ text = levels[3], color = "blizzardColors", index = 3 },
		{ text = levels[4], color = "blizzardColors", index = 4 },
		{ text = levels[5], color = "blizzardColors", index = 5 },
		{ text = levels[6], color = "blizzardColors", index = 6 },
		{ text = levels[7], color = "blizzardColors", index = 7 },
		{ text = levels[8], color = "blizzardColors", index = 8 }, } },
	{ text = "ASCII Colors", submenu = {
		{ text = levels[1], color = "asciiColors", index = 1 },
		{ text = levels[2], color = "asciiColors", index = 2 },
		{ text = levels[3], color = "asciiColors", index = 3 },
		{ text = levels[4], color = "asciiColors", index = 4 },
		{ text = levels[5], color = "asciiColors", index = 5 },
		{ text = levels[6], color = "asciiColors", index = 6 },
		{ text = levels[7], color = "asciiColors", index = 7 },
		{ text = levels[8], color = "asciiColors", index = 8 },
		{ text = "Past Exalted", color = "asciiColors", index = 9 }, } },
	{ text = "Use ASCII colors for bars", check = "asciiColorsInstead" },
	{ text = "Tooltip Size", submenu = {
		{ text =  "90%", radio = "scale", val = 0.9 },
		{ text = "100%", radio = "scale", val = 1.0 },
		{ text = "110%", radio = "scale", val = 1.1 },
		{ text = "120%", radio = "scale", val = 1.2 },
		{ text = "Custom...", radio="scaleX", func=function() StaticPopup_Show"SET_ABR_SCALE" end } } },
	{ text = "Auto switch on reputation gain", check = "autoSwitch" },
	{ text = "Show Hints", check = "showHints" }
	}

	ColorPickerChange = function() c.r, c.g, c.b = ColorPickerFrame:GetColorRGB() UpdateBar() end
	ColorPickerCancel = function(prev) c.r, c.g, c.b = unpack(prev) UpdateBar() end
	OpenColorPicker = function(self, col, index)
		c = config[col][index]
		ColorPickerFrame.func = ColorPickerChange
		ColorPickerFrame.cancelFunc = ColorPickerCancel
		ColorPickerFrame.previousValues = { c.r, c.g, c.b }
		ColorPickerFrame:SetColorRGB( c.r, c.g, c.b )
		ColorPickerFrame:Show()
	end

	SetOption = function(bt, var, val, checked)
		config[var] = val or checked
		if var == "blockDisplay" or var == "asciiBar" or var:sub(1, 4) == "text" then UpdateBar() end
		if not val then return end

		local sub = bt:GetName():sub(1, 19)
		for i = 1, bt:GetParent().numButtons do
			if _G[sub..i] == bt then _G[sub..i.."Check"]:Show() else _G[sub..i.."Check"]:Hide() _G[sub..i.."UnCheck"]:Show() end
		end
	end

	textures = { "Armory", "BantoBar", "Blizzard", "Glaze", "LiteStep", "Minimalist", "Otravi", "Smooth", "Smooth v2" }

	f.SetCustomScale = function(self,dialog)
		local val = tonumber( dialog.editBox:GetText():match"(%d+)" )
		if not val or val<70 or val>200 then
			baseScript = BasicScriptErrors:GetScript"OnHide"
			BasicScriptErrors:SetScript("OnHide",Error_OnHide)
			BasicScriptErrorsText:SetText"Invalid scale.\nShould be a number between 70 and 200%"
			return BasicScriptErrors:Show()
		end
		config.scale = val/100
	end

	StaticPopupDialogs.SET_ABR_SCALE = {
		text = "Set a custom tooltip scale.\nEnter a value between 70 and 200 (%%).",
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		maxLetters = 4,
		OnAccept = AraReputation.SetCustomScale,
		OnShow = function(self) CloseDropDownMenus() self.editBox:SetText(config.scale*100) self.editBox:SetFocus() end,
		OnHide = ChatEdit_FocusActiveWindow,
		EditBoxOnEnterPressed = function(self) local p=self:GetParent() AraReputation:SetCustomScale(p) p:Hide() end,
		EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	}

	configMenu.initialize = function(self, level)
		if not level then return end
		if level > 1 and UIDROPDOWNMENU_MENU_VALUE == "textures" then
			local sharedMedia = LibStub"LibSharedMedia-3.0"
			for i, name in ipairs(sharedMedia and textures or {"Blizzard"}) do
				local texture = name == "Blizzard" and defaultTexture or sharedMedia.MediaTable.statusbar[name]
				if texture then
					info = wipe(info)
					info.text = name
					info.checked = config.barTexture == texture
					info.func, info.arg1, info.arg2 = SetOption, "barTexture", texture
					info.keepShownOnClick = true
					UIDropDownMenu_AddButton( info, level )
				end
			end
			return
		end
		for i, v in ipairs( level > 1 and UIDROPDOWNMENU_MENU_VALUE or options ) do
			info = wipe(info)
			info.text = v.text
			info.isTitle, info.hasArrow, info.value = v.isTitle, v.submenu ~= nil, v.submenu
			if v.radio then
				if v.radio == "scaleX" then
					info.checked = config.scale ~= .9 and config.scale ~= 1 and config.scale ~= 1.1 and config.scale ~= 1.2
					info.func = v.func
					if info.checked then
						info.text = ("%s (%i%%)"):format(info.text, config.scale*100)
					end
				else
					info.checked = config[v.radio] == v.val
					info.func, info.arg1, info.arg2 = SetOption, v.radio, v.val
					info.keepShownOnClick = true
				end
			elseif v.check then
				info.checked = config[v.check]
				info.func, info.arg1 = SetOption, v.check
				info.keepShownOnClick = true
				info.isNotRadio = true
			elseif v.color then
				info.hasColorSwatch, info.notCheckable, info.padding = true, true, 10
				c = config[v.color][v.index]
				info.r, info.g, info.b = c.r, c.g, c.b
				info.func, info.arg1, info.arg2 = OpenColorPicker, v.color, v.index
			end
			if level==1 and not info.func then
				info.text = ("|Tx:%i|t%s"):format(20/self.scale, info.text)
				info.notCheckable = true
			end
			UIDropDownMenu_AddButton(info, level)
		end
	end

	f.SetupConfigMenu = nil
end

local function FirstUpdate()
	f:SetScript("OnUpdate", nil)
	f:Hide()
	watchedFaction = GetWatchedFactionInfo()
	UpdateBar()
end

local function Init()
	f:SetScript("OnUpdate", FirstUpdate)
end

function f:ADDON_LOADED(addon)
	if addon ~= addonName then return end

	AraReputationsDB = AraReputationsDB or defaultConfig
	config = AraReputationsDB
	for k, v in next, defaultConfig do -- easy upgrade
		if config[k] == nil then config[k] = v end
	end

	local charPath = GetRealmName().." - "..GetUnitName"player"
	config[charPath] = config[charPath] or defaultCharConfig
	char = config[charPath]
	for k, v in next, defaultCharConfig do
		if char[k] == nil then char[k] = v end
	end

	FACTION_BAR_COLORS = config.blizzardColors

	self:SetFrameStrata"TOOLTIP"
	self:SetClampedToScreen(true)
	self:EnableMouse(true)
	self:SetScript("OnEnter", Menu_OnEnter)
	self:SetScript("OnLeave", Menu_OnLeave)
	self:RegisterEvent"CHAT_MSG_COMBAT_FACTION_CHANGE"

	f:SetBackdrop( { bgFile="Interface\\Buttons\\WHITE8X8", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
		tile=false, tileSize=0, edgeSize=14, insets = { left=3, right=3, top=3, bottom=3 } } )
	f:SetBackdropColor( .1, .1, .1, .9 )
	f:SetBackdropBorderColor( .3, .3, .3, .9 )

	slider = CreateFrame("Slider", nil, f)
	slider:SetWidth(16)
	slider:SetThumbTexture"Interface\\Buttons\\UI-SliderBar-Button-Horizontal"
	slider:SetBackdrop( {
		bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
		edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
		edgeSize = 8, tile = true, tileSize = 8,
		insets = {left = 3, right = 3, top = 6, bottom = 6}
	} )
	slider:SetValueStep(1)
	slider:SetScript( "OnLeave", Menu_OnLeave )
	slider:SetScript( "OnValueChanged", function(self, value)
		if hasSlider then
			sliderValue = value
			if f:IsMouseOver() then UpdateScrollButtons(MAX_ENTRIES) end -- ou bien --> if f:IsShown() then ?
		end
	end )

	if IsLoggedIn() then Init()
	else
		f:RegisterEvent"PLAYER_ENTERING_WORLD"
		f.PLAYER_ENTERING_WORLD = Init
	end

	f:UnregisterEvent"ADDON_LOADED"
	f.ADDON_LOADED = nil
end

f:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end)
f:RegisterEvent"ADDON_LOADED"