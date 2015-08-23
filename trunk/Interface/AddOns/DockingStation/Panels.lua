local addonName, addon = ...
setfenv(1, addon)

local min, pairs_iter, tonumber, GetMouseFocus = min, pairs(addon), tonumber, GetMouseFocus

local mt = getmetatable(InterfaceOptionsFrame)

local SetFrameLevel, SetFrameStrata = mt.__index.SetFrameLevel, mt.__index.SetFrameStrata

local panels, strataLayers = panels, LibStub('LibDisplayAssist-1.2').StrataLayers

--[[-----------------------------------------------------------------------------
Helpers
-------------------------------------------------------------------------------]]
local anchors, backdropInsets = { Center = 'LEFT', Left = 'LEFT', Right = 'RIGHT' }, { left = 0, right = 0, top = 0, bottom = 0 }
local backdrop = { bgFile = "", tile = false, tileSize = 0, edgeFile = "", edgeSize = 0, insets = backdropInsets }
local connections, directions = { LEFT = 'RIGHT', RIGHT = 'LEFT' }, { Center = 1, Left = 1, Right = -1 }
local recycled = { }

local auxFrame, auxString, centerFrame, overlayFrame, stateDriver = { }, { }, { }, { }, { }

local LJ = LibStub('LibJostle-3.0')

local function UpdateAlpha(panel, alpha)
	alpha = hideConditions[alpha] or tonumber(alpha) or panel.settings.alphaNormal
	if alpha <= 0 then
		panel:Hide()
	else
		panel:Show()
		panel:SetAlpha(alpha)
	end
end

--[[-----------------------------------------------------------------------------
Scripts
-------------------------------------------------------------------------------]]
local function OnLeave(self, motion)
	self:HideTooltip(motion)
	if self.settings.alphaMouse and not self:HasMouseFocus() then
		self:Unreveal()
	end
end

local function OnMouseDown(self, button)
	if button == 'LeftButton' and self.unlocked then
		self.x, self.y = self:GetCenter()
		self:HideTooltip()
		self:SetFrameStrata('TOOLTIP')
		self:StartMoving()
		self.moving = true
	end
end

local function OnMouseUp(self, button)
	if button == 'LeftButton' then
		if self.moving then
			self.moving = nil
			self:StopMovingOrSizing()
			self:SetFrameStrata(strataLayers[self.settings.strata])
			self:SaveOffset()
			self:ShowTooltip()
		end
	elseif button == 'RightButton' and ConfigFrames and self.settings.rightClickConfig and GetMouseFocus() == self then
		ConfigFrames[1]()																				-- Do it this way to force loading of config module
		PanelList:Select(self.id)
		self:ShowTooltip()
	end
end

local function OnEnter_AuxFrame(self)
	self.parent:Reveal()
--	self:EnableMouse(false)
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local methods = {
	["AllChildren"] = function(self, method, ...)
		local children
		for section in pairs_iter, sectionTypes, nil do
			children = self[section]
			for index = #children, 1, -1 do
				children[index][method](children[index], ...)
			end
		end
	end,

	["AnchorChildren"] = function(self, section)
		local children = self[section]
		if children[1] then
			local anchor, frame, offset = anchors[section]
			local anchorTo = connections[anchor]
			if section ~= "Center" then
				frame, offset = self, self.settings["spacing" .. section .. "Edge"] * directions[section] * self.size
			else
				frame, offset = centerFrame[self], 0
			end

			plugin = children[1]
			plugin:ClearAllPoints()
			plugin:SetPoint(anchor, frame, anchor, offset, 0)
			frame, offset = plugin, self.settings["spacing" .. section] * directions[section] * self.size

			for index = 2, #children do
				plugin = children[index]
				plugin:ClearAllPoints()
				plugin:SetPoint(anchor, frame, anchorTo, offset, 0)
				frame = plugin
			end

			if section == "Center" then
				QueueMethod(self, "UpdateCenterWidth")
			end
		end
	end,

	['GetName'] = function(self)
		if self.settings.allowGlobals then
			return GetPanelName(self.id)
		end
	end,

	["GetOffset"] = function(self)
		local anchor, x, y = self.anchor
		local L1, B1, W1, H1 = UIParent:GetRect()
		local L2, B2, W2, H2 = self:GetRect()
		if anchor == 'TOP' then
--			x, y = (L2 + L2 + W2 - L1 - L1 - W1) * 0.5, B2 + H2 - B1 - H1
			x, y = L2 - L1 + (W2 - W1) * 0.5, B2 + H2 - B1 - H1
		elseif anchor == 'BOTTOM' then
--			x, y = (L2 + L2 + W2 - L1 - L1 - W1) * 0.5, B2 - B1
			x, y = L2 - L1 + (W2 - W1) * 0.5, B2 - B1
		elseif anchor == 'LEFT' then
--			x, y = L2 - L1, (B2 + B2 + H2 - B1 - B1 - H1) * 0.5
			x, y = L2 - L1, B2 - B1 + (H2 - H1) * 0.5
		elseif anchor == 'RIGHT' then
--			x, y = L2 + W2 - L1 - W1, (B2 + B2 + H2 - B1 - B1 - H1) * 0.5
			x, y = L2 + W2 - L1 - W1, B2 - B1 + (H2 - H1) * 0.5
		elseif anchor == 'TOPLEFT' then
			x, y = L2 - L1, B2 + H2 - B1 - H1
		elseif anchor == 'TOPRIGHT' then
			x, y = L2 + W2 - L1 - W1, B2 + H2 - B1 - H1
		elseif anchor == 'BOTTOMLEFT' then
			x, y = L2 - L1, B2 - B1
		elseif anchor == 'BOTTOMRIGHT' then
			x, y = L2 + W2 - L1 - W1, B2 - B1
		else
--			x, y = (L2 + L2 + W2 - L1 - L1 - W1) * 0.5, (B2 + B2 + H2 - B1 - B1 - H1) * 0.5
			x, y = L2 - L1 + (W2 - W1) * 0.5, B2 - B1 + (H2 - H1) * 0.5
		end
		return x / SCREEN_WIDTH, y / SCREEN_HEIGHT
	end,

	["HasMouseFocus"] = function(self)
		return self[GetMouseFocus()]
	end,

	["HideTooltip"] = function(self, motion)
		if not (motion and CONFIG_IS_OPEN and GetMouseFocus() == self) then
			GameTooltip:Hide()
			if self.tooltipScale then
				GameTooltip:SetScale(self.tooltipScale)
				self.tooltipScale = nil
			end
		end
	end,

	["Recycle"] = function(self)
		if self.jostle then
			LJ:Unregister(auxFrame[self])
		end
		stateDriver[self]:Recycle()
		self:Hide()
		self:AllChildren("Recycle")
		PurgeQueue(self)
		auxFrame[self]:EnableMouse(false)
		auxFrame[self]:Hide()
		tremove_byVal(addon, self)
		_G[GetPanelName(self.id)] = nil
		panels[self.id], stateDriver[self] = nil, nil
		self[0], self = self[0], wipe(self)
		recycled[#recycled + 1] = self
	end,

	["Refresh"] = function(self)
		local settings = self.settings

		local height, width = settings.height * SCREEN_HEIGHT, settings.width * SCREEN_WIDTH
		self.anchor, self.size = settings.anchor, height

		local level, strata = settings.level, strataLayers[settings.strata]
		self:SetFrameStrata(strata)
		self:SetFrameLevel(level)

		local stateDriver = stateDriver[self]
		if stateDriver:IsEnabled() then
			auxFrame[self]:EnableMouse(not self:HasMouseFocus() and settings.alphaMouse)
		end
		stateDriver:SetParameters(settings.alphaParameters)
		stateDriver()

		local clamp, x, y = settings.screenClamp, self:GetOffset()
		self:SetClampedToScreen(false)
		self:SetClampRectInsets(clamp, -clamp, -clamp, clamp)
		self:SetHeight(height)
		self:SetWidth(width)
		self:SetClampedToScreen(true)
		self:SetOffset(x, y)

		local fontSize, string = min(height * PHI, width / PHI / 10), auxString[self]
		if fontSize < 1 then
			fontSize = 1
		elseif fontSize > 34 then
			fontSize = 34
		end
		string:SetHeight(0)
		string:SetWidth(0)
		string:SetFont([[Fonts\FRIZQT__.TTF]], fontSize)
		string:SetHeight(string:GetStringHeight())
		string:SetWidth(min(width, string:GetStringWidth()))
		self:AllChildren("Refresh")

		local bgInset = settings.bgInset
		backdrop.bgFile = LSM:Fetch('statusbar', settings.bgTexture)
		backdrop.edgeFile = LSM:Fetch('border', settings.borderTexture) or LSM:Fetch('border', "None")
		backdrop.edgeSize = settings.borderSize
		for inset in pairs_iter, backdropInsets, nil do
			backdropInsets[inset] = bgInset
		end
		self:SetBackdrop(backdrop)
		self:SetBackdropColor(settings.bgColorR, settings.bgColorG, settings.bgColorB, settings.bgColorA)
		self:SetBackdropBorderColor(settings.borderColorR, settings.borderColorG, settings.borderColorB, settings.borderColorA)

		local overlay = overlayFrame[self]
		overlay:SetTexture(LSM:Fetch('statusbar_overlay', settings.overlayTexture))
		if settings.overlayFlip then
			if settings.overlayFlop then
				overlay:SetTexCoord(1, 0, 1, 0)
			else
				overlay:SetTexCoord(1, 0, 0, 1)
			end
		else
			if settings.overlayFlop then
				overlay:SetTexCoord(0, 1, 1, 0)
			else
				overlay:SetTexCoord(0, 1, 0, 1)
			end
		end
		overlay:SetVertexColor(settings.overlayColorR, settings.overlayColorG, settings.overlayColorB, settings.overlayColorA)

		for section in pairs_iter, sectionTypes, nil do
			self:AnchorChildren(section)
		end
	end,

	["SaveOffset"] = function(self)
		local settings = self.settings
		settings.offsetX, settings.offsetY = self:GetOffset()
		if settings.moveBlizzard then
			local region = self.anchor:sub(1, 1)
			if region ~= 'T' and region ~= 'B' then
				local _, y = self:GetCenter()
				region = y < SCREEN_HEIGHT_MIDDLE and 'B' or 'T'
			end
			if region ~= self.jostle then
				LJ[region == 'T' and 'RegisterTop' or 'RegisterBottom'](LJ, auxFrame[self])
				self.jostle = region
			else
				LJ:Refresh()
			end
		elseif self.jostle then
			LJ:Unregister(auxFrame[self])
			self.jostle = nil
		end
	end,

	['SetFrameLevel'] = function(self, value)
		SetFrameLevel(self, value)
		SetFrameLevel(auxFrame[self], value + 3)
		self:AllChildren("SetFrameLevel", value + 1)
	end,

	['SetFrameStrata'] = function(self, value)
		SetFrameStrata(self, value)
		SetFrameStrata(auxFrame[self], value)
		self:AllChildren("SetFrameStrata", value)
	end,

	["SetOffset"] = function(self, x, y)
		self:ClearAllPoints()
		self:SetPoint(self.anchor, UIParent, self.anchor, x * SCREEN_WIDTH, y * SCREEN_HEIGHT)
		self:SaveOffset()
	end,

	["ShowTooltip"] = function(self, motion)
		if self.unlocked or CONFIG_IS_OPEN then
			local settings, tooltip = self.settings, GameTooltip
			if not self.tooltipScale then															-- In case of multiple shows before a hide
				self.tooltipScale = ConnectTooltip(self, tooltip, 0.8)
			end
			tooltip:SetText(addonName .. " - " .. (settings.alias or L["Panel"]), 1, 1, 1)
			if self.unlocked then
				tooltip:AddLine(L["Left click and hold to move this panel."])
			end
			if settings.rightClickConfig and (CONFIG_IS_OPEN ~= ConfigFrames[1] or PanelList.selection ~= self.id) then
				tooltip:AddLine(L["Right click to change this panel's settings."])
			end
			tooltip:Show()
		end
	end,

	["UpdateCenterWidth"] = function(self)
		local center = self.Center
		centerFrame[self]:SetWidth(center[#center]:GetRight() - center[1]:GetLeft() + 1)
	end,

	["UpdateOrder"] = function(self)
		local settings = self.settings
		local order = (#strataLayers - settings.strata) * 1000 + (127 - settings.level)
		if self.order ~= order then
			self.order = order
			tremove_byVal(addon, self)
			local insertPoint
			for index = 1, #addon do
				if order <= addon[index].order then
					insertPoint = index
					break
				end
			end
			tinsert(addon, insertPoint or #addon + 1, self)
		end		
	end,

-- WIP

	["Lock"] = function(self)
		if self.unlocked ~= false then
			self.unlocked = false
			auxFrame[self]:SetAlpha(0)
			self:Unreveal()
		end
	end,

	["Reveal"] = function(self)
		if self.revealed == 0 then
			self.revealed = 1
			stateDriver[self]:Disable()
			auxFrame[self]:EnableMouse(false)
			self:SetAlpha(1)
			self:Show()
		else
			self.revealed = self.revealed + 1
		end
	end,

	["Unlock"] = function(self)
		if self.unlocked ~= true then
			self.unlocked = true
			auxFrame[self]:SetAlpha(1)
			self:Reveal()
		end
	end,

	["Unreveal"] = function(self)
		local revealed = self.revealed
		if revealed == 1 and self.unlocked ~= true then
			self.revealed = 0
			stateDriver[self]:Enable()
			auxFrame[self]:EnableMouse(self.settings.alphaMouse)
		elseif revealed > 1 then
			self.revealed = revealed - 1
		end
	end,

	['EnableMouse'] = mt.__index.EnableMouse,
	['Hide'] = mt.__index.Hide,
	['SetAlpha'] = mt.__index.SetAlpha,
	['Show'] = mt.__index.Show
}

mt = { __index = setmetatable(methods, mt), __metatable = addonName }

--[[-----------------------------------------------------------------------------
Global to addon
-------------------------------------------------------------------------------]]
function GetPanelName(id)
	return addonName .. L["Panel"] .. "[" .. id .. "]"
end

function CreatePanel(id)
	if not id then
		id = GenerateUniqueKey()
	end
	local self = recycled[#recycled]
	if self then
		recycled[#recycled] = nil
		self:SetClampedToScreen(false)
		auxFrame[self]:Show()
		self:Show()
	else
		self = CreateFrame('Frame', nil, UIParent)
		self:EnableMouse(true)
		self:SetMovable(true)
		self:SetScript('OnEnter', methods.ShowTooltip)
		self:SetScript('OnLeave', OnLeave)
		self:SetScript('OnMouseDown', OnMouseDown)
		self:SetScript('OnMouseUp', OnMouseUp)

		local frame = CreateFrame('Frame', nil, UIParent)
		frame:SetAllPoints(self)
		frame:SetScript('OnEnter', OnEnter_AuxFrame)

		local texture = frame:CreateTexture(nil, 'BACKGROUND')
		texture:SetAllPoints()
		texture:SetTexture([[Interface\BUTTONS\WHITE8X8]])
		texture:SetVertexColor(0, 0.05, 1, 1 - PHI)

		local string = frame:CreateFontString(nil, 'ARTWORK')
		string:SetPoint('CENTER')
		string:SetFont([[Fonts\FRIZQT__.TTF]], 12)
		string:SetJustifyH('CENTER')
		string:SetJustifyV('MIDDLE')
		string:SetNonSpaceWrap(false)
		string:SetShadowColor(0, 0, 0, 0.5)
		string:SetShadowOffset(1, -1)
		string:SetText(L["Unlocked"])
		string:SetTextColor(0.85, 0.85, 0.85)

		local overlay = self:CreateTexture(nil, 'OVERLAY')
		overlay:SetAllPoints()

		local center = CreateFrame('Frame', nil, self)
		center:SetPoint('CENTER')
		center:SetHeight(1)
		center:SetWidth(1)

		auxFrame[self], auxString[self], centerFrame[self], frame.parent, overlayFrame[self] = frame, string, center, self, overlay
		setmetatable(self, mt)
	end
	panels[id], self.id, self.Center, self.Left, self.Right = self, id, { }, { }, { }

	self:SetHeight(1)
	self:SetWidth(1)

	local driver = LibStub('LibStateDriver-1.1'):New()
	driver:SetObject(self)
	driver:SetCallback(UpdateAlpha)
	stateDriver[self] = driver

	local settings = GetPanelSettings(id)
	self.anchor, self.settings = settings.anchor, settings
	self:SetOffset(settings.offsetX, settings.offsetY)

	self:UpdateOrder()
	if settings.lockPanel then
		self.revealed = 1
		self:Lock()
	else
		self.revealed = 0
		self:Unlock()
	end
	self:Refresh()
	_G[GetPanelName(id)] = settings.allowGlobals and self or nil

	local pluginSettings, children, name = settings.plugins
	for section in pairs_iter, sectionTypes, nil do
		children = settings[section]
		for index = 1, #children do
			name = children[index]
			if dataObj[name] and pluginSettings[name].enable and not plugins[name] then
				CreatePlugin(name, dataObj[name])
			end
		end
	end

	PanelList:Add(id)
	return self
end
