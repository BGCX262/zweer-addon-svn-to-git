local LIB, REVISION = "LibDisplayAssist-1.2", 1
if not (LibStub and LibStub('CallbackHandler-1.0', true)) then
	error(LIB .. " requires LibStub and CallbackHandler-1.0", 0)
end

local lib, oldRevision = LibStub:NewLibrary(LIB, REVISION)
if not lib then
	return
elseif not oldRevision then
	oldRevision = -1
end

local strsplit, tonumber, type = strsplit, tonumber, type

local GetCVar, GetRect = GetCVar, UIParent.GetRect

--[[-----------------------------------------------------------------------------
Internal support
-------------------------------------------------------------------------------]]
if oldRevision < 0 then
	lib.CBH = LibStub('CallbackHandler-1.0'):New(lib, nil, nil, false)
end

if oldRevision < 0 then
	lib.CVars = { gxMaximize = true, gxWindow = true, uiscale = true, useUiScale = true }
end

if oldRevision < 0 then
	lib.frame = CreateFrame('Frame', nil, UIParent)

	lib.frame:SetScript('OnUpdate', function(self)											-- Always runs upon start/reload
		lib.resolution = GetCVar('gxResolution')
		lib.CBH:Fire("Update", UIParent:GetWidth(), UIParent:GetHeight(), lib:GetResolutionInfo())
		self:Hide()
	end)

	hooksecurefunc('SetCVar', function(name, value)											-- Monitor CVar changes during normal play
		if not lib.CVars[name] then return end
		lib.frame:Show()
	end)

	hooksecurefunc('SetScreenResolution', function(value)									-- In case a setting combo doesn't trigger a CVar change
		if lib.resolution == GetCVar('gxResolution') then return end
		lib.frame:Show()
	end)
end

lib.resolution = lib.resolution or GetCVar('gxResolution')

if oldRevision < 1 then
	lib.mt = { __newindex = function() end }
end

--[=[----------------------------------------------------------------------------

LIB.AnchorPoints

	The anchor points used for frames, as a dictionary.

------------------------------------------------------------------------------]=]
if oldRevision < 1 then
	lib.AnchorPoints = setmetatable({ BOTTOM = 'BOTTOM', BOTTOMLEFT = 'BOTTOMLEFT', BOTTOMRIGHT = 'BOTTOMRIGHT', CENTER = 'CENTER', LEFT = 'LEFT', RIGHT = 'RIGHT', TOP = 'TOP', TOPLEFT = 'TOPLEFT', TOPRIGHT = 'TOPRIGHT' }, lib.mt)
end

--[=[----------------------------------------------------------------------------

LIB.StrataLayers

	The non-tooltip strata layers generally used by addons, as an array, from
	lowest to highest.

------------------------------------------------------------------------------]=]
if oldRevision < 1 then
	lib.StrataLayers = setmetatable({ 'BACKGROUND', 'LOW', 'MEDIUM', 'HIGH', 'DIALOG', 'FULLSCREEN', 'FULLSCREEN_DIALOG' }, lib.mt)
end

--[=[----------------------------------------------------------------------------

LIB:GetOffsets(frame [, point [, relFrame [, relPoint]]])

	Get the X and Y offsets of a frame relative to another frame.

Input:

	frame			(table)	 	The frame to get the offsets for.

	point			(string)		The point on frame to get the offsets for.  Defaults
									to 'CENTER' if nil.

	relFrame		(table)	 	The frame to get the offsets relative to.  Defaults to
									frame's parent if nil or to UIParent if frame has no
									parent.

	relPoint		(string)		The point on relFrame to get the offsets relative to.
									Defaults to point if nil.

Returns:

	x				(number)		The horizontal offset.

	y				(number)		The vertical offset.

------------------------------------------------------------------------------]=]
if oldRevision < 1 then
	local function get_offsets(frame, point)
		local left, bottom, width, height = GetRect(frame)
		if point == 'TOP' then
			return (left + left + width - 1) * 0.5, bottom + height - 1
		elseif point == 'BOTTOM' then
			return (left + left + width - 1) * 0.5, bottom
		elseif point == 'LEFT' then
			return left, (bottom + bottom + height - 1) * 0.5
		elseif point == 'RIGHT' then
			return left + width - 1, (bottom + bottom + height - 1) * 0.5
		elseif point == 'TOPLEFT' then
			return left, bottom + height - 1
		elseif point == 'TOPRIGHT' then
			return left + width - 1, bottom + height - 1
		elseif point == 'BOTTOMLEFT' then
			return left, bottom
		elseif point == 'BOTTOMRIGHT' then
			return left + width - 1, bottom
		else
			return (left + left + width - 1) * 0.5, (bottom + bottom + height - 1) * 0.5
		end
	end

	function lib.GetOffsets(frame, point, relFrame, relPoint)
		if type(frame) ~= 'table' then
			error(LIB .. ":GetOffsets(frame, point, relFrame, relPoint) - 'frame' expected table, got " .. type(frame), 2)
		elseif relFrame == nil then
			relFrame = frame:GetParent() or UIParent
		elseif type(relFrame) ~= 'table' then
			error(LIB .. ":GetOffsets(frame, point, relFrame, relPoint) - 'relFrame' expected table, got " .. type(relFrame), 2)
		end
		if point == nil then
			point = 'CENTER'
		elseif type(point) ~= 'string' then
			error(LIB .. ":GetOffsets(frame, point, relFrame, relPoint) - 'point' expected string or nil, got " .. type(point), 2)
		elseif not lib.AnchorPoints[point] then
			error(LIB .. ":GetOffsets(frame, point, relFrame, relPoint) - 'point' has an invalid value of '" .. point .. "'", 2)
		end
		if relPoint == nil then
			relPoint = point
		elseif type(relPoint) ~= 'string' then
			error(LIB .. ":GetOffsets(frame, point, relFrame, relPoint) - 'relPoint' expected string or nil, got " .. type(relPoint), 2)
		elseif not lib.AnchorPoints[relPoint] then
			error(LIB .. ":GetOffsets(frame, point, relFrame, relPoint) - 'relPoint' has an invalid value of '" .. relPoint .. "'", 2)
		end
		local frameX, frameY = get_offsets(frame, point)
		local relX, relY = get_offsets(relFrame, relPoint)
		return frameX - relX, frameY - relY
	end
end

--[=[----------------------------------------------------------------------------

LIB:GetResolutionInfo(resolution)

	Take a string representing a screen resolution and break it down into useful
	information.

Input:

	resolution	(string) 	The resolution to break down or nil to use the current
									resolution.  Example: 1024x768

Returns:

	width			(number)		The resolution width.

	height		(number)		The resolution height.

	isWide		(boolean)	Whether or not the resolution is wide-screen.

------------------------------------------------------------------------------]=]
if oldRevision < 0 then
	function lib:GetResolutionInfo(resolution)
		resolution = resolution or lib.resolution
		if type(resolution) ~= 'string' then
			error(LIB .. ":GetResolutionInfo(resolution) - 'resolution' expected string or nil, got " .. type(resolution), 2)
		end
		local width, height = strsplit('x', resolution)
		width, height = tonumber(width), tonumber(height)
		if not (width and height) then
			error(LIB .. ":GetResolutionInfo(resolution) - 'resolution' is not in the proper format", 2)
		end
		return width, height, height / width < 0.75
	end
end

--[=[----------------------------------------------------------------------------

LIB:Register(nameSpace, func [, arg])

	Register for a callback on the "Update" event.

Input:

	nameSpace	(table)		The addon that will be receiving the callback.

	func			(function)	A function reference or method name within nameSpace.
					(string)

	arg			(any)			An optional arguement to pass during the callback.

------------------------------------------------------------------------------]=]
if oldRevision < 0 then
	function lib:Register(nameSpace, ...)
		self.RegisterCallback(nameSpace, "Update", ...)
	end
end

--[=[----------------------------------------------------------------------------

LIB:Unregister(nameSpace)

	Unregister for the callback on the "Update" event.

Input:

	nameSpace	(table)		The addon that was receiving the callback.

------------------------------------------------------------------------------]=]
if oldRevision < 0 then
	function lib:Unregister(nameSpace)
		self.UnregisterCallback(nameSpace, "Update")
	end
end
