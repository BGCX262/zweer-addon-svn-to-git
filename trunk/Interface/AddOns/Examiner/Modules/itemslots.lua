local ex = Examiner;
local gtt = GameTooltip;

-- Module
local mod = ex:CreateModule("ItemSlots");
mod.slotBtns = {};

-- Variables
local cfg, cache;
local statTipStats1, statTipStats2 = {}, {};

-- Options
ex.options[#ex.options + 1] = { var = "alwaysShowItemLevel", default = false, label = "Always Show Item Levels", tip = "With this enabled, the items will always show their item levels, instead of having to hold down the ALT key." };

--------------------------------------------------------------------------------------------------------
--                                           Module Scripts                                           --
--------------------------------------------------------------------------------------------------------

-- OnInitialize
function mod:OnInitialize()
	cfg = Examiner_Config;
	cache = Examiner_Cache;
	-- Create a sorted List of Stats
	local stats = LibGearExam.StatNames;
	local statsSorted = {};
	LibGearExam.StatNamesSorted = statsSorted;
	for stat, name in next, stats do
		statsSorted[#statsSorted + 1] = stat;
	end
	sort(statsSorted,function(a,b) return stats[a] < stats[b]; end);
end

-- OnInspect
function mod:OnInspect(unit,guid)
	self:ShowItemSlotButtons();
	if (ex.isSelf) then
		self:UpdateItemSlots();
	end
end

-- OnInspectReady
function mod:OnInspectReady(unit,guid)
	self:ShowItemSlotButtons();
	if (not ex.isSelf) then
		self:UpdateItemSlots();
	end
end

-- OnCacheLoaded
function mod:OnCacheLoaded(entry,unit)
	self:UpdateItemSlots();
	self:ShowItemSlotButtons();
end

-- OnPageChanged
function mod:OnPageChanged(mod)
	self:ShowItemSlotButtons();
end

-- OnConfigChanged
function mod:OnConfigChanged(var,value)
	if (var == "alwaysShowItemLevel") then
		for index, button in ipairs(self.slotBtns) do
			if (value) and (button.link) then
				button.level:Show();
			else
				button.level:Hide();
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
--                                          Helper Functions                                          --
--------------------------------------------------------------------------------------------------------

-- Show the Item Slot Buttons
function mod:ShowItemSlotButtons()
	local visible = (ex.itemsLoaded) and (not cfg.activePage or ex.modules[cfg.activePage].showItems);
	for _, button in ipairs(self.slotBtns) do
		if (visible) then
			button:Show();
		else
			button:Hide();
		end
	end
end

-- UpdateSlot: Updates slot from "button.link"
function mod:UpdateItemSlots()
	for index, button in ipairs(self.slotBtns) do
		local link = ex.info.Items[button.slotName];
		if (cfg.alwaysShowItemLevel) then
			button.level:Show();
		end
		button.realLink = nil;
		button.link = link;
		if (not link) then
			button.texture:SetTexture(button.bgTexture);
			button.border:Hide();
			button.level:SetText("");
		elseif (GetItemInfo(link)) then
			local _, _, itemRarity, itemLevel, _, _, _, _, _, itemTexture = GetItemInfo(link);
			button.texture:SetTexture(itemTexture or "Interface\\Icons\\INV_Misc_QuestionMark");
			local r,g,b = GetItemQualityColor(itemRarity and itemRarity > 0 and itemRarity or 0);
			button.border:SetVertexColor(r,g,b);
			button.border:Show();
			button.level:SetText(itemLevel);
		else
			button.realLink = link;
			button.link = nil;
			button.texture:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
			button.border:Hide();
			button.level:SetText("");
		end
	end
end

--------------------------------------------------------------------------------------------------------
--                                          Item Slot Scripts                                         --
--------------------------------------------------------------------------------------------------------

-- OnEnter
local function OnEnter(self,motion)
	-- Inspect Cursor
	if (IsModifiedClick("DRESSUP")) then
		ShowInspectCursor();
	else
		ResetCursor();
	end
	-- Set Tip
	gtt:SetOwner(self,"ANCHOR_RIGHT");
	if (self.link) and (IsShiftKeyDown()) and (IsAltKeyDown()) then
		local linkToken, itemId, enchantId, gemId1, gemId2, gemId3, gemId4, suffixId, uniqueId, linkLvl, reforgeId = (":"):split(self.link);
		local itemName, _, itemRarity = GetItemInfo(self.link);
		gtt:AddLine(itemName,GetItemQualityColor(itemRarity));
		gtt:AddDoubleLine("itemId",itemId,1,1,1);
		gtt:AddDoubleLine("enchantId",enchantId,1,1,1);
		gtt:AddDoubleLine("gemId1",gemId1,1,1,1);
		gtt:AddDoubleLine("gemId2",gemId2,1,1,1);
		gtt:AddDoubleLine("gemId3",gemId3,1,1,1);
		gtt:AddDoubleLine("gemId4",gemId4,1,1,1);
		gtt:AddDoubleLine("suffixId",suffixId,1,1,1);
		gtt:AddDoubleLine("uniqueId",format("0x%x",uniqueId),1,1,1);
		gtt:AddDoubleLine("linkLvl",linkLvl,1,1,1);
		gtt:AddDoubleLine("reforgeId",reforgeId,1,1,1);
		gtt:Show();
	elseif (self.link) and (IsAltKeyDown()) then
		local itemName, _, itemRarity = GetItemInfo(self.link);
		gtt:AddLine(itemName,GetItemQualityColor(itemRarity));
		LibGearExam:ScanItemLink(self.link,statTipStats1);
		if (ex.isComparing) then
			LibGearExam:ScanItemLink(ex.compareStats[self.slotName],statTipStats2);
		end
		for index, statToken in ipairs(LibGearExam.StatNamesSorted) do
			if (statTipStats1[statToken]) or (statTipStats2 and statTipStats2[statToken]) then
				local statName = LibGearExam.StatNames[statToken];
				gtt:AddDoubleLine(statName,ex:GetStatValue(statToken,statTipStats1,ex.isComparing and statTipStats2),1,1,1);
			end
		end
		wipe(statTipStats1);
		wipe(statTipStats2);
		gtt:Show();
	elseif (ex:ValidateUnit() and CheckInteractDistance(ex.unit,1) and gtt:SetInventoryItem(ex.unit,self.id)) then
	elseif (self.link) then
		gtt:SetHyperlink(self.link);
	elseif (self.realLink) then
		gtt:SetText(_G[self.slotName:upper()]);
		gtt:AddLine("ItemID: "..self.realLink:match("item:(%d+)"),0,0.44,0.86);
		gtt:AddLine("This item was not in the local item cache, click this button to reload the cached player, so the item will update.",1,1,1,1);
		gtt:Show();
	else
		gtt:SetText(_G[self.slotName:upper()]);
	end
end

-- OnLeave
local function OnLeave(self)
	ResetCursor();
	gtt:Hide();
end

-- OnEvent -- MODIFIER_STATE_CHANGED
local function OnEvent(self,event,key,state)
	-- Update Tip
	if (gtt:IsOwned(self)) then
		OnEnter(self);
	end
	-- Toggle ItemLevel
	if (not cfg.alwaysShowItemLevel) then
		if (self.link) and (IsAltKeyDown()) then
			self.level:Show();
		else
			self.level:Hide();
		end
	end
end

-- OnDrag
local function OnDrag(self)
	if (ex:ValidateUnit() and UnitIsUnit(ex.unit,"player")) then
		PickupInventoryItem(self.id);
	end
end

-- OnClick
local function OnClick(self,button)
	if (self.link) then
		if (button == "RightButton") then
			AzMsg("---|2 Gem Overview for "..select(2,GetItemInfo(self.link)).." |r---");
			for i = 1, 3 do
				local _, gemLink = GetItemGem(self.link,i);
				if (gemLink) then
					AzMsg(format("Gem |1%d|r = %s",i,gemLink));
				end
			end
		elseif (button == "LeftButton") then
			local editBox = ChatEdit_GetActiveWindow();
			if (IsModifiedClick("DRESSUP")) then
				DressUpItemLink(self.link);
			elseif (IsModifiedClick("CHATLINK")) and (editBox) and (editBox:IsVisible()) then
				editBox:Insert(select(2,GetItemInfo(self.link)));
			else
				OnDrag(self);
			end
		end
	elseif (self.realLink) then
		local entryName = ex:GetEntryName();
		ex:ClearInspect();
		ex:LoadPlayerFromCache(entryName);
		OnEnter(self);
	end
end

-- OnShow
local function OnShow(self)
	self:RegisterEvent("MODIFIER_STATE_CHANGED");
end

-- OnHide
local function OnHide(self)
	self:UnregisterEvent("MODIFIER_STATE_CHANGED");
	if (not cfg.alwaysShowItemLevel) then
		self.level:Hide();
	end
end

--------------------------------------------------------------------------------------------------------
--                                           Widget Creation                                          --
--------------------------------------------------------------------------------------------------------

for index, slot in ipairs(LibGearExam.Slots) do
	local btn = CreateFrame("Button","ExaminerItemButton"..slot,ex.model); -- Some other mods bug if you create this nameless
	btn:SetWidth(37);
	btn:SetHeight(37);
	btn:RegisterForClicks("LeftButtonUp","RightButtonUp");
	btn:RegisterForDrag("LeftButton");
	btn:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress");
	btn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");

	btn:SetScript("OnShow",OnShow);
	btn:SetScript("OnHide",OnHide);
	btn:SetScript("OnClick",OnClick);
	btn:SetScript("OnEnter",OnEnter);
	btn:SetScript("OnLeave",OnLeave);
	btn:SetScript("OnEvent",OnEvent);
	btn:SetScript("OnDragStart",OnDrag);
	btn:SetScript("OnReceiveDrag",OnDrag);

	btn.id, btn.bgTexture = GetInventorySlotInfo(slot);
	btn.slotName = slot;

	btn.texture = btn:CreateTexture(nil,"BACKGROUND");
	btn.texture:SetAllPoints();

	btn.border = btn:CreateTexture(nil,"OVERLAY");
	btn.border:SetTexture("Interface\\Addons\\Examiner\\Textures\\Border");
	btn.border:SetWidth(41);
	btn.border:SetHeight(41);
	btn.border:SetPoint("CENTER");

	btn.level = btn:CreateFontString(nil,"ARTWORK","GameFontHighlight");
	btn.level:SetFont(GameFontHighlight:GetFont(),12,"OUTLINE");
	btn.level:SetPoint("BOTTOM",0,4);
	btn.level:Hide();

	if (index == 1) then
		btn:SetPoint("TOPLEFT",4,-3);
	elseif (index == 9) then
		btn:SetPoint("TOPRIGHT",-4,-3);
	elseif (index == 17) then
		btn:SetPoint("BOTTOM",-41.5,27);
	elseif (index <= 16) then
		btn:SetPoint("TOP",mod.slotBtns[index - 1],"BOTTOM",0,-4);
	else
		btn:SetPoint("LEFT",mod.slotBtns[index - 1],"RIGHT",5,0);
	end

	mod.slotBtns[index] = btn;
end