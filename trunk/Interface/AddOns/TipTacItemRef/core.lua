local ttif = CreateFrame("Frame","TipTacItemRef");

-- Options
local cfg = {
	if_enable = true,
	if_infoColor = { 0.2, 0.6, 1 },
	if_itemQualityBorder = true,
	if_showAuraCaster = true,
	if_showItemLevelAndId = true,
	if_showQuestLevelAndId = true,
	if_showSpellIdAndRank = false,
	if_modifyAchievementTips = true,
	if_showIcon = true,
	if_smartIcons = true,
	if_borderlessIcons = false,
	if_iconSize = 42,
};

-- Tooltips to Hook into
local tipsToModify = {
	"GameTooltip",
	"ItemRefTooltip",
};
-- Tips which will have an icon
local tipsToAddIcon = {
	["GameTooltip"] = true,
	["ItemRefTooltip"] = true,
};

-- Tables
local TipTypeFuncs = {};
local criteriaList = {};	-- Used for Achievement criterias
local tipDataAdded = {};	-- Sometimes, OnTooltipSetItem/Spell is called before the tip has been filled using SetHyperlink, we use the array to test if the tooltip has had data added

-- Returns colored text string
local function BoolCol(bool)
	return (bool and "|cff80ff80" or "|cffff8080");
end

--------------------------------------------------------------------------------------------------------
--                                         Create Tooltip Icon                                        --
--------------------------------------------------------------------------------------------------------

-- Set Texture and Text
local function SetIconTextureAndText(self,texture,count)
	if (texture) then
		self.ttIcon:SetTexture(texture);
		self.ttCount:SetText(count);
		self.ttIcon:Show();
	else
		self.ttIcon:Hide();
		self.ttCount:SetText("");
	end
end

-- Create Icon for Tooltip
function ttif:CreateTooltipIcon(tip)
	tip.ttIcon = tip:CreateTexture(nil,"BACKGROUND");
	tip.ttIcon:SetPoint("TOPRIGHT",tip,"TOPLEFT",0,-2.5);
	tip.ttIcon:Hide();

	tip.ttCount = tip:CreateFontString(nil,"ARTWORK");
	tip.ttCount:SetTextColor(1,1,1);
	tip.ttCount:SetPoint("BOTTOMRIGHT",tip.ttIcon,"BOTTOMRIGHT",-3,3);
end

--------------------------------------------------------------------------------------------------------
--                                         TipTacItemRef Frame                                        --
--------------------------------------------------------------------------------------------------------

ttif:RegisterEvent("VARIABLES_LOADED");

-- OnEvent
ttif:SetScript("OnEvent",function(self,event,...)
	-- What tipsToModify to use?
	if (TipTac and TipTac.tipsToModify) then
		tipsToModify = TipTac.tipsToModify;
	else
		for index, tip in ipairs(tipsToModify) do
			tipsToModify[index] = (_G[tip] or false);	-- don't want to nil out an entry
		end
	end
	-- Use TipTac settings if installed
	if (TipTac_Config) then
		cfg = TipTac_Config;
	end
	-- Hook
	self:DoHooks();
	-- Settings
	self:ApplySettings();
	-- Cleanup
	self:UnregisterAllEvents();
	self:SetScript("OnEvent",nil);
end);

-- Apply Settings
function ttif:ApplySettings()
	for index, tip in ipairs(tipsToModify) do
		if (type(tip) == "table") and (tipsToAddIcon[tip:GetName()]) then
			if (cfg.if_showIcon) then
				tip.ttIcon:SetWidth(cfg.if_iconSize);
				tip.ttIcon:SetHeight(cfg.if_iconSize);
				tip.ttCount:SetFont(GameFontNormal:GetFont(),(cfg.if_iconSize / 3),"OUTLINE");
				tip.SetIconTextureAndText = SetIconTextureAndText;
				if (cfg.if_borderlessIcons) then
					tip.ttIcon:SetTexCoord(0.07,0.93,0.07,0.93);
				else
					tip.ttIcon:SetTexCoord(0,1,0,1);
				end
			elseif (tip.SetIconTextureAndText) then
				tip.ttIcon:Hide();
				tip.SetIconTextureAndText = nil;
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
--                                       HOOK: Tooltip Functions                                      --
--------------------------------------------------------------------------------------------------------

-- HOOK: ItemRefTooltip + GameTooltip: SetHyperlink
local function SetHyperlink_Hook(self,refString)
	if (cfg.if_enable) and (not tipDataAdded[self]) then
		local rawLink = refString:match("|H([^|]+)|h") or refString;
		local linkToken = rawLink:match("^[^:]+");
		-- Call Tip Type Func
		if (TipTypeFuncs[linkToken]) and (self:NumLines() > 0) then
			tipDataAdded[self] = "hyperlink";
			TipTypeFuncs[linkToken](self,(":"):split(rawLink));
		end
	end
end

-- HOOK: SetUnitAura
local function SetUnitAura_Hook(self,unit,index,filter)
	if (cfg.if_enable) and (cfg.if_showAuraCaster) then
		local _, _, _, _, _, _, _, casterUnit = UnitAura(unit,index,filter);
		if (UnitExists(casterUnit)) then
			self:AddLine(format("<Applied by %s>",UnitName(casterUnit) or UNKNOWN),unpack(cfg.if_infoColor));
			self:Show();
		end
	end
end

-- OnTooltipSetItem
local function OnTooltipSetItem(self,...)
	if (cfg.if_enable) and (not tipDataAdded[self]) then
		local _, link = self:GetItem();
		if (link) then
			local id = link:match("item:(%d+)");
			if (id) then
				tipDataAdded[self] = "item";
				TipTypeFuncs.item(self,"item",id);
			end
		end
	end
end

-- OnTooltipSetSpell
local function OnTooltipSetSpell(self,...)
	if (cfg.if_enable) and (not tipDataAdded[self]) then
		local _, _, id = self:GetSpell();
		if (id) then
			tipDataAdded[self] = "spell";
			TipTypeFuncs.spell(self,"spell",id);
		end
	end
end

-- OnTooltipCleared
local function OnTooltipCleared(self)
	tipDataAdded[self] = nil;
	if (self.SetIconTextureAndText) then
		self:SetIconTextureAndText();
	end
end

-- HOOK: SetHyperlink
function ttif:DoHooks()
	for index, tip in ipairs(tipsToModify) do
		if (type(tip) == "table") then
			if (tipsToAddIcon[tip:GetName()]) then
				self:CreateTooltipIcon(tip);
			end
			hooksecurefunc(tip,"SetHyperlink",SetHyperlink_Hook);
			hooksecurefunc(tip,"SetUnitAura",SetUnitAura_Hook);
			hooksecurefunc(tip,"SetUnitBuff",SetUnitAura_Hook);
			hooksecurefunc(tip,"SetUnitDebuff",SetUnitAura_Hook);
			tip:HookScript("OnTooltipSetItem",OnTooltipSetItem);
			tip:HookScript("OnTooltipSetSpell",OnTooltipSetSpell);
			tip:HookScript("OnTooltipCleared",OnTooltipCleared);
		end
	end
end

--------------------------------------------------------------------------------------------------------
--                                        Smart Icon Evaluation                                       --
--------------------------------------------------------------------------------------------------------

local function SmartIconEvaluation(tip,linkToken)
	local owner = tip:GetOwner();
	-- No Owner?
	if (not owner) then
		return false;
	-- Item
	elseif (linkToken == "item") then
		if (owner.hasItem or owner.action or owner.icon or owner.texture) then
			return false;
		end
	-- Spell
	elseif (linkToken == "spell") then
		if (owner.action or owner.icon) then
			return false;
		end
	end
	-- IconTexture sub texture
	local ownerName = owner:GetName();
	if (ownerName) then
		if (_G[ownerName.."IconTexture"]) or (ownerName:match("SendMailAttachment(%d+)")) then
			return false;
		end
	end
	-- Show Icon
	return true;
end

--------------------------------------------------------------------------------------------------------
--                                         Tip Type Functions                                         --
--------------------------------------------------------------------------------------------------------

-- instancelock
--function TipTypeFuncs:instancelock(linkToken,guid,mapId,difficulty,encounterbits)
--	AzDump(guid,mapId,difficulty,encounterbits)
--end

-- item
function TipTypeFuncs:item(linkToken,id)
	local _, _, itemRarity, itemLevel, _, _, _, itemStackCount, _, itemTexture = GetItemInfo(id);
	-- Icon
	if (self.SetIconTextureAndText) and (not cfg.if_smartIcons or SmartIconEvaluation(self,linkToken)) then
		local count = (itemStackCount and itemStackCount > 1 and (itemStackCount == 0x7FFFFFFF and "#" or itemStackCount) or "");
		self:SetIconTextureAndText(itemTexture,count);
	end
	-- Quality Border
	if (cfg.if_itemQualityBorder) then
		self:SetBackdropBorderColor(GetItemQualityColor(itemRarity or 0));
	end
	-- level + id
	if (cfg.if_showItemLevelAndId) then
		for i = 2, self:NumLines() do
			local line = _G[self:GetName().."TextLeft"..i];
			if (line and (line:GetText() or ""):match(ITEM_LEVEL.."+")) then
				line:SetText(nil);
				break;
			end
		end
		self:AddLine(format("ItemLevel: %d, ItemID: %d",itemLevel or 0,id or 0),unpack(cfg.if_infoColor));
		self:Show();
	end
end

-- spell
function TipTypeFuncs:spell(linkToken,id)
	local name, rank, icon = GetSpellInfo(id);
	-- Icon
	if (self.SetIconTextureAndText) and (not cfg.if_smartIcons or SmartIconEvaluation(self,linkToken)) then
		self:SetIconTextureAndText(icon);
	end
	-- Id + Rank
	if (cfg.if_showSpellIdAndRank) then
		self:AddLine("SpellID: "..id..(rank and rank ~= "" and ", "..rank or ""),unpack(cfg.if_infoColor));
		self:Show();
	end
end

-- quest
function TipTypeFuncs:quest(linkToken,id,level)
	if (cfg.if_showQuestLevelAndId) then
		self:AddLine(format("QuestLevel: %d, QuestID: %d",level or 0,id or 0),unpack(cfg.if_infoColor));
		self:Show();
	end
end

-- achievement
function TipTypeFuncs:achievement(linkToken,id,guid,completed,month,day,year,unknown1,unknown2,unknown3,unknown4)
	if (cfg.if_modifyAchievementTips) then
		completed = (tonumber(completed) == 1);
		local tipName = self:GetName();
		local isPlayer = (UnitGUID("player"):sub(3) == guid);
		-- Get category
		local catId = GetAchievementCategory(id);
		local category, catParent = GetCategoryInfo(catId);
		local catName;
		while (catParent > 0) do
			catName, catParent = GetCategoryInfo(catParent);
			category = catName.." - "..category;
		end
		-- Get Criteria
		wipe(criteriaList);
		local criteriaComplete = 0;
		for i = 6, self:NumLines() do
			local left = _G[tipName.."TextLeft"..i];
			local right = _G[tipName.."TextRight"..i];
			local leftText = left:GetText();
			local rightText = right:GetText();
			if (leftText and leftText ~= " ") then
				criteriaList[#criteriaList + 1] = { label = leftText, done = left:GetTextColor() < 0.5 };
				if (criteriaList[#criteriaList].done) then
					criteriaComplete = (criteriaComplete + 1);
				end
			end
			if (rightText and rightText ~= " ") then
				criteriaList[#criteriaList + 1] = { label = rightText, done = right:GetTextColor() < 0.5 };
				if (criteriaList[#criteriaList].done) then
					criteriaComplete = (criteriaComplete + 1);
				end
			end
		end
		-- Cache Info
		local progressText = _G[tipName.."TextLeft3"]:GetText() or "";
		local _, title, points, _, _, _, _, description, _, icon, reward = GetAchievementInfo(id);
		-- Rebuild Tip
		self:ClearLines();
		local stat = isPlayer and GetStatistic(id);
		self:AddDoubleLine(title,(stat ~= "0" and stat ~= "--" and stat),nil,nil,nil,1,1,1);
		self:AddLine("<"..category..">");
		if (reward) then
			self:AddLine(reward,unpack(cfg.if_infoColor));
		end
		self:AddLine(description,1,1,1,1);
		self:AddLine(BoolCol(completed)..progressText);
		if (#criteriaList > 0) then
			self:AddLine(" ");
			self:AddLine("Achievement Criteria |cffffffff"..criteriaComplete.."|r of |cffffffff"..#criteriaList);
			local r1, g1, b1, r2, g2, b2;
			local myDone1, myDone2;
			for i = 1, #criteriaList, 2 do
				r1, g1, b1 = (criteriaList[i].done and 0.25 or 0.5), (criteriaList[i].done and 0.75 or 0.5), (criteriaList[i].done and 0.25 or 0.5);
				if (criteriaList[i + 1]) then
					r2, g2, b2 = (criteriaList[i + 1].done and 0.25 or 0.5), (criteriaList[i + 1].done and 0.75 or 0.5), (criteriaList[i + 1].done and 0.25 or 0.5);
				end
				if (not isPlayer) then
					myDone1 = select(3,GetAchievementCriteriaInfo(id,i));
					myDone2 = select(3,GetAchievementCriteriaInfo(id,i + 1));
				end
				self:AddDoubleLine((isPlayer and "" or BoolCol(myDone1).."*|r")..criteriaList[i].label,criteriaList[i + 1] and criteriaList[i + 1].label..(isPlayer and "" or BoolCol(myDone2).."*"),r1,g1,b1,r2,g2,b2);
			end
		end
		-- Icon
		if (self.SetIconTextureAndText) then
			self:SetIconTextureAndText(icon,points);
		end
		-- Show
		self:Show();
	else
		-- Icon
		local _, _, points, _, _, _, _, _, _, icon = GetAchievementInfo(id);
		if (self.SetIconTextureAndText) then
			self:SetIconTextureAndText(icon,points);
		end
	end
end