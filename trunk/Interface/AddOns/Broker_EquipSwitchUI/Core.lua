local _, EquipSwitchUI = ...

------------------------------------------------------------------------
--  Get needed references
------------------------------------------------------------------------
local LDB = LibStub("LibDataBroker-1.1")
local LDBIcon = LibStub("LibDBIcon-1.0")

------------------------------------------------------------------------
--  Local variables
------------------------------------------------------------------------
local db

-----------------------------------------------------------------------
--  OnEvent handler
------------------------------------------------------------------------
function EquipSwitchUI:OnLoad()
	self:RegisterEvent("PLAYER_LOGIN")
end

function EquipSwitchUI:PLAYER_LOGIN()
	db = _G.EQUIPSWITCH
	if not LDBIcon:IsRegistered("Broker_EquipSwitch") then
		local bes = LDB:GetDataObjectByName("Broker_EquipSwitch")
		LDBIcon:Register("Broker_EquipSwitch", bes, db)
	end	
end
