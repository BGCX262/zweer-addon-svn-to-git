--[[
	Copyright (c) 2009, dr_AllCOM3
    All rights reserved.

    You're allowed to use this addon, free of monetary charge,
    but you are not allowed to modify, alter, or redistribute
    this addon without express, written permission of the author.
]]

local L = LibStub("AceLocale-3.0"):GetLocale("DocsUI_Nameplates")
local LSM = LibStub("LibSharedMedia-3.0")

local temp, temp2, db
local addon = DocsUI_Nameplates

--[[ Print ]]
local function p( text )
	ChatFrame3:AddMessage( tostring( text ) )
end

addon.resources = {}

--[[ Helper functions ]]
-- _G global names
addon.resources.globalNames = setmetatable({}, {__index = function(self, index)
	for k,v in pairs(_G) do
		if(v == index) then
			self[index] = k
			return k
		end
	end
	return tostring(index)
end})

-- Short numbers
function addon.resources.siValue( val )
    if val >= 10000000 then 
        return format( "%.1fm", val / 1000000 ) 
    elseif val >= 1000000 then
        return format( "%.2fm", val / 1000000 ) 
    elseif val >= 100000 then
        return format( "%.0fk", val / 1000 ) 
    elseif val >= 1000 then
        return format( "%.1fk", val / 1000 ) 
    else
        return val
    end
end

-- Round a number
-- number, decimal places
function addon.resources.round( num, idp ) --number, decimal places
	local mult = 10^( idp or 0 )
	return math.floor( num * mult + 0.5 ) / mult
end

-- Format time
function addon.resources.formatTime( time )
    if time>60 then
        time = floor( time/60 ).."m"
    else
        time = time
    end
    
    return time
end

-- Sort by time
function addon.resources.sortByTime( a,b )
    local time = GetTime()
    
    if a[7]-time==b[7]-time then --[1]name, [7]expirationTime
        return a[1]>b[1]
    else
        return a[7]-time>b[7]-time
    end
end

-- Copy table
function addon.resources.deepcopy( object )
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy( object )
end

-- Threat color gradient
-- http://www.wowwiki.com/ColorGradient
function addon.resources.colorGradient( perc, c1, c2 )
	if perc>=1 then
		return c2.r, c2.g, c2.b
	elseif perc<=0 then
		return c1.r, c1.g, c1.b
	end
	
	return c1.r+( c2.r-c1.r )*perc, c1.g+( c2.g-c1.g )*perc, c1.b+( c2.b-c1.b )*perc
end

-- Lighten up a color
function addon.resources.lightenColor( r, g, b )
    local modifier = 1.5
    
    if not r or not g or not b then
        return r, g, b
    else
        return r+( 1-r )/modifier, g+( 1-g )/modifier, b+( 1-b )/modifier
    end
end

-- Darken a color
function addon.resources.darkenColor( r, g, b )
    local modifier = 1.5
    
    if not r or not g or not b then
        return r, g, b
    else
        return r/modifier, g/modifier, b/modifier
    end
end

-- Level color
function addon.resources.getLevelColor( level, playerLevel )
    if level>playerLevel+4 then -- Red
        return { 0.75,0,0 }
    elseif level>playerLevel+2 then -- Orange
        return { 0.75,0.75/2,0 }
    elseif playerLevel+2>=level and level>=playerLevel-2 then -- Yellow
        return { 0.75,0.75,0 }
    else -- Green
        if playerLevel<=9 and level>=playerLevel-4 then
            return { 0,0.75,0 }
        elseif playerLevel<=19 and level>=playerLevel-5 then
            return { 0,0.75,0 }
        elseif playerLevel<=29 and level>=playerLevel-6 then
            return { 0,0.75,0 }
        elseif playerLevel<=39 and level>=playerLevel-7 then
            return { 0,0.75,0 }
        elseif playerLevel<=70 and level>=playerLevel-8 then
            return { 0,0.75,0 }
        elseif playerLevel<=80 and level>=playerLevel-8 then
            return { 0,0.75,0 }
        elseif playerLevel<=85 and level>=playerLevel-9 then
            return { 0,0.75,0 }
        else -- Grey
            return { 0.5,0.5,0.5 }
        end
    end
end

-- Social color
function addon.resources.getSocialColor( social )
    if social=="raid" then
        return 255/255, 127/255, 0/255
    elseif social=="party" then
        return 166/255, 166/255, 255/255
    elseif social=="guild" then
        return 64/255, 255/255, 64/255
    elseif social=="bnet" then
        return 115/255, 199/255, 255/255
    elseif social=="friend" then
        return 254/255, 222/255, 41/255
    else
        return 255/255, 255/255, 255/255
    end
end

--[[ Create the border ]]
function addon:setBorder( option )
    db = addon.db.profile
    
    local size = db.borderSize
    local strata = "BACKGROUND"
    local texture
    local textureSize = 16
    if option=="icon" then
        texture = db.borderIcon
    else
        texture = db.border
    end
    local r = db.borderColor.r
    local g = db.borderColor.g
    local b = db.borderColor.b
    local a = db.borderColor.a
    
    if option=="icon" then
        if not self.border then
            self.border = self:CreateTexture( nil, strata )
        end
        
        self.border:SetWidth( self:GetWidth()+size )
        self.border:SetHeight( self:GetHeight()+size )
        self.border:SetPoint( "CENTER", self, "CENTER" )--, size, -size )
        --self.border:SetPoint( "TOPLEFT", self, "TOPLEFT", -size, size )
        --self.border:SetPoint( "BOTTOMRIGHT", self, "BOTTOMRIGHT", size, -size )
        self.border:SetTexture( texture )
        self.border:SetVertexColor( r, g, b, a )
    else
        size = 0
        
        if not self.border then
            self.border = {}
            self.border.topleft = self:CreateTexture( nil, strata )
            self.border.top = self:CreateTexture( nil, strata )
            self.border.topright = self:CreateTexture( nil, strata )
            self.border.left = self:CreateTexture( nil, strata )
            self.border.right = self:CreateTexture( nil, strata )
            self.border.bottomleft = self:CreateTexture( nil, strata )
            self.border.bottom = self:CreateTexture( nil, strata )
            self.border.bottomright = self:CreateTexture( nil, strata )
        end
        
        self.border.topleft:SetWidth( textureSize )
        self.border.topleft:SetHeight( textureSize )
        self.border.topleft:SetPoint( "BOTTOMRIGHT", self, "TOPLEFT", -size, size )
        self.border.topleft:SetTexture( texture )
        self.border.topleft:SetTexCoord( 0/8, 1/8, 0, 1 )
        self.border.topleft:SetVertexColor( r, g, b, a )
        
        self.border.top:SetWidth( textureSize )
        self.border.top:SetHeight( textureSize )
        self.border.top:SetPoint( "BOTTOMLEFT", self, "TOPLEFT", -size, size )
        self.border.top:SetPoint( "BOTTOMRIGHT", self, "TOPRIGHT", -size, size )
        self.border.top:SetTexture( texture )
        self.border.top:SetTexCoord( 1/8, 2/8, 0, 1 )
        self.border.top:SetVertexColor( r, g, b, a )
        
        self.border.topright:SetWidth( textureSize )
        self.border.topright:SetHeight( textureSize )
        self.border.topright:SetPoint( "BOTTOMLEFT", self, "TOPRIGHT", -size, size )
        self.border.topright:SetTexture( texture )
        self.border.topright:SetTexCoord( 2/8, 3/8, 0, 1 )
        self.border.topright:SetVertexColor( r, g, b, a )
        
        self.border.left:SetWidth( textureSize )
        self.border.left:SetHeight( textureSize )
        self.border.left:SetPoint( "TOPRIGHT", self, "TOPLEFT", -size, size )
        self.border.left:SetPoint( "BOTTOMRIGHT", self, "BOTTOMLEFT", -size, size )
        self.border.left:SetTexture( texture )
        self.border.left:SetTexCoord( 3/8, 4/8, 0, 1 )
        self.border.left:SetVertexColor( r, g, b, a )
        
        self.border.right:SetWidth( textureSize )
        self.border.right:SetHeight( textureSize )
        self.border.right:SetPoint( "TOPLEFT", self, "TOPRIGHT", -size, size )
        self.border.right:SetPoint( "BOTTOMLEFT", self, "BOTTOMRIGHT", -size, size )
        self.border.right:SetTexture( texture )
        self.border.right:SetTexCoord( 4/8, 5/8, 0, 1 )
        self.border.right:SetVertexColor( r, g, b, a )
        
        self.border.bottomleft:SetWidth( textureSize )
        self.border.bottomleft:SetHeight( textureSize )
        self.border.bottomleft:SetPoint( "TOPRIGHT", self, "BOTTOMLEFT", -size, size )
        self.border.bottomleft:SetTexture( texture )
        self.border.bottomleft:SetTexCoord( 5/8, 6/8, 0, 1 )
        self.border.bottomleft:SetVertexColor( r, g, b, a )
        
        self.border.bottom:SetWidth( textureSize )
        self.border.bottom:SetHeight( textureSize )
        self.border.bottom:SetPoint( "TOPLEFT", self, "BOTTOMLEFT", -size, size )
        self.border.bottom:SetPoint( "TOPRIGHT", self, "BOTTOMRIGHT", -size, size )
        self.border.bottom:SetTexture( texture )
        self.border.bottom:SetTexCoord( 6/8, 7/8, 0, 1 )
        self.border.bottom:SetVertexColor( r, g, b, a )
        
        self.border.bottomright:SetWidth( textureSize )
        self.border.bottomright:SetHeight( textureSize )
        self.border.bottomright:SetPoint( "TOPLEFT", self, "BOTTOMRIGHT", -size, size )
        self.border.bottomright:SetTexture( texture )
        self.border.bottomright:SetTexCoord( 7/8, 8/8, 0, 1 )
        self.border.bottomright:SetVertexColor( r, g, b, a )
    end
end

--[[ Data ]]
addon.raidIconList = {
    L["Yellow Star"],
    L["Orange Circle"],
    L["Purple Diamond"],
    L["Green Triangle"],
    L["White Moon"],
    L["Blue Square"],
    L["Red X"],
    L["White Skull"],
}

-- Class icon tex coords
addon.resources.classIcon = {
    ["WARRIOR"] = { 0.00, 0.25, 0.00, 0.25 },
    ["MAGE"] = { 0.25, 0.50, 0.00, 0.25 },
    ["ROGUE"] = { 0.50, 0.75, 0.00, 0.25 },
    ["DRUID"] = { 0.75, 1.00, 0.00, 0.25 },
    ["HUNTER"] = { 0.00, 0.25, 0.25, 0.50 },
    ["SHAMAN"] = { 0.25, 0.50, 0.25, 0.50 },
    ["PRIEST"] = { 0.50, 0.75, 0.25, 0.50 },
    ["WARLOCK"] = { 0.75, 1.00, 0.25, 0.50 },
    ["PALADIN"] = { 0.00, 0.25, 0.50, 0.75 },
    ["DEATHKNIGHT"] = { 0.25, 0.50, 0.50, 0.75 },
}

-- Totem spell ids
addon.resources.totemList = {
--~     2484,--Earthbind Totem
--~     8143,--Tremor Totem
--~     8177,--Grounding Totem
--~     8512,--Windfury Totem
--~     6495,--Sentry Totem
--~     8170,--Cleansing Totem
--~     3738,--Wrath of Air Totem
--~     2062,--Earth Elemental Totem
--~     2894,--Fire Elemental Totem
--~     58734,--Magma Totem
--~     58582,--Stoneclaw Totem
--~     58753,--Stoneskin Totem
--~     58739,--Fire Resistance Totem
--~     58656,--Flametongue Totem
--~     58745,--Frost Resistance Totem
--~     58757,--Healing Stream Totem
--~     58774,--Mana Spring Totem
--~     58749,--Nature Resistance Totem
--~     58704,--Searing Totem
--~     58643,--Strength of Earth Totem
--~     57722,--Totem of Wrath
--~     
--~     71278,--chokingGas --"Interface\\Icons\\Ability_Creature_Cursed_01"
}
addon.resources.totems = {}
for i=1,#addon.resources.totemList do
    local name, _, texture = GetSpellInfo(addon.resources.totemList[i])
    addon.resources.totems[i] = { name = name, texture = texture }
end
tinsert( addon.resources.totems, { name = "Initiate's Training Dummy", texture = "Interface\\Icons\\Mail_gmicon" } )

-- Raid icon tex coords
addon.resources.raidIconTextureCoords = { -- ULx, ULy, LLx, LLy, URx, URy, LRx, LRy
    { 0,0,0,0.25,0.25,0,0.25,0.25 }, --star 1
    { 0.25,0,0.25,0.25,0.5,0,0.5,0.25 }, --circle 2
    { 0.5,0,0.5,0.25,0.75,0,0.75,0.25 }, --purple 3
    { 0.75,0,0.75,0.25,1,0,1,0.25 }, --triangle 4
    { 0,0.25,0,0.5,0.25,0.25,0.25,0.5 }, --moon 5
    { 0.25,0.25,0.25,0.5,0.5,0.25,0.5,0.5 }, --blue 6
    { 0.5,0.25,0.5,0.5,0.75,0.25,0.75,0.5 }, --cross 7
    { 0.75,0.25,0.75,0.5,1,0.25,1,0.5 }, --skull 8
}

-- Role icon tex coords
addon.resources.roleTextureCoords = {
    TANK = { 0.5, 0.75, 0, 1.0 },
    HEALER = { 0.75, 1.0, 0, 1.0 },
    DAMAGER = { 0.25, 0.5, 0, 1.0 },
}

-- Class colors
addon.resources.classByColor = {
C285 = "DEATHKNIGHT",
C390 = "DRUID",
C498 = "HUNTER",
C549 = "MAGE",
C571 = "PALADIN",
C768 = "PRIEST",	
C605 = "ROGUE",	
C335 = "SHAMAN",	
C479 = "WARLOCK",
C465 = "WARRIOR",
--C256 = "Npc",
}

-- ToC: Faction Champs
function addon.resources.factionChampClassAndRole( name )
    --[[Shaman]]--
		if name==L["Saamul"] or name==L["Thrakgar"] then
            return "SHAMAN", "DAMAGER"
        elseif name==L["Broln Stouthorn"] or name==L["Shaabad"] then
            return "SHAMAN", "HEALER"
    --[[Paladins]]--
        elseif name==L["Baelnor Lightbearer"] or name==L["Malithas Brightblade"] then
            return "PALADIN", "TANK"
        elseif name==L["Velanaa"] or name==L["Liandra Suncaller"] then
            return "PALADIN", "HEALER"
	--[[Druids]]--
        elseif name==L["Kavina Grovesong"] or name==L["Birana Stormhoof"] then
            return "DRUID", "DAMAGER"
        elseif name==L["Melador Valestrider"] or name==L["Erin Misthoof"] then
            return "DRUID", "HEALER"
	--[[Priests]]--
        elseif name==L["Brienna Nightfell"] or name==L["Vivienne Blackwhisper"] then
            return "PRIEST", "DAMAGER"
        elseif name==L["Anthar Forgemender"] or name==L["Caiphus the Stern"] then
            return "PRIEST", "HEALER"
	--[[Warlocks]]--
        elseif name==L["Serissa Grimdabbler"] or name==L["Harkzog"] then
            return "WARLOCK", "DAMAGER"
	--[[Warriors]]--
        elseif name==L["Shocuul"] or name==L["Narrhok Steelbreaker"] then
            return "WARRIOR", "TANK"
	--[[Rogues]]--
        elseif name==L["Irieth Shadowstep"] or name==L["Maz'dinah"] then
            return "ROGUE", "DAMAGER"
	--[[Death Knights]]--
        elseif name==L["Tyrius Duskblade"] or name==L["Gorgrim Shadowcleave"] then
            return "DEATHKNIGHT", "TANK"
	--[[Hunters]]--
        elseif name==L["Alyssia Moonstalker"] or name==L["Ruj'kah"] then
            return "HUNTER", "DAMAGER"
	--[[Mages]]--
        elseif name==L["Noozle Whizzlestick"] or name==L["Ginselle Blightslinger"] then
            return "MAGE", "DAMAGER"
        else
            return nil
        end
end