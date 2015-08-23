local LIB, REVISION = "LibStateDriver-1.1", 2
if not LibStub then error(LIB .. " requires LibStub", 0) end

local lib, oldRevision = LibStub:NewLibrary(LIB, REVISION)
if not lib then return end

local gmatch, pcall, select, setmetatable, tremove = string.gmatch, pcall, select, setmetatable, table.remove
local SecureCmdOptionParse, AND, OR, XOR = SecureCmdOptionParse, bit.band, bit.bor, bit.bxor

--[[-----------------------------------------------------------------------------
Version bridge
-------------------------------------------------------------------------------]]
local activeMonitor, callback, enabled, eventCount, eventMonitor, modMonitor, mt, object, parameters, state, status

if oldRevision then
	activeMonitor, callback, enabled, eventCount, eventMonitor, modMonitor, mt, object, parameters, state, status = lib.__void()
else
	callback, enabled, modMonitor, mt, object, parameters, state, status = { }, { }, { }, { }, { }, { }, { }, { }
	eventCount = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
	activeMonitor, eventMonitor = CreateFrame('Frame'), CreateFrame('Frame')
	activeMonitor:Hide()
	eventMonitor:Hide()
end

--[[-----------------------------------------------------------------------------
Defaults
-------------------------------------------------------------------------------]]
local function DoNothing() end

setmetatable(callback, { __index = function() return DoNothing end })

setmetatable(object, { __index = function(_, index) return index end })

setmetatable(parameters, { __index = function() return "" end })

--[[-----------------------------------------------------------------------------
Constants
-------------------------------------------------------------------------------]]
local ACTIVE_FLAG, MOD_FLAG, STATIC = 0x80000000, 0x40000000, 0x00000000
local ACTIVE_MASK = OR(ACTIVE_FLAG, MOD_FLAG)
local EVENT_MASK = bit.bnot(ACTIVE_MASK)

local conditionMask = {
	['actionbar']	= 0x00000010,		['noactionbar']	= 0x00000010,
	['bar']			= 0x00000010,		['nobar']			= 0x00000010,
	['bonusbar']	= 0x00000020,		['nobonusbar']		= 0x00000020,
	['combat']		= 0x00000003,		['nocombat']		= 0x00000003,
	['equipped']	= 0x00000200,		['noequipped']		= 0x00000200,
	['form']			= 0x00000020,		['noform']			= 0x00000020,
	['group']		= 0x0000000C,		['nogroup']			= 0x0000000C,
	['mod']			= MOD_FLAG,			['nomod']			= MOD_FLAG,
	['modifier']	= MOD_FLAG,			['nomodifier']		= MOD_FLAG,
	['pet']			= 0x00000100,		['nopet']			= 0x00000100,
	['spec']			= 0x00000080,		['nospec']			= 0x00000080,
	['stance']		= 0x00000020,		['nostance']		= 0x00000020,
	['stealth']		= 0x00000040,		['nostealth']		= 0x00000040,
	['worn']			= 0x00000200,		['noworn']			= 0x00000200
}

local eventMask = {
	0x00000001, 0x00000002, 0x00000004, 0x00000008,
	0x00000010, 0x00000020, 0x00000040, 0x00000080,
	0x00000100, 0x00000200
}

local eventName = {
	'PLAYER_REGEN_DISABLED', 'PLAYER_REGEN_ENABLED', 'PARTY_MEMBERS_CHANGED', 'RAID_ROSTER_UPDATE',
	'ACTIONBAR_PAGE_CHANGED', 'UPDATE_BONUS_ACTIONBAR', 'UPDATE_STEALTH', 'ACTIVE_TALENT_GROUP_CHANGED',
	'UNIT_PET', 'UNIT_INVENTORY_CHANGED'
}

local NUM_EVENTS = #eventName

--[[-----------------------------------------------------------------------------
Set status flags for parameters: status[parameters] = flags
-------------------------------------------------------------------------------]]
setmetatable(status, { __index = function(self, index)
	local status, temp = STATIC, STATIC
	for parameter in gmatch(index, "[^;]+") do
		for conditions in gmatch(parameter, "%[%s*(.-)%s*%]") do
			if conditions ~= "" then
				for condition in gmatch(conditions, "%s*([%a@]+)[^%a,]*[^,]*") do
					temp = OR(temp, conditionMask[condition] or ACTIVE_FLAG)
				end
			else
				self[index] = AND(status, ACTIVE_FLAG) == 0 and status or AND(status, ACTIVE_MASK)
				return self[index]
			end
		end
		status, temp = OR(status, temp), STATIC
	end
	self[index] = AND(status, ACTIVE_FLAG) == 0 and status or AND(status, ACTIVE_MASK)
	return self[index]
end })

--[[-----------------------------------------------------------------------------
Active Monitor / Modifier Monitor
-------------------------------------------------------------------------------]]
local numActive, numMod = #activeMonitor, #modMonitor

activeMonitor:SetScript('OnEvent', function(self)
	local driver, err, ok, result
	for index = numMod, 1, -1 do
		driver = modMonitor[index]
		result = SecureCmdOptionParse(parameters[driver])
		if state[driver] ~= result then
			state[driver] = result
			ok, err = pcall(callback[driver], object[driver], result)
			if not ok then
				geterrorhandler()(err)
			end
		end
	end
end)

do
	local timer = 0

	activeMonitor:SetScript('OnUpdate', function(self, elapsed)
		timer = timer + elapsed
		if timer < 0.2 then return end
		timer = 0
		local driver, err, ok, result
		for index = numActive, 1, -1 do
			driver = self[index]
			result = SecureCmdOptionParse(parameters[driver])
			if state[driver] ~= result then
				state[driver] = result
				ok, err = pcall(callback[driver], object[driver], result)
				if not ok then
					geterrorhandler()(err)
				end
			end
		end
	end)
end

--[[-----------------------------------------------------------------------------
Event Monitor
-------------------------------------------------------------------------------]]
local numEvent = #eventMonitor

eventMonitor:SetScript('OnEvent', function(self, event, unit)
	if (event == 'UNIT_INVENTORY_CHANGED' or event == 'UNIT_PET') and unit ~= 'player' then return end
	self:Show()
end)

eventMonitor:SetScript('OnUpdate', function(self)
	self:Hide()
	local driver, err, ok, result
	for index = numEvent, 1, -1 do
		driver = self[index]
		result = SecureCmdOptionParse(parameters[driver])
		if state[driver] ~= result then
			state[driver] = result
			ok, err = pcall(callback[driver], object[driver], result)
			if not ok then
				geterrorhandler()(err)
			end
		end
	end
end)

--[[-----------------------------------------------------------------------------
Support functions
-------------------------------------------------------------------------------]]
local function Disable(driver, status)
	if AND(status, EVENT_MASK) ~= 0 then
		for index = 1, numEvent do
			if eventMonitor[index] == driver then
				tremove(eventMonitor, index)
				numEvent = numEvent - 1
				for index = 1, NUM_EVENTS do
					if AND(status, eventMask[index]) ~= 0 then
						eventCount[index] = eventCount[index] - 1
						if eventCount[index] == 0 then
							eventMonitor:UnregisterEvent(eventName[index])
						end
					end
				end
				break
			end
		end
	elseif AND(status, ACTIVE_FLAG) ~= 0 then
		for index = 1, numActive do
			if activeMonitor[index] == driver then
				tremove(activeMonitor, index)
				if numActive > 1 then
					numActive = numActive - 1
				else
					numActive = 0
					activeMonitor:Hide()
				end
				break
			end
		end
	end
	if AND(status, MOD_FLAG) ~= 0 then
		for index = 1, numMod do
			if modMonitor[index] == driver then
				tremove(modMonitor, index)
				if numMod > 1 then
					numMod = numMod - 1
				else
					numMod = 0
					activeMonitor:UnregisterEvent('MODIFIER_STATE_CHANGED')
				end
				break
			end
		end
	end
end

local function Enable(driver, status)
	if AND(status, EVENT_MASK) ~= 0 then
		numEvent = numEvent + 1
		eventMonitor[numEvent] = driver
		for index = 1, NUM_EVENTS do
			if AND(status, eventMask[index]) ~= 0 then
				eventCount[index] = eventCount[index] + 1
				if eventCount[index] == 1 then
					eventMonitor:RegisterEvent(eventName[index])
				end
			end
		end
	elseif AND(status, ACTIVE_FLAG) ~= 0 then
		if numActive > 0 then
			numActive = numActive + 1
		else
			numActive = 1
			activeMonitor:Show()
		end
		activeMonitor[numActive] = driver
	end
	if AND(status, MOD_FLAG) ~= 0 then
		if numMod > 0 then
			numMod = numMod + 1
		else
			numMod = 1
			activeMonitor:RegisterEvent('MODIFIER_STATE_CHANGED')
		end
		modMonitor[numMod] = driver
	end
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
mt.__call = function(self, force)																-- Trigger a state update and callback
	state[self] = SecureCmdOptionParse(parameters[self])
	if enabled[self] or force then
		local ok, err = pcall(callback[self], object[self], state[self])
		if ok then return end
		geterrorhandler()(err)
	end
end

mt.__index = {
	["Disable"] = function(self)
		if enabled[self] then
			enabled[self] = nil
			Disable(self, status[parameters[self]])
		end
	end,

	["Enable"] = function(self)
		if not enabled[self] then
			enabled[self] = true
			Enable(self, status[parameters[self]])
			self()
		end
	end,

	["GetCallback"] = function(self)
		return rawget(callback, self)
	end,

	["GetObject"] = function(self)
		return object[self]
	end,

	["GetParameters"] = function(self)
		return parameters[self]
	end,

	["GetState"] = function(self)
		return state[self]
	end,

	["IsEnabled"] = function(self)
		return enabled[self]
	end,

	["Pack"] = function(self, ...)
		local num = select('#', ...)
		for index = 1, num do
			self[index] = select(index, ...)
		end
		for index = #self, num + 1, -1 do
			self[index] = nil
		end
	end,

	["Recycle"] = function(self)
		self:Disable()
		callback[self], object[self], parameters[self], state[self] = nil, nil, nil, nil
		mt.__metatable = nil
		setmetatable(self, nil)
		mt.__metatable = LIB
	end,

	["SetCallback"] = function(self, value)
		if type(value) ~= 'function' and value ~= nil then
			error(LIB .. ": <object>:SetCallback(value) - 'value' expected function or nil, got " .. type(value), 2)
		end
		callback[self] = value
	end,

	["SetObject"] = function(self, value)
		if value == self then
			value = nil
		end
		object[self] = value
	end,

	["SetParameters"] = function(self, value)
		if type(value) == 'string' then
			value = strtrim(value)
		elseif value == nil then
			value = ""
		else
			error(LIB .. ": <object>:SetParameters(value) - 'value' expected string or nil, got " .. type(value), 2)
		end
		if parameters[self] ~= value then
			if enabled[self] then
				local newStatus, oldStatus, result = status[value], status[parameters[self]], SecureCmdOptionParse(value)
				if oldStatus ~= newStatus then
					local deltaStatus = XOR(oldStatus, newStatus)
					Disable(self, AND(deltaStatus, oldStatus))
					Enable(self, AND(deltaStatus, newStatus))
				end
			end
			parameters[self] = value ~= "" and value or nil
			self()
		end
	end,

	["Toggle"] = function(self)
		if enabled[self] then
			self:Disable()
		else
			self:Enable()
		end
	end
}

mt.__metatable = LIB

--[[-----------------------------------------------------------------------------
Private API
-------------------------------------------------------------------------------]]
function lib.__void()
	wipe(lib)
	wipe(mt)
	return activeMonitor, callback, enabled, eventCount, eventMonitor, modMonitor, mt, object, parameters, state, status
end

--[[-----------------------------------------------------------------------------
Public API
-------------------------------------------------------------------------------]]
function lib:New(enable)
	local driver = setmetatable({ }, mt)
	if enable then
		driver:Enable()
	end
	return driver
end
