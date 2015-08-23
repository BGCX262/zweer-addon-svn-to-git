if not _G[...] then return end
local addon = _G[...]
local addonName = addon.addonName
setfenv(1, addon)

--[[-----------------------------------------------------------------------------
Core
-------------------------------------------------------------------------------]]
local function DeletePanel(id)
	local cacheSettings, pluginSettings, children, name, plugin  = settings.panels[id], settings.plugins
	settings.panels[id] = nil
	if settings.defaultPanel == id then
		settings.defaultPanel = next(settings.panels)
	end
	for section in pairs(sectionTypes) do
		children = cacheSettings[section]
		for index = 1, #children do
			name = children[index]
			if pluginSettings[name] then
				pluginSettings[name].enable = false
				SetInheritance(name, nil)
			end
		end
	end
	if panels[id] then
		panels[id]:Recycle()
	end
	PanelList:Delete(id)
	update_panel_list()
end

local function DeletePlugin(name)
	local id, section, index = GetPluginLocation(name)
	if id then
		tremove(settings.panels[id][section], index)
	end
	settings.plugins[name] = nil
	PluginList:Delete(name)
end

local function RenamePanel(id, value)
	if value == "" or value == L["<unnamed>"] then
		value = nil
	end
	if settings.panels[id].alias ~= value then
		settings.panels[id].alias = value
		PanelList:Add(id)
		update_panel_list()
	end
end

local function RenamePlugin(name, value)
	if value == "" or value == name then
		value = nil
	end
	if pluginAlias[name] ~= value then
		pluginAlias[name] = value
		if plugins[name] then
			plugins[name]:Refresh()
		end
		PluginList:Add(name)
	end
end

--[[-----------------------------------------------------------------------------
Edit box
-------------------------------------------------------------------------------]]
local editBox = CreateFrame('EditBox', nil, SideBar)
editBox:SetFrameLevel(editBox:GetFrameLevel() + 1)
editBox:SetCountInvisibleLetters(false)
editBox:Hide()

editBox:SetScript('OnEditFocusLost', function(self)
	if self:IsShown() then
		if self.ignore then
			self.ignore = nil
		else
			(SideBarMenu.isPanel and RenamePanel or RenamePlugin)(self.entry.data.key, self:GetText():trim())
		end
		self:Hide()
	end
end)

editBox:SetScript('OnEnterPressed', editBox.ClearFocus)

editBox:SetScript('OnEscapePressed', function(self)
	self.ignore = true
	self:ClearFocus()
end)

editBox:SetScript('OnHide', function(self)
	self.entry.text:Show()
end)

editBox:SetScript('OnShow', function(self)
	local entry = SideBarMenu.entry
	self.entry = entry
	entry.text:Hide()
	self:SetAllPoints(entry.text)
	self:SetFontObject(entry:GetNormalFontObject())
	self:SetText(entry.data.label)
	self:HighlightText()
	self:SetCursorPosition(self:GetNumLetters())
	self:SetFocus()
end)

--[[-----------------------------------------------------------------------------
Drop down menu
-------------------------------------------------------------------------------]]
local function OnClick(self, delete, key)
	editBox:ClearFocus()
	if delete then
		delete(key)
	else
		editBox:Show()
	end
end

SideBarMenu = LibStub('LibMenuAssist-1.0'):New()
SideBarMenu.point = 'cursor'
SideBarMenu.xOffset = 0
SideBarMenu.yOffset = 0

SideBarMenu.initialize = function(self, level)
	local data, info = self.entry.data, UIDropDownMenu_CreateInfo()
	info.notCheckable = true

	info.isTitle = true
	info.text = RemoveColorCodes(data.label)
	UIDropDownMenu_AddButton(info, level)
	info.isTitle = nil

	info.func, info.arg2 = OnClick, data.key
	info.text = L["Delete"]
	if self.isPanel then
		info.disabled, info.arg1 = #PanelList <= 1, DeletePanel
	else
		info.disabled, info.arg1 = dataObj[data.key], DeletePlugin
	end
	UIDropDownMenu_AddButton(info, level)
	info.disabled, info.arg1 = nil, nil

	info.text = L["Rename"]
	UIDropDownMenu_AddButton(info, level)
end
