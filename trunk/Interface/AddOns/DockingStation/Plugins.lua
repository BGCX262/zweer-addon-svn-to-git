local addonName, addon = ...
setfenv(1, addon)

local pairs_iter, type = pairs(addon), type

local mt = getmetatable(InterfaceOptionsFrameOkay)

local EnableMouseWheel, SetScript = mt.__index.EnableMouseWheel, mt.__index.SetScript

local LDB_UnregisterCallback = LDB_UnregisterCallback

local dataObj, plugins, QueueMethod = dataObj, plugins, QueueMethod

--[[-----------------------------------------------------------------------------
Helpers
-------------------------------------------------------------------------------]]
local components = { ['data source'] = { 'icon', 'label', 'text', 'value', 'suffix' }, ['launcher'] = { 'icon', 'label' } }
local scriptHandlers = { OnClick = { }, OnEnter = { }, OnLeave = { }, OnMouseWheel = { }, OnReceiveDrag = { } }
local recycled = { }

local BUFFER_FACTOR = PHI * PHI * 0.1

local function FixPluginLocation(children)
	local plugin
	for index = 1, #children do
		plugin = plugins[children[index]]
		if plugin then
			plugin.index = index
		end
	end
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local methods = {
	["AnchorChildren"] = function(self)
		local child, settings, size = self[1], self.settings, self.size
		local frame, offsetY, vertAdj = child, settings[child._field .. "VertAdj"] or 0
		if offsetY ~= 0 then
			offsetY = offsetY * (size - child.size) * 0.5
		end
		child:ClearAllPoints()
		child:SetPoint('LEFT', self, 'LEFT', 0, offsetY)
		local deltaZero = -offsetY
		for index = 2, #self do
			child = self[index]
			vertAdj = settings[child._field .. "VertAdj"] or 0
			if vertAdj == 0 then
				offsetY = deltaZero
			else
				offsetY = vertAdj * (size - child.size) * 0.5 + deltaZero
			end
			child:ClearAllPoints()
			child:SetPoint('LEFT', frame, 'RIGHT', (child.size + frame.size) * BUFFER_FACTOR, offsetY)
			deltaZero, frame = deltaZero - offsetY, child
		end
	end,

	['AttachFrame'] = function(self, frame)
		if IsFrame(frame) then
			if self.attached then
				self:DetachFrame()
			end
			self.attached, self.attachedScale = frame, ConnectTooltip(self, frame, self.settings.tooltipScale)
		end
	end,

	['DetachFrame'] = function(self)
		local frame = self.attached
		if frame then
			self.attached = nil
			if self.attachedScale then
				safecall(frame.SetScale, frame, self.attachedScale)
				self.attachedScale = nil
			end
			safecall(frame.ClearAllPoints, frame)
		end
	end,

	['EnableMouseWheel'] = DoNothing,

	['GetName'] = function(self)
		return self:GetParent():GetName()
	end,

	['GetScript'] = function(self, script)														-- Stop plugins from directly hooking in and bypassing settings
		if scriptHandlers[script] then
			return scriptHandlers[script][self]
		end
	end,

	["Recycle"] = function(self)
		local name, panel = self.name, self.panel
		self:Hide()
		for index = #self, 1, -1 do
			self[index]:Recycle()
		end
		LDB_UnregisterCallback(addon, 'LibDataBroker_AttributeChanged_' .. name .. '_icon')
		LDB_UnregisterCallback(addon, 'LibDataBroker_AttributeChanged_' .. name .. '_label')
		if pluginType[name] == 'data source' then
			LDB_UnregisterCallback(addon, 'LibDataBroker_AttributeChanged_' .. name .. '_suffix')
			LDB_UnregisterCallback(addon, 'LibDataBroker_AttributeChanged_' .. name .. '_text')
			LDB_UnregisterCallback(addon, 'LibDataBroker_AttributeChanged_' .. name .. '_value')
		end
		if panel and tremove_byVal(panel[self.section], self) then
			panel:AnchorChildren(self.section)
			panel[self] = nil
		end
		PurgeQueue(self)
		plugins[name] = nil
		self[0], self = self[0], wipe(self)
		recycled[#recycled + 1] = self
	end,

	["Refresh"] = function(self)
		self.size = self.panel.size
		self:SetHeight(self.size)
		self:UpdateChildren()
	end,

	['SetScript'] = function(self, script, handler)											-- Stop plugins from directly hooking in and bypassing settings
		if scriptHandlers[script] and (type(handler) == 'function' or handler == nil) then
			scriptHandlers[script][self] = handler
			if script ~= 'OnMouseWheel' then return end
			EnableMouseWheel(self, handler)
		end
	end,

	["SetState"] = function(self)
		local id, section, index = GetPluginLocation(self.name)
		SetInheritance(self.name, id)
		local panel = panels[id]
		if panel then
			if self.settings.enable then
				self.panel, self.section, self.index = panel, section, index

				local children = panel[section]
				tremove_byVal(children, self)
				self:SetParent(panel)
				self:SetFrameStrata(panel:GetFrameStrata())
				self:SetFrameLevel(panel:GetFrameLevel() + 1)

				local insertPoint
				for i = 1, #children do
					if index <= children[i].index then
						insertPoint = i
						break
					end
				end
				tinsert(children, insertPoint or #children + 1, self)
				panel:AnchorChildren(section)
				panel[self] = true
				self:Refresh()
				self:Show()
				return
			end
		elseif not id then
			self.settings.enable = false
		end
		self:Recycle()
	end,

	["UpdateChildren"] = function(self)
		local count, name, settings = 0, self.name, self.settings
		local type = pluginType[name]
		local components = components[type]
		for index = #self, 1, -1 do
			self[index]:Recycle()
			self[index] = nil
		end
		for index = 1, #components do
			LDB_UnregisterCallback(addon, 'LibDataBroker_AttributeChanged_' .. name .. '_' .. components[index])
		end
		if type == 'data source' then
			if not settings.textHide then
				if CreateFontString('value', self, 'text') then
					if not settings.suffixHide then
						CreateFontString('suffix', self)
					end
				else
					CreateFontString('text', self)
				end
			end
		end
		if not settings.iconHide then
			CreateTexture('icon', self)
		end
		if not settings.labelHide then
			CreateFontString('label', self)
		end
		for index = 1, #components do
			if self[components[index]] then
				count = count + 1
				self[count] = self[components[index]]
			end
		end
		if count > 1 then
			if self.icon and settings.iconFlip then
				self[count] = tremove(self, 1)
			end
		elseif count == 0 then
			self[1] = CreateFontString('label', self)
		end
		self:AnchorChildren()
	end,

	["UpdateWidth"] = function(self)
		self:SetWidth(self[#self]:GetRight() - self[1]:GetLeft() + 1)
		if self.section == "Center" and not self.moving then
			QueueMethod(self.panel, "UpdateCenterWidth")
		end
	end,

	['GetLeft'] = mt.__index.GetLeft,
	['GetRight'] = mt.__index.GetRight
}

mt = { __index = setmetatable(methods, mt), __metatable = addonName }

--[[-----------------------------------------------------------------------------
Tooltip visibility support
-------------------------------------------------------------------------------]]
local OnEnter, OnLeave
do
	local tooltipDriver = LibStub('LibStateDriver-1.1'):New()

	local function HideTooltip(self, motion)
		local data = dataObj[self.name]
		tooltipDriver.shown = nil
		if data.tooltip then
			local tooltip = data.tooltip
			self:DetachFrame(tooltip)
			safecall(tooltip.Hide, tooltip)
		else
			local handler = scriptHandlers.OnLeave[self] or data.OnLeave
			if type(handler) == 'function' then
				safecall(handler, self, motion)
			else
				self:DetachFrame(GameTooltip)
				GameTooltip:Hide()
			end
		end
	end

	tooltipDriver:SetCallback(function(self, state)
		local data = dataObj[self.name]
		if hideConditions[state] then
			if tooltipDriver.shown then
				HideTooltip(self)
			end
		elseif not tooltipDriver.shown then														-- ShowTooltip: tooltip > OnEnter > OnTooltipShow > tooltiptext
			tooltipDriver.shown = true
			local tooltip = data.tooltip
			if tooltip then
				self:AttachFrame(tooltip)
				safecall(tooltip.Show, tooltip)
			else
				local handler = scriptHandlers.OnEnter[self] or data.OnEnter
				if type(handler) == 'function' then
					safecall(handler, self)
				else
					tooltip = GameTooltip
					self:AttachFrame(tooltip)
					if type(data.OnTooltipShow) == 'function' then
						safecall(data.OnTooltipShow, tooltip)
					else
						tooltip:SetText(pluginAlias[self.name] or strtrim(self.name), 1, 1, 1)
						if data.keybind then
							local keyBind = pcall(GetBindingKey, data.keybind)
							if keyBind then
								tooltip:AppendText(("%s (%s)|r"):format(NORMAL_FONT_COLOR_CODE, keyBind))
							end
						end
						if data.tooltiptext then
							tooltip:AddLine(data.tooltiptext, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
						end
					end
					tooltip:Show()
				end
			end
		end
	end)

	function OnEnter(self)
		tooltipDriver:SetObject(self)
		tooltipDriver:SetParameters(self.settings.tooltipParameters)
		tooltipDriver:Enable()
	end

	function OnLeave(self, motion)
		tooltipDriver:Disable()
		HideTooltip(self, motion)
		if not self.drag then
			local panel = self.panel
			if panel.settings.alphaMouse and not panel:HasMouseFocus() then
				panel:Unreveal()
			end
		end
	end
end

--[[-----------------------------------------------------------------------------
Drag-and-drop support
-------------------------------------------------------------------------------]]
local function ActiveIndexToRealIndex(panel, section, activeIndex)
	local activeCount, lastActive, settings, plugin = 0, 0, panel.settings[section]
	for realIndex = 1, #settings do
		plugin = plugins[settings[realIndex]]
		if plugin then
			activeCount, lastActive = activeCount + 1, realIndex
			if activeCount == activeIndex then
				return panel.id, section, realIndex
			end
		end
	end
	return panel.id, section, lastActive + 1
end

local function GetActiveIndex(panel, section, x, y, reversed)
	local children = panel[section]
	if not reversed then
		for index = 1, #children do
			if x <= children[index]:GetCenter() then
				return ActiveIndexToRealIndex(panel, section, index)
			end
		end
	else
		for index = 1, #children do
			if x > children[index]:GetCenter() then
				return ActiveIndexToRealIndex(panel, section, index)
			end
		end
	end
	return ActiveIndexToRealIndex(panel, section, #children + 1)
end

local function GetLocation(self)
	local x, y, bottom, height, left, panel, width = self:GetCenter()
	for index = 1, #addon do
		panel = addon[index]
		left, bottom, width, height = panel:GetRect()
		if y >= bottom and left <= x and bottom + height >= y and x <= left + width then
			local Center, Left, Right = panel.Center, panel.Left, panel.Right
			if x < ((Left[1] and Left[#Left]:GetRight() or left) + (Center[1] and Center[1]:GetLeft() or left + width * 0.5)) * 0.5 then
				return GetActiveIndex(panel, "Left", x, y)
			elseif x < ((Center[1] and Center[#Center]:GetRight() or left + width * 0.5) + (Right[1] and Right[#Right]:GetLeft() or left + width)) * 0.5 then
				return GetActiveIndex(panel, "Center", x, y)
			else
				return GetActiveIndex(panel, "Right", x, y, true)
			end
		end
	end
	return self.panel.id, self.section, self.index
end

local function OnDragStart(self)
	if self.drag then
		SetScript(self, 'OnEnter', nil)
		OnLeave(self)

--		if not dataObj[self.name].group then
			AllPanels("Reveal")
--		end

		local x, y = self:GetCenter()
		self:ClearAllPoints()
		self:SetPoint('CENTER', UIParent, 'BOTTOMLEFT', x, y)

		VoidPluginLocation(self.name)

		local hClamp, vClamp = (self:GetWidth() - 1) / 2, (self.size - 1) / 2
		self:SetClampedToScreen(true)
		self:SetClampRectInsets(hClamp, -hClamp, -vClamp, vClamp)
		self:SetFrameStrata('TOOLTIP')
		self:StartMoving()
		self.moving = true
	end
end

local function OnDragStop(self)
	if self.drag then
		self:StopMovingOrSizing()
		self:SetClampedToScreen(false)
		self.moving = nil

		local panel = self.panel
		SetPluginLocation(self.name, GetLocation(self))

--		if not dataObj[self.name].group then
			AllPanels("Unreveal")
--		end
		self.drag = nil

		if panel.settings.alphaMouse and not panel:HasMouseFocus() then
			panel:Unreveal()
		end
		SetScript(self, 'OnEnter', OnEnter)
		if GetMouseFocus() == self then
			OnEnter(self)
		end
	end
end

--[[-----------------------------------------------------------------------------
Scripts
-------------------------------------------------------------------------------]]
local function OnClick(self, button, down, ...)
	if button == 'LeftButton' then
		if down then
			if not self.settings.lockPlugin then
				self.drag = true
			end
			return
		elseif self.drag then
			self.drag = nil
		end
	end
	local handler = scriptHandlers.OnClick[self] or dataObj[self.name].OnClick
	if type(handler) == 'function' then
		safecall(handler, self, button, down, ...)
	end
end

local function OnMouseWheel(self, ...)
	local handler = scriptHandlers.OnMouseWheel[self] or dataObj[self.name].OnMouseWheel
	if type(handler) == 'function' then
		safecall(handler, self, ...)
	end
end

local function OnReceiveDrag(self, ...)
	local handler = scriptHandlers.OnReceiveDrag[self] or dataObj[self.name].OnReceiveDrag
	if type(handler) == 'function' then
		safecall(handler, self, ...)
	end
end

--[[-----------------------------------------------------------------------------
Global to addon
-------------------------------------------------------------------------------]]
function GetPluginLocation(name)
	local children
	for id, settings in pairs_iter, settings.panels, nil do
		for section in pairs_iter, sectionTypes, nil do
			children = settings[section]
			for index = 1, #children do
				if children[index] == name then
					return id, section, index
				end
			end
		end
	end
end

function SetPluginLocation(name, id, section, index)
	VoidPluginLocation(name)
	if not id then
		id = settings.defaultPanel
	end
	local children = settings.panels[id][section or settings.defaultSection]
	if not index or index > #children then
		index = #children + 1
	end
	tinsert(children, index, name)
	if panels[id] then
		FixPluginLocation(children)
	end
	if plugins[name] then
		plugins[name]:SetState()
	else
		SetInheritance(name, id)
	end
	UpdateConfig(nil, true)
end

function VoidPluginLocation(name)
	local id, section, index = GetPluginLocation(name)
	if id then
		local children = settings.panels[id][section]
		tremove(children, index)
		local panel = panels[id]
		if panel then
			local plugin = plugins[name]
			if plugin and tremove_byVal(panel[section], plugin) then
				panel:AnchorChildren(section)
				panel[plugin] = nil
			end
			FixPluginLocation(children)
		end
	end
end

function CreatePlugin(name)
	local self = recycled[#recycled]
	if self then
		recycled[#recycled] = nil
		self:Show()
	else
		self = CreateFrame('Button', nil, UIParent)											-- Need the 'OnClick' handler (fix for CastSpellByName)
		self:EnableMouse(true)
		self:SetMovable(true)
		self:RegisterForClicks('AnyUp', 'LeftButtonDown')
		self:RegisterForDrag('LeftButton')
		self:SetScript('OnClick', OnClick)
		self:SetScript('OnDragStart', OnDragStart)
		self:SetScript('OnDragStop', OnDragStop)
		self:SetScript('OnEnter', OnEnter)
		self:SetScript('OnLeave', OnLeave)
		self:SetScript('OnMouseWheel', OnMouseWheel)
		self:SetScript('OnReceiveDrag', OnReceiveDrag)
		setmetatable(self, mt)
	end
	plugins[name], self.name = self, name

	self:SetHeight(1)
	self:SetWidth(1)
	self.size = 1

	self.settings = GetPluginSettings(name)
	self:SetState()
	PluginList:Add(name)
	return self
end
