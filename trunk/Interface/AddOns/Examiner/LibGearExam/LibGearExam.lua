local REVISION = 2;
if (type(LibGearExam) == "table") and (LibGearExam.revision and LibGearExam.revision >= REVISION) then
	return;
end

-- Examiner Scanner Table
LibGearExam = LibGearExam or {};
local LGE = LibGearExam;
LGE.revision = REVISION;

-- Patterns
LGE.ItemLinkPattern = "(item:[^|]+)";
--LGE.ItemLinkPattern = "^.+|H(item:[^|]+)|h%[.+$";
LGE.ItemLinkLevelPattern = "(%d+)(:%-?%d+)$";
LGE.ItemUseToken = "^"..ITEM_SPELL_TRIGGER_ONUSE.." ";
LGE.SetNamePattern = "^(.+) %((%d)/(%d)%)$";
LGE.SetBonusTokenActive = "^"..ITEM_SET_BONUS:gsub("%%s","");

-- Schools
LGE.MagicSchools = { "FIRE", "NATURE", "ARCANE", "FROST", "SHADOW", "HOLY" };

-- Gear Slots
LGE.Slots = {
	"HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot",
	"HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot",
	"MainHandSlot", "SecondaryHandSlot", "RangedSlot",
};
LGE.SlotIDs = {};
for _, slotName in ipairs(LGE.Slots) do
	LGE.SlotIDs[slotName] = GetInventorySlotInfo(slotName);
end

-- Stat Names
LGE.StatNames = {
	STR = ITEM_MOD_STRENGTH_SHORT,
	AGI = ITEM_MOD_AGILITY_SHORT,
	STA = ITEM_MOD_STAMINA_SHORT,
	INT = ITEM_MOD_INTELLECT_SHORT,
	SPI = ITEM_MOD_SPIRIT_SHORT,

	ARMOR = ARMOR,

	ARCANERESIST = RESISTANCE6_NAME,
	FIRERESIST = RESISTANCE2_NAME,
	NATURERESIST = RESISTANCE3_NAME,
	FROSTRESIST = RESISTANCE4_NAME,
	SHADOWRESIST = RESISTANCE5_NAME,

	MASTERY = ITEM_MOD_MASTERY_RATING_SHORT,

	DODGE = ITEM_MOD_DODGE_RATING_SHORT,
	PARRY = ITEM_MOD_PARRY_RATING_SHORT,
	DEFENSE = ITEM_MOD_DEFENSE_RATING_SHORT,
	BLOCK = ITEM_MOD_BLOCK_RATING_SHORT,
	BLOCKVALUE = ITEM_MOD_BLOCK_VALUE_SHORT,
	RESILIENCE = ITEM_MOD_RESILIENCE_RATING_SHORT,

	AP = ITEM_MOD_ATTACK_POWER_SHORT,
	RAP = ITEM_MOD_RANGED_ATTACK_POWER_SHORT,
	CRIT = ITEM_MOD_CRIT_MELEE_RATING_SHORT,
	HIT = ITEM_MOD_HIT_MELEE_RATING_SHORT,
	HASTE = ITEM_MOD_HASTE_MELEE_RATING_SHORT,

	WPNDMG = DAMAGE_TOOLTIP,
	RANGEDDMG = RANGED_DAMAGE_TOOLTIP,
	ARMORPENETRATION = ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT,
	EXPERTISE = ITEM_MOD_EXPERTISE_RATING_SHORT,

	SPELLCRIT = ITEM_MOD_CRIT_SPELL_RATING_SHORT,
	SPELLHIT = ITEM_MOD_HIT_SPELL_RATING_SHORT,
	SPELLHASTE = ITEM_MOD_HASTE_SPELL_RATING_SHORT,
	SPELLPENETRATION = ITEM_MOD_SPELL_PENETRATION_SHORT,

	SPELLDMG = ITEM_MOD_SPELL_POWER_SHORT,
	ARCANEDMG = ITEM_MOD_SPELL_POWER_SHORT.." ("..STRING_SCHOOL_ARCANE..")",
	FIREDMG = ITEM_MOD_SPELL_POWER_SHORT.." ("..STRING_SCHOOL_FIRE..")",
	NATUREDMG = ITEM_MOD_SPELL_POWER_SHORT.." ("..STRING_SCHOOL_NATURE..")",
	FROSTDMG = ITEM_MOD_SPELL_POWER_SHORT.." ("..STRING_SCHOOL_FROST..")",
	SHADOWDMG = ITEM_MOD_SPELL_POWER_SHORT.." ("..STRING_SCHOOL_SHADOW..")",
	HOLYDMG = ITEM_MOD_SPELL_POWER_SHORT.." ("..STRING_SCHOOL_HOLY..")",

	-- Az: How to make these two more global?
	HP = HEALTH.." Points",
	MP = MANA.." Points",

	HP5 = ITEM_MOD_HEALTH_REGEN_SHORT,
	MP5 = ITEM_MOD_POWER_REGEN0_SHORT,
};

-- Scanner Tooltip
LGE.Tip = LGE.Tip or CreateFrame("GameTooltip","LibGearExamTip",nil,"GameTooltipTemplate");
LGE.Tip:SetOwner(UIParent,"ANCHOR_NONE");

-- Used in ScanUnitItems
local scannedSetNames = {};

--------------------------------------------------------------------------------------------------------
--                                  Level 60 Stat Rating Base Numbers                                 --
--------------------------------------------------------------------------------------------------------

-- More Info - Thanks to Whitetooth.
-- http://elitistjerks.com/f15/t29453-combat_ratings_level_85_cataclysm/

-- Combat Rating Changes in WoW Version History:
-- 3.1		Armor Penetration	"All classes now receive 25% more benefit from Armor Penetration Rating."
-- 3.2		Dodge				"The amount of dodge rating required per percentage of dodge has been increased by 15%"
-- 3.2		Parry				"The amount of parry rating required per percentage of parry has been reduced by 8%."
-- 3.2		Resilience			"... In addition, the amount of resilience needed to reduce critical strike chance, critical strike damage and overall damage has been increased by 15%"
-- 3.2.2	Armor Penetration	"The amount of armor penetration gained per point of this rating has been reduced by 12%."

LGE.StatRatingBaseTable = {
	SPELLHASTE = 10,
	SPELLHIT = 8,
	SPELLCRIT = 14,
	HASTE = 10,
	HIT = 9.37931,				-- Buffed a little in 4.0.1 (was 10 before)
	CRIT = 14,
	EXPERTISE = 2.34483,		-- Buffed a little in 4.0.1 (was 2.5 before)
	DODGE = 13.8,
	PARRY = 13.8,
	BLOCK = 6.9,				-- Nerfed a little in 4.0.1 (was 5 before)
	RESILIENCE = 21.5625 / 2;	-- Reduced 25% compared to wrath, then buffed by 100% as a "hotfix"
	MASTERY = 14,

	DEFENSE = 1.5,
	ARMORPENETRATION = 4.69512176513672 / 1.25 / .88,
};

--------------------------------------------------------------------------------------------------------
--          Scan all items and set bonuses on given 'unit' (Make sure the tables are reset)           --
--------------------------------------------------------------------------------------------------------
function LGE:ScanUnitItems(unit,statTable,setTable)
	if (not unit) or (not UnitExists(unit)) then
		return;
	end
	-- Check all item slots
	for _, slotName in ipairs(self.Slots) do
		-- Set New Item Tip
		self.Tip:ClearLines();
		self.Tip:SetInventoryItem(unit,self.SlotIDs[slotName]);
		local lastSetName;
		local lastBonusCount = 1;
		-- Check Lines
		for i = 2, self.Tip:NumLines() do
			local needScan, lineText = self:DoLineNeedScan(_G["LibGearExamTipTextLeft"..i],true);
			if (needScan) then
				-- We use "setMax" to check if the Line was a SetNamePattern (WTB continue statement in Lua)
				local setName, setCount, setMax;
				-- Set Header (Only run this if we haven't found a set on this item yet)
				if (not lastSetName) then
					setName, setCount, setMax = lineText:match(self.SetNamePattern);
					if (setMax) and (not setTable[setName]) then
						setTable[setName] = { count = tonumber(setCount), max = tonumber(setMax) };
						lastSetName = setName;
						--continue :(
					end
				end
				-- Check Line for Patterns if this Line was not a SetNamePattern
				if (not setMax) then
					if (lineText:find(self.SetBonusTokenActive)) then
						-- If this item is part of a set, that we haven't scanned the setbonuses of, do it now.
						if (lastSetName) and (not scannedSetNames[lastSetName]) then
							self:ScanLineForPatterns(lineText,statTable);
							setTable[lastSetName]["setBonus"..lastBonusCount] = lineText;
							lastBonusCount = (lastBonusCount + 1);
						end
					else
						self:ScanLineForPatterns(lineText,statTable);
					end
				end
			end
		end
		-- Mark this set as scanned
		if (lastSetName) then
			scannedSetNames[lastSetName] = true;
		end
	end
	-- Cleanup
	wipe(scannedSetNames);
end
--------------------------------------------------------------------------------------------------------
--        Scans a single item given by 'itemLink', stats are added to the 'statTable' variable        --
--------------------------------------------------------------------------------------------------------
function LGE:ScanItemLink(itemLink,statTable)
	if (itemLink) then
		-- Set Link
		self.Tip:ClearLines();
		self.Tip:SetHyperlink(itemLink);
		-- Check Lines
		for i = 2, self.Tip:NumLines() do
			local needScan, lineText = self:DoLineNeedScan(_G["LibGearExamTipTextLeft"..i],false);
			if (needScan) then
				self:ScanLineForPatterns(lineText,statTable);
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------
--                         Checks if a Line Needs to be Scanned for Patterns                          --
--------------------------------------------------------------------------------------------------------
function LGE:DoLineNeedScan(tipLine,scanSetBonuses)
	-- Init Line
	local text = tipLine:GetText();
	local color = text:match("^(|c%x%x%x%x%x%x%x%x)");
	text = text:gsub("|c%x%x%x%x%x%x%x%x","");
	local r, g, b = tipLine:GetTextColor();
	r, g, b = ceil(r * 255), ceil(g * 255), ceil(b * 255);
	-- Always *Skip* Gray Lines
	if (r == 128 and g == 128 and b == 128) or (color == "|cff808080") then
		return false, text;
	-- Active Set Bonuses (Must be checked before green color check)
	elseif (not scanSetBonuses and text:find(self.SetBonusTokenActive)) then
		return false, text;
	-- Skip "Use:" lines, they are not a permanent stat, so don't include them
	elseif (text:find(self.ItemUseToken)) then
		return false, text;
	-- Always *Scan* Green Lines
	elseif (r == 0 and g == 255 and b == 0) or (color == "|cff00ff00") then
		return true, text;
	-- Should Match: Normal +Stat, Base Item Armor, Block Value on Shields
	elseif (text:find("^[+-]?%d+ [^%d]")) then
		return true, text;
	-- Set Names (Needed to Check Sets)
	elseif (scanSetBonuses and text:find(self.SetNamePattern)) then
		return true, text;
	end
	return;
end
--------------------------------------------------------------------------------------------------------
--                                 Checks a Single Line for Patterns                                  --
--------------------------------------------------------------------------------------------------------
function LGE:ScanLineForPatterns(text,statTable)
	for index, pattern in ipairs(self.Patterns) do
		local pos, _, value1, value2 = text:find(pattern.p);
		if (pos) and (value1 or pattern.v) then
-- Az: debug!
if (pattern.alert) then
	local _, link = self.Tip:GetItem();
	link = link:match(self.ItemLinkPattern);
	AzMsg("|2Examiner Scan Alert:|r Please report the following to author.");
	AzMsg(format("index = |1%d|r, unit = |1%s|r.",index,Examiner.info.name));
	AzMsg(format("text = |1%s|r",text));
	AzMsg(format("pattern = |1%s|r",pattern.p));
	AzMsg(format("link = |1%s|r",tostring(link)));
end
			if (type(pattern.s) == "string") then
				statTable[pattern.s] = (statTable[pattern.s] or 0) + (value1 or pattern.v);
			elseif (type(pattern.s) == "table") then
				for statIndex, statName in ipairs(pattern.s) do
					if (type(pattern.v) == "table") then
						statTable[statName] = (statTable[statName] or 0) + (pattern.v[statIndex]);
					-- Az: This is a bit messy, only supports 2 now, needs to make it dynamic and support as many extra values as needed
					elseif (statIndex == 2) and (value2) then
						statTable[statName] = (statTable[statName] or 0) + (value2);
					else
						statTable[statName] = (statTable[statName] or 0) + (value1 or pattern.v);
					end
				end
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------
--              Convert Rating to Percent          http://www.wowwiki.com/Combat_Rating_System        --
--------------------------------------------------------------------------------------------------------
function LGE:GetRatingInPercent(stat,rating,level,class)
	local base = self.StatRatingBaseTable[stat];
	-- Check Valid Input
	if (not base or not rating or not level) then
		return;
	end
	-- Patch 3.1 Quote: "shamans, paladins, druids, and death knights now receive 30% more melee haste from Haste Rating."
	-- Az: This has been disabled for cataclysm. Haven't read anything official about it being removed, but it appears to be. Tested on paladins and shamans. DKs and druids still untested.
--	if (class and stat == "HASTE") and (class == "PALADIN" or class == "SHAMAN" or class == "DEATHKNIGHT" or class == "DRUID") then
--		base = (base / 1.3);
--	end
	-- Calculate "scale" Depending on Level
	local scale;
	if (level > 80) then
		scale = (82 / 52 * (131 / 63) * 3.9053695 ^ ((level - 80) / 5));	-- Az: not the correct Cata formula for 80-85!
	elseif (level >= 70) then
		scale = (82 / 52 * (131 / 63) ^ ((level - 70) / 10));
	elseif (level >= 60) then
		scale = (82 / (262 - 3 * level));
	elseif (level <= 33) and (stat == "DODGE" or stat == "PARRY" or stat == "BLOCK" or stat == "RESILIENCE") then
		scale = 0.5;
	elseif (level > 10) then
		scale = ((level - 8) / 52);
	else
		scale = (2 / 52);
	end
	-- Return Calculated Percentage
	return (rating / base / scale);
end
--------------------------------------------------------------------------------------------------------
--                                        Fix Item String Level                                       --
--------------------------------------------------------------------------------------------------------
function LGE:FixItemStringLevel(link,level)
	-- The level number of an item string, is always the inspector's level, not the inspected, this function fixes that
	-- WARNING: This code will break if item strings gets another value added
	return (link and level) and link:gsub(self.ItemLinkLevelPattern,level.."%2") or link;
end