local addonName, addon = ...
setfenv(1, addon)

CONFIG_IS_OPEN = false
PanelList = { Add = DoNothing, Delete = DoNothing, Refresh = DoNothing, Select = DoNothing }
PluginList = PanelList																				-- Will assign a seperate table when needed

--[[-----------------------------------------------------------------------------
Config mode support
-------------------------------------------------------------------------------]]
GetSubTable(_G, 'CONFIGMODE_CALLBACKS')[addonName] = function(action)
	local lock
	if action == 'ON' then
		lock = false
	elseif action == 'OFF' then
		lock = true
	else
		return
	end
	settings.lockPanel = lock
	for _, settings in pairs(settings.panels) do
		settings.lockPanel = nil
	end
	AllPanels(lock and "Lock" or "Unlock")
	UpdateConfig(nil, true)
end

--[[-----------------------------------------------------------------------------
LoD support
-------------------------------------------------------------------------------]]
local LOA = LibStub('LibOptionsAssist-1.0', true)
if not (LOA and select(2, GetAddOnInfo(addonName .. '_Config'))) then return end	-- Make sure config support exists

local function LoadOnDemand()
	local config = addonName .. '_Config'
	addon.addonName, _G[config], PluginList = addonName, addon, { }					-- PanelList and PluginList are shared while they are dummies
	LibStub('LibOptionsAssist-1.0'):LoadModule(config)
	addon.addonName, _G[config] = nil, nil
	for index = 0, #ConfigFrames do
		ConfigFrames[index]:FlagAsLoaded()
	end
end

ConfigFrames = {
	[0] = LOA:AddEntry(addonName, nil, LoadOnDemand),
	[1] = LOA:AddEntry(L["Panels"], addonName, LoadOnDemand),
	[2] = LOA:AddEntry(L["Plugins"], addonName, LoadOnDemand),
	[3] = LOA:AddEntry(L["Profiles"], addonName, LoadOnDemand)
}

function OpenConfig()
	local open = 0
	for index = 0, #ConfigFrames do
		if ConfigFrames[index]:IsShown() then
			open = ConfigFrames[index]:IsVisible() and index + 1 or index
			break
		end
	end
	ConfigFrames[open % (#ConfigFrames + 1)]()
end

--[[-----------------------------------------------------------------------------
Quicklauncher
-------------------------------------------------------------------------------]]
LibStub('LibDataBroker-1.1'):NewDataObject(addonName, {
	type = 'launcher',
	icon = [[Interface\AddOns\]] .. addonName .. [[\Media\Icon]],
	iconCoords = { 2/64, 61/64, 3/64, 61/64 },
	label = addonName,
	OnClick = function()
		local open = 0
		for index = 0, #ConfigFrames do
			if ConfigFrames[index]:IsShown() then
				open = ConfigFrames[index]:IsVisible() and index + 1 or index
				break
			end
		end
		ConfigFrames[open % (#ConfigFrames + 1)]()
	end,
	OnTooltipShow = function(tooltip)
		tooltip:SetText(addonName, 1, 1, 1)
		tooltip:AddLine(L["Click to open the configuration panel."], NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
	end
})

--[[-----------------------------------------------------------------------------
Slash command
-------------------------------------------------------------------------------]]
_G['SLASH_' .. addonName .. 1] = '/' .. addonName
_G['SLASH_' .. addonName .. 2] = '/' .. addonName:lower()
_G['SLASH_' .. addonName .. 3] = '/' .. addonName:upper()
SlashCmdList[addonName] = ConfigFrames[0]
