------------------------------------------------------------------------
--  EventHandler
--  Version 1.0.0
------------------------------------------------------------------------
local AddonName, AddonTable = ... -- this is passed by blizzard

-- create a simple event handler
local eventHandler = CreateFrame("Frame")
eventHandler:SetScript("OnEvent", function(self, _, name)
	-- listen for ADDON_LOADED
	if name ~= AddonName then return end
	self:UnregisterEvent("ADDON_LOADED")

	-- alter the OnEvent script to handle all possible events,
	-- the functions are supposed to be in the addon table
	self:SetScript("OnEvent", function(_, event, ...)
		if AddonTable[event] then AddonTable[event](AddonTable, event, ...) end
	end)
	
	-- try to call OnLoad on the addon table, this is where
	-- the user can call RegisterEvent and other initializations
	if AddonTable["OnLoad"] then AddonTable["OnLoad"](AddonTable) end
end)
-- register only ADDON_LOADED when the lua file is parsed
eventHandler:RegisterEvent("ADDON_LOADED")

-- Handle RegisterEvent and UnregisterEvent
function AddonTable:RegisterEvent(event, method)
	if method then eventHandler[event] = eventHandler[method] end
	eventHandler:RegisterEvent(event)	
end

function AddonTable:UnregisterEvent(event)
	eventHandler:UnregisterEvent(event)
end
