-- TODO? GUI for sort orders.
-- TODO  translate zones.
-- TODO? merge real/regular and set game as static top order ?
-- TODO? don't recreate guild/friend entries, replace values in the table if char is present, remove disconnected, add connected.
-- TODO  make real friend with broadcast a double sized button unless the broadcast has a link (in this case, click broadcast to copy link).
--	 adjust sep as needed.

local	BUTTON_HEIGHT,	ICON_SIZE,	GAP,	TEXT_OFFSET,	MAX_ENTRIES =
	15,		13,		10,	5

local f = CreateFrame( "Frame", "AraBrokerGuildFriends", UIParent )
local t = CreateFrame"Frame"
local addonName, L = ...
local CC = select(4, GetBuildInfo()) == 4e4

local defaultConfig = {
	highlightOrder = true,
	highlightMode = "gradientAZ",
	showGuildTotal = true,
	showFriendsTotal = true,
	showGuildNotes = true,
	showFriendNotes = true,
	showGuildName = false,
	sortCols = { [true] = { "class", "name", "name" }, [false] = { "name", "name", "name" } },
	sortASC = { [true] = { true, true, true }, [false] = { true, true, true } },
	scale = 1,
	statusMode = "icon",
	realID = "before",
	showUngroupedClassIcon = true,
	alignName = "LEFT",
	alignZone = "CENTER",
	alignNote = "CENTER",
	alignRank = "RIGHT",
	colors = {
		background = { .1, .1, .1, .85 },
		border = { .3, .3, .3, .9 },
		note = { .14, .76, .15 },
		officerNote = { 1, .56, .25 },
		motd = { 1, .8, 0 },
		broadcast = { 1, .1, .1 },
		title = { 1, 1, 1 },
		rank = { .1, .9, 1 },
		realm = { 1, .8, 0 },
		status = { .7, .7, .7 },
		orderA = { 1, 1, 1, .1 },
		contestedZone = { 1, 1, 0 },
		friendlyZone = { 0, 1, 0 },
		enemyZone = { 1, 0, 0 },
	},
	hideHints = true,
	hWhisp = true,
	hInvite = true,
	hQuery = true,
	hNote = true,
	hONote = true,
	hOrderA = true,
	hOrderB = true,
	hOrderC = true,
	hResizeTip = true,
	hRemoveFriend = true,
	showBlockHints = true,
	hbOpenPanel = true,
	hbConfig = true,
	hbToggleNotes = true,
	hbAddFriend = true,
}
local dontShow, block, horde, config, isGuild, tip = true
local guildEntries, friendEntries, motd, slider, nbEntries = {}, {}
local sliderValue, hasSlider, UpdateTablet, extraHeight = 0
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
local info, buttons, toasts, playerRealm = {}
local totalFriends, onlineFriends, nbRealFriends, realFriendsHeight, nbBroadcast = 0, 0, 0
local WOW, SC2 = 1, 2
local configMenu, options, c, cname, SetOption, UpdateColor, ColorPickerChange, ColorPickerCancel, OpenColorPicker, colors
local preformatedStatusText, sortIndexes

local wipe, next, GetGuildRosterInfo, GetFriendInfo, IsInGuild, GuildRoster, ShowFriends, CLASS_BUTTONS, BNGetFriendToonInfo, BNGetFriendInfoByID, BNGetFriendInfo, BNGetNumFriends, GetDifficultyColor =
	wipe, next, GetGuildRosterInfo, GetFriendInfo, IsInGuild, GuildRoster, ShowFriends, CLASS_BUTTONS, BNGetFriendToonInfo, BNGetFriendInfoByID, BNGetFriendInfo, BNGetNumFriends, GetQuestDifficultyColor

local colpairs = { ["class"] = 1, ["name"] = 2, ["level"] = 3, ["zone"] = 4, ["note"] = 5, ["status"] = 6, ["rank"] = 7 }


local new, del

do
	local tables = setmetatable( {}, { __mode = "k" } )

	new = function(...)
		local t = next(tables)
		if t then tables[t] = nil else t = {} end
		for i=1, select("#",...) do t[i] = select(i,...) end
		return t
	end

	del = function(t)
		tables[wipe(t)] = true
	end

end


local function UpdateGuildBlockText()
	if IsInGuild() then
		local guildName = config.showGuildName and GetGuildInfo"player"
		f.GuildBlock.text = (config.showGuildTotal and "%s%d/%d" or "%s%d"):format(guildName and guildName .. ": " or "", #guildEntries, GetNumGuildMembers(true))
	else
		f.GuildBlock.text = "No Guild"
	end
end

local function UpdateFriendBlockText(updatePanel)
	local totalRF, onlineRF = BNGetNumFriends()
	f.FriendsBlock.text = (config.showFriendsTotal and "%d/%d" or "%d"):format( onlineFriends + onlineRF, totalFriends + totalRF )
	if updatePanel then f:BN_FRIEND_INFO_CHANGED() end
end


local friendOnline, friendOffline = ERR_FRIEND_ONLINE_SS:gsub("|Hplayer:%%s|h%[%%s%]|h",""), ERR_FRIEND_OFFLINE_S:gsub("%%s","")
function f:CHAT_MSG_SYSTEM( msg )
	if msg:find(friendOnline) or msg:find(friendOffline) then ShowFriends() end
end

function f:FRIENDLIST_UPDATE()
	for k,v in next,friendEntries do del(v) friendEntries[k]=nil end
	totalFriends, onlineFriends = GetNumFriends()
	for i = 1, onlineFriends do
		local name, level, class, zone, connected, status, note = GetFriendInfo(i)
		friendEntries[i] = new( L[class] or "", name or "", level or 0, zone or UNKNOWN, note or "|cffffcc00-", status or "", "", "", i )
	end
	UpdateFriendBlockText()
	if not isGuild and f:IsShown() then UpdateTablet() end
end


function f:GUILD_ROSTER_UPDATE()
	for k, v in next, guildEntries do del(v) guildEntries[k]=nil end
	local r,g,b = unpack(colors.officerNote)
	local officerColor = ("\124cff%.2x%.2x%.2x"):format( r*255, g*255, b*255 )
	for i=1, GetNumGuildMembers(true) do
		local name, rank, rankIndex, level, class, zone, note, offnote, connected, status = GetGuildRosterInfo(i)
		if connected then
			local notes = note ~= "" and (offnote == "" and note or ("%s |cffffcc00-|r %s%s"):format(note, officerColor, offnote)) or
				offnote == "" and "|cffffcc00-" or officerColor..offnote
			guildEntries[#guildEntries+1] = new( L[class] or "", name or "", level or 0, zone or UNKNOWN, notes, status or "", rankIndex or 0, rank or 0, i )
		end
	end
	UpdateGuildBlockText()
	if isGuild and f:IsShown() then UpdateTablet() end
end

function f:PLAYER_GUILD_UPDATE(unit)
	if unit and unit ~= "player" then return end
	if IsInGuild() then GuildRoster() end
end

-- cata horde zones: add "Azshara,Northern Barrens" - remove "The Barrens"
local hordeZones = "Orgrimmar,Undercity,Thunder Bluff,Silvermoon City,Durotar,Tirisfal Glades,Mulgore,Eversong Woods,The Barrens,Silverpine Forest,Ghostlands,"
local allianceZones = "Ironforge,Stormwind City,Darnassus,The Exodar,Azuremyst Isle,Bloodmyst Isle,Darkshore,Deeprun Tram,Dun Morogh,Elwynn Forest,Loch Modan,Teldrassil,Westfall,"

local function GetZoneColor(zone)
	return unpack( colors[
		hordeZones:find(zone..",") and (horde and "friendlyZone" or "enemyZone") or
		allianceZones:find(zone..",") and (horde and "enemyZone" or "friendlyZone") or
		"contestedZone"
	] )
end

local function UpdateBlockHints()
	if f.onBlock then
		if config.showBlockHints then
			tip:SetOwner(f, "ANCHOR_NONE")
			tip:ClearAllPoints()
			if f.isTop then
				tip:SetPoint( "TOP", f, "BOTTOM" )
			else
				tip:SetPoint( "BOTTOM", f, "TOP" )
			end
			tip:AddLine("Hints [|cffffffffBlock|r]")
			if config.hbOpenPanel then tip:AddLine("|cffff8020Click|r to open panel.", 0.2, 1, 0.2) end
			if config.hbConfig then tip:AddLine("|cffff8020RightClick|r to display config menu.", 0.2, 1, 0.2) end
			if not isGuild then
				if config.hbAddFriend then
					tip:AddLine("|cffff8020MiddleClick|r to add a friend.", 0.2, 1, 0.2)
					tip:AddLine("|cffff8020Modifier+Click|r to add a friend.", 0.2, 1, 0.2)
				end
			end
			if config.hbToggleNotes then tip:AddLine("|cffff8020Button4|r to toggle notes.", 0.2, 1, 0.2) end
			if tip:NumLines() > 1 then tip:Show() else tip:Hide() end
		else
			tip:Hide()
		end
	end
end

local function ShowHints(btn,config)
	if not config.hideHints and btn and btn.unit then
		local showBelow = UIParent:GetHeight()-f:GetTop()*config.scale < f:GetBottom()*config.scale
		tip:SetOwner(f, "ANCHOR_NONE")
		tip:SetPoint(showBelow and "TOP" or "BOTTOM", f, showBelow and "BOTTOM" or "TOP")
		tip:AddLine"Hints"
		if config.hWhisp then tip:AddLine("|cffff8020Click|r to whisper.", .2,1,.2) end
		if config.hInvite and (not btn.presenceID or btn.sameRealm) then tip:AddLine("|cffff8020Alt+Click|r to invite.", .2,1,.2) end
		if config.hQuery and not btn.presenceID then tip:AddLine("|cffff8020Shift+Click|r to query informations.", .2, 1, .2) end
		if config.hNote and (not isGuild or CanEditPublicNote()) then tip:AddLine("|cffff8020Ctrl+Click|r to edit note.", .2, 1, .2) end
		if isGuild then
			if config.hONote and CanEditOfficerNote() then tip:AddLine("|cffff8020Ctrl+RightClick|r to edit officer note.", .2, 1, .2) end
		else
			if config.hRemoveFriend then tip:AddLine("|cffff8020MiddleClick|r to remove friend.", .2, 1, .2) end
		end
		if not btn.presenceID then
			if config.hOrderA then tip:AddLine("|cffff8020RightClick|r to sort main column.", .2, 1, .2) end
			if config.hOrderB then tip:AddLine("|cffff8020Shift+RightClick|r to sort second column.", .2, 1, .2) end
			if config.hOrderC then tip:AddLine("|cffff8020Alt+RightClick|r to sort third column.", .2, 1, .2) end
		end
		if config.hResizeTip then tip:AddLine("|cffff8020Ctrl+MouseWheel|r to resize tooltip.", .2, 1, .2) end
		if tip:NumLines() > 1 then tip:Show() end
	end
end

local highlight = f:CreateTexture()
highlight:SetTexture"Interface\\QuestFrame\\UI-QuestTitleHighlight"
highlight:SetBlendMode"ADD"
highlight:SetAlpha(0)

local function Menu_OnEnter(b)
	if b and b.index then
		highlight:SetAllPoints(b)
		if b.index > 0 then
			highlight:SetAlpha(1)
			ShowHints(b,config)
		end
	end
end

local function Menu_OnLeave(b)
	highlight:ClearAllPoints()
	tip:Hide()
	if b and b.index and b.index > 0 then highlight:SetAlpha(0) end
	if not f:IsMouseOver() then f:Hide() end
end


local function MOTD_OnClose(edit)
	edit:ClearAllPoints()
	edit:SetParent(edit.prevParent)
	edit:SetPoint(unpack(edit.prevPoint))
end

local function EditMOTD()
	f:Hide()
	if not GuildTextEditFrame then LoadAddOn"Blizzard_GuildUI" end
	local edit = GuildTextEditFrame
	edit.prevPoint = { edit:GetPoint() }
	edit.prevParent = edit:GetParent()
	edit:ClearAllPoints()
	edit:SetParent(UIParent)
	edit:SetPoint("CENTER", 0, 180)
	GuildTextEditFrame_Show"motd"
	edit:HookScript("OnHide", MOTD_OnClose)
end

local function EditBroadcast()
	f:Hide()
	StaticPopup_Show"SET_BN_BROADCAST"
end


local function OnGuildmateClick( self, button )
	if not( self and self.unit ) then return end
	if (isGuild or not self.presenceID) and button == "RightButton" and not IsControlKeyDown() then
		local level = IsShiftKeyDown() and 2 or IsAltKeyDown() and 3 or 1
		local btn, ofx = buttons[1], GAP*.25
		local pos = GetCursorPosition() / self:GetEffectiveScale()
		for v, i in next, colpairs do
			local b = btn[v]
			if b:IsShown() and pos >= b:GetLeft() - ofx and pos <= b:GetRight() + ofx then
				local sortCols, sortASC = config.sortCols[isGuild], config.sortASC[isGuild]
				if sortCols[level] == v then
					sortASC[level] = not sortASC[level]
				else
					sortCols[level] = v
					sortASC[level] = v ~= "level"
				end
				sortIndexes[isGuild][level] = i
				return f:IsShown() and UpdateTablet()
			end
		end
	elseif button == "MiddleButton" and not isGuild then
		if self.presenceID then
			StaticPopup_Show("CONFIRM_REMOVE_FRIEND", self.realID, nil, self.presenceID)
		else
			RemoveFriend( self.unit )
		end
	elseif IsAltKeyDown() then
		if self.presenceID and not self.sameRealm then return end
		InviteUnit( self.unit )
	elseif IsControlKeyDown() then
		if not isGuild then
			FriendsFrame.NotesID = self.presenceID or self.realIndex
			if self.presenceID then
				StaticPopup_Show( "SET_BNFRIENDNOTE", self.realID )
			else
				StaticPopup_Show( "SET_FRIENDNOTE", self.unit )
			end
		elseif button == "LeftButton" and CanEditPublicNote() or button ~= "LeftButton" and CanEditOfficerNote() then
			SetGuildRosterSelection( self.realIndex )
			StaticPopup_Show( button == "LeftButton" and "SET_GUILDPLAYERNOTE" or "SET_GUILDOFFICERNOTE" )
		end
	else
		local name = self.presenceID and self.realID or self.unit
		SetItemRef( "player:"..name, ("|Hplayer:%1$s|h[%1$s]|h"):format(name), "LeftButton" )
	end
end

local function Scroll(self, delta)
	if IsControlKeyDown() then
		config.scale = config.scale - delta * 0.05
		UpdateTablet()
--	elseif IsShiftKeyDown() then
--		GAP = GAP - delta
--		UpdateTablet()
	else
		slider:SetValue( sliderValue - delta * (IsModifierKeyDown() and 10 or 3) )
	end
end


local function CreateFS( parent, justify, anchor, offsetX, color )
	local fs = parent:CreateFontString( nil, "OVERLAY", "SystemFont_Shadow_Med1" )
	if justify then fs:SetJustifyH( justify ) end
	if anchor then fs:SetPoint( "LEFT", anchor, "RIGHT", offsetX or GAP, 0 ) end
	if color then fs:SetTextColor(unpack(color)) end
	return fs
end

local function CreateTex( parent, anchor, offsetX )
	local tex = parent:CreateTexture()
	tex:SetWidth( ICON_SIZE )
	tex:SetHeight( ICON_SIZE )
	tex:SetPoint( "LEFT", anchor or parent, anchor and "RIGHT" or "LEFT", offsetX or 0, 0 )
	return tex
end


local sep2, sep = f:CreateTexture()
sep2:SetTexture"Interface\\FriendsFrame\\UI-FriendsFrame-OnlineDivider"

--local function FriendBroadcast_OnClick()
	-- TODO: detect URL and copy to input box
--end

local broadcasts = setmetatable( {}, { __index = function( table, index )
	local bc = CreateFrame( "Button", nil, f )
	table[index] = bc
	bc:SetHeight(BUTTON_HEIGHT)
	bc:SetNormalFontObject(GameFontNormal)
--	bc:RegisterForClicks"LeftButtonUp"
--	bc:SetScript("OnClick", FriendBroadcast_OnClick)
	bc:EnableMouseWheel(true)
	bc:SetScript( "OnMouseWheel", Scroll )
	bc.icon = CreateTex( bc, nil, ICON_SIZE + TEXT_OFFSET )
	bc.icon:SetTexture"Interface\\FriendsFrame\\BroadcastIcon"
	bc.icon:SetTexCoord(.1,.9,.1,.9)
	bc.text = CreateFS( bc, "LEFT", bc.icon, TEXT_OFFSET, colors.broadcast )
	bc.text:SetHeight(BUTTON_HEIGHT)
	return bc
end } )

toasts = setmetatable( {}, { __index = function( table, key )
	local button = CreateFrame( "Button", nil, f )
	table[key] = button
	button.index = key
	button:SetNormalFontObject(GameFontNormal)
	button:RegisterForClicks"AnyUp"
	button:SetScript( "OnEnter", Menu_OnEnter )
	button:SetScript( "OnLeave", Menu_OnLeave )

	button:EnableMouseWheel(true)
	button:SetScript( "OnMouseWheel", Scroll )
	button:SetScript( "OnClick", OnGuildmateClick )

	button:SetHeight( BUTTON_HEIGHT )

	button.class = CreateTex( button )
	button.status = CreateTex( button, button.class, TEXT_OFFSET )
	button.status:SetTexCoord(.1, .9, .1, .9)
	button.name  = CreateFS( button, config.alignName, button.status, TEXT_OFFSET )
	button.level = CreateFS( button, "CENTER", button.name, GAP )
	button.faction = CreateTex( button, button.level, GAP )
	button.zone  = CreateFS( button, config.alignZone, button.faction, TEXT_OFFSET )
	button.note = CreateFS( button, config.alignNote, button.zone, GAP, colors.note )
	return button
end } )

buttons = setmetatable( { }, { __index = function( table, key )
	local button = CreateFrame( "Button", nil, f )
	table[key] = button
	button.index = key
	button:SetNormalFontObject(GameFontNormal)
	button:RegisterForClicks"AnyUp"
	button:SetScript( "OnEnter", Menu_OnEnter )
	button:SetScript( "OnLeave", Menu_OnLeave )

	button:EnableMouseWheel(true)
	button:SetScript( "OnMouseWheel", Scroll)

	if key == 0 then
		motd = button
		motd.name = CreateFS( motd, "LEFT" )
		motd:Show()
		motd.name:SetJustifyV"TOP"
		motd.name:SetPoint( "TOPLEFT", motd, "TOPLEFT" )
		motd:SetPoint( "TOPLEFT", f, "TOPLEFT", GAP, -GAP )

		sep = motd:CreateTexture()
		sep:SetTexture"Interface\\FriendsFrame\\UI-FriendsFrame-OnlineDivider"
		sep:SetPoint("TOPLEFT", motd, "BOTTOMLEFT", 0, BUTTON_HEIGHT)
		sep:SetPoint("BOTTOMRIGHT", motd, "BOTTOMRIGHT", 0, 0)
	else
		button:SetHeight( BUTTON_HEIGHT )
		button.class = button:CreateTexture()
		button.class:SetWidth( ICON_SIZE ) button.class:SetHeight( ICON_SIZE )
		button.class:SetPoint( "LEFT", button, "LEFT" )

		button.status = CreateTex( button, button.class, TEXT_OFFSET )
		button.status:SetTexCoord(.1, .9, .1, .9)

		button.name = CreateFS( button, config.alignName )
		button.name:SetPoint( "LEFT", button.class, "RIGHT", TEXT_OFFSET, 0 )
		button.level = CreateFS( button, "CENTER", button.name )
		button.zone  = CreateFS( button, config.alignZone, button.level )
		button.note = CreateFS( button, config.alignNote, button.zone, GAP, colors.note )
		button.rank  = CreateFS( button, config.alignRank,  button.note, GAP, colors.rank )
	end
	return button
end } )


local function SetClassOrCheckIcon( tex, inGroup, name, class )
	local isGrouped = inGroup and inGroup(name)
	if inGroup and (isGrouped or not config.showUngroupedClassIcon) then
		tex:SetTexture( isGrouped and "Interface\\Buttons\\UI-CheckBox-Check" or "" )
		tex:SetTexCoord( .15, .85, .15, .85 )
	else
		tex:SetTexture"Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"
		local offset, left, right, bottom, top = 0.025, unpack( CLASS_BUTTONS[class] )
		tex:SetTexCoord( left+offset, right-offset, bottom+offset, top-offset )
	end
end

local function SetStatusLayout( isAFK, isDND, statusTex, fs )
	if config.statusMode == "icon" then
		statusTex:SetTexture("Interface\\FriendsFrame\\StatusIcon-"..(isAFK and "Away" or isDND and "DnD" or "Online"))
		statusTex:Show()
		fs:SetPoint("LEFT", statusTex, "RIGHT", TEXT_OFFSET, 0)
	else
		statusTex:Hide()
		fs:SetPoint("LEFT", statusTex, "LEFT")
	end
end

local function SetButtonData( index, inGroup )
	local button = buttons[index]

	if index == 0 then
		button.name:SetText(inGroup)
		return button, button.name:GetStringWidth()
	end

	local class, name, level, zone, notes, status, _, rank, realIndex = unpack( (isGuild and guildEntries or friendEntries)[index] )
	button.unit = name
	button.realIndex = realIndex
	button.name:SetFormattedText( (status and preformatedStatusText or "")..(name or""), status )
	if name then
		local color = RAID_CLASS_COLORS[class]
		button.name:SetTextColor( color.r, color.g, color.b )
		SetClassOrCheckIcon( button.class, inGroup, name, class )
		SetStatusLayout( status == CHAT_FLAG_AFK, status == CHAT_FLAG_DND, button.status, button.name )
		color = GetDifficultyColor(level)
		button.level:SetTextColor( color.r, color.g, color.b )
		button.zone:SetTextColor( GetZoneColor(zone) )
	end

	button.level:SetText( level or "" )
	button.zone:SetText( zone or "" )
	button.note:SetText( notes or "" )
	button.rank:SetText( rank or "" )

	return	button,
		button.name:GetStringWidth(),
		button.level:GetStringWidth(),
		button.zone:GetStringWidth(),
		button.note:GetStringWidth(),
		rank and button.rank:GetStringWidth() or -GAP
end


local function SetToastData( index, inGroup )
	local toast, bc, color = toasts[index]
	local presenceID, givenName, surname, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, broadcast, notes = BNGetFriendInfo(index)
	local _, _, game, realm, faction, race, class, guild, zone, level, gameText = BNGetToonInfo(toonID or 0)
	local statusText = config.statusMode ~= "icon" and (isAFK or isDND) and (preformatedStatusText):format(isAFK and CHAT_FLAG_AFK or isDND and CHAT_FLAG_DND) or ""

	if broadcast and broadcast ~= "" then
		nbBroadcast = nbBroadcast + 1
		bc = broadcasts[nbBroadcast]
		bc.text:SetText(broadcast)
		toast.bcIndex = nbBroadcast
	else	toast.bcIndex = nil end

	toast.presenceID = presenceID
	toast.unit = toonName
	toast.realID = (BATTLENET_NAME_FORMAT):format(givenName, surname)

	SetStatusLayout( isAFK, isDND, toast.status, toast.name )

	client = client == BNET_CLIENT_WOW and WOW or BNET_CLIENT_SC2 and SC2 or 0
	toast.client = client

	if client == WOW then
		toast.faction:SetTexture"Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Factions"
		toast.faction:SetTexCoord( faction == 1 and 0.03 or 0.53, faction == 1 and 0.47 or 0.97, 0.03, 0.97 )
		zone = (not zone or zone == "") and UNKNOWN or zone
		toast.zone:SetPoint("TOPLEFT", toast.faction, "TOPRIGHT", TEXT_OFFSET, 0)
		toast.zone:SetTextColor( GetZoneColor(zone) )
		toast.sameRealm = realm == playerRealm

		if not toast.sameRealm then
			-- hide faction icon and move zone to level
			local r,g,b = unpack(colors.realm)
			zone = ("%1$s |cff%3$.2x%4$.2x%5$.2x- %2$s"):format(zone, realm, r*255, g*255, b*255)
		end
		class = L[class]
		if class then
			SetClassOrCheckIcon( toast.class, inGroup, toonName, class )
			color = RAID_CLASS_COLORS[class]
			toast.name:SetTextColor( color.r, color.g, color.b )
		else
			toast.class:SetTexture""
		end
	elseif client == SC2 then
		toast.class:SetTexture"Interface\\FriendsFrame\\Battlenet-Sc2icon"
		toast.class:SetTexCoord( .2, .8, .2, .8 )
		toast.name:SetTextColor( .8, .8, .8 )
		toast.faction:SetTexture""
		zone = gameText
		toast.zone:SetPoint("TOPLEFT", toast.name, "TOPRIGHT", GAP, 0)
		toast.zone:SetTextColor( 1, .77, 0 )
	end

	if config.realID == "none" then
		toast.name:SetText(toonName or "")
	else
		local rid = "|cff00b2f0"..toast.realID.."|r"
		if config.realID == "instead" then
			toast.name:SetText( statusText.. rid)
		else
			toast.name:SetFormattedText( statusText..(config.realID=="before" and "%1$s - %2$s" or "%2$s - %1$s"), rid, toonName or "")
		end
	end

	if level and level ~= "" then
		toast.level:SetText(level)
		color = GetDifficultyColor(tonumber(level))
		toast.level:SetTextColor( color.r, color.g, color.b )
	else	toast.level:SetText"" end

--	toast.raceIcon:SetTexture"Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races"
--	toast.raceIcon:SetTexCoord(  )
	toast.zone:SetText(zone or "")
	toast.note:SetText(notes or "")

	return	toast, client,
		toast.name:GetStringWidth(),
		client == SC2 and -GAP or toast.level:GetStringWidth(),
		toast.zone:GetStringWidth(),
		toast.note:GetStringWidth()
end

local function UpdateScrollButtons(nbEntries)
	for i=1, #buttons do buttons[i]:Hide() end
	local baseOffset = -realFriendsHeight
	local sliderValue = hasSlider and sliderValue or 0
	for i=1, nbEntries do
		local button = buttons[sliderValue+i]
		button:SetPoint("TOPLEFT", motd, "BOTTOMLEFT", 0, baseOffset - (i-1)*BUTTON_HEIGHT)
		button:Show()
	end
end


local function AnchorTablet(frame)
	CloseDropDownMenus()
	f:Show()
	local _, y = frame:GetCenter()
	f.isTop, f.onBlock = y > UIParent:GetHeight() / 2, true
	f:ClearAllPoints()
	if f.isTop then
		f:SetPoint( "TOP", frame, "BOTTOM" )
	else
		f:SetPoint( "BOTTOM", frame, "TOP" )
	end
	if Skinner then
		Skinner:applySkin(f)
	else
		f:SetBackdropColor( unpack( colors.background ) )
		f:SetBackdropBorderColor( unpack( colors.border ) )
	end
	UpdateBlockHints()
	UpdateTablet()
end

local texOrder1 = f:CreateTexture()
texOrder1:SetTexture"Interface\\Buttons\\WHITE8X8"
texOrder1:SetBlendMode"ADD"


local function SortMates(a,b)
	local s = sortIndexes[isGuild]
	local si, lv = s[1], 1
	if a[si] == b[si] then
		si, lv = s[2], 2
		if a[si] ==  b[si] then
			si, lv = s[3], 3
		end
	end
	if config.sortASC[isGuild][lv] then
		return a[si] < b[si]
	else
		return a[si] > b[si]
	end
end


UpdateTablet = function()
	f:SetScale(config.scale)

	local totalRF, onlineRF, entries = 0, 0

	if isGuild then
		entries = guildEntries
		nbRealFriends = 0
	else
		entries = friendEntries
		totalRF, onlineRF = BNGetNumFriends()
		nbRealFriends = onlineRF
	end

	local nbTotalEntries = #entries + nbRealFriends
	local rid_width, button = 0

	realFriendsHeight = 0

	local nameC, levelC, zoneC, notesC, rankC = 0, 0, 0, 0, -GAP
	local nameW, levelW, zoneW, notesW, rankW
	local hideNotes = isGuild and not config.showGuildNotes or not (isGuild or config.showFriendNotes)

	local inGroup = GetNumRaidMembers()>0 and UnitInRaid or GetNumPartyMembers()>0 and UnitInParty or nil
	local tnC, lC, zC, nC = 0, -GAP, -GAP, 0
	local spanZoneC = 0

	if nbRealFriends > 0 then
		nbBroadcast = 0
		for i=1, nbRealFriends do
			local button, client, tnW, lW, zW, nW, spanZoneW = SetToastData(i,inGroup)

			if tnW>tnC then tnC=tnW end

			if client == WOW then
				if lW>lC then lC=lW end
				if zW>zC then zC=zW end
			elseif client == SC2 then
				if zW > spanZoneC then spanZoneC = zW end
			end

			if nW>nC then nC=nW end
		end

		realFriendsHeight = (nbRealFriends+nbBroadcast) * BUTTON_HEIGHT + (#entries>0 and GAP or 0)
		if hideNotes then nC = -GAP end

		spanZoneC = max( spanZoneC, lC + GAP + ICON_SIZE + TEXT_OFFSET + zC )
		rid_width = ICON_SIZE + TEXT_OFFSET + tnC + spanZoneC + nC + 2*GAP

		if #entries>0 then
			local t = toasts[nbRealFriends]
			local offsetY = t.bcIndex and BUTTON_HEIGHT or 0
			sep2:SetPoint("TOPLEFT", t, "BOTTOMLEFT", 0, 2-offsetY)
			sep2:SetPoint("BOTTOMRIGHT", t, "BOTTOMRIGHT", 0, 2-offsetY-BUTTON_HEIGHT)
			sep2:Show()
		end
	end
	if isGuild or #entries==0 then sep2:Hide() end

	sort(entries,SortMates)
	for i = 1, #entries do
		button, nameW, levelW, zoneW, notesW, rankW = SetButtonData( i, inGroup )
		button:SetScript( "OnClick", OnGuildmateClick )
		if nameW > nameC then nameC = nameW end
		if levelW and levelW>0 then
			if levelW > levelC then levelC = levelW end
			if  zoneW >  zoneC then  zoneC = zoneW  end
			if notesW > notesC then notesC = notesW end
			if  rankW >  rankC then  rankC = rankW  end
			if hideNotes then button.note:Hide() else button.note:Show() end
			button.rank:SetPoint( "TOPLEFT", hideNotes and button.zone or button.note, "TOPRIGHT", GAP, 0 )
		end
	end

	if hideNotes then notesC = -GAP end
	local maxWidth = max( rid_width, ICON_SIZE + TEXT_OFFSET + nameC + levelC + zoneC + notesC + rankC + GAP * 4 )
	if config.statusMode=="icon" then maxWidth = maxWidth + ICON_SIZE + TEXT_OFFSET end

	-- motd / broadcast
	local canEditMOTD = CanEditMOTD()
	motd:SetScript("OnClick",nil)
	local guildMOTD = isGuild and GetGuildRosterMOTD()
	if isGuild and (nbTotalEntries>0 and guildMOTD or nbTotalEntries==0) or not isGuild and (BNFeaturesEnabled() and totalRF>0 or nbTotalEntries==0) then
		motd.name:SetJustifyH"LEFT"
		motd.name:SetTextColor( unpack(colors.title) )
		local r, g, b = unpack(colors.motd)
		local motdText = ("%%s:  |cff%.2x%.2x%.2x%%s"):format(r*255, g*255, b*255)
		if isGuild then
			SetButtonData( 0, nbTotalEntries>0 and motdText:format("MOTD", guildMOTD) or "     |cffff2020"..ERR_GUILD_PLAYER_NOT_IN_GUILD )
			if nbTotalEntries>0 and canEditMOTD then motd:SetScript( "OnClick", EditMOTD ) end
		else
			if nbTotalEntries == 0 then
				SetButtonData( 0, "     |cffff2020".."No friends online." )
			elseif not BNConnected() then
				motd.name:SetJustifyH"CENTER"
				SetButtonData( 0, "|cffff2020"..BATTLENET_UNAVAILABLE )
			else
				SetButtonData( 0, motdText:format("Broadcast", select(3, BNGetInfo()) or "") )
				motd:SetScript("OnClick", EditBroadcast)
			end
		end
		if nbTotalEntries==0 then
			extraHeight = 0
			sep:Hide()
			maxWidth = min( motd.name:GetStringWidth()+GAP*2, 300 )
		else
			extraHeight = BUTTON_HEIGHT
			sep:Show()
		end
		motd.name:SetWidth( maxWidth )
		extraHeight = extraHeight + motd.name:GetHeight()

		motd:SetWidth( maxWidth )
		motd:SetHeight( extraHeight )

		buttons[1]:SetPoint( "TOPLEFT", motd, "BOTTOMLEFT", 0, -realFriendsHeight )
	else
		extraHeight = 0
		motd.name:SetText""
		motd:SetHeight(1) motd:SetWidth(maxWidth)
		buttons[1]:SetPoint( "TOPLEFT", f, "TOPLEFT", GAP, -GAP )
	end

	for i=1, #toasts do toasts[i]:Hide() end
	for i=1, #broadcasts do broadcasts[i]:Hide() end
	if not isGuild and nbRealFriends>0 then
		local header, bcOffset = motd, 0
		local bcWidth = maxWidth - 2*(ICON_SIZE - TEXT_OFFSET) -2*GAP
		for i=1, nbRealFriends do
			local b = toasts[i]
			b:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, (1-i-bcOffset)*BUTTON_HEIGHT)
			if b.bcIndex then
				bcOffset = bcOffset + 1
				local bc = broadcasts[b.bcIndex]
				bc.text:SetWidth(bcWidth)
				bc:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, (1-i-bcOffset)*BUTTON_HEIGHT)
				bc:SetPoint("BOTTOMRIGHT", header, "BOTTOMRIGHT", -ICON_SIZE-TEXT_OFFSET, (-i-bcOffset)*BUTTON_HEIGHT)
				bc:Show()
			end
			b:Show()
		end
	end

	MAX_ENTRIES = floor( (UIParent:GetHeight()/config.scale - extraHeight - GAP*2) / BUTTON_HEIGHT - (config.hideHints and 2 or ((not isGuild or canEditMOTD) and 11 or 9)) / config.scale )
	slider:SetHeight(BUTTON_HEIGHT*MAX_ENTRIES)
	hasSlider = #entries > MAX_ENTRIES
	if hasSlider then
		slider:SetMinMaxValues( 0, #entries - MAX_ENTRIES )
		slider:SetValue(sliderValue)
		slider:Show()
	else	slider:Hide() end
	nbEntries = math.min( MAX_ENTRIES, #entries )

	UpdateScrollButtons(nbEntries)

	for i=1, nbRealFriends do
		button = toasts[i]
		button:SetWidth( maxWidth )
		button.name:SetWidth(tnC)
		if button.client == SC2 then
			button.zone:SetWidth(spanZoneC)
		elseif button.client == WOW then
			button.level:SetWidth(lC)
			button.zone:SetWidth(zC)
		end
		button.note:SetWidth(nC)
	end

	for i=1, #entries do
		button = buttons[i]
		button:SetWidth( maxWidth )
		button.name:SetWidth(nameC)
		button.level:SetWidth(levelC)
		button.zone:SetWidth(zoneC)
		button.note:SetWidth(notesC)
		button.rank:SetWidth(rankC)
	end

	if nbEntries>0 and config.highlightOrder then
		local col = config.sortCols[isGuild][1]
		local obj = buttons[1][col]
		if obj:IsShown() then
			texOrder1:SetPoint("TOPLEFT", obj, "TOPLEFT", -.25*GAP, 2 )
			texOrder1:SetWidth(obj:GetWidth()+GAP*.5) texOrder1:SetHeight(nbEntries*BUTTON_HEIGHT+1)
			local asc = config.sortASC[isGuild][1]
			if col == "level" then asc = not asc end
			if config.highlightMode == "simple" then
				local r,g,b,a = unpack(colors.orderA)
				texOrder1:SetGradientAlpha("VERTICAL", r,g,b,a, r,g,b,a)
			else
				if config.highlightMode == "gradientZA" then asc = not asc end
				local a1, r1, g1, b1 = colors.orderA[4], unpack(colors.orderA)
				local a2, r2, g2, b2 = 0, unpack(colors.background)
				if asc then r1,g1,b1,a1, r2,g2,b2,a2 = r2,g2,b2,a2, r1,g1,b1,a1 end
				texOrder1:SetGradientAlpha("VERTICAL", r1,g1,b1,a1, r2,g2,b2,a2)
			end
		else
			texOrder1:SetAlpha(0)
		end
	else
		texOrder1:SetAlpha(0)
	end

	if hasSlider then slider:SetPoint("TOPRIGHT", buttons[1], "TOPRIGHT", 19 + TEXT_OFFSET, 0) end

	f:SetWidth( maxWidth + GAP*2 + (hasSlider and 16 + TEXT_OFFSET*2 or 0) )
	f:SetHeight( extraHeight + realFriendsHeight + BUTTON_HEIGHT * nbEntries + GAP*2 )
	if not (f.onBlock or f:IsMouseOver()) then f:Hide() end
end

local function Block_OnLeave(self)
	f.onBlock = nil
	tip:Hide()
	if not f:IsMouseOver() then
		f:Hide()
	end
end

local function PreFormatStatusText(color)
	if config.statusMode == "classColored" then
		preformatedStatusText = "%s "
	elseif config.statusMode == "customColored" then
		local r,g,b = unpack(color)
		preformatedStatusText = ("|cff%.2x%.2x%.2x%%s|r "):format(r*255,g*255,b*255)
	elseif config.statusMode == "icon" then
		preformatedStatusText = ""
	end
end


local function UpdateAlignments(var, val)
	local fs = var:sub(6):lower()
	for _, b in ipairs(buttons) do
		b[fs]:SetJustifyH(val)
	end
end


function f:SetupConfigMenu()
	configMenu = CreateFrame("Frame", "AraGuildFriendsConfigMenu")
	configMenu.displayMode = "MENU"

	f.SetCustomScale = function(self,dialog)
		local val = tonumber( dialog.editBox:GetText():match"(%d+)" )
		if not val or val<70 or val>200 then
			baseScript = BasicScriptErrors:GetScript"OnHide"
			BasicScriptErrors:SetScript("OnHide",Error_OnHide)
			BasicScriptErrorsText:SetText"Invalid scale.\nShould be a number between 70 and 200%"
			return BasicScriptErrors:Show()
		end
		config.scale = val/100
	end

	StaticPopupDialogs.SET_ABGF_SCALE = {
		text = "Set a custom tooltip scale.\nEnter a value between 70 and 200 (%%).",
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		maxLetters = 4,
		OnAccept = function(self) AraBrokerGuildFriends:SetCustomScale(self) end,
		OnShow = function(self) CloseDropDownMenus() self.editBox:SetText(config.scale*100) self.editBox:SetFocus() end,
		OnHide = function(self) ChatEdit_FocusActiveWindow() end,
		EditBoxOnEnterPressed = function(self) local p=self:GetParent() AraBrokerGuildFriends:SetCustomScale(p) p:Hide() end,
		EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	}

	options = {
		{ text = ("|cffffb366Ara|r Guild & Friends (%s)"):format( GetAddOnMetadata( addonName, "Version" ) ), isTitle = true },
		{ text = "Show guild notes", check = "showGuildNotes" },
		{ text = "Show friend notes", check = "showFriendNotes" },
		{ text = "Show guild name", check = "showGuildName" },
		{ text = "Show total number of guildmates", check = "showGuildTotal" },
		{ text = "Show total number of friends", check = "showFriendsTotal" },
		{ text = "Show class icon when grouped", check = "showUngroupedClassIcon" },
		{ text = "Highlight sorted column", check = "highlightOrder", submenu = {
			{ text = "Simple", radio = "highlightMode", val = "simple" },
			{ text = "Gradient", radio = "highlightMode", val = "gradientAZ" },
			{ text = "Reverse gradient", radio = "highlightMode", val = "gradientZA" },
			} },
		{ text = "Status as...", submenu = {
			{ text = "Class colored text", radio = "statusMode", val = "classColored" },
			{ text = "Custom colored text", radio = "statusMode", val = "customColored" },
			{ text = "Icon", radio = "statusMode", val = "icon" },
		} },
		{ text = "Real ID...", submenu = {
			{ text = "Before nickname", radio = "realID", val = "before" },
			{ text = "Instead of nickname", radio = "realID", val = "instead" },
			{ text = "After nickname", radio = "realID", val = "after" },
			{ text = "Don't show", radio = "realID", val = "none" }
			} },
		{ text = "Column alignments", submenu = {
			{ text = "Name", submenu = "alignName" },
			{ text = "Zone", submenu = "alignZone" },
			{ text = "Notes",submenu = "alignNote" },
			{ text = "Rank", submenu = "alignRank" },
		} },
		{ text = "Colors", submenu = {
			{ text = "Background", color = "background" },
			{ text = "Borders", color = "border" },
			{ text = "Order highlight", color = "orderA" },
			{ text = "Headers", color = "title" },
			{ text = "MotD / broadcast", color = "motd" },
			{ text = "Friendly zone", color = "friendlyZone" },
			{ text = "Contested zone", color = "contestedZone" },
			{ text = "Enemy zone", color = "enemyZone" },
			{ text = "Notes", color = "note" },
			{ text = "Officer notes", color = "officerNote" },
			{ text = "Status", color = "status" },
			{ text = "Ranks", color = "rank" },
			{ text = "Friends broadcast", color = "broadcast" },
			{ text = "Realms", color = "realm" },
			{ text = "|cffaaaaffRestore default colors", func=
				function()
					for k, v in next, defaultConfig.colors do
						local color = colors[k]
						color[1], color[2], color[3], color[4] = unpack(v)
					end
				end }
		} },
		{ text = "Tooltip Size", submenu = {
			{ text =  "90%", radio = "scale", val = 0.9 },
			{ text = "100%", radio = "scale", val = 1.0 },
			{ text = "110%", radio = "scale", val = 1.1 },
			{ text = "120%", radio = "scale", val = 1.2 },
			{ text = "Custom...", radio="scaleX", func=function() StaticPopup_Show"SET_ABGF_SCALE" end }, } },
		{ text = "Show Block Hints", check = "showBlockHints", submenu = {
			{ text = "Open panel", check = "hbOpenPanel" },
			{ text = "Config menu", check = "hbConfig" },
			{ text = "Toggle notes", check = "hbToggleNotes" },
			{ text = "Add a friend", check = "hbAddFriend" },
		} },
		{ text = "Show Hints", check = "hideHints", inv=true, submenu = {
			{ text = "Whisper", check = "hWhisp" },
			{ text = "Invite", check = "hInvite" },
			{ text = "Query", check = "hQuery" },
			{ text = "Edit note", check = "hNote" },
			{ text = "Edit officer note", check = "hONote" },
			{ text = "Sort main column", check = "hOrderA" },
			{ text = "Sort second column", check = "hOrderB" },
			{ text = "Sort third column", check = "hOrderC" },
			{ text = "Resize tooltip", check = "hResizeTip" },
			{ text = "Remove friend", check = "hRemoveFriend" },
		} }
	}
	local aligns = { "LEFT", "CENTER", "RIGHT" }

	configMenu.initialize = function(self, level)
		if not level then return end
		local opt = level > 1 and UIDROPDOWNMENU_MENU_VALUE or options
		if type(opt)=="string" and opt:find("^align") then
			for _, pos in ipairs(aligns) do
				info = wipe(info)
				info.text = pos
				info.checked = config[opt] == pos
				info.func, info.arg1, info.arg2 = SetOption, opt, pos
				info.keepShownOnClick = true
				UIDropDownMenu_AddButton( info, level )
			end
			return
		end
		for i, v in ipairs( opt ) do
			info = wipe(info)
			info.text = v.text
			info.isTitle = v.isTitle
			local adjust
			if v.radio then
				if v.radio == "scaleX" then
					info.checked = config.scale ~= .9 and config.scale ~= 1 and config.scale ~= 1.1 and config.scale ~= 1.2
					info.func = v.func
					if info.checked then
						info.text = ("%s (%i%%)"):format(info.text, config.scale*100)
					end
				else
					info.checked = config[v.radio] == v.val
					info.func, info.arg1, info.arg2 = SetOption, v.radio, v.val
					info.keepShownOnClick = true
				end
			elseif v.check then
				info.checked = v.inv and not config[v.check] or not v.inv and config[v.check]
				info.func, info.arg1 = SetOption, v.check
				info.isNotRadio = true
				info.keepShownOnClick = true
			elseif v.color then
				info.hasColorSwatch, info.notCheckable = true, true
				info.r, info.g, info.b = unpack(colors[v.color])
				info.func, info.arg1 = OpenColorPicker, v.color
				info.padding = 10
			else
				info.func = v.func
				info.notCheckable = true
				if level == 1 then info.text, adjust = ("|Tx:%i|t%s"):format(25/self.scale, info.text), v.submenu end
			end
			info.hasArrow, info.value = v.submenu, v.submenu
			UIDropDownMenu_AddButton( info, level )
			if adjust then
				local frame = _G[("DropDownList1Button%i"):format(DropDownList1.numButtons)]
			--	frame:SetPoint("TOPLEFT", 11, select(5,frame:GetPoint()))
				local framePoint, relativeFrame, framePoint, offsetX, offsetY =  frame:GetPoint()
				frame:SetPoint(framePoint, relativeFrame, framePoint, offsetX - 4, offsetY)
			end
		end
	end

	local hasNoColorProcessing = { ["background"]=1, ["orderA"]=1, ["order"]=1, ["officerNote"]=1, ["motd"]=1, ["friendlyZone"]=1, ["contestedZone"]=1, ["enemyZone"]=1 }

	UpdateColor = function(cname)
		if hasNoColorProcessing[cname] then return end
		if cname == "status" then return PreFormatStatusText(c) end
		local r,g,b = unpack(c)
		if cname == "broadcast" or cname == "note" or cname == "realm" then
			for i, toast in next, toasts do
				toast[cname]:SetTextColor(r,g,b)
			end
		end
		if cname == "rank" or cname == "note" then
			for i, btn in next, buttons do
				if i>1 then btn[cname]:SetTextColor(r,g,b) end
			end
		end
	end
	ColorPickerOpacity = function()
		c[4] = 1 - OpacitySliderFrame:GetValue()
	end
	ColorPickerChange = function()
		c[1], c[2], c[3] = ColorPickerFrame:GetColorRGB()
		UpdateColor(cname)
	end
	ColorPickerCancel = function(prev)
		c[1], c[2], c[3], c[4] = unpack(prev)
		UpdateColor(cname)
	end
	OpenColorPicker = function(self, colorName)
		ColorPickerFrame:Hide()
		cname = colorName
		c = colors[colorName]
		ColorPickerFrame.hasOpacity = c[4] and true
		if c[4] then ColorPickerFrame.opacity = 1 - c[4] end
		ColorPickerFrame.opacityFunc = c[4] and ColorPickerOpacity or nil
		ColorPickerFrame.func = ColorPickerChange
		ColorPickerFrame.cancelFunc = ColorPickerCancel
		ColorPickerFrame.previousValues = {unpack(c)}
		ColorPickerFrame:SetColorRGB( c[1], c[2], c[3] )
		ColorPickerFrame:Show()
	end

	SetOption = function(bt, var, val)
		config[var] = val or not config[var]
		if var == "showGuildName" or var == "showGuildTotal" then
			UpdateGuildBlockText()
		elseif var == "showFriendsTotal" then
			UpdateFriendBlockText()
		elseif var == "statusMode" then
			PreFormatStatusText(colors.status)
		elseif var:find"^align" then
			UpdateAlignments(var, val)
		end
		if not val then return end

		local sub = bt:GetName():sub(1, 19).."%i"
		for i = 1, bt:GetParent().numButtons do
			local subi = sub:format(i)
			if _G[subi] == bt then
				_G[subi.."Check"]:Show()
			else
				_G[subi.."Check"]:Hide()
				_G[subi.."UnCheck"]:Show()
			end
		end
	end

	f.SetupConfigMenu = nil
end

local function DisplayConfigMenu( anchor )
	if not configMenu then f:SetupConfigMenu() end
	f:Hide() tip:Hide()
	configMenu.scale = UIParent:GetScale()
	ToggleDropDownMenu(1, nil, configMenu, anchor, 0, 0)
end


local ldb = LibStub("LibDataBroker-1.1")

f.GuildBlock = ldb:NewDataObject( "|cFFFFB366Ara|r Guild", {
	type = "data source",
	text = GUILD,
	icon = [[Interface\AddOns\Ara_Broker_Guild_Friends\guild]],
	OnEnter = function(self)
		isGuild = true
		if IsInGuild() then GuildRoster() end
		AnchorTablet(self)
	end,
	OnLeave = Block_OnLeave,
	OnClick = function(self, button)
		if button == "LeftButton" then
			ToggleGuildFrame()
			if GuildFrame:IsShown() then
				GuildFrameTab2:Click()
				f.GuildBlock.OnLeave(self)
			else	f.GuildBlock.OnEnter(self) end
		elseif button == "RightButton" then
			DisplayConfigMenu(self)
		elseif button == "Button4" then
			config.showGuildNotes = not config.showGuildNotes
			UpdateTablet()
		end
	end,
} )

f.FriendsBlock = ldb:NewDataObject( "|cFFFFB366Ara|r Friends", {
	type = "data source",
	text = FRIENDS,
	icon = [[Interface\AddOns\Ara_Broker_Guild_Friends\friends]],
	OnEnter = function(self)
		isGuild = false
		ShowFriends()
		AnchorTablet(self)
	end,
	OnLeave = Block_OnLeave,
	OnClick = function(self, button)
		if button == "MiddleButton" or IsModifierKeyDown() then
			f:Hide() tip:Hide()
			FriendsFrameAddFriendButton:Click()
		elseif button == "LeftButton" then
			ToggleFriendsFrame(1)
		elseif button == "RightButton" then
			DisplayConfigMenu(self)
		elseif button == "Button4" then
			config.showFriendNotes = not config.showFriendNotes
			UpdateTablet()
		end
	end,
} )

local guildTimer, friendTimer = 0, 0


local orgGuildRoster = GuildRoster
GuildRoster = function(...)
	guildTimer = 0
	return orgGuildRoster(...)
end

local orgShowFriends = ShowFriends
ShowFriends = function(...)
	friendTimer = 0
	return orgShowFriends(...)
end


local function OnUpdate( self, elapsed )
	guildTimer, friendTimer = guildTimer + elapsed, friendTimer + elapsed
	if guildTimer > 15 then
		if IsInGuild() then GuildRoster() else guildTimer = 0 end
	end
	if friendTimer > 15 then ShowFriends() end
end


function f:BN_FRIEND_INFO_CHANGED()
	if f:IsShown() then
		UpdateTablet()
	end
end
f.BN_CUSTOM_MESSAGE_CHANGED = f.BN_FRIEND_INFO_CHANGED

f.BN_FRIEND_ACCOUNT_ONLINE = UpdateFriendBlockText
f.BN_FRIEND_ACCOUNT_OFFLINE = UpdateFriendBlockText
f.BN_CONNECTED = UpdateFriendBlockText
f.BN_DISCONNECTED = UpdateFriendBlockText

-- add/remove new/obsolete config var
local function UpdateConfig( baseConfig, currentConfig, deep, remove )
	for var, defaultValue in next, baseConfig do
		local currentValue = currentConfig[var]
		if currentValue == nil then
			if remove then baseConfig[var] = nil else currentConfig[var] = defaultValue end
		elseif type(currentValue) == "table" and type(defaultValue) == "table" then
			UpdateConfig( defaultValue, currentValue, true, remove )
		end
	end
	-- if top level first call and config isn't new, remove obsolete var
	if not deep and defaultConfig ~= config then UpdateConfig( currentConfig, baseConfig, true, true ) end
end


function f:ADDON_LOADED( addon )
	if addon ~= addonName then return end
	f:Hide()

	AraBrokerGuildFriendsDB = AraBrokerGuildFriendsDB or defaultConfig
	config = AraBrokerGuildFriendsDB
	UpdateConfig( defaultConfig, config )

	colors = config.colors
	PreFormatStatusText(colors.status)
	sortIndexes = {
		[true] = { colpairs[config.sortCols[true ][1]], colpairs[config.sortCols[true ][2]], colpairs[config.sortCols[true ][3]] },
		[false] ={ colpairs[config.sortCols[false][1]], colpairs[config.sortCols[false][2]], colpairs[config.sortCols[false][3]] },
	}
	texOrder1:SetVertexColor(unpack(colors.orderA))

	for eng, loc in next, LOCALIZED_CLASS_NAMES_MALE   do L[loc] = eng end
	for eng, loc in next, LOCALIZED_CLASS_NAMES_FEMALE do L[loc] = eng end

	tip = GameTooltip
	horde = UnitFactionGroup"player" == "Horde"
	playerRealm = GetRealmName()
	f:SetBackdrop( {
		bgFile = "Interface\\Buttons\\WHITE8X8",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		edgeSize=16, tile = false, tileSize=0,
		insets = { left=3, right=3, top=3, bottom=3 } } )
	f:SetFrameStrata"TOOLTIP"
	f:SetClampedToScreen(true)
	f:EnableMouse(true)

	StaticPopupDialogs.SET_BN_BROADCAST = {
		text = BN_BROADCAST_TOOLTIP,
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		hasWideEditBox = 1,
		maxLetters = 127,
		OnAccept = function(self) BNSetCustomMessage(self.wideEditBox:GetText()) end,
		OnShow = function(self) self.wideEditBox:SetText( select(3, BNGetInfo()) ) self.wideEditBox:SetFocus() end,
		OnHide = ChatEdit_FocusActiveWindow,
		EditBoxOnEnterPressed = function(self) BNSetCustomMessage(self:GetText()) self:GetParent():Hide() end,
		EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	}

	t:SetScript( "OnUpdate", OnUpdate )
	f:SetScript( "OnEnter", Menu_OnEnter )
	f:SetScript( "OnLeave", Menu_OnLeave )

	f:RegisterEvent"GUILD_ROSTER_UPDATE"
	f:RegisterEvent"PLAYER_GUILD_UPDATE"
	f:RegisterEvent"FRIENDLIST_UPDATE"
	f:RegisterEvent"CHAT_MSG_SYSTEM"

	f:RegisterEvent"BN_FRIEND_INFO_CHANGED"
	f:RegisterEvent"BN_FRIEND_ACCOUNT_ONLINE"
	f:RegisterEvent"BN_FRIEND_ACCOUNT_OFFLINE"
	f:RegisterEvent"BN_CUSTOM_MESSAGE_CHANGED"
	f:RegisterEvent"BN_CONNECTED"
	f:RegisterEvent"BN_DISCONNECTED"

	slider = CreateFrame("Slider", nil, f)
	slider:SetWidth(16)
	slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
	slider:SetBackdrop( {
		bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
		edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
		edgeSize = 8, tile = true, tileSize = 8,
		insets = { left=3, right=3, top=6, bottom=6 }
	} )
	slider:SetValueStep(1)
	slider:SetScript( "OnLeave", Menu_OnLeave )
	slider:SetScript( "OnValueChanged", function(self, value)
		if hasSlider then
			sliderValue = value
			if f:IsMouseOver() then UpdateScrollButtons(MAX_ENTRIES) end
		end
	end )

	ShowFriends()
	if IsInGuild(buttons[0]) then GuildRoster() else guildTimer = 0 end
	f:GUILD_ROSTER_UPDATE()

	f:UnregisterEvent"ADDON_LOADED"
	f.ADDON_LOADED = nil
end

f:RegisterEvent"ADDON_LOADED"
f:SetScript( "OnEvent", function(self, event, ...) return self[event](self, ...) end )