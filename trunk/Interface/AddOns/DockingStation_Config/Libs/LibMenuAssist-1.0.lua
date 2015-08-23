local LIB, REVISION = "LibMenuAssist-1.0", 0
if not LibStub then error(LIB .. " requires LibStub", 0) end

local lib, oldRevision = LibStub:NewLibrary(LIB, REVISION)
if not lib then return end

local setmetatable = setmetatable

--[[-----------------------------------------------------------------------------
Version bridge
-------------------------------------------------------------------------------]]
local activeMenu, focusFrames, mt, OnHide, OnShow

if oldRevision then
	activeMenu, focusFrames, mt, OnHide, OnShow = lib.__void()
else
	focusFrames, mt, OnHide, OnShow = { }, { }, { }, { }
	DropDownList1:HookScript('OnHide', function() lib.OnHideHook(activeMenu) end)
	DropDownList1:HookScript('OnShow', function() lib.OnShowHook(UIDROPDOWNMENU_OPEN_MENU) end)
end

--[[-----------------------------------------------------------------------------
Hooks
-------------------------------------------------------------------------------]]
function lib.OnHideHook(menu)
	activeMenu = nil
	if OnHide[menu] then
		OnHide[menu](menu)
	end
end

function lib.OnShowHook(menu)
	activeMenu = menu
	if OnShow[menu] then
		OnShow[menu](menu)
	end
end

--[[-----------------------------------------------------------------------------
Support functions
-------------------------------------------------------------------------------]]
local function DoNothing()
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
mt.__index = {
	displayMode = 'MENU',

	["AddFocusFrame"] = function(self, frame)
		local type = type(frame)
		if type == 'string' or type == 'table' then
			if not focusFrames[self] then
				focusFrames[self] = { }
			end
			focusFrames[self][frame] = true
		end
	end,

	["Close"] = function(self)
		if activeMenu == self then
			CloseDropDownMenus()
			return true
		end
	end,

	['GetScript'] = function(self, script)
		if script == 'OnHide' then
			return OnHide[self]
		elseif script == 'OnShow' then
			return OnShow[self]
		else
			error(LIB .. ": <menu>:GetScript(script) - '" .. tostring(script) .. "' is not a valid script for this object", 2)
		end
	end,

	["HasMouseFocus"] = function(self)
		local focus, focusFrames = GetMouseFocus(), focusFrames[self]
		if focus then
			local name = focus:GetName()
			if (focusFrames and (focusFrames[focus] or focusFrames[name])) or (activeMenu == self and name and name:match("^DropDownList%d+")) then
				return true
			end
		end
	end,

	['HasScript'] = function(self, script)
		return script == 'OnHide' or script == 'OnShow'
	end,

	["IsOpen"] = function(self)
		return activeMenu == self
	end,

	["Open"] = function(self)
		local onHide, onShow, runOnShow = OnHide[self], OnShow[self], activeMenu ~= self
		OnHide[self], OnShow[self] = nil, nil
		CloseDropDownMenus()
		if self.point ~= 'cursor' then
			ToggleDropDownMenu(1, nil, self, self.relativeTo or 'UIParent')
		else
			ToggleDropDownMenu(1, nil, self, 'cursor', self.xOffset, self.yOffset)
		end
		DropDownList1.showTimer = nil																-- Fix for a typo in UIDropDownMenuTemplates.xml
		OnHide[self], OnShow[self] = onHide, onShow
		if runOnShow and onShow then
			onShow(self)
		end
		return self:UpdateAutoHide()
	end,

	["Recycle"] = function(self)
		self:Close()
		focusFrames[self], OnHide[self], OnShow[self] = nil, nil, nil
		mt.__metatable = nil
		setmetatable(self, nil)
		mt.__metatable = LIB
	end,

	["Refresh"] = function(self)
		if activeMenu == self then
			local menuLevel, frame = UIDROPDOWNMENU_MENU_LEVEL
			for level = 2, menuLevel do
				frame = _G['DropDownList' .. level]
				if not (frame and frame:IsShown()) then
					menuLevel = level - 1
					break
				end
			end
			if self:Open() then
				local button, _
				for level = 2, menuLevel do
					frame = _G['DropDownList' .. level]
					_, button = frame:GetPoint()
					if button and button.hasArrow then
						ToggleDropDownMenu(level, button.value, nil, nil, nil, nil, nil, button)
						if frame.numButtons == 0 then
							break
						end
					end
				end
				return self:UpdateAutoHide()
			end
		end
	end,

	["RemoveFocusFrame"] = function(self, frame)
		if focusFrames[self] then
			focusFrames[self][frame] = nil
			if not next(focusFrames[self]) then
				focusFrames[self] = nil
			end
		end
	end,

	["SetAnchor"] = function(self, xOffset, yOffset, point, relativeTo, relativePoint)
		if point == 'cursor' then
			relativeTo, relativePoint = nil, nil
		end
		if xOffset ~= self.xOffset or yOffset ~= self.yOffset or point ~= self.point or relativeTo ~= self.relativeTo or relativePoint ~= self.relativePoint then
			self.xOffset, self.yOffset, self.point, self.relativeTo, self.relativePoint = xOffset, yOffset, point, relativeTo, relativePoint
			return self:Refresh()
		end
	end,

	['SetHeight'] = DoNothing,																		-- Let Blizzard's code keep thinking this is a frame

	['SetScript'] = function(self, script, func)
		if type(func) ~= 'function' and func ~= nil then
			error(LIB .. ": <menu>:SetScript(script, func) - 'func' expected function or nil, got " .. type(func), 2)
		elseif script == 'OnHide' then
			OnHide[self] = func
		elseif script == 'OnShow' then
			OnShow[self] = func
		else
			error(LIB .. ": <menu>:SetScript(script, func) - '" .. tostring(script) .. "' is not a valid script for this object", 2)
		end
	end,

	["UpdateAutoHide"] = function(self)
		if activeMenu == self then
			if self:HasMouseFocus() then
				UIDropDownMenu_StopCounting(DropDownList1)
			else
				UIDropDownMenu_StartCounting(DropDownList1)
			end
			return true
		end
	end
}

mt.__metatable = LIB

--[[-----------------------------------------------------------------------------
Tweaks
-------------------------------------------------------------------------------]]
DropDownList1:SetClampedToScreen(true)

for level = 2, UIDROPDOWNMENU_MAXLEVELS do
	_G['DropDownList' .. level]:SetScript('OnUpdate', nil)
end

--[[-----------------------------------------------------------------------------
Private API
-------------------------------------------------------------------------------]]
function lib.__void()
	wipe(lib)
	wipe(mt)
	return activeMenu, focusFrames, mt, OnHide, OnShow
end

--[[-----------------------------------------------------------------------------
Public API
-------------------------------------------------------------------------------]]
function lib:New()
	return setmetatable({ }, mt)
end
