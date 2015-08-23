------------------------------------------------------------------------
--  Get Blizzard infos, name and addon table
------------------------------------------------------------------------
local _, EquipSwitch = ...

------------------------------------------------------------------------
--  Local variables
------------------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("Broker_EquipSwitch")
local menu, menuFrame, menuDirty
local db
local bes

------------------------------------------------------------------------
--  Forward declaration for some functions
------------------------------------------------------------------------
local onClick
local onTooltipShow
local hookedUseEquipmentSet

------------------------------------------------------------------------
--  Local functions
------------------------------------------------------------------------
local function onDisplayUpdate(text, icon)
	bes.text = text
	bes.icon = icon

	db.text = text
	db.icon = icon
end

local function hookedUseEquipmentSet(setName)
	for id = 1, GetNumEquipmentSets() do
		local name, icon = GetEquipmentSetInfo(id)
		if name == setName then
			return onDisplayUpdate(name, icon)
		end
	end
end

local function switchEquipmentSet(_, name)
	EquipmentManager_EquipSet(name)
end

------------------------------------------------------------------------
--  Table recycling, copied from Omen.lua by Xinhuan
------------------------------------------------------------------------
local newTable, delTable
do
	-- Table Pool for recycling tables 
	local tablePool = {}
	setmetatable(tablePool, {__mode = "kv"}) -- weak table for key and value

	-- Get a new table
	function newTable()
		local t = next(tablePool) or {}
		tablePool[t] = nil
		return t
	end

	-- Delete table and return to pool
	function delTable(t)
		if not t then return nil end -- save for nil values
		for k, v in pairs(t) do
			if type(v) == "table" then
				t[k] = delTable(v)
			end			
		end
		wipe(t)
		t[true] = true
		t[true] = nil
		tablePool[t] = true
		return nil -- return nil to assign input reference
	end
end

------------------------------------------------------------------------
--  The Addon
------------------------------------------------------------------------
function EquipSwitch:OnLoad()
	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("EQUIPMENT_SETS_CHANGED")

	bes = LibStub("LibDataBroker-1.1"):NewDataObject("Broker_EquipSwitch", {
		type = "data source",
		icon = "Interface\\PaperDollInfoFrame\\UI-GearManager-Button",
		text = L["No set"],
		OnClick = onClick,
		OnTooltipShow = onTooltipShow,
	})

	_G.EQUIPSWITCH = _G.EQUIPSWITCH or { text = bes.text, icon = bes.icon }	
	db = _G.EQUIPSWITCH

	onDisplayUpdate(db.text, db.icon)
end

function EquipSwitch:PLAYER_LOGIN()
	hooksecurefunc("UseEquipmentSet", hookedUseEquipmentSet)
	menuDirty = true
end

function EquipSwitch:EQUIPMENT_SETS_CHANGED()
	menuDirty = true
	menu = delTable(menu)
	onDisplayUpdate(L["No set"], "Interface\\PaperDollInfoFrame\\UI-GearManager-Button")
end

------------------------------------------------------------------------
--  Menu functions
------------------------------------------------------------------------
local function sortFunc(item1, item2)
	return item1.id < item2.id
end

local function menuCreate()
	menu = newTable()
	
	--  Request info for all sets and build a table
	for id = 1, GetNumEquipmentSets() do
		local name, icon = GetEquipmentSetInfo(id)
		local item = newTable()
		item.id = id
		
		item.text = name
		item.icon = icon
		item.arg1 = name
		item.func = switchEquipmentSet

		item.notCheckable = true

		menu[id] = item
	end
	-- Sort our table
	table.sort(menu, sortFunc)
end			

local function menuInit(self, level)
	level = level or 1

	-- Mainmenu, level 1	
	for _, value in pairs(menu) do
		UIDropDownMenu_AddButton(value, level)
	end
end

------------------------------------------------------------------------
--  Callbacks from LibDataBroker
------------------------------------------------------------------------
function onClick(self, button)
	if button == "LeftButton" then
		if not menuFrame then
			menuFrame = CreateFrame("Frame", "Broker_EquipSwitchMenu", UIParent, "UIDropDownMenuTemplate")
		end
		if menuDirty then
			menuCreate()
			UIDropDownMenu_Initialize(menuFrame, menuInit, "MENU")
			menuDirty = nil
		end
		ToggleDropDownMenu(1, nil, menuFrame, self, 20, 4)
	elseif button == "RightButton" then
		if not PaperDollFrame:IsVisible() then ToggleCharacter("PaperDollFrame") end
		if not GearManagerDialog:IsVisible() then GearManagerDialog:Show() end
	end
end

function onTooltipShow(tooltip)
	tooltip:AddLine("Broker: EquipSwitch")
	tooltip:AddLine(string.format(L["Current set: %s"], bes.text))
end
