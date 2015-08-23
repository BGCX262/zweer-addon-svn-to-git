-- TODO: toggle "use gear set" <> "don't use gear set"
local f = CreateFrame"Frame"
local block, char, tip, tipshown, f1, f2, f3
local DEFAULT_ICON = "Interface\\Icons\\Spell_Shadow_SacrificialShield"
local orgSetActiveTalentGroup = SetActiveTalentGroup
local gearManagerHooked, waitingInput, popupData, talentGroup
local POPUP_SET_ALIAS = "ABSS_SET_ALIAS"

local spam1 = ERR_LEARN_ABILITY_S:gsub("%.", "%."):gsub("%%s", "(.*)")
local spam2 = ERR_LEARN_SPELL_S:gsub("%.", "%."):gsub("%%s", "(.*)")
local spam3 = ERR_SPELL_UNLEARNED_S:gsub("%.", "%."):gsub("%%s", "(.*)")

local function SpamFilter(self, event, msg)
	if strfind(msg, spam1) or strfind(msg, spam2) or strfind(msg, spam3) then return true end
end

local function WearSet(self, elapsed)
	f:SetScript("OnUpdate",nil)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SYSTEM", SpamFilter)
	local set = char[GetActiveTalentGroup()].set
	if set and GetEquipmentSetInfoByName(set) then UseEquipmentSet(set) end
end

function SetActiveTalentGroup(...)
	f:RegisterEvent"UNIT_SPELLCAST_SUCCEEDED"
	f:RegisterEvent"UNIT_SPELLCAST_STOP"
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", SpamFilter)
	return orgSetActiveTalentGroup(...)
end

function f:UNIT_SPELLCAST_STOP(event, unit)
	if unit ~= "player" then return end
	f:UnregisterEvent"UNIT_SPELLCAST_SUCCEEDED"
	f:UnregisterEvent"UNIT_SPELLCAST_STOP"
	if event == "UNIT_SPELLCAST_SUCCEEDED" then f:SetScript("OnUpdate", WearSet) end
end
f.UNIT_SPELLCAST_SUCCEEDED = f.UNIT_SPELLCAST_STOP


local function GetTalentText(group)
	local maxPoints, finalIcon, text = 0, DEFAULT_ICON
	for tab = 1, 3 do
		local icon, points = select( 4, GetTalentTabInfo(tab,nil,nil,group) )
		if points > maxPoints then
			maxPoints = points
			finalIcon = icon
		end
		text = format("%s%.2i", text and text.."/" or "", points)
	end
	return text, finalIcon
end


local function GearManager_RestoreButton(name,text)
	local b = _G["GearManagerDialog"..name.."Set"]
	b:SetText(text)
	b:SetScript("OnClick", _G["GearManagerDialog"..name.."Set_OnClick"])
end

local function GearSet_OnClick(self)
	if not waitingInput then return else waitingInput = false end

	local gmd = GearManagerDialog
	gmd.title:SetText(EQUIPMENT_MANAGER)

	GearManager_RestoreButton( "Delete", DELETE )
	GearManager_RestoreButton( "Equip", EQUIPSET_EQUIP )
	GearManager_RestoreButton( "Save",  SAVE )

	gmd:ClearAllPoints()
	gmd:SetParent(gmd.prevParent)
	gmd:SetPoint(unpack(gmd.prevPoint))
	gmd:Hide()

	if self ~= GearManagerDialogDeleteSet and self ~= GearManagerDialogEquipSet then return end
	local spec = char[talentGroup]
	spec.set = self == GearManagerDialogDeleteSet and GearManagerDialog.selectedSetName or nil
	if spec.aliasIsSetName then f:PLAYER_TALENT_UPDATE() end
end


block = LibStub("LibDataBroker-1.1"):NewDataObject("|cFFFFB366Ara|r SpecSwitcher", {
	type = "data source",
	icon = DEFAULT_ICON,
	iconCoords = { .08, .92, .08, .92 },
	text = "00/00/00",

	OnEnter = function(self)
		local showBelow = select(2, self:GetCenter()) > UIParent:GetHeight()/2
		tip:SetOwner( self, "ANCHOR_NONE" )
		tip:SetPoint( showBelow and "TOP" or "BOTTOM", self, showBelow and "BOTTOM" or "TOP" )

		local r = GetActiveTalentGroup()==1 and .1 or 1
		for i = 1, GetNumTalentGroups() do
			local spec, icon = GetTalentText(i)
			local group = char[i]
			local alias, setName, setIcon = group[spec], group.set
			spec = "\124T"..icon..":19:19:0:0:25:25:2:23:2:23\124t "..spec
			if setName then setIcon = GetEquipmentSetInfoByName(setName or "") end
			tip:AddDoubleLine(
				alias and (spec.."  |cffffffff"..alias) or spec,
				setIcon and (setName.."  |TInterface\\Icons\\"..setIcon..":19:19:0:0:25:25:2:23:2:23\124t") or "",
				r, 1.1-r, .1, r, 1.1-r, .1 )
			r = 1.1 - r
		end
		if not char.hideHints then tip:AddLine([[
|cffff8020Click|r to swap talent spec.
|cffff8020Shift+(Right)Click|r to associate a set.
|cffff8020Ctrl+(Right)Click|r to set an alias.
|cffff8020Right-Click|r to open talent frame.
|cffff8020Middle-Click|r to toggle hints.]], .2,1,.2) end

		tipshown = self
		f1, f2, f3 = GameTooltipTextLeft1:GetFont()
		GameTooltipTextLeft1:SetFont( GameTooltipTextLeft2:GetFont() )
		GameTooltipTextRight1:SetFont( GameTooltipTextLeft2:GetFont() )
		return tip:Show()
	end,


	OnLeave = function()
		tipshown = nil
		if f1 then
			GameTooltipTextLeft1:SetFont( f1, f2, f3 )
			GameTooltipTextRight1:SetFont( f1, f2, f3 )
		end
		return tip:Hide()
	end,


	OnClick = function(self, button)

		if IsShiftKeyDown() or IsControlKeyDown() then
			talentGroup = GetActiveTalentGroup()
			if button == "RightButton" then talentGroup = 3 - talentGroup end
			local talentText, talentIcon = GetTalentText(talentGroup)
			local talentPlate = (" |T%s:18:18:0:0:25:25:2:23:2:23|t %s%s|r"):format( talentIcon, button == "RightButton" and "|cffff1919" or "|cff19ff19", talentText )

			if IsShiftKeyDown() then
				if waitingInput == button then return GearSet_OnClick() end

				StaticPopup_Hide(POPUP_SET_ALIAS)
				block.OnLeave(self)
				local alias = char[talentGroup][talentText]
				if not GearManagerDialog then ToggleCharacter"PaperDollFrame" ToggleCharacter"PaperDollFrame" end --
				local gmd = GearManagerDialog
				gmd.title:SetFormattedText("Gear for %s |cffffffff%s", talentPlate, alias or "")
				gmd.prevParent = gmd.prevParent or gmd:GetParent()
				gmd.prevPoint = gmd.prevPoint or { gmd:GetPoint() }
				gmd:ClearAllPoints()
				gmd:SetParent(UIParent)
				gmd:SetClampedToScreen(true)
				local showBelow = select(2, self:GetCenter()) > UIParent:GetHeight()/2
				gmd:SetPoint(showBelow and "TOP" or "BOTTOM", self, showBelow and "BOTTOM" or "TOP")
				gmd:Show()
				gmd.selectedSetName = char[talentGroup].set
				GearManagerDialog_Update()
				waitingInput = button

				if not gearManagerHooked then
					gmd:HookScript("OnHide", GearSet_OnClick)
					gearManagerHooked = true
				end

				if gmd.selectedSet then
					GearManagerDialogDeleteSet:Enable()
				end
				GearManagerDialogDeleteSet:SetText(ACCEPT)
				GearManagerDialogDeleteSet:SetScript("OnClick", GearSet_OnClick)
				GearManagerDialogEquipSet:Enable()
				GearManagerDialogEquipSet:SetText(NONE)
				GearManagerDialogEquipSet:SetScript("OnClick", GearSet_OnClick)
				GearManagerDialogSaveSet:Enable()
				GearManagerDialogSaveSet:SetText(CANCEL)
				GearManagerDialogSaveSet:SetScript("OnClick", GearSet_OnClick)

			else
				local data = char[talentGroup]
				if StaticPopup_FindVisible( POPUP_SET_ALIAS, data ) then
					return StaticPopup_Hide( POPUP_SET_ALIAS, data )
				end

				if not StaticPopupDialogs[POPUP_SET_ALIAS] then
					local dialog = {
						text = "Set an alias for %s (spec %i).\nLeave blank to remove alias.",
						button3 = "Use gear set",
						OnAccept = function(self, spec)
							local input = self.editBox:GetText()
							spec[popupData] = input ~= "" and input or nil
							spec.aliasIsSetName = false
							f:PLAYER_TALENT_UPDATE()
						end,
						OnShow = function(self, spec)
							self.editBox:SetText(spec[popupData]or"")
							self.editBox:SetFocus()
						end,
						OnAlt = function(self, spec)
							spec.aliasIsSetName = true
							f:PLAYER_TALENT_UPDATE()
						end,
						EditBoxOnEnterPressed = function(self, spec)
							local p = self:GetParent()
							StaticPopupDialogs[POPUP_SET_ALIAS].OnAccept(p, spec)
							p:Hide()
						end,
						EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
						multiple = true,
					}
					for k, v in next, StaticPopupDialogs.RENAME_GUILD do
						if not dialog[k] then dialog[k] = v end
					end
				--	dialog.OnCancel, dialog.OnAlt = dialog.OnAlt, dialog.OnCancel
					StaticPopupDialogs[POPUP_SET_ALIAS] = dialog
				end

				if waitingInput then GearSet_OnClick() end
				popupData = talentText
				StaticPopup_Show( POPUP_SET_ALIAS, talentPlate, talentGroup, data)
			end
		elseif button == "RightButton" then
			ToggleTalentFrame()
		elseif button == "MiddleButton" then
			char.hideHints = not char.hideHints
			if tipshown then block.OnEnter(tipshown) end
		else
			SetActiveTalentGroup( 3 - GetActiveTalentGroup() )
		end
	end
})


function f:PLAYER_TALENT_UPDATE()
	local curr = char[GetActiveTalentGroup()]
	local spec, icon = GetTalentText()
	block.icon = curr.aliasIsSetName and GetEquipmentSetInfoByName(curr.set or "") and ("Interface\\Icons\\"..GetEquipmentSetInfoByName(curr.set or "")) or icon
	block.text = curr.aliasIsSetName and curr.set or curr[spec] or spec
	if tipshown then block.OnEnter(tipshown) end
end

function f:ACTIVE_TALENT_GROUP_CHANGED()
	f:SetScript("OnUpdate", WearSet)
end

function f:ADDON_LOADED(event, addon)
	if addon ~= "Ara_Broker_SpecSwitcher" then return end
	AraSpecSwitcherDBPC = AraSpecSwitcherDBPC or {{},{}}
	char = AraSpecSwitcherDBPC
	f:SetScript( "OnUpdate", function() f:SetScript("OnUpdate", nil) f:PLAYER_TALENT_UPDATE() end )
	f:RegisterEvent"PLAYER_TALENT_UPDATE"
	f:RegisterEvent"ACTIVE_TALENT_GROUP_CHANGED"
	f:RegisterEvent"PLAYER_ENTERING_WORLD"
	f:RegisterEvent"PLAYER_LEAVING_WORLD"
	tip = GameTooltip

	f:UnregisterEvent(event)
	f.ADDON_LOADED = nil
end

function f:PLAYER_LEAVING_WORLD() f:UnregisterEvent"PLAYER_TALENT_UPDATE" end
function f:PLAYER_ENTERING_WORLD() f:RegisterEvent"PLAYER_TALENT_UPDATE" end

f:SetScript( "OnEvent", function(self, event, ...) return self[event](self, event, ...) end )
f:RegisterEvent"ADDON_LOADED"