--[[
Copyright (C) 2009-2010 Adirelle

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
--]]

local addonName, ns = ...

------------------------------------------------------------------------------
-- Our main frame
------------------------------------------------------------------------------

local InlineAura = CreateFrame('Frame', 'InlineAura')

------------------------------------------------------------------------------
-- Retrieve the localization table
------------------------------------------------------------------------------

local L = ns.L
InlineAura.L = L

------------------------------------------------------------------------------
-- Locals
------------------------------------------------------------------------------

local db

local auraChanged = {}
local unitGUIDs = {}
local timerFrames = {}
local needUpdate = false
local configUpdated = false

local buttons = {}
local newButtons = {}
local activeButtons = {}
InlineAura.buttons = buttons

------------------------------------------------------------------------------
-- Make often-used globals local
------------------------------------------------------------------------------

local UnitCanAssist, UnitCanAttack = UnitCanAssist, UnitCanAttack
local UnitGUID, UnitIsUnit, UnitAura = UnitGUID, UnitIsUnit, UnitAura
local IsHarmfulSpell, IsHelpfulSpell = IsHarmfulSpell, IsHelpfulSpell
local unpack, type, pairs, rawget, next = unpack, type, pairs, rawget, next
local strsplit, strtrim, strsub, select = strsplit, strtrim, strsub, select
local format, ceil, floor, tostring, gsub = format, ceil, floor, tostring, gsub
local GetTotemInfo, GetActionInfo, GetItemInfo = GetTotemInfo, GetActionInfo, GetItemInfo
local GetNumTrackingTypes, GetTrackingInfo = GetNumTrackingTypes, GetTrackingInfo
local SecureCmdOptionParse, GetMacroBody = SecureCmdOptionParse, GetMacroBody
local GetCVarBool, SecureButton_GetModifiedUnit = GetCVarBool, SecureButton_GetModifiedUnit
local GetMacroSpell, GetMacroItem, IsHelpfulItem = GetMacroSpell, GetMacroItem, IsHelpfulItem

local ActionButton_ShowOverlayGlow = ActionButton_ShowOverlayGlow -- Hook protection
local ActionButton_UpdateOverlayGlow = ActionButton_UpdateOverlayGlow -- Hook protection

------------------------------------------------------------------------------
-- Libraries and helpers
------------------------------------------------------------------------------

local LSM = LibStub('LibSharedMedia-3.0')

local function dprint() end
--[===[@debug@
if tekDebug then
	local frame = tekDebug:GetFrame(addonName)
	local function mytostringall(a, ...)
		local str
		if type(a) == "table" and type(a.GetName) == "function" then
			str = format("|cffff8844[%s]|r", tostring(a:GetName()))
		else
			str = tostring(a)
		end
		if select('#', ...) > 0 then
			return str, mytostringall(...)
		else
			return str
		end
	end
	dprint = function(...)
		return frame:AddMessage(gsub(strjoin(" ", mytostringall(...)), "= ", "="))
	end
end
--@end-debug@]===]
InlineAura.dprint = dprint

------------------------------------------------------------------------------
-- Constants
------------------------------------------------------------------------------
local FONTMEDIA = LSM.MediaType.FONT

local FONT_NAME = LSM:GetDefault(FONTMEDIA)
local FONT_FLAGS = "OUTLINE"
local FONT_SIZE_SMALL = 13
local FONT_SIZE_LARGE = 20

local DEFAULT_OPTIONS = {
	profile = {
		onlyMyBuffs = true,
		onlyMyDebuffs = true,
		hideCountdown = false,
		hideStack = false,
		showStackAtTop = false,
		preciseCountdown = false,
		decimalCountdownThreshold = 10,
		singleTextPosition = 'BOTTOM',
		twoTextFirstPosition = 'BOTTOMLEFT',
		twoTextSecondPosition = 'BOTTOMRIGHT',
		fontName = FONT_NAME,
		smallFontSize     = FONT_SIZE_SMALL,
		largeFontSize     = FONT_SIZE_LARGE,
		colorBuffMine     = { 0.0, 1.0, 0.0, 1.0 },
		colorBuffOthers   = { 0.0, 1.0, 1.0, 1.0 },
		colorDebuffMine   = { 1.0, 0.0, 0.0, 1.0 },
		colorDebuffOthers = { 1.0, 1.0, 0.0, 1.0 },
		colorCountdown    = { 1.0, 1.0, 1.0, 1.0 },
		colorStack        = { 1.0, 1.0, 0.0, 1.0 },
		spells = {
			['**'] = {
				disabled = false,
				auraType = 'regular',
				highlight = 'border',
				default = false,
			},
		},
		enabledUnits = {
			player = true,
			pet = true,
			target = true,
			focus = true,
			mouseover = false,
		}
	},
}
InlineAura.DEFAULT_OPTIONS = DEFAULT_OPTIONS

-- Events only needed if the unit is enabled
local UNIT_EVENTS = {
	focus = 'PLAYER_FOCUS_CHANGED',
	mouseover = 'UPDATE_MOUSEOVER_UNIT',
}

------------------------------------------------------------------------------
-- Some Unit helpers
------------------------------------------------------------------------------

local MY_UNITS = { player = true, pet = true, vehicle = true }

-- These two functions return nil when unit does not exist
local UnitIsBuffable = function(unit) return MY_UNITS[unit] or UnitCanAssist('player', unit) end
local UnitIsDebuffable = function(unit) return UnitCanAttack('player', unit) end

------------------------------------------------------------------------------
-- Special "auras" handling
------------------------------------------------------------------------------

local SPECIALS = {}
local SPECIALS_EVENTS = {}
InlineAura.SPECIALS = SPECIALS

function InlineAura:RegisterSpecial(name, testFunc, event, handler)
	SPECIALS[name] = testFunc
	SPECIALS_EVENTS[name] = event
	if event and handler then
		if self[event] then
			hooksecurefunc(self, event, handler)
		else
			self[event] = handler
		end
	end
end

local UpdateSpecialListeners
do
	local t = {}
	function UpdateSpecialListeners()
		wipe(t)
		for special, event in pairs(SPECIALS_EVENTS) do
			t[event] = false
		end
		for name, spell in pairs(db.profile.spells) do
			if not spell.disabled and spell.aliases then
				for i, alias in pairs(spell.aliases) do
					local event = SPECIALS_EVENTS[alias]
					if event then
						t[event] = alias
					end
				end
			end
		end
		for event, enabled in pairs(t) do
			if enabled then
				if not InlineAura:IsEventRegistered(event) then
					--[===[@debug@
					dprint("Starting listening for event", event, "for special", enabled)
					--@end-debug@]===]
					InlineAura:RegisterEvent(event)
					InlineAura[event](InlineAura, "UpdateSpecialListeners")
				end
			elseif InlineAura:IsEventRegistered(event) then
				--[===[@debug@
				dprint("Stopping listening for", event)
				--@end-debug@]===]
				InlineAura:UnregisterEvent(event)
				InlineAura[event](InlineAura, "UpdateSpecialListeners")
			end
		end
	end
end

------------------------------------------------------------------------------
-- Countdown formatting
------------------------------------------------------------------------------

local function GetPreciseCountdownText(timeLeft, threshold)
	if timeLeft >= 3600 then
		return format(L["%dh"], floor(timeLeft/3600)), 1 + floor(timeLeft) % 3600
	elseif timeLeft >= 600 then
		return format(L["%dm"], floor(timeLeft/60)), 1 + floor(timeLeft) % 60
	elseif timeLeft >= 60 then
		return format("%d:%02d", floor(timeLeft/60), floor(timeLeft%60)), timeLeft % 1
	elseif timeLeft >= threshold then
		return tostring(floor(timeLeft)), timeLeft % 1
	elseif timeLeft >= 0 then
		return format("%.1f", floor(timeLeft*10)/10), 0
	else
		return "0"
	end
end

local function GetImpreciseCountdownText(timeLeft)
	if timeLeft >= 3600 then
		return format(L["%dh"], ceil(timeLeft/3600)), ceil(timeLeft) % 3600
	elseif timeLeft >= 60 then
		return format(L["%dm"], ceil(timeLeft/60)), ceil(timeLeft) % 60
	elseif timeLeft > 0 then
		return tostring(floor(timeLeft)), timeLeft % 1
	else
		return "0"
	end
end

local function GetCountdownText(timeLeft, precise, threshold)
	return (precise and GetPreciseCountdownText or GetImpreciseCountdownText)(timeLeft, threshold)
end

------------------------------------------------------------------------------
-- Safecall
------------------------------------------------------------------------------

local safecall
do
	local pcall, geterrorhandler, _ERRORMESSAGE = pcall, geterrorhandler, _ERRORMESSAGE
	local reported = {}

	local function safecall_inner(ok, ...)
		if not ok then
			local msg = ...
			local handler = geterrorhandler()
			if handler == _ERRORMESSAGE then
				if not reported[msg] then
					reported[msg] = true
					print('|cffff0000InlineAura error report:|r', msg)
				end
			else
				handler(msg)
			end
		else
			return ...
		end
	end

	function safecall(...)
		return safecall_inner(pcall(...))
	end
end

------------------------------------------------------------------------------
-- Home-made bucketed timers
------------------------------------------------------------------------------
-- This is mainly a simplified version of AceTimer-3.0, credits goes to Ace3 authors

local ScheduleTimer, CancelTimer, TimerCallback
do
	local assert, type, next, floor, GetTime = assert, type, next, floor, GetTime
	local BUCKETS = 131
	local HZ = 20
	local buckets = {}
	local targets = {}
	for i = 1, BUCKETS do buckets[i] = {} end

	local lastIndex = floor(GetTime()*HZ)

	function ScheduleTimer(target, delay)
		assert(target and type(delay) == "number" and delay >= 0)
		if targets[target] then
			buckets[targets[target]][target] = nil
		end
		local when = GetTime() + delay
		local index = floor(when*HZ) + 1
		local bucketNum = 1 + (index % BUCKETS)
		buckets[bucketNum][target] = when
		targets[target] = bucketNum
	end

	function CancelTimer(target)
		assert(target)
		local bucketNum = targets[target]
		if bucketNum then
			buckets[bucketNum][target] = nil
			targets[target] = nil
		end
	end

	function ProcessTimers()
		local now = GetTime()
		local newIndex = floor(now*HZ)
		for index = lastIndex + 1, newIndex do
			local bucketNum = 1 + (index % BUCKETS)
			local bucket = buckets[bucketNum]
			for target, when in next, bucket do
				if when <= now then
					bucket[target] = nil
					targets[target] = nil
					safecall(TimerCallback, target)
				end
			end
		end
		lastIndex = newIndex
	end
end

------------------------------------------------------------------------------
-- Timer frame handling
------------------------------------------------------------------------------

local TimerFrame_OnUpdate, TimerFrame_Skin, TimerFrame_Display, TimerFrame_UpdateCountdown

local function SetTextPosition(text, position)
	text:SetJustifyH(position:match('LEFT') or position:match('RIGHT') or 'MIDDLE')
	text:SetJustifyV(position:match('TOP') or position:match('BOTTOM') or 'CENTER')
end

function TimerFrame_UpdateTextLayout(self)
	local stackText, countdownText = self.stackText, self.countdownText
	if countdownText:IsShown() and stackText:IsShown() then
		SetTextPosition(countdownText, InlineAura.db.profile.twoTextFirstPosition)
		SetTextPosition(stackText, InlineAura.db.profile.twoTextSecondPosition)
	elseif countdownText:IsShown() then
		SetTextPosition(countdownText, InlineAura.db.profile.singleTextPosition)
	elseif stackText:IsShown() then
		SetTextPosition(stackText, InlineAura.db.profile.singleTextPosition)
	end
end

function TimerFrame_Skin(self)
	local font = LSM:Fetch(FONTMEDIA, db.profile.fontName)

	local countdownText = self.countdownText
	countdownText.fontName = font
	countdownText.baseFontSize = db.profile[InlineAura.bigCountdown and "largeFontSize" or "smallFontSize"]
	countdownText:SetFont(font, countdownText.baseFontSize, FONT_FLAGS)
	countdownText:SetTextColor(unpack(db.profile.colorCountdown))

	local stackText = self.stackText
	stackText:SetFont(font, db.profile.smallFontSize, FONT_FLAGS)
	stackText:SetTextColor(unpack(db.profile.colorStack))

	TimerFrame_UpdateTextLayout(self)
end

function TimerFrame_OnUpdate(self)
	TimerFrame_UpdateCountdown(self, GetTime())
end

-- Compat
TimerFrame_CancelTimer = CancelTimer
TimerCallback = TimerFrame_OnUpdate

local dynamicModifiers = {
	-- { font scale, r, g, b }
	{ 1.3, 1, 0, 0 }, -- soon
	{ 1.0, 1, 1, 0 }, -- in less than a minute
	{ 0.8, 1, 1, 1 }, -- in more than a minute
}

function TimerFrame_UpdateCountdown(self, now)
	local timeLeft = self.expirationTime - now
	local displayTime, delay = GetCountdownText(timeLeft, db.profile.preciseCountdown, db.profile.decimalCountdownThreshold)
	local countdownText = self.countdownText
	countdownText:SetText(displayTime)
	if db.profile.dynamicCountdownColor then
		local phase = (timeLeft <= 5 and 1) or (timeLeft <= 60 and 2) or 3
		if phase ~= self.dynamicPhase then
			self.dynamicPhase = phase
			local scale, r, g, b = unpack(dynamicModifiers[phase])
			if InlineAura.bigCountdown then
				countdownText:SetFont(countdownText.fontName, countdownText.actualFontSize * scale, FONT_FLAGS)
			end
			countdownText:SetTextColor(r, g, b)
		end
	end
	if delay then
		ScheduleTimer(self, math.min(delay, timeLeft))
	end
end

function TimerFrame_Display(self, expirationTime, count, now)
	local stackText, countdownText = self.stackText, self.countdownText

	if count then
		stackText:SetText(count)
		stackText:Show()
	else
		stackText:Hide()
	end

	if expirationTime then
		self.expirationTime = expirationTime
		countdownText:Show()
		countdownText:SetFont(countdownText.fontName, countdownText.baseFontSize, FONT_FLAGS)
		local sizeRatio = countdownText:GetStringWidth() / (self:GetWidth()-4)
		if sizeRatio > 1 then
			countdownText.actualFontSize = countdownText.baseFontSize / sizeRatio
			countdownText:SetFont(countdownText.fontName, countdownText.actualFontSize, FONT_FLAGS)
		else
			countdownText.actualFontSize = countdownText.baseFontSize
		end
		self.dynamicPhase = nil
		TimerFrame_UpdateCountdown(self, now)
	else
		TimerFrame_CancelTimer(self)
		countdownText:Hide()
	end

	if stackText:IsShown() or countdownText:IsShown() then
		self:Show()
		TimerFrame_UpdateTextLayout(self)
	else
		self:Hide()
	end
end

local function CreateTimerFrame(button)
	local timer = CreateFrame("Frame", nil, button)
	local cooldown = _G[button:GetName()..'Cooldown']
	timer:SetFrameLevel(cooldown:GetFrameLevel() + 5)
	timer:SetAllPoints(cooldown)
	timer:SetToplevel(true)
	timer:Hide()
	timer:SetScript('OnHide', TimerFrame_CancelTimer)
	timerFrames[button] = timer

	local countdownText = timer:CreateFontString(nil, "OVERLAY")
	countdownText:SetAllPoints(timer)
	countdownText:Show()
	timer.countdownText = countdownText

	local stackText = timer:CreateFontString(nil, "OVERLAY")
	stackText:SetAllPoints(timer)
	timer.stackText = stackText

	TimerFrame_Skin(timer)

	return timer
end

------------------------------------------------------------------------------
-- LibButtonFacade compatibility
------------------------------------------------------------------------------

local function SetVertexColor(texture, r, g, b, a)
	texture:SetVertexColor(r, g, b, a)
end

local function LBF_SetVertexColor(texture, r, g, b, a)
	local R, G, B, A = texture:GetVertexColor()
	texture:SetVertexColor(r*R, g*G, b*B, a*(A or 1))
end

local function LBF_Callback()
	configUpdated = true
end

------------------------------------------------------------------------------
-- Aura lookup
------------------------------------------------------------------------------

local TOTEMS = {}
local AuraLookup
do
	local function CheckAuraAny(aura, unit, helpfulFilter, harmfulFilter)
		-- Look for debuff or buff
		local isDebuff = false
		local name, _, _, count, _, duration, expirationTime, caster = UnitAura(unit, aura, nil, harmfulFilter)
		if name then
			isDebuff = true
		else
			name, _, _, count, _, duration, expirationTime, caster = UnitAura(unit, aura, nil, helpfulFilter)
		end
		if name then
			return name, count ~= 0 and count or nil, duration and duration ~= 0 and expirationTime or nil, isDebuff, caster and MY_UNITS[caster], true
		end
	end

	local function CheckTotem(spell)
		spell = strlower(spell)
		for slot = 1, 4 do
			local haveTotem, name, startTime, duration = GetTotemInfo(slot)
			if haveTotem and name and strlower(name) == spell then
				return name, nil, startTime and duration and (startTime + duration) or nil, false, true, true
			end
		end
	end

	local function CheckAuraPlayer(aura, unit, helpfulFilter, harmfulFilter)
		if SPECIALS[aura] then
			-- Specials only exists on player
			local count, highlight = SPECIALS[aura]()
			--[===[@debug@
			dprint("CheckAuraPlayer:SPECIALS", aura, '=>', count, highlight)
			--@end-debug@]===]
			if count and count ~= 0 then
				return aura, count, nil, false, true, highlight
			end
		elseif TOTEMS[aura] then
			return CheckTotem(aura)
		else
			return CheckAuraAny(aura, unit, helpfulFilter, harmfulFilter)
		end
	end

	function AuraLookup(unit, onlyMyBuffs, onlyMyDebuffs, ...)
		local helpfulFilter = onlyMyBuffs and "HELPFUL PLAYER" or "HELPFUL"
		local harmfulFilter = onlyMyDebuffs and "HARMFUL PLAYER" or "HARMFUL"
		local checkFunc = UnitIsUnit(unit, "player") and CheckAuraPlayer or CheckAuraAny
		local name, count, expirationTime, isDebuff, isMine, highlight
		for i = 1, select('#', ...) do
			local newName, newCount, newExpirationTime, newIsDebuff, newIsMine, newHighlight = checkFunc(select(i, ...), unit, helpfulFilter, harmfulFilter)
			if newName then
				if not newExpirationTime then -- no expiration time == forever
					return newName, newCount, newExpirationTime, newIsDebuff, newIsMine, newHighlight
				elseif not name or newExpirationTime > expirationTime then
					name, count, expirationTime, isDebuff, isMine, highlight = newName, newCount, newExpirationTime, newIsDebuff, newIsMine, newHighlight
				end
			end
		end
		return name, count, expirationTime, isDebuff, isMine, highlight
	end
end

local EMPTY_TABLE = {}
local function GetAuraToDisplay(spell, target, specific)
	local aliases
	local highlight = "border"
	local hideStack = db.profile.hideStack
	local hideCountdown = db.profile.hideCountdown
	local onlyMyBuffs = db.profile.onlyMyBuffs
	local onlyMyDebuffs = db.profile.onlyMyDebuffs

	-- Specific spell overrides global settings
	if specific then
		highlight = specific.highlight
		aliases = specific.aliases
		if specific.hideStack ~= nil then
			hideStack = specific.hideStack
		end
		if specific.hideCountdown ~= nil then
			hideCountdown = specific.hideCountdown
		end
		if specific.auraType == "special" then
			onlyMyBuffs, onlyMyDebuffs, hideStack, hideCountdown = true, true, false, false
		elseif specific.onlyMine ~= nil then
			onlyMyBuffs, onlyMyDebuffs = specific.onlyMine, specific.onlyMine
		end
	end

	-- Look for the aura or its aliases
	local name, count, expirationTime, isDebuff, isMine, showHighlight = AuraLookup(target, onlyMyBuffs, onlyMyDebuffs, spell, unpack(aliases or EMPTY_TABLE))

	if specific and specific.invertHighlight then
		showHighlight = not showHighlight
		if not name then
			name = spell
			isDebuff = UnitIsDebuffable(target)
			if isDebuff then
				isMine = onlyMyDebuffs
			else
				isMine = onlyMyBuffs
			end
		end
	end

	if name then
		return name, (not hideStack) and count or nil, (not hideCountdown) and expirationTime or nil, isDebuff, isMine, showHighlight and highlight or "none"
	end
end

------------------------------------------------------------------------------
-- Visual feedback hooks
------------------------------------------------------------------------------

local function UpdateTimer(self)
	local state = buttons[self]
	if state.name and (state.expirationTime or state.count) then
		local now = GetTime()
		local expirationTime = state.expirationTime
		if expirationTime and expirationTime <= now then
			expirationTime = nil
		end
		local count = state.count
		if count == 0 then
			count = nil
		end
		if expirationTime or count then
			local frame = timerFrames[self] or CreateTimerFrame(self)
			return TimerFrame_Display(frame, expirationTime, count, now)
		end
	end
	if timerFrames[self] then
		timerFrames[self]:Hide()
	end
end

local function ActionButton_HideOverlayGlow_Hook(self)
	local state = buttons[self]
	if not state then return end
	if state.highlight == "glowing" then
		--[===[@debug@
		self:Debug("Enforcing glowing for", state.name)
		--@end-debug@]===]
		return ActionButton_ShowOverlayGlow(self)
	end
end

local function UpdateButtonState_Hook(self)
	local state = buttons[self]
	if not state then return end
	local texture = self:GetCheckedTexture()
	if state.highlight == "border" then
		--[===[@debug@
		self:Debug("Showing border for", state.name)
		--@end-debug@]===]
		local color = db.profile['color'..(state.isDebuff and "Debuff" or "Buff")..(state.isMine and 'Mine' or 'Others')]
		self:SetChecked(true)
		SetVertexColor(texture, unpack(color))
	else
		texture:SetVertexColor(1, 1, 1)
	end
end

------------------------------------------------------------------------------
-- Aura updating
------------------------------------------------------------------------------

local function FindMacroOptions(...)
	for i = 1, select('#', ...) do
		local line = select(i, ...)
		local prefix, suffix = strsplit(" ", strtrim(line), 2)
		if suffix and (prefix == '#show' or prefix == '#showtooltip' or strsub(prefix, 1, 1) ~= "#") then
			return suffix
		end
	end
end

local function GuessMacroTarget(index)
	local body = assert(GetMacroBody(index), format("Can't find macro body for %q", index))
	local options = FindMacroOptions(strsplit("\n", body))
	if options then
		local action, target = SecureCmdOptionParse(options)
		if action and action ~= "" and target and target ~= "" then
			return target
		end
	end
end

local function GuessSpellTarget(spell, helpful)
	if IsModifiedClick("SELFCAST") then
		return "player"
	elseif IsModifiedClick("FOCUSCAST") then
		return "focus"
	elseif spell and helpful and not UnitIsBuffable("target") and GetCVarBool("autoSelfCast") then
		return "player"
	else
		return "target"
	end
end

local function ApplyVehicleModifier(unit)
	if UnitHasVehicleUI("player") then
		if unit == "player" then
			return "vehicle"
		elseif unit == "pet" then
			return
		end
	elseif unit == "vehicle" then
		return
	end
	return unit
end

local function GetSpellTargetAndType(self, action, param)
	local isMacro, isItem, key, spell

	-- Extract spell info from action and parameter
	if action == "macro" then
		isMacro = true
		local macroSpell = GetMacroSpell(param)
		if macroSpell then
			spell = macroSpell, macroSpell
		else
			local _, macroItem = GetMacroItem(param)
			if macroItem then
				isItem, key, spell = true, macroItem, GetItemSpell(macroItem)
			else
				return -- Can't handle
			end
		end
	elseif action == "item" then
		isItem, key, spell = true, GetItemInfo(param), GetItemSpell(param)
	elseif action == "spell" then
		spell = GetSpellInfo(param)
	else
		return -- Can't handle
	end

	-- Check for specific settings
	local specific = rawget(db.profile.spells, key or spell)
	if type(specific) == "table" then
		if specific.disabled then
			return -- Don't want to handle
		end
		auraType = specific.auraType or "regular"
		if auraType == "self" or auraType == "special" then
			return spell, "player", auraType, specific
		elseif auraType == "pet" then
			return spell, "pet", auraType, specific
		end
	else
		specific = nil
	end

	-- Check for totems and items
	if TOTEMS[spell] or isItem then
		return spell, "player", "self", specific
	end

	-- Regular aura

	-- GetModifiedUnit always has precedence
	local target = SecureButton_GetModifiedUnit(self)
	if target and target ~= "" then
		return spell, target, "regular", specific
	end

	-- Check macro target modifiers
	if isMacro then
		target = GuessMacroTarget(param)
		if target then
			return spell, target, "regular", specific
		end
	end

	-- Educated guess
	local helpful
	if isItem then
		helpful = IsHelpfulItem(param)
	else
		helpful = IsHelpfulSpell(param)
	end
	return spell, GuessSpellTarget(spell, helpful), "regular", specific
end

local function UpdateButtonAura(self, force)
	local state = buttons[self]
	if not state then return end

	local guid, spell, target, auraType, specific
	spell, target, auraType, specific = GetSpellTargetAndType(self, state.action, state.param)
	if spell and target then
		target = ApplyVehicleModifier(target)
	end
	guid = target and UnitGUID(target)
	--[===[@debug@
	self:Debug('UpdateButtonAura', state.action, state.param, '=>', auraType, spell, target, guid)
	--@end-debug@]===]

	if force or auraChanged[guid or state.guid or false] or auraType ~= state.auraType or spell ~= state.spell or guid ~= state.guid then
		--[===[@debug@
		self:Debug("UpdateButtonAura update because of:",
			force and "forced" or "-",
			auraChanged[guid or false] and "aura" or "-",
			auraType ~= state.auraType and "auraType" or "-",
			spell ~= state.spell and "spell" or "-",
			guid ~= state.guid and "guid" or "-"
		)
		--@end-debug@]===]
		state.spell, state.guid, state.auraType = spell, guid, auraType

		local name, count, expirationTime, isDebuff, isMine, highlight

		if spell and target and auraType then
			name, count, expirationTime, isDebuff, isMine, highlight = GetAuraToDisplay(spell, target, specific)
			--[===[@debug@
			if name then
				self:Debug("GetAuraToDisplay", spell, target, specific, "=>", "name=", name, "count=", count, "expirationTime=", expirationTime, "isDebuff=", isDebuff, "isMine=", isMine, "highlight=", highlight)
			end
			--@end-debug@]===]
		end

		if state.name ~= name or state.count ~= count or state.expirationTime ~= expirationTime or state.isDebuff ~= isDebuff or state.isMine ~= isMine or state.highlight ~= highlight then
			state.name, state.count, state.expirationTime, state.isDebuff, state.isMine = name, count, expirationTime, isDebuff, isMine
			if state.highlight ~= highlight then
				state.highlight = highlight
				--[===[@debug@
				self:Debug("GetAuraToDisplay: updating highlight")
				--@end-debug@]===]
				ActionButton_UpdateOverlayGlow(self)
				self:__IA_UpdateState()
			end
			return UpdateTimer(self)
		end
	end
end

------------------------------------------------------------------------------
-- Action handling
------------------------------------------------------------------------------

local function ParseAction(self)
	local action, param = self:__IA_GetAction()
	if action == 'action' then
		local _, spellId
		action, param, _, spellId = GetActionInfo(param)
		if action == 'equipmentset' then
			return
		elseif action == 'companion' then
			action, param = 'spell', spellId
		end
	end
	if action and param and param ~= 0 and param ~= "" then
		if action == "item" and not GetItemSpell(GetItemInfo(param) or param) then
			return
		end
		return action, param
	end
end

local function UpdateAction_Hook(self)
	local state = buttons[self]
	if not state then return end
	local action, param
	if self:IsVisible() then
		action, param = ParseAction(self)
	end
	if action ~= state.action or param ~= state.param then
		--[===[@debug@
		self:Debug("action changed =>", action, param)
		--@end-debug@]===]
		state.action, state.param = action, param
		activeButtons[self] = (action and param) or nil
		return UpdateButtonAura(self)
	end
end

------------------------------------------------------------------------------
-- Button initializing
------------------------------------------------------------------------------

local function Blizzard_GetAction(self)
	return 'action', self.action
end

local function LAB_GetAction(self)
	return self:GetAction()
end

local function LAB_UpdateState(self)
	return self:UpdateAction(true)
end

local function NOOP() end
local function InitializeButton(self)
	if buttons[self] then return end
	buttons[self] = {}
	--[===[@debug@
	if self == ActionButton10 then
		self.Debug = dprint
	else
	--@end-debug@]===]
		self.Debug = self.Debug or NOOP
	--[===[@debug@
	end
	--@end-debug@]===]
	if self.__LAB_Version then
		self.__IA_GetAction = LAB_GetAction
		self.__IA_UpdateState = LAB_UpdateState
		self:HookScript('OnShow', UpdateAction_Hook)
	else
		self.__IA_GetAction = Blizzard_GetAction
		self.__IA_UpdateState = ActionButton_UpdateState
	end
	UpdateAction_Hook(self)
end

------------------------------------------------------------------------------
-- Blizzard button hooks
------------------------------------------------------------------------------

local function ActionButton_OnLoad_Hook(self)
	if not buttons[self] and not newButtons[self] then
		newButtons[self] = true
		return true
	end
end

local function ActionButton_Update_Hook(self)
	return ActionButton_OnLoad_Hook(self) or UpdateAction_Hook(self)
end

------------------------------------------------------------------------------
-- Event listener stuff
------------------------------------------------------------------------------

local function UpdateUnitListeners()
	for unit, event in pairs(UNIT_EVENTS) do
		if db.profile.enabledUnits[unit] then
			--[===[@debug@
			if not InlineAura:IsEventRegistered(event) then
				dprint("Starting listening for event", event, 'for unit', unit)
			end
			--@end-debug@]===]
			InlineAura:RegisterEvent(event)
		else
			--[===[@debug@
			if InlineAura:IsEventRegistered(event) then
				dprint("Stopping listening for event", event, 'for unit', unit)
			end
			--@end-debug@]===]
			InlineAura:UnregisterEvent(event)
		end
	end
end

------------------------------------------------------------------------------
-- Bucketed updates
------------------------------------------------------------------------------

local function UpdateConfig()
	-- Update event listening based on units
	UpdateUnitListeners()

	-- Update event listening based on SPECIALS
	UpdateSpecialListeners()

	-- Update timer skins
	for button, timerFrame in pairs(timerFrames) do
		TimerFrame_Skin(timerFrame)
	end
end

local function UpdateMouseover(elapsed)
	-- Track mouseover changes, since most events aren't fired for mouseover
	if unitGUIDs['mouseover'] ~= UnitGUID('mouseover') then
		InlineAura:UPDATE_MOUSEOVER_UNIT("OnUpdate")
	elseif InlineAura.mouseoverTimer < elapsed then
		InlineAura.mouseoverTimer = 1
		if not (UnitInParty('mouseover') or UnitInRaid('mouseover') or UnitIsUnit('mouseover', 'pet') or UnitIsUnit('mouseover', 'target') or UnitIsUnit('mouseover', 'focus')) then
			InlineAura:UPDATE_MOUSEOVER_UNIT("OnUpdate")
		end
	else
		InlineAura.mouseoverTimer = InlineAura.mouseoverTimer - elapsed
	end
end

local function InitializeNewButtons()
	-- Initializing any pending buttons
	for button in pairs(newButtons) do
		InitializeButton(button)
	end
end

local function UpdateButtons()
	-- Update all buttons
	for button in pairs(activeButtons) do
		UpdateButtonAura(button, configUpdated)
	end
end

function InlineAura:OnUpdate(elapsed)
	-- Configuration has been updated
	if configUpdated then
		safecall(UpdateConfig)
	end

	-- Watch for mouseover aura if we can't get UNIT_AURA events
	if unitGUIDs['mouseover'] then
		safecall(UpdateMouseover, elapsed)
	end

	-- Handle new buttons
	if next(newButtons) then
		safecall(InitializeNewButtons)
		wipe(newButtons)
	end

	-- Update buttons
	if next(auraChanged) or needUpdate or configUpdated then
		safecall(UpdateButtons)
		needUpdate, configUpdated = false, false
		wipe(auraChanged)
	end

	-- Update timers
	safecall(ProcessTimers)
end

function InlineAura:RequireUpdate(config)
	configUpdated = config
	needUpdate = true
end

function InlineAura:RegisterButtons(prefix, count)
	for id = 1, count do
		local button = _G[prefix .. id]
		if button and not buttons[button] and not newButtons[button] then
			newButtons[button] = true
		end
	end
end

------------------------------------------------------------------------------
-- Event handling
------------------------------------------------------------------------------

function InlineAura:AuraChanged(unit)
	local oldGUID = unitGUIDs[unit]
	local realUnit = ApplyVehicleModifier(unit)
	local guid = realUnit and db.profile.enabledUnits[unit] and UnitGUID(realUnit)
	if oldGUID then
		auraChanged[oldGUID] = true
	end
	if guid then
		auraChanged[guid] = true
	end
	unitGUIDs[unit] = guid
	if UnitIsUnit(unit, 'mouseover') then
		self.mouseoverTimer = 1
	end
end

function InlineAura:UNIT_ENTERED_VEHICLE(event, unit)
	if unit == 'player' then
		self:AuraChanged("player")
	end
end

InlineAura.UNIT_EXITED_VEHICLE = InlineAura.UNIT_ENTERED_VEHICLE

function InlineAura:UNIT_AURA(event, unit)
	self:AuraChanged(unit)
end

function InlineAura:UNIT_PET(event, unit)
	if unit == 'player' then
		self:AuraChanged("pet")
	end
end

function InlineAura:PLAYER_ENTERING_WORLD(event)
	for unit, enabled in pairs(db.profile.enabledUnits) do
		if enabled then
			self:AuraChanged(unit)
		end
	end
end

function InlineAura:PLAYER_FOCUS_CHANGED(event)
	self:AuraChanged("focus")
end

function InlineAura:PLAYER_TARGET_CHANGED(event)
	self:AuraChanged("target")
end

function InlineAura:UPDATE_MOUSEOVER_UNIT(event)
	self:AuraChanged("mouseover")
end

function InlineAura:MODIFIER_STATE_CHANGED(event)
	self:RequireUpdate()
end

function InlineAura:CVAR_UPDATE(event, name)
	if name == 'autoSelfCast' then
		self:RequireUpdate(true)
	end
end

function InlineAura:UPDATE_BINDINGS(event, name)
	self:RequireUpdate(true)
end

function InlineAura:VARIABLES_LOADED()
	self.VARIABLES_LOADED = nil
	self:UnregisterEvent('VARIABLES_LOADED')

	-- Retrieve default spell configuration, if loaded
	if InlineAura_LoadDefaults then
		safecall(InlineAura_LoadDefaults, self)
		InlineAura_LoadDefaults = nil
	end

	-- Saved variables setup
	db = LibStub('AceDB-3.0'):New("InlineAuraDB", DEFAULT_OPTIONS)
	db.RegisterCallback(self, 'OnProfileChanged', 'RequireUpdate')
	db.RegisterCallback(self, 'OnProfileCopied', 'RequireUpdate')
	db.RegisterCallback(self, 'OnProfileReset', 'RequireUpdate')
	self.db = db

	LibStub('LibDualSpec-1.0'):EnhanceDatabase(db, "Inline Aura")

	-- Update the database from previous versions
	for name, spell in pairs(db.profile.spells) do
		if type(spell) == "table" then
			local units = spell.unitsToScan
			if type(units) ~= "table" then units = nil end
			local auraType = spell.auraType
			if auraType == "buff" then
				if units and units.pet then
					auraType = "pet"
				elseif units and units.player and not units.target and not units.focus then
					auraType = "self"
				else
					auraType = "regular"
				end
			elseif auraType == "debuff" or auraType == "enemy" or auraType == "friend" then
				auraType = "regular"
			end
			if spell.alternateColor then
				spell.highlight = "glowing"
				spell.alternateColor = nil
			end
			spell.auraType = auraType
			spell.unitsToScan = nil
		end
	end

	-- Setup
	self.bigCountdown = true

	-- Setup basic event listening up
	self:RegisterEvent('UNIT_AURA')
	self:RegisterEvent('UNIT_PET')
	self:RegisterEvent('PLAYER_TARGET_CHANGED')
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:RegisterEvent('UNIT_ENTERED_VEHICLE')
	self:RegisterEvent('UNIT_EXITED_VEHICLE')
	self:RegisterEvent('MODIFIER_STATE_CHANGED')
	self:RegisterEvent('CVAR_UPDATE')
	self:RegisterEvent('UPDATE_BINDINGS')
	if self.TOTEMS then
		TOTEMS = self.TOTEMS
		function self:PLAYER_TOTEM_UPDATE(...)
			self:AuraChanged("player")
		end
		self:RegisterEvent('PLAYER_TOTEM_UPDATE')
	end

	-- standard buttons
	self:RegisterButtons("ActionButton", 12)
	self:RegisterButtons("BonusActionButton", 12)
	self:RegisterButtons("MultiBarRightButton", 12)
	self:RegisterButtons("MultiBarLeftButton", 12)
	self:RegisterButtons("MultiBarBottomRightButton", 12)
	self:RegisterButtons("MultiBarBottomLeftButton", 12)

	-- Hooks
	hooksecurefunc('ActionButton_OnLoad', ActionButton_OnLoad_Hook)
	hooksecurefunc('ActionButton_UpdateState', function(...) return safecall(UpdateButtonState_Hook, ...) end)
	hooksecurefunc('ActionButton_Update', function(...) return safecall(ActionButton_Update_Hook, ...) end)
	hooksecurefunc('ActionButton_HideOverlayGlow', function(...) return safecall(ActionButton_HideOverlayGlow_Hook, ...) end)

	-- ButtonFacade support
	local LBF = LibStub('LibButtonFacade', true)
	local LBF_RegisterCallback = function() end
	if LBF then
		SetVertexColor = LBF_SetVertexColor
		LBF:RegisterSkinCallback("Blizzard", LBF_Callback)
	end
	-- Miscellanous addon support
	if Dominos then
		self:RegisterButtons("DominosActionButton", 120)
		hooksecurefunc(Dominos.ActionButton, "Skin", ActionButton_OnLoad_Hook)
		if LBF then
			LBF:RegisterSkinCallback("Dominos", LBF_Callback)
		end
	end
	if OmniCC or CooldownCount then
		InlineAura.bigCountdown = false
	end
	local LAB, LAB_version = LibStub("LibActionButton-1.0", true)
	if LAB then
		if LAB_version >= 11 then -- Callbacks and GetAllButtons() are supported since minor 11
			--[===[@debug@
			dprint("Found LibActionButton-1.0 version", LAB_version)
			--@end-debug@]===]
			LAB.RegisterCallback(self, "OnButtonCreated", function(_, button) return InitializeButton(button) end)
			LAB.RegisterCallback(self, "OnButtonUpdate", function(_, button) return UpdateAction_Hook(button) end)
			LAB.RegisterCallback(self, "OnButtonState", function(_, button) return UpdateButtonState_Hook(button) end)
			for button in pairs(LAB:GetAllButtons()) do
				newButtons[button] = true
			end
		else
			local _, loader = issecurevariable(LAB, "CreateButton")
			print("|cffff0000InlineAura: the version of LibActionButton-1.0 embedded in", (loader or "???"), "is not supported. Please consider updating it.|r")
		end
	end
	if Bartender4 then
		self:RegisterButtons("BT4Button", 120) -- should not be necessary
		if LBF then
			LBF:RegisterSkinCallback("Bartender4", LBF_Callback)
		end
	end

	-- Refresh everything
	self:RequireUpdate(true)

	-- Our bucket thingy
	self.mouseoverTimer = 1
	self:SetScript('OnUpdate', self.OnUpdate)

	-- Scan unit in case of delayed loading
	if IsLoggedIn() then
		self:PLAYER_ENTERING_WORLD()
	end
end

function InlineAura:ADDON_LOADED(event, name)
	if name ~= addonName then return end
	self:UnregisterEvent('ADDON_LOADED')
	self.ADDON_LOADED = nil

	if IsLoggedIn() then
		self:VARIABLES_LOADED()
	else
		self:RegisterEvent('VARIABLES_LOADED')
	end
end

-- Event handler
InlineAura:SetScript('OnEvent', function(self, event, ...)
	--[===[@debug@
	if type(self[event]) == 'function' then
	--@end-debug@]===]
		safecall(self[event], self, event, ...)
	--[===[@debug@
	else
		dprint('InlineAura: registered event has no handler: '..event)
	end
	--@end-debug@]===]
end)

-- Initialize on ADDON_LOADED
InlineAura:RegisterEvent('ADDON_LOADED')

------------------------------------------------------------------------------
-- Configuration GUI loader
------------------------------------------------------------------------------

local function LoadConfigGUI()
	safecall(LoadAddOn, 'InlineAura_Config')
end

-- Chat command line
SLASH_INLINEAURA1 = "/inlineaura"
function SlashCmdList.INLINEAURA()
	LoadConfigGUI()
	InterfaceOptionsFrame_OpenToCategory(L['Inline Aura'])
end

-- InterfaceOptionsFrame spy
CreateFrame("Frame", nil, InterfaceOptionsFrameAddOns):SetScript('OnShow', LoadConfigGUI)
