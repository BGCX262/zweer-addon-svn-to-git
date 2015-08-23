local addonName, addon = ...
setmetatable(addon, { __index = _G })
setfenv(1, addon)

LibStub('AceEvent-3.0'):Embed(addon)

local gsub, pairs_iter, pcall, tostring, type = gsub, pairs(addon), pcall, tostring, type

local GetObjectType = UIParent.GetObjectType

local LDB = LibStub('LibDataBroker-1.1')

settings = false																						-- To avoid issues with a global named 'settings' (it's happened)

--[[-----------------------------------------------------------------------------
Helper functions
-------------------------------------------------------------------------------]]
local function UpdateProfile()
	AllPanels("Recycle")
	settings = GetSettings()
	for id, settings in pairs_iter, settings.panels, nil do
		if settings.enable then
			CreatePanel(id)
		end
	end
	PanelList:Refresh()
	PluginList:Refresh()
end

RESOLUTION_HEIGHT, RESOLUTION_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH = 768, 1024, 768, 1024
SCREEN_HEIGHT_MIDDLE, SCREEN_WIDTH_MIDDLE = SCREEN_HEIGHT / 2, SCREEN_WIDTH / 2
local function UpdateResolution(event, screenWidth, screenHeight, resolutionWidth, resolutionHeight)
	RESOLUTION_HEIGHT, RESOLUTION_WIDTH, SCREEN_HEIGHT, SCREEN_WIDTH = resolutionHeight, resolutionWidth, screenHeight, screenWidth
	SCREEN_HEIGHT_MIDDLE, SCREEN_WIDTH_MIDDLE = screenHeight / 2, screenWidth / 2
	UpdateConfig()
end

local function UpdateSharedMedia(event, type)
	if type == 'border' or type == 'font' or type == 'statusbar' or type == 'statusbar_overlay' then
		addon:QueueMethod("UpdateConfig")
	end
end

--[[-----------------------------------------------------------------------------
Global to addon
-------------------------------------------------------------------------------]]
LSM, PHI = LibStub('LibSharedMedia-3.0'), 2 / (sqrt(5) + 1)
LDB_RegisterCallback, LDB_UnregisterCallback = LDB.RegisterCallback, LDB.UnregisterCallback
hideConditions , sectionTypes = { hide = 0, Hide = 0, HIDE = 0, ["0"] = 0 }, { Center = "Center", Left = "Left", Right = "Right" }
dataObj, panels, plugins = { }, { }, { }

L = setmetatable({ }, { __index = function(self, key)
	self[key] = key
	return key
end })

mt_subtables = {
	__index = function(self, key)
		self[key] = { }
		return self[key]
	end
}

function safecall(...)
	local ok, result = pcall(...)
	if ok then
		return result
	elseif not settings.hideErrors then
		geterrorhandler()(result)
	end
end

function tremove_byVal(table, value)
	for index = 1, #table do
		if table[index] == value then
			tremove(table, index)
			return true
		end
	end
end

function AllPanels(method, ...)
	for index = #addon, 1, -1 do																	-- Reversed order so that panel:Recycle() will work properly
		addon[index][method](addon[index], ...)
	end
end

function ConnectTooltip(frame, tooltip, scale)
	if tooltip.SetOwner then
		safecall(tooltip.SetOwner, tooltip, frame, 'ANCHOR_NONE')
	end
	safecall(tooltip.SetPoint, tooltip, GetAnchorInfo(frame))
	local oldScale = safecall(tooltip.GetScale, tooltip)
	if oldScale then
		safecall(tooltip.SetScale, tooltip, scale or frame.settings.tooltipScale)
		return oldScale
	end
end

function DoNothing()
end

function GetAnchorInfo(frame)
	local _, y = frame:GetCenter()
	if y >= SCREEN_HEIGHT_MIDDLE then
		return 'TOP', frame, 'BOTTOM', 0, 0
	end
	return 'BOTTOM', frame, 'TOP', 0, 0
end

function GetSubTable(table, key, ...)
	local tableKey = table[key]
	if type(tableKey) ~= 'table' then
		tableKey = { }
		local field, value
		for index = 1, select('#', ...), 2 do
			field, value = select(index, ...)
			tableKey[field] = value
		end
		table[key] = tableKey
	end
	return tableKey
end

function IsFrame(object)
	return pcall(GetObjectType, object)
end

function RemoveColorCodes(string)
	local type = type(string)
	if type == 'string' then
		return gsub(gsub(string, "\|[Rr]", ""), "\|[Cc]%x%x%x%x%x%x%x%x", "")
	elseif type == 'number' then
		return tostring(string)
	end
	return ""
end

function UpdateConfig(self, noRefresh)
	if noRefresh then return end
	AllPanels("Refresh")
end

--[[-----------------------------------------------------------------------------
Key Generator
-------------------------------------------------------------------------------]]
do
	local digit, base, chrono = {
		'#', '$', '%', '&', '*', '+', '-', '.', '0', '1', '2', '3', '4', '5', '6',
		'7', '8', '9', ':', '=', '?', '@', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
		'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
		'X', 'Y', 'Z', '^', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
		'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
	}
	base, chrono, digit[0] = #digit + 1, 0, '!'

	function GenerateUniqueKey()
		local key, time = "", time() - 1262325600												-- Epoch: 2010 Jan 01 00:00:00
		if chrono >= time then
			time = chrono + 1
		end
		chrono = time
		while time >= base do
			time, key = floor(time / base), digit[time % base] .. key
		end
		if time > 0 or key == "" then
			key = digit[time] .. key
		end
		return key
	end
end

--[[-----------------------------------------------------------------------------
Queue - delays a method until the next OnUpdate, used to throttle stuff
-------------------------------------------------------------------------------]]
do
	local caller, shown = CreateFrame('Frame')
	caller:Hide()

	local process, queue = setmetatable({ }, mt_subtables), setmetatable({ }, mt_subtables)

	caller:SetScript('OnUpdate', function(self)
		self:Hide()
		process, queue, shown = queue, process, nil											-- Fix for a queued method triggering a call to QueueMethod
		for object, methods in pairs_iter, process, nil do
			for method, arg in pairs_iter, methods, nil do
				object[method](object, arg)
				methods[method] = nil
			end
		end
	end)

	function PurgeQueue(object, method)
		if method then
			queue[object][method] = nil
			if not pairs_iter(queue[object]) then
				process[object], queue[object] = nil, nil
			end
		else
			process[object], queue[object] = nil, nil
		end
	end

	function QueueMethod(object, method, arg)
		queue[object][method] = arg or false
		if not shown then
			shown = true
			caller:Show()
		end
	end
end

--[[-----------------------------------------------------------------------------
Data Objects
-------------------------------------------------------------------------------]]
local ValidateDataObject

do
	local function DetectType(_, name, _, _, data)
		ValidateDataObject(_, name, data)
		LDB_UnregisterCallback(addon, 'LibDataBroker_AttributeChanged_' .. name .. '_type')
	end

	function ValidateDataObject(_, name, data)
		local type = data.type
		if type == nil then																			-- Just in case type == false
			LDB_RegisterCallback(addon, 'LibDataBroker_AttributeChanged_' .. name .. '_type', DetectType)
		elseif (type == 'data source' or type == 'launcher') and not dataObj[name] then
			dataObj[name], pluginType[name] = data, type
			if GetPluginSettings(name).enable then
				CreatePlugin(name)
			else
				PluginList:Add(name)
			end
		end
	end
end

--[[-----------------------------------------------------------------------------
Initialize display/media
-------------------------------------------------------------------------------]]
LibStub('LibDisplayAssist-1.2'):Register(addon, function(...)							-- Runs on first frame update to ensure proper sizing
	LibStub('LibDisplayAssist-1.2'):Register(addon, UpdateResolution)
	UpdateResolution(...)																			-- Refreshes panels/plugins
	UpdateProfile()
	for name, data in LDB:DataObjectIterator() do											-- Check for plugins
		ValidateDataObject(nil, name, data)
	end
	addon.db.RegisterCallback(addon, 'OnProfileChanged', UpdateProfile)
	addon.db.RegisterCallback(addon, 'OnProfileCopied', UpdateProfile)
	addon.db.RegisterCallback(addon, 'OnProfileReset', UpdateProfile)
	LDB_RegisterCallback(addon, 'LibDataBroker_DataObjectCreated', ValidateDataObject)
	LSM.RegisterCallback(addon, 'LibSharedMedia_Registered', UpdateSharedMedia)
	LSM.RegisterCallback(addon, 'LibSharedMedia_SetGlobal', UpdateSharedMedia)
end)

LSM:Register('statusbar', "Blizzard Gradient", [[Interface\WorldStateFrame\WORLDSTATEFINALSCORE-HIGHLIGHT]])
LSM:Register('statusbar', "Empty", [[Interface\AddOns\]] .. addonName .. [[\Media\None]])
LSM:Register('statusbar', "Solid", [[Interface\BUTTONS\WHITE8X8]])

LSM:Register('statusbar_overlay', "Line, Gradient", [[Interface\AddOns\]] .. addonName .. [[\Media\Line, Gradient]])
LSM:Register('statusbar_overlay', "Line, Gradient (Center)", [[Interface\AddOns\]] .. addonName .. [[\Media\Line, Gradient (Center)]])
LSM:Register('statusbar_overlay', "Line, Solid", [[Interface\AddOns\]] .. addonName .. [[\Media\Line, Solid]])
LSM:Register('statusbar_overlay', "Gloss", [[Interface\AddOns\]] .. addonName .. [[\Media\Gloss]])
LSM:Register('statusbar_overlay', "None", [[Interface\AddOns\]] .. addonName .. [[\Media\None]])

LSM:SetDefault('statusbar_overlay', "None")
