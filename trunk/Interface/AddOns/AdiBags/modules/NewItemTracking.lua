--[[
AdiBags - Adirelle's bag addon.
Copyright 2010 Adirelle (adirelle@tagada-team.net)
All rights reserved.
--]]

local addonName, addon = ...
local L = addon.L

local mod = addon:RegisterFilter('NewItem', 80, 'AceEvent-3.0', 'AceBucket-3.0', 'AceTimer-3.0')
mod.uiName = L['Track new items']
mod.uiDesc = L['Track new items in each bag, displaying a glowing aura over them and putting them in a special section. "New" status can be reset by clicking on the small "N" button at top left of bags.']

local allBagIds = {}

local bags = {}
local inventory = {}
local glows = {}
local frozen = false
local inventoryScanned = false
local initializing = false
local bagUpdateBucket

function mod:OnInitialize()
	self.db = addon.db:RegisterNamespace(self.moduleName, {
		profile = {
			showGlow = true,
			glowScale = 1.5,
			glowColor = { 0.3, 1, 0.3, 0.7 },
			ignoreJunk = false,
		},
	})
	addon:SetCategoryOrder(L['New'], 100)
end

function mod:OnEnable()

	for i, bag in addon:IterateBags() do
		if not bags[bag.bagName] then
			self:Debug('Adding bag', bag, bag.bagIds)
			local data = {
				bagIds = bag.bagIds,
				isBank = bag.isBank,
				counts = {},
				newItems = {},
				first = true,
				available = not bag.isBank,
			}
			for id in pairs(bag.bagIds) do
				allBagIds[id] = id
			end
			bags[bag.bagName] = data
		end
	end

	addon:HookBagFrameCreation(self, 'OnBagFrameCreated')
	for name, bag in pairs(bags) do
		if bag.button then
			bag.button:Show()
		end
	end

	self:RegisterMessage('AdiBags_PreFilter')
	self:RegisterMessage('AdiBags_UpdateButton', 'UpdateButton')

	self:RegisterEvent('BANKFRAME_OPENED')
	self:RegisterEvent('BANKFRAME_CLOSED')
	self:RegisterEvent('EQUIPMENT_SWAP_PENDING')
	self:RegisterEvent('EQUIPMENT_SWAP_FINISHED')
	self:RegisterEvent('UNIT_INVENTORY_CHANGED')

	initializing = true
	bagUpdateBucket = self:RegisterBucketEvent('BAG_UPDATE', 10, "UpdateBags")

	addon.filterProto.OnEnable(self)
end

function mod:OnDisable()
	for name, bag in pairs(bags) do
		if bag.button then
			bag.button:Hide()
		end
	end
	addon.filterProto.OnDisable(self)
end

--------------------------------------------------------------------------------
-- Widget creation
--------------------------------------------------------------------------------

local function ResetButton_OnClick(button)
	PlaySound("igMainMenuOptionCheckBoxOn")
	mod:Reset(button.bagName)
end

function mod:OnBagFrameCreated(bag)
	local container = bag:GetFrame()

	local button = CreateFrame("Button", nil, container, "UIPanelButtonTemplate")
	button.bagName = bag.bagName
	button:SetText("N")
	button:SetWidth(20)
	button:SetHeight(20)
	button:SetScript("OnClick", ResetButton_OnClick)
	container:AddHeaderWidget(button, 10)
	addon.SetupTooltip(button, {
		L["Reset new items"],
		L["Click to reset item status."]
	}, "ANCHOR_TOPLEFT", 0, 8)

	if not next(bags[bag.bagName].newItems) then
		button:Disable()
	end

	container:HookScript('OnShow', function()
		mod:UpdateBags(bag.bagIds)
	end)

	bags[bag.bagName].button = button
	bags[bag.bagName].container = container
end

--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------

function mod:GetOptions()
	return {
		showGlow = {
			name = L['New item highlight'],
			type = 'toggle',
			order = 10,
		},
		glowScale = {
			name = L['Highlight scale'],
			type = 'range',
			min = 0.5,
			max = 3.0,
			step = 0.01,
			isPercent = true,
			bigStep = 0.05,
			order = 20,
		},
		glowColor = {
			name = L['Highlight color'],
			type = 'color',
			order = 30,
			hasAlpha = true,
		},
		ignoreJunk = {
			name = L['Ignore low quality items'],
			type = 'toggle',
			order = 40,
			set = function(info, ...)
				info.handler:Set(info, ...)
				self:UpdateBags(allBagIds)
			end
		},
	}, addon:GetOptionHandler(self)
end

--------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------

function mod:UNIT_INVENTORY_CHANGED(event, unit)
	if unit == "player" then
		inventoryScanned = false
	end
end

function mod:BANKFRAME_OPENED(event)
	self:Debug(event)
	self:UpdateInventory()
	for name, bag in pairs(bags) do
		if bag.isBank then
			bag.available = true
			if initialized then
				self:UpdateBags(bag.bagIds)
			end
		end
	end
end

function mod:BANKFRAME_CLOSED(event)
	self:Debug(event)
	for name, bag in pairs(bags) do
		if bag.isBank then
			bag.available = false
		end
	end
end

function mod:EQUIPMENT_SWAP_PENDING(event)
	self:Debug(event)
	frozen = true
end

function mod:EQUIPMENT_SWAP_FINISHED(event)
	self:Debug(event)
	frozen = false
	inventoryScanned = false
	if initialized then
		self:UpdateBags(allBagIds)
	end
end

local GetDistinctItemID = addon.GetDistinctItemID

local function IsIgnored(itemId)
	return mod.db.profile.ignoreJunk and select(3, GetItemInfo(itemId)) == ITEM_QUALITY_POOR
end

local newCounts, equipped = {}, {}
function mod:UpdateBag(bag)
	if not bag.available then return end

	wipe(newCounts)
	wipe(equipped)

	-- Gather every item id of every bags
	for bagId in pairs(bag.bagIds) do
		for slot = 1, GetContainerNumSlots(bagId) do
			local _, count, _, _, _, _, link = GetContainerItemInfo(bagId, slot)
			local itemId = GetDistinctItemID(link)
			if itemId then
				newCounts[itemId] = (newCounts[itemId] or 0) + (count or 1)
			end
		end
	end

	-- Merge items from inventory
	for slot, link in pairs(inventory) do
		local itemId = GetDistinctItemID(link)
		if itemId then
			newCounts[itemId] = (newCounts[itemId] or 0) + 1
			equipped[itemId] = (equipped[itemId] or 0) + 1
		end
	end

	local counts, newItems = bag.counts, bag.newItems

	-- Items that were in the bags
	for itemId, oldCount in pairs(counts) do
		local newCount = newCounts[itemId]
		counts[itemId], newCounts[itemId] = newCount, nil
		if newCount and equipped[itemId] then -- Ignore equipped item count
			newCount = newCount - equipped[itemId]
		end
		if not newCount or IsIgnored(itemId) then
			if newItems[itemId] then
				self:Debug('Not new anymore', itemId)
				newItems[itemId] = nil
				bag.updated = true
			end
		elseif not bag.first and newCount > oldCount and not newItems[itemId] then
			self:Debug('Got more of', itemId)
			newItems[itemId] = true
			bag.updated = true
		end
	end

	-- Brand new items
	for itemId, newCount in pairs(newCounts) do
		counts[itemId] = newCount
		if not bag.first and not equipped[itemId] and not newItems[itemId] and not IsIgnored(itemId) then
			self:Debug('Brand new item:', itemId)
			newItems[itemId] = true
			bag.updated = true
		end
	end

	bag.first = nil
end

function mod:UpdateBags(bagIds)
	self:Debug('UpdateBags')

	if GetContainerNumSlots(BACKPACK_CONTAINER) == 0 then
		-- No bag data at all
		self:Debug('Aborting, no bag data')
		return
	end

	-- Update inventory if need be
	if not self:UpdateInventory() then
		self:Debug('Aborting, incomplete inventory')
		-- Missing links in inventory
		return
	end

	-- Update all bags
	for name, bag in pairs(bags) do
		self:UpdateBag(bag)
	end

	if initializing then
		-- Do not go further if we're still initializing
		self:UnregisterBucket(bagUpdateBucket)
		bagUpdateBucket = self:RegisterBucketEvent('BAG_UPDATE', 0.1, "UpdateBags")
		initializing = false
		return
	end

	-- Update feedback
	local filterChanged = false
	for name, bag in pairs(bags) do
		if bag.button then
			if next(bag.newItems) then
				bag.button:Enable()
			else
				bag.button:Disable()
			end
		end
		if bag.updated and bag.available then
			self:Debug(name, 'contains new new items')
			bag.updated = nil
			filterChanged = true
		end
	end
	if filterChanged then
		self:Debug('Need to filter bags again')
		self:SendMessage('AdiBags_FiltersChanged')
	end

end

do
	local incomplete

	local function ScanInventorySlot(slot)
		local id = GetInventoryItemID("player", slot)
		if id then
			local link = GetInventoryItemLink("player", slot)
			inventory[slot] = link
			if not link then
				incomplete = true
			end
		else
			inventory[slot] = nil
		end
	end

	function mod:UpdateInventory()
		if not inventoryScanned then
			self:Debug('UpdateInventory')
			incomplete = false

			-- All equipped items and bags
			for slot = 0, 20 do
				ScanInventorySlot(slot)
			end
			-- Bank equipped bags
			for slot = 68, 74 do
				ScanInventorySlot(slot)
			end

			inventoryScanned = not incomplete
		end
		return inventoryScanned
	end
end

function mod:Reset(name)
	local bag = bags[name]
	self:Debug('Reset', name)
	wipe(bag.counts)
	wipe(bag.newItems)
	bag.first = true
	bag.updated = true
	self:UpdateBags(bag.bagIds)
end

function mod:IsNew(itemLink, bagName)
	if not itemLink or not bagName then return false end
	local bag = bags[bagName]
	return not bag.first and bag.newItems[GetDistinctItemID(itemLink)]
end

--------------------------------------------------------------------------------
-- Filtering
--------------------------------------------------------------------------------

do
	local currentContainerName

	function mod:AdiBags_PreFilter(event, container)
		currentContainerName = container.name
	end

	function mod:Filter(slotData)
		if self:IsNew(slotData.link, currentContainerName) then
			return L["New"]
		end
	end
end

--------------------------------------------------------------------------------
-- Item glows
--------------------------------------------------------------------------------

local function Glow_Update(glow)
	glow:SetScale(mod.db.profile.glowScale)
	glow.Texture:SetVertexColor(unpack(mod.db.profile.glowColor))
end

local function CreateGlow(button)
	local glow = CreateFrame("FRAME", nil, button)
	glow:SetFrameLevel(button:GetFrameLevel()+15)
	glow:SetPoint("CENTER")
	glow:SetWidth(addon.ITEM_SIZE)
	glow:SetHeight(addon.ITEM_SIZE)

	local tex = glow:CreateTexture("OVERLAY")
	tex:SetTexture([[Interface\Cooldown\starburst]])
	tex:SetBlendMode("ADD")
	tex:SetAllPoints(glow)
	glow.Texture = tex

	local group = glow:CreateAnimationGroup()
	group:SetLooping("REPEAT")

	local anim = group:CreateAnimation("Rotation")
	anim:SetOrder(1)
	anim:SetDuration(10)
	anim:SetDegrees(360)
	anim:SetOrigin("CENTER", 0, 0)

	group:Play()

	glow.Update = Glow_Update

	glows[button] = glow
	return glow
end

function mod:UpdateButton(event, button)
	local glow = glows[button]
	if mod.db.profile.showGlow and self:IsNew(button.itemLink, button.container.name) then
		if not glow then
			glow = CreateGlow(button)
		end
		glow:Update()
		glow:Show()
	elseif glow then
		glow:Hide()
	end
end
