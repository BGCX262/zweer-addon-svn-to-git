-------------------------------------
-- CORE -----------------------------
-------------------------------------

local total = 0;
-- slash commands
SlashCmdList['FRAME'] = function() ChatFrame1:AddMessage(GetMouseFocus():GetName()) end
SLASH_FRAME1 = '/frame'
SlashCmdList['RELOAD'] = function() ReloadUI() end
SLASH_RELOAD1 = '/rl'

local VEHICLE_MAX_OVERLAY = 4;
local VEHICLE_MAX_ARTWORK = 10;
local VEHICLE_MAX_BORDER = 7;
local VEHICLE_MAX_BACKGROUND = 3;

function ShowRoathBags(...)
	MainMenuBarBackpackButton:Show();
	CharacterBag0Slot:Show();
	CharacterBag1Slot:Show();
	CharacterBag2Slot:Show();
	CharacterBag3Slot:Show();
end

function HideRoathBags(...)
	MainMenuBarBackpackButton:Hide();
	CharacterBag0Slot:Hide();
	CharacterBag1Slot:Hide();
	CharacterBag2Slot:Hide();
	CharacterBag3Slot:Hide();
end

function ShowRoathMenu(...)
	TalentMicroButton:Show();
	CharacterMicroButton:Show();
	SpellbookMicroButton:Show();
	QuestLogMicroButton:Show();
	GuildMicroButton:Show();
	MainMenuMicroButton:Show();
	HelpMicroButton:Show();
	LFDMicroButton:Show();
	PVPMicroButton:Show();
	AchievementMicroButton:Show();
end

function HideRoathMenu(...)
	TalentMicroButton:Hide();
	CharacterMicroButton:Hide();
	SpellbookMicroButton:Hide();
	QuestLogMicroButton:Hide();
	GuildMicroButton:Hide();
	MainMenuMicroButton:Hide();
	HelpMicroButton:Hide();
	LFDMicroButton:Hide();
	PVPMicroButton:Hide();
	AchievementMicroButton:Hide();
end

function RoathCore_OnEvent(self, event, arg1, arg2, arg3, arg4, ...)
	if (event=="ADDON_LOADED" or event=="PLAYER_ENTERING_WORLD") then
		if (RoathOffset == nil or RoathOffset == "" or RoathOffset=="nil") then
			if (IsAddOnLoaded("InfoPanel")) then
				RoathOffset = 25;
			elseif (IsAddOnLoaded("Fubar")) then
				RoathOffset = 18;
			else
				RoathOffset = 0;
			end
		end
		if (RoathCastOffset == nil or RoathCastOffset == "" or RoathCastOffset=="nil") then
			RoathCastOffset = 0;
		end
		if (Roathscale == nil or Roathscale == "" or Roathscale=="nil") then
			Roathscale = 1;
		else 
			MainMenuBar:SetScale(Roathscale);
--			MultiBarBottomRight:SetScale(Roathscale);
--			MultiBarBottomLeft:SetScale(Roathscale);
--			MultiBarRight:SetScale(Roathscale);
--			MultiBarLeft:SetScale(Roathscale); 
		end
		if (RoathVehiclescale == nil or RoathVehiclescale == "" or RoathVehiclescale=="nil") then
			RoathVehiclescale = 1;
		else 
			VehicleMenuBar:SetScale(RoathVehiclescale*0.8);
		end

		if (RoathStanceOff == nil or RoathStanceOff == "" or RoathStanceOff=="nil") then
			RoathStanceOff = 0;
		end
		if (RoathHorizOff == nil or RoathHorizOff == "" or RoathHorizOff=="nil") then
			RoathHorizOff = 0;
		end
		if (RoathGryphonState == nil or RoathGryphonState == "hide") then
			RoathGryphonState = "hide";
			MainMenuBarLeftEndCap:Hide();
			MainMenuBarRightEndCap:Hide();
		elseif RoathGryphonState == "show" then
			MainMenuBarLeftEndCap:Show();
			MainMenuBarRightEndCap:Show();
		end
		if (RoathMenuState == nil or RoathMenuState == "show") then
			RoathMenuState = "show";
			ShowRoathMenu();
		elseif RoathMenuState == "hide" then
			HideRoathMenu();
		end
		if (RoathBagState == nil or RoathBagState == "show") then
			RoathBagState = "show";
			ShowRoathBags();
		elseif RoathBagState == "hide" then
			HideRoathBags();
		end
		if (RoathKeyState == nil or RoathKeyState == "show") then
			RoathKeyState = "show";
			KeyRingButton:Show();
		elseif RoathKeyState == "hide" then
			KeyRingButton:Hide();
		end
		MoveMenuandBags();
		UpdateBarPositions();				
	end
	
	if (event=="UPDATE_BONUS_ACTIONBAR" or "PET_UI_UPDATE" or "UNIT_PET" or "ACTIONBAR_PAGE_CHANGED" or "PET_BAR_UPDATE" or "UPDATE_MULTI_CAST_ACTIONBAR") then
		MoveMenuandBags();
		UpdateBarPositions();
	end
	
	if (event=="UNIT_ENTERING_VEHICLE" or "UNIT_EXITING_VEHICLE") and (arg1 == 'player') then
		UpdateVehicleBarPositions();		
	end
end

function onUpdate(self,elapsed)
	total = total + elapsed;
	if total >= 1 then
		UpdateBarPositions();
		total = 0;
	end
end

function SetMenuBarScale(scale)
	MainMenuBar:SetScale(Roathscale);
--	MultiBarBottomRight:SetScale(Roathscale);
--	MultiBarBottomLeft:SetScale(Roathscale);
--	MultiBarRight:SetScale(Roathscale);
--	MultiBarLeft:SetScale(Roathscale);
end

function SetVehicleBarScale(scale)
	VehicleMenuBar:SetScale(RoathVehiclescale * 0.8);
	UpdateVehicleBarPositions();
end

local frame = CreateFrame("Frame", "MyAddOnFrame");
frame:SetScript("OnEvent", RoathCore_OnEvent);
frame:SetScript("OnUpdate", onUpdate);
frame:RegisterEvent("VARIABLES_LOADED");
frame:RegisterEvent("PLAYER_ENTERING_WORLD");
frame:RegisterEvent("PLAYER_LOGIN");
frame:RegisterEvent("PLAYER_ALIVE");
frame:RegisterEvent("PLAYER_TARGET_CHANGED");
frame:RegisterEvent("PET_UI_UPDATE");
frame:RegisterEvent("UNIT_PET");
frame:RegisterEvent("ACTIONBAR_PAGE_CHANGED");
frame:RegisterEvent("PET_BAR_UPDATE");
frame:RegisterEvent("UNIT_ENTERING_VEHICLE");
frame:RegisterEvent("UNIT_EXITING_VEHICLE");
frame:RegisterEvent("UPDATE_MULTI_CAST_ACTIONBAR");

local function slashCMD(msg, ...)
	local _, _, command, args = string.find(msg, "^(%w+)%s*(.*)$");
	if string.lower(msg) == "gryphon" or string.lower(msg) == "gryphons" then
		if MainMenuBarLeftEndCap:IsShown() and MainMenuBarRightEndCap:IsShown() then
			MainMenuBarLeftEndCap:Hide();
			MainMenuBarRightEndCap:Hide();
			RoathGryphonState = "hide";
		else
			MainMenuBarLeftEndCap:Show();
			MainMenuBarRightEndCap:Show();
			RoathGryphonState = "show";
		end
	elseif string.lower(msg) == "bag" or string.lower(msg) == "bags" then
		if MainMenuBarBackpackButton:IsShown() and CharacterBag0Slot:IsShown() and CharacterBag1Slot:IsShown() and CharacterBag2Slot:IsShown() and CharacterBag3Slot:IsShown() then
			HideRoathBags();
			RoathBagState = "hide";
		else
			ShowRoathBags();
			RoathBagState = "show";
		end
	elseif string.lower(msg) == "key" or string.lower(msg) == "keys" or string.lower(msg) == "keyring" then
		if KeyRingButton:IsShown() then
			KeyRingButton:Hide();
			RoathKeyState = "hide";
		else
			KeyRingButton:Show();
			RoathKeyState = "show";
		end
	elseif string.lower(msg) == "menu" or string.lower(msg) == "menus" then
		if CharacterMicroButton:IsShown() and SpellbookMicroButton:IsShown() and QuestLogMicroButton:IsShown() and GuildMicroButton:IsShown() and MainMenuMicroButton:IsShown() and HelpMicroButton:IsShown() and LFDMicroButton:IsShown() then
			HideRoathMenu();
			RoathMenuState = "hide";
		else
			ShowRoathMenu();
			RoathMenuState = "show";
		end
	elseif ( command == "offset" and args ) then
		if tonumber(args) == nil then
			DEFAULT_CHAT_FRAME:AddMessage("Current Offset: " .. "|cffF58CBA" .. tostring(RoathOffset));
		else
			RoathOffset = args;
			MainMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", RoathHorizOff, RoathOffset/Roathscale);
			UpdateBarPositions();
			DEFAULT_CHAT_FRAME:AddMessage("Offset changed to " .. "|cffF58CBA" .. tostring(RoathOffset));
		end
	elseif ( command == "horizon" and args ) then
		if tonumber(args) == nil then
			DEFAULT_CHAT_FRAME:AddMessage("Current Horizon: " .. "|cffF58CBA" .. tostring(RoathHorizOff));
		else
			RoathHorizOff = args;
			MainMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", RoathHorizOff, RoathOffset/Roathscale);
			UpdateBarPositions();
			DEFAULT_CHAT_FRAME:AddMessage("Horizon changed to " .. "|cffF58CBA" .. tostring(RoathHorizOff));
		end
	elseif ( command == "castoffset" and args ) then
		if tonumber(args) == nil then
			DEFAULT_CHAT_FRAME:AddMessage("Current Castoffset: " .. "|cffF58CBA" .. tostring(RoathCastOffset));
		else
			RoathCastOffset = args;
			CastingBarFrame:SetPoint("BOTTOM", WorldFrame, "BOTTOM", RoathHorizOff, (RoathOffset + 225 + RoathCastOffset) * Roathscale);
			UpdateBarPositions();
			DEFAULT_CHAT_FRAME:AddMessage("Castoffset changed to " .. "|cffF58CBA" .. tostring(RoathCastOffset));
		end
	elseif ( command == "stanceoffset" and args ) then
		if tonumber(args) == nil then
			DEFAULT_CHAT_FRAME:AddMessage("Current StanceOffset: " .. "|cffF58CBA" .. tostring(RoathStanceOff));
		else
			RoathStanceOff = args;
			UpdateBarPositions();
			DEFAULT_CHAT_FRAME:AddMessage("StanceOffset changed to " .. "|cffF58CBA" .. tostring(RoathStanceOff));
		end
	elseif ( command == "scale" and args ) then
		if tonumber(args) == nil then
			DEFAULT_CHAT_FRAME:AddMessage("Current Scale: " .. "|cffF58CBA" .. tostring(Roathscale));
		else
			Roathscale = args;
			SetMenuBarScale(Roathscale);
			UpdateBarPositions();
			DEFAULT_CHAT_FRAME:AddMessage("Scale changed to " .. "|cffF58CBA" .. tostring(Roathscale));
		end
	elseif ( command == "vehiclescale" and args ) then
		if tonumber(args) == nil then
			DEFAULT_CHAT_FRAME:AddMessage("Current VehicleScale: " .. "|cffF58CBA" .. tostring(RoathVehiclescale));
		else
			RoathVehiclescale = args;
			SetVehicleBarScale(RoathVehiclescale);
			UpdateVehicleBarPositions();
			DEFAULT_CHAT_FRAME:AddMessage("VehicleScale changed to " .. "|cffF58CBA" .. tostring(RoathVehiclescale));
		end
	elseif string.lower(msg) == "value" or string.lower(msg) == "values" then
		DEFAULT_CHAT_FRAME:AddMessage("Current Roath values:");
		DEFAULT_CHAT_FRAME:AddMessage("Bags: " .. "|cffF58CBA" .. tostring(RoathBagState));
		DEFAULT_CHAT_FRAME:AddMessage("Gryphons: " .. "|cffF58CBA" .. tostring(RoathGryphonState));
		DEFAULT_CHAT_FRAME:AddMessage("Menu: " .. "|cffF58CBA" .. tostring(RoathMenuState));
		DEFAULT_CHAT_FRAME:AddMessage("Key: " .. "|cffF58CBA" .. tostring(RoathKeyState));
		DEFAULT_CHAT_FRAME:AddMessage("Offset: " .. "|cffF58CBA" .. tostring(RoathOffset));
		DEFAULT_CHAT_FRAME:AddMessage("Horizon: " .. "|cffF58CBA" .. tostring(RoathHorizOff));
		DEFAULT_CHAT_FRAME:AddMessage("Castoffset: " .. "|cffF58CBA" .. tostring(RoathCastOffset));
		DEFAULT_CHAT_FRAME:AddMessage("Stanceoffset: " .. "|cffF58CBA" .. tostring(RoathStanceOff));
		DEFAULT_CHAT_FRAME:AddMessage("Scale: " .. "|cffF58CBA" .. tostring(Roathscale));
		DEFAULT_CHAT_FRAME:AddMessage("VehicleScale: " .. "|cffF58CBA" .. tostring(RoathVehiclescale));
	elseif string.lower(msg) == "reset" then
		DEFAULT_CHAT_FRAME:AddMessage("you hit reset");
		MainMenuBar.state = "player";
		MultiActionBar_Update();
		VehicleMenuBar:Hide();
		MainMenuBar:Show();
		SetMainMenuBarPosition();
		UpdateVehicleBarPositions();
		UpdateBarPositions();
	else
		DEFAULT_CHAT_FRAME:AddMessage("Roath UI Commands:", 1, 1, 1, 53, 15);
		DEFAULT_CHAT_FRAME:AddMessage("/roath - |cffF58CBAGives you a list of available commands", 1, 1, 1, 53, 15);
		DEFAULT_CHAT_FRAME:AddMessage("/roath bags - |cffF58CBAToggles the bags on or off", 1, 1, 1, 53, 15);
		DEFAULT_CHAT_FRAME:AddMessage("/roath gryphons - |cffF58CBAToggles the gryphons on the main menu on or off", 1, 1, 1, 53, 15);
		DEFAULT_CHAT_FRAME:AddMessage("/roath menu - |cffF58CBAToggles the micromenu on or off", 1, 1, 1, 53, 15);
		DEFAULT_CHAT_FRAME:AddMessage("/roath key - |cffF58CBAToggles the keyring button on or off", 1, 1, 1, 53, 15);
		DEFAULT_CHAT_FRAME:AddMessage("/roath offset xx - |cffF58CBASets a vertical offset from the bottom of the screen", 1, 1, 1, 53, 15);
		DEFAULT_CHAT_FRAME:AddMessage("/roath horizon xx - |cffF58CBASets a horizontal offset from the center of the screen", 1, 1, 1, 53, 15);
		DEFAULT_CHAT_FRAME:AddMessage("/roath castoffset xx - |cffF58CBASets an additional vertical offset from the bottom of the screen for the caster bar", 1, 1, 1, 53, 15);
		DEFAULT_CHAT_FRAME:AddMessage("/roath stanceoffset xx - |cffF58CBASets an additional horizontal offset for the stance / presence / pet / form bars", 1, 1, 1, 53, 15);
		DEFAULT_CHAT_FRAME:AddMessage("/roath scale xx - |cffF58CBAAllows you to adjust the scale of the actionbars. Default is 1", 1, 1, 1, 53, 15);
		DEFAULT_CHAT_FRAME:AddMessage("/roath vehiclescale xx - |cffF58CBAAllows you to adjust the scale of the vehicle interface. Default is 1", 1, 1, 1, 53, 15);
		DEFAULT_CHAT_FRAME:AddMessage("/roath values - |cffF58CBAOutputs the values of all Roath variables", 1, 1, 1, 53, 15);
	end
end

_G["SlashCmdList"]["ROATH"] = slashCMD
_G["SLASH_ROATH1"] = "/roath"

-- Binding Variables
BINDING_HEADER_ROATHEADER = "Missing Micromenu Keybindings";
BINDING_NAME_ROATHBDINGIND1 = "Support/Knowledgebase";


-------------------------------------
-- ACTION BARS ----------------------
-------------------------------------

-- Function to update the position of the actionbars whenever a change is made to them.
function UpdateBarPositions()
	if not UnitInVehicle("player") then
		VehicleMenuBar:Hide();
		MainMenuBar:Show();
		MultiActionBar_Update();
	else
		VehicleMenuBar:Show();
		SetVehicleBarScale(RoathVehiclescale);
		UpdateVehicleBarPositions();
	end
	if not MainMenuExpBar:IsShown() and not ReputationWatchBar:IsShown() then
		if MultiBarBottomLeft:IsShown() and MultiBarBottomLeft:IsShown() then
			HideJunk();
			MoveBottomLeft(MainMenuBar,2,0);
			MoveBottomRight(MultiBarBottomLeft,0,5);
		elseif MultiBarBottomRight:IsShown() and not MultiBarBottomLeft:IsShown() then
			HideJunk();
			MoveBottomRight(MainMenuBar,2,0);
		elseif MultiBarBottomLeft:IsShown() and not MultiBarBottomRight:IsShown() then
			HideJunk();
			MoveBottomLeft(MainMenuBar,2,0);
		end
		if PetActionBarFrame:IsShown() then
			if MultiBarBottomRight:IsShown() then
				HideJunk();
				MovePetBar(MultiBarBottomRight,5,5);
			elseif MultiBarBottomLeft:IsShown() then
				HideJunk();
				MovePetBar(MultiBarBottomLeft,5,5);
			else
				HideJunk();
				MovePetBar(MainMenuBar,5,14);
			end
		end
		if ShapeshiftBarFrame:IsShown() then
			if PetActionBarFrame:IsShown() then
				HideJunk();
				MoveStanceBar(PetActionBarFrame,5,0);
			elseif MultiBarBottomRight:IsShown() then
				HideJunk();
				MoveStanceBar(MultiBarBottomRight,5,5);
			elseif MultiBarBottomLeft:IsShown() then
				HideJunk();
				MoveStanceBar(MultiBarBottomLeft,5,5);
			else
				HideJunk();
				MoveStanceBar(MainMenuBar,5,14);
			end
		end
		if PossessBarFrame:IsShown() then
			if MultiBarBottomRight:IsShown() then
				HideJunk();
				MovePossesBar(MultiBarBottomRight,0,5);
			elseif MultiBarBottomLeft:IsShown() then
				HideJunk();
				MovePossesBar(MultiBarBottomLeft,0,5);
			else
				HideJunk();
				MovePossesBar(MainMenuBar,0,14);
			end
		end
		if HasMultiCastActionBar then
			if PetActionBarFrame:IsShown() then
				HideJunk();
				MoveTotemBar(PetActionBarFrame,5,0);
			elseif MultiBarBottomRight:IsShown() then
				HideJunk();
				MoveTotemBar(MultiBarBottomRight,5,5);
			elseif MultiBarBottomLeft:IsShown() then
				HideJunk();
				MoveTotemBar(MultiBarBottomLeft,5,5);
			else
				HideJunk();
				MoveTotemBar(MainMenuBar,5,14);
			end
		end
	
	elseif not MainMenuExpBar:IsShown() and ReputationWatchBar:IsShown() then
		if MultiBarBottomLeft:IsShown() and MultiBarBottomLeft:IsShown() then
			HideJunk();
			MoveBottomLeft(MainMenuBar,2,5);
			MoveBottomRight(MultiBarBottomLeft,0,5);
		elseif MultiBarBottomRight:IsShown() and not MultiBarBottomLeft:IsShown() then
			HideJunk();
			MoveBottomRight(MainMenuBar,2,5);
		elseif MultiBarBottomLeft:IsShown() and not MultiBarBottomRight:IsShown() then
			HideJunk();
			MoveBottomLeft(MainMenuBar,2,5);
		end
		if PetActionBarFrame:IsShown() then
			if MultiBarBottomRight:IsShown() then
				HideJunk();
				MovePetBar(MultiBarBottomRight,5,5);
			elseif MultiBarBottomLeft:IsShown() then
				HideJunk();
				MovePetBar(MultiBarBottomLeft,5,5);
			else
				HideJunk();
				MovePetBar(MainMenuBar,5,5);
			end
		end
		if ShapeshiftBarFrame:IsShown() then
			if PetActionBarFrame:IsShown() then
				HideJunk();
				MoveStanceBar(PetActionBarFrame,5,0);
			elseif MultiBarBottomRight:IsShown() then
				HideJunk();
				MoveStanceBar(MultiBarBottomRight,5,5);
			elseif MultiBarBottomLeft:IsShown() then
				HideJunk();
				MoveStanceBar(MultiBarBottomLeft,5,5);
			else
				HideJunk();
				MoveStanceBar(MainMenuBar,5,5);
			end
		end
		if PossessBarFrame:IsShown() then
			if MultiBarBottomRight:IsShown() then
				HideJunk();
				MovePossesBar(MultiBarBottomRight,0,5);
			elseif MultiBarBottomLeft:IsShown() then
				HideJunk();
				MovePossesBar(MultiBarBottomLeft,0,5);
			else
				HideJunk();
				MovePossesBar(MainMenuBar,0,5);
			end
		end
		if HasMultiCastActionBar then
			if PetActionBarFrame:IsShown() then
				HideJunk();
				MoveTotemBar(PetActionBarFrame,5,0);
			elseif MultiBarBottomRight:IsShown() then
				HideJunk();
				MoveTotemBar(MultiBarBottomRight,5,5);
			elseif MultiBarBottomLeft:IsShown() then
				HideJunk();
				MoveTotemBar(MultiBarBottomLeft,5,5);
			else
				HideJunk();
				MoveTotemBar(MainMenuBar,5,5);
			end
		end
	elseif MainMenuExpBar:IsShown() and not ReputationWatchBar:IsShown() then
		if MultiBarBottomLeft:IsShown() and MultiBarBottomLeft:IsShown() then
			HideJunk();
			MoveBottomLeft(MainMenuBar,2,5);
			MoveBottomRight(MultiBarBottomLeft,0,5);
		elseif MultiBarBottomRight:IsShown() and not MultiBarBottomLeft:IsShown() then
			HideJunk();
			MoveBottomRight(MainMenuBar,2,5);
		elseif MultiBarBottomLeft:IsShown() and not MultiBarBottomRight:IsShown() then
			HideJunk();
			MoveBottomLeft(MainMenuBar,2,5);
		end
		if PetActionBarFrame:IsShown() then
			if MultiBarBottomRight:IsShown() then
				HideJunk();
				MovePetBar(MultiBarBottomRight,5,5);
			elseif MultiBarBottomLeft:IsShown() then
				HideJunk();
				MovePetBar(MultiBarBottomLeft,5,5);
			else
				HideJunk();
				MovePetBar(MainMenuBar,5,5);
			end
		end
		if ShapeshiftBarFrame:IsShown() then
   			if PetActionBarFrame:IsShown() then
				HideJunk();
				MoveStanceBar(PetActionBarFrame,5,0);
			elseif MultiBarBottomRight:IsShown() then
				HideJunk();
				MoveStanceBar(MultiBarBottomRight,5,5);
			elseif MultiBarBottomLeft:IsShown() then
				HideJunk();
				MoveStanceBar(MultiBarBottomLeft,5,5);
			else
				HideJunk();
				MoveStanceBar(MainMenuBar,5,5);
			end
		end
		if PossessBarFrame:IsShown() then
			if MultiBarBottomRight:IsShown() then
				HideJunk();
				MovePossesBar(MultiBarBottomRight,0,5);
			elseif MultiBarBottomLeft:IsShown() then
				HideJunk();
				MovePossesBar(MultiBarBottomLeft,0,5);
			else
				HideJunk();
				MovePossesBar(MainMenuBar,0,14);
			end
		end
		if HasMultiCastActionBar then
			if PetActionBarFrame:IsShown() then
				HideJunk();
				MoveTotemBar(PetActionBarFrame,5,0);
			elseif MultiBarBottomRight:IsShown() then
				HideJunk();
				MoveTotemBar(MultiBarBottomRight,5,5);
			elseif MultiBarBottomLeft:IsShown() then
				HideJunk();
				MoveTotemBar(MultiBarBottomLeft,5,5);
			else
				HideJunk();
				MoveTotemBar(MainMenuBar,5,5);
			end
		end
		
	elseif MainMenuExpBar:IsShown() and ReputationWatchBar:IsShown() then
		if MultiBarBottomLeft:IsShown() and MultiBarBottomLeft:IsShown() then
			HideJunk();
			MoveBottomLeft(MainMenuBar,2,14);
			MoveBottomRight(MultiBarBottomLeft,0,5);
		elseif MultiBarBottomRight:IsShown() and not MultiBarBottomLeft:IsShown() then
			HideJunk();
			MoveBottomRight(MainMenuBar,2,14);
		elseif MultiBarBottomLeft:IsShown() and not MultiBarBottomRight:IsShown() then
			HideJunk();
			MoveBottomLeft(MainMenuBar,2,14);
		end
		if PetActionBarFrame:IsShown() then
			if MultiBarBottomRight:IsShown() then
				HideJunk();
				MovePetBar(MultiBarBottomRight,5,5);
			elseif MultiBarBottomLeft:IsShown() then
				HideJunk();
				MovePetBar(MultiBarBottomLeft,5,5);
			else
				HideJunk();
				MovePetBar(MainMenuBar,5,5);
			end
		end
		if ShapeshiftBarFrame:IsShown() then
			if PetActionBarFrame:IsShown() then
				HideJunk();
				MoveStanceBar(PetActionBarFrame,5,0);
			elseif MultiBarBottomRight:IsShown() then
				HideJunk();
				MoveStanceBar(MultiBarBottomRight,5,5);
			elseif MultiBarBottomLeft:IsShown() then
				HideJunk();
				MoveStanceBar(MultiBarBottomLeft,5,5);
			else
				HideJunk();
				MoveStanceBar(MainMenuBar,5,5);
			end
		end
		if PossessBarFrame:IsShown() then
			if MultiBarBottomRight:IsShown() then
				HideJunk();
				MovePossesBar(MultiBarBottomRight,0,5);
			elseif MultiBarBottomLeft:IsShown() then
				HideJunk();
				MovePossesBar(MultiBarBottomLeft,0,5);
			else
				HideJunk();
				MovePossesBar(MainMenuBar,0,14);
			end
		end
		if HasMultiCastActionBar then
			if PetActionBarFrame:IsShown() then
				HideJunk();
				MoveTotemBar(PetActionBarFrame,5,0);
			elseif MultiBarBottomRight:IsShown() then
				HideJunk();
				MoveTotemBar(MultiBarBottomRight,5,5);
			elseif MultiBarBottomLeft:IsShown() then
				HideJunk();
				MoveTotemBar(MultiBarBottomLeft,5,5);
			else
				HideJunk();
				MoveTotemBar(MainMenuBar,5,5);
			end
		end
	end
	if (RoathMenuState == "show") and not UnitInVehicle("player") then
		MoveMenuandBags();
		ShowRoathMenu();
	else
		HideRoathMenu();
	end
	if (RoathBagState == "show") then
		MoveMenuandBags();
		ShowRoathBags();
	else
		HideRoathBags();
	end
	if (RoathKeyState == nil or RoathKeyState == "show") then
		KeyRingButton:Show();
	elseif RoathKeyState == "hide" then
		KeyRingButton:Hide();
	end
	MoveCasterBar();
	SetMainMenuBarPosition();
	XPBarStuff();
end

hooksecurefunc("UIParent_ManageFramePositions", UpdateBarPositions);
hooksecurefunc("SetUpAnimation", UpdateBarPositions);

-------------------------------------
-- FUNCTIONS ------------------------
-------------------------------------

-- Function to hide the ShapeshiftBar and PetActionBar textures
function HideJunk(...)
	SlidingActionBarTexture0:Hide();
	SlidingActionBarTexture1:Hide();
	ShapeshiftBarLeft:Hide();
	ShapeshiftBarMiddle:Hide();
	ShapeshiftBarRight:Hide();
end

-- Function to move the bottom left actionbar
function MoveBottomLeft(attach,x,y)
	MultiBarBottomLeft:ClearAllPoints();
	MultiBarBottomLeft:SetPoint("BOTTOM", attach, "TOP", x, y);
end

-- function to move the bottom right actionbar
function MoveBottomRight(attach,x,y)
	MultiBarBottomRight:ClearAllPoints();
	MultiBarBottomRight:SetPoint("BOTTOM", attach, "TOP", x, y);
end

-- function to move the petbar
function MovePetBar(attach,x,y)
	UIPARENT_MANAGED_FRAME_POSITIONS["PetActionBarFrame"] = nil;
	PetActionBarFrame:ClearAllPoints();
	PetActionBarFrame:SetPoint("BOTTOMLEFT", attach, "TOPLEFT", x + RoathStanceOff, y);
end

-- function to move the stance and shapeshift bar
function MoveStanceBar(attach,x,y)
	UIPARENT_MANAGED_FRAME_POSITIONS["ShapeshiftBarFrame"] = nil;
	ShapeshiftBarFrame:ClearAllPoints();
	ShapeshiftButton1:SetPoint("BOTTOMLEFT", attach, "TOPLEFT", x + RoathStanceOff, y);
end

function MoveTotemBar(attach,x,y)
	MultiCastActionBarFrame:SetPoint("BOTTOMLEFT", attach, "TOPLEFT", x + RoathStanceOff, y);
end



-- function to move the Possesbar
function MovePossesBar(attach,x,y)
	UIPARENT_MANAGED_FRAME_POSITIONS["PossessBarFrame"] = nil;
	PossessBarFrame:ClearAllPoints();
	PossessBarFrame:SetPoint("BOTTOMLEFT", attach, "TOPLEFT", x + RoathStanceOff, y);
end

-- Hiding the actionbar paging buttons/number
MainMenuBarPageNumber:Hide();
ActionBarUpButton:Hide();
ActionBarDownButton:Hide();

-- Move the micro menu buttons and bags
function MoveMenuandBags()
	if not UnitInVehicle("player") then
		CharacterMicroButton:ClearAllPoints();
		CharacterMicroButton:SetPoint("BOTTOMRIGHT", WorldFrame, "BOTTOMRIGHT", -225, RoathOffset / Roathscale);
	end
	MainMenuBarBackpackButton:ClearAllPoints();
	MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", CharacterMicroButton, "TOPRIGHT", 225, -20);
end

-- Hiding various textures
--MainMenuXPBarTexture2:Hide();
--MainMenuXPBarTexture3:Hide();

function XPBarStuff()
	if not UnitInVehicle("player") then
		MainMenuXPBarDiv10:Hide();
		MainMenuXPBarDiv11:Hide();
		MainMenuXPBarDiv12:Hide();
		MainMenuXPBarDiv13:Hide();
		MainMenuXPBarDiv14:Hide();
		MainMenuXPBarDiv15:Hide();
		MainMenuXPBarDiv16:Hide();
		MainMenuXPBarDiv17:Hide();
		MainMenuXPBarDiv18:Hide();
		MainMenuXPBarDiv19:Hide();
	else
		MainMenuXPBarDiv10:Show();
		MainMenuXPBarDiv11:Show();
		MainMenuXPBarDiv12:Show();
		MainMenuXPBarDiv13:Show();
		MainMenuXPBarDiv14:Show();
		MainMenuXPBarDiv15:Show();
		MainMenuXPBarDiv16:Show();
		MainMenuXPBarDiv17:Show();
		MainMenuXPBarDiv18:Show();
		MainMenuXPBarDiv19:Show();
	end
end

MainMenuBarTexture2:Hide();
MainMenuBarTexture3:Hide();
--MainMenuMaxLevelBar0:Hide();
--MainMenuMaxLevelBar1:Hide();
MainMenuMaxLevelBar2:Hide();
MainMenuMaxLevelBar3:Hide();
ReputationWatchBarTexture2:SetTexture("");
ReputationWatchBarTexture3:SetTexture("");
ReputationXPBarTexture2:SetTexture("");
ReputationXPBarTexture3:SetTexture("");
SlidingActionBarTexture0:Hide();
SlidingActionBarTexture1:Hide();
ShapeshiftBarLeft:Hide();
ShapeshiftBarMiddle:Hide();
ShapeshiftBarRight:Hide();

-- Scaling the visible textures and setting the bar width
function SetMainMenuBarPosition()
	MainMenuBar:ClearAllPoints();
	MainMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", RoathHorizOff, (RoathOffset / Roathscale));

-- Moving the visible textures to their right location
--	MainMenuXPBarTexture0:SetPoint("BOTTOM", "MainMenuExpBar", "BOTTOM", -128, 2);
--	MainMenuXPBarTexture1:SetPoint("BOTTOM", "MainMenuExpBar", "BOTTOM", 128, 3);
	MainMenuMaxLevelBar0:SetPoint("BOTTOM", "MainMenuBarMaxLevelBar", "TOP", -128, 0);
	MainMenuBarTexture0:SetPoint("BOTTOM", "MainMenuBarArtFrame", "BOTTOM", -128, 0);
	MainMenuBarTexture1:SetPoint("BOTTOM", "MainMenuBarArtFrame", "BOTTOM", 128, 0);
	MainMenuBarLeftEndCap:SetPoint("BOTTOM", "MainMenuBarArtFrame", "BOTTOM", -290, 0);
	MainMenuBarRightEndCap:SetPoint("BOTTOM", "MainMenuBarArtFrame", "BOTTOM", 287, 0);
	MainMenuBar:SetWidth(512);
	MainMenuExpBar:SetWidth(512);
	ReputationWatchBar:SetWidth(512);
	MainMenuBarMaxLevelBar:SetWidth(512);
	ReputationWatchStatusBar:SetWidth(512);
--	MainMenuBarArtFrame:SetWidth(512);
--	VehicleMenuBar:ClearAllPoints();
--	VehicleMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", RoathHorizOff, (RoathOffset / (RoathVehiclescale * 0.8)));
end

function UpdateVehicleBarPositions()
	VehicleMenuBarArtFrame:Show();
	VehicleMenuBar:Show();
	VehicleMenuBar:ClearAllPoints();
	VehicleMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", RoathHorizOff, (RoathOffset / (RoathVehiclescale * 0.8)));
	
	VehicleMenuBar.currSkin = nil;
	for i=1, VEHICLE_MAX_BACKGROUND do
		_G["VehicleMenuBarArtFrameBACKGROUND"..i]:Hide();
	end
	for i=1, VEHICLE_MAX_BORDER do
		_G["VehicleMenuBarArtFrameBORDER"..i]:Hide();
	end
	for i=1, VEHICLE_MAX_ARTWORK do
		_G["VehicleMenuBarArtFrameARTWORK"..i]:Hide();
	end
	if RoathGryphonState == "hide" then
		for i=1, VEHICLE_MAX_OVERLAY do
			_G["VehicleMenuBarArtFrameOVERLAY"..i]:Hide();
		end
	end
end

-- Moving castingbar Upwards
function MoveCasterBar(self)
	UIPARENT_MANAGED_FRAME_POSITIONS["CastingBarFrame"] = nil;
	CastingBarFrame:ClearAllPoints();
	CastingBarFrame:SetPoint("BOTTOM", WorldFrame, "BOTTOM", RoathHorizOff, ((RoathOffset + 225 + RoathCastOffset)*Roathscale));
end
