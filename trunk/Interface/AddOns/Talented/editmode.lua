local Talented = Talented
local ipairs = ipairs
local L = LibStub("AceLocale-3.0"):GetLocale("Talented")

local CHAR_TEMPLATE_MAX_POINTS = 41
local PET_TEMPLATE_MAX_POINTS = 20
local CHAR_TEMPLATE_MASTERY_THRESHOLD = 31

function Talented:IsTemplateAtCap(template)
	local max = RAID_CLASS_COLORS[template.class] and CHAR_TEMPLATE_MAX_POINTS or PET_TEMPLATE_MAX_POINTS
	return self.db.profile.level_cap and self:GetPointCount(template) >= max
end

function Talented:GetPointCount(template)
	local total = 0
	local info = self:UncompressSpellData(template.class)
	for tab in ipairs(info) do
		total = total + self:GetTalentTabCount(template, tab)
	end
	return total
end

function Talented:GetTemplateMasteryState(template)
	if not RAID_CLASS_COLORS[template.class] then return "none" end
	local v1, v2, v3 = self:GetTalentTabCount(template, 1),
		self:GetTalentTabCount(template, 2),
		self:GetTalentTabCount(template, 3)
	if v1 >= CHAR_TEMPLATE_MASTERY_THRESHOLD then return "loose", 1 end
	if v2 >= CHAR_TEMPLATE_MASTERY_THRESHOLD then return "loose", 2 end
	if v3 >= CHAR_TEMPLATE_MASTERY_THRESHOLD then return "loose", 3 end
	local vc
	if v1 > 0 then vc = 1 end
	if v2 > 0 then if vc then return "error" end vc = 2 end
	if v3 > 0 then if vc then return "error" end vc = 3 end
	if vc then return "strict", vc end
	return "none"
end

function Talented:GetTalentTabCount(template, tab)
	local total = 0
	for _, value in ipairs(template[tab]) do
		total = total + value
	end
	return total
end

function Talented:ClearTalentTab(tab)
	local template = self.template
	if template and not template.talentGroup and self.mode == "edit" then
		local tab = template[tab]
		for index in ipairs(tab) do
			tab[index] = 0
		end
	end
	self:UpdateView()
end

function Talented:GetSkillPointsPerTier(class)
	-- Player Tiers are 5 points appart, Pet Tiers are only 3 points appart.
	return RAID_CLASS_COLORS[class] and 5 or 3
end

function Talented:IsTemplateTabLocked(template, tab)
	local ms, mt = self:GetTemplateMasteryState(template)
	if ms == "none" or ms == "loose" then return false end
	if ms == "error" then return true end
	return mt ~= tab
end

function Talented:GetTalentState(template, tab, index)
	if self:IsTemplateTabLocked(template, tab) then return "unavailable" end
	local s
	local info = self:UncompressSpellData(template.class)[tab][index]
	local tier = (info.row - 1) * self:GetSkillPointsPerTier(template.class)
	local count = self:GetTalentTabCount(template, tab)

	if count < tier then
		s = false
	else
		s = true
		if info.req and self:GetTalentState(template, tab, info.req) ~= "full" then
			s = false
		end
	end

	if not s or info.inactive then
		s = "unavailable"
	else
		local value = template[tab][index]
		if value == #info.ranks then
			s = "full"
		elseif value == 0 then
			s = "empty"
		else
			s = "available"
		end
	end
	return s
end

function Talented:ValidateTalentBranch(template, tab, index, newvalue)
	if self:IsTemplateTabLocked(template, tab) then return false end
	local count = 0
	local pointsPerTier = self:GetSkillPointsPerTier(template.class)
	local tree = self:UncompressSpellData(template.class)[tab]
	local ttab = template[tab]
	for i, talent in ipairs(tree) do
		local value = i == index and newvalue or ttab[i]
		if value > 0 then
			local tier = (talent.row - 1) * pointsPerTier
			if count < tier then
				self:Debug("Update refused because of tier")
				return false
			end
			local r = talent.req
			if r then
				local rvalue = r == index and newvalue or ttab[r]
				if rvalue < #tree[r].ranks then
					self:Debug("Update refused because of prereq")
					return false
				end
			end
			count = count + value
		end
	end
	return true
end

function Talented:ValidateTemplate(template, fix)
	local class = template.class
	if not class or not self.spelldata[class] then return end
	local pointsPerTier = self:GetSkillPointsPerTier(template.class)
	local info = self:UncompressSpellData(class)
	local fixed
	for tab, tree in ipairs(info) do
		local t = template[tab]
		if not t then return end
		local locked = self:IsTemplateTabLocked(template, tab)
		local count = 0
		for i, talent in ipairs(tree) do
			local value = t[i]
			if not value then return end
			if value > 0 then
				if locked then t[i], value, fixed = 0, 0, true end
				if count < (talent.row - 1) * pointsPerTier or value > (talent.inactive and 0 or #talent.ranks) then
					if fix then t[i], value, fixed = 0, 0, true else return end
				end
				local r = talent.req
				if r then
					if t[r] < #tree[r].ranks then
						if fix then t[i], value, fixed = 0, 0, true else return end
					end
				end
				count = count + value
			end
		end
	end
	if fixed then
		self:Print(L["The template '%s' had inconsistencies and has been fixed. Please check it before applying."], template.name)
		template.points = nil
	end
	return true
end
