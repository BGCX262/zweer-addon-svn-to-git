--[[
	Copyright (c) 2009, dr_AllCOM3
    All rights reserved.

    You're allowed to use this addon, free of monetary charge,
    but you are not allowed to modify, alter, or redistribute
    this addon without express, written permission of the author.
]]

local L = LibStub("AceLocale-3.0"):GetLocale("DocsUI_Nameplates")
local LSM = LibStub("LibSharedMedia-3.0")
local db
local temp,temp2 = nil

--[[ Print ]]
local function p( text )
	ChatFrame3:AddMessage( tostring( text ) )
end

local _, playerClass = UnitClass( "player" )

DocsUI_Nameplates.version = 5.01
DocsUI_Nameplates.defaults = { 
    profile = {
        version = -1,
        logo = "Interface\\Addons\\DocsUI_Nameplates\\media\\logo",
        import = 0,
        debugMode = false,
        
        -- Options
        socialIcon = true,
        classIcon = false,
        roleIcon = false,
        unknownIcon = true,
        guildName = true,
        lfgIcon = true,
        whisperIcon = true,
        tot = true,
        
        width = 60,
        height = 12,
        widthCast = 60,
        heightCast = 12,
        scale = 1,
        scaleBuffs = 1,
        
        combatLogFix = true,
        combatLogFixPrint = false,
        
        fontsize = 13,
        fontsizeHealth = 20,
        fontsizeName = 11,
        fontsizeGuild = 8,
        fontsizeBuffs = 9,
        fontsizeCast = 12,
        
        outline = "NONE",
        font = "Segoe UI",
        fonti = "Segoe UI Italic",
        fontb = "Segoe UI Bold",
        
        texture = "Doc",
        bg = "Interface\\Addons\\DocsUI_Nameplates\\media\\bg",
        border = "Pixel",
        borderIcon = "Interface\\Addons\\DocsUI_Nameplates\\media\\borderGradientIcon",
        borderSize = 2,
        
        fontColor = {r=0.75,g=0.75,b=0.75,a=1},
        customColor = {r=0.3,g=0.3,b=0.3,a=1},
        bgColor = {r=0,g=0,b=0,a=0.5},
        borderColor = {r=0.4,g=0.4,b=0.4,a=1},
        colorThreatVerySafe = {r=0.45,g=0.45,b=0.45,a=1},
        colorThreatSafe = {r=0.875,g=0.875,b=0,a=1},
        colorThreatUnsafe = {r=0.875,g=0.875/2,b=0,a=1},
        colorThreatAlert = {r=0.875,g=0,b=0,a=1},
        colorThreatTanked = {r=0,g=0.875/2,b=0.875,a=1},
        castColor = { r=255/255, g=201/255, b=14/255, a=1 },
        
        threatEnabled = true,
        
        showHpAbsolut = false,
        showHpPercent = true,
        showHpBar = false,
        healthBarColorCustom = false,
        healthBarColorPvP = false,
        healthBarColorClass = true,
        healthBarFriendPve = false,
        healthBarEnemyPve = true,
        healthBarFriendPveCombat = false,
        healthBarEnemyPveCombat = true,
        healthBarFriendPvp = false,
        healthBarEnemyPvp = true,
        
        castBarFriendPve = false,
        castBarEnemyPve = true,
        castBarFriendPveCombat = false,
        castBarEnemyPveCombat = true,
        castBarFriendPvp = false,
        castBarEnemyPvp = true,
        castBarNonTargets = true,
        
        buffsNumber = 6,
        buffsFriendPve = false,
        buffsEnemyPve = true,
        buffsFriendPveCombat = false,
        buffsEnemyPveCombat = true,
        buffsFriendPvp = false,
        buffsEnemyPvp = true,
        
        allowOverlap = true,
        
        visibilityPveFriendUnit = true,
        visibilityPveFriendPet = false,
        visibilityPveFriendGuardian = false,
        visibilityPveFriendTotem = false,
        visibilityPveEnemyUnit = true,
        visibilityPveEnemyPet = false,
        visibilityPveEnemyGuardian = true,
        visibilityPveEnemyTotem = true,
        
        visibilityPvecombatFriendUnit = false,
        visibilityPvecombatFriendPet = false,
        visibilityPvecombatFriendGuardian = false,
        visibilityPvecombatFriendTotem = false,
        visibilityPvecombatEnemyUnit = true,
        visibilityPvecombatEnemyPet = false,
        visibilityPvecombatEnemyGuardian = true,
        visibilityPvecombatEnemyTotem = true,
        
        visibilityPvpFriendUnit = true,
        visibilityPvpFriendPet = false,
        visibilityPvpFriendGuardian = false,
        visibilityPvpFriendTotem = false,
        visibilityPvpEnemyUnit = true,
        visibilityPvpEnemyPet = false,
        visibilityPvpEnemyGuardian = false,
        visibilityPvpEnemyTotem = true,
        
        buffFilter = {
            buffs = {
                my = {},
                any = {},
                never = {},
                allMy = false,
                allAny = false,
            },
            debuffs = {
                my = {},
                any = {},
                never = {},
                allMy = false,
                allAny = false,
            },
            filterLow = true,
        },
        
        -- unsortiertes zeug
        -- General Options
        
        
        heightCast = 5,
        heightThreat = 3,
        sizeBuffs = 14,
        sizeTotem = 16,
        
        spacing = 2,
        spacingFixed = 2,
        
        fontoffset = 0,
        
        textureComboPoint1 = "Interface\\Addons\\DocsUI_Nameplates\\media\\combo1",
        textureComboPoint2 = "Interface\\Addons\\DocsUI_Nameplates\\media\\combo2",
        textureComboPoint3 = "Interface\\Addons\\DocsUI_Nameplates\\media\\combo3",
        textureComboPoint4 = "Interface\\Addons\\DocsUI_Nameplates\\media\\combo4",
        textureComboPoint5 = "Interface\\Addons\\DocsUI_Nameplates\\media\\combo5",
        
        alpha = 0.6,
        
        showNameplates = true,
        UPDATE_FREQUENCY = 0.1,
        showNameplateName = true,
        showNameplatePvpName = true,
        
        nameplateHider = {},
        
        -- Bossplates
        professorPutricide = true,
        
        healingSpells = {
            strlower( GetSpellInfo( 31739 ) or "nil" ),--Heal
            strlower( GetSpellInfo( 2147 ) or "nil" ),--Mending
            
            strlower( GetSpellInfo( 50464 ) or "nil" ),--Nourish
            --strlower( GetSpellInfo( 48378 ) or "nil" ),--Healing Touch
            strlower( GetSpellInfo( 48443 ) or "nil" ),--Regrowth
            strlower( GetSpellInfo( 48447 ) or "nil" ),--Tranquility
            --strlower( GetSpellInfo( 55459 ) or "nil" ),--Chain Heal
            --strlower( GetSpellInfo( 49273 ) or "nil" ),--Healing Wave
            --strlower( GetSpellInfo( 49276 ) or "nil" ),--Lesser Healing Wave
            strlower( GetSpellInfo( 64843 ) or "nil" ),--Divine Hymn
            strlower( GetSpellInfo( 53007 ) or "nil" ),--Penance
            --strlower( GetSpellInfo( 48071 ) or "nil" ),--Flash Heal
            --strlower( GetSpellInfo( 48120 ) or "nil" ),--Binding Heal
            --strlower( GetSpellInfo( 48063 ) or "nil" ),--Greater Heal
            strlower( GetSpellInfo( 48782 ) or "nil" ),--Holy Light
            strlower( GetSpellInfo( 48785 ) or "nil" ),--Flash of Light
        },
    },
    
    realm = {
        playerList = {},
    },
    
    global = {
        healerList = {},
        casterList = {},
        agressiveList = {},
        npcList = {},
        spellList = {},
        nameplateHider = {},
        nameReplacer = {},
        LFGList = {},
    },
    
}

local db = DocsUI_Nameplates.defaults.profile

local agressiveList = {
    ["Initiate's Training Dummy"] = true,
    ["Disciple's Training Dummy"] = true,
    ["Veteran's Training Dummy"] = true,
    ["Ebon Knight's Training Dummy"] = true,
    ["Highlord's Nemesis Trainer"] = true,
    ["Expert's Training Dummy"] = true,
}

local nameplateHider = {
    "Dark Rune Commoner", --small non-elites in Thorim arena
    "Dunkler Runenb\195\188rger", --small non-elites in Thorim arena
    "Onyxian Whelp",
    "Welpe von Onyxia",
    "Forest Swarmer",
    "Fanged Pit Viper",
    "Bissige Grubenotter",
}

local nameReplacer = {
    ["Val'kyr Shadowguard"] = "Valk",
    ["Heroic Training Dummy"] = "Boss",
}

local LFGList = {
    "lfm",
}

local myBuffs = {
    ["WARRIOR"] = {
        
    },
    ["MAGE"] = {
        
    },
    ["ROGUE"] = {
        
    },
    ["DRUID"] = {
        
    },
    ["HUNTER"] = {
        
    },
    ["SHAMAN"] = {
        
    },
    ["PRIEST"] = {
        
    },
    ["WARLOCK"] = {
        
    },
    ["PALADIN"] = {
        
    },
    ["DEATHKNIGHT"] = {
        
    },
}

local anyBuffs = {
    {642,3},--Divine Shield
    {1022,3},--Hand of Protection
    {45438,3},--Ice Block
    {31224,3},--Cloak of Shadows
    {5277,3},--Evasion
    {781,3},--Disengage
    {22812,3},--Barkskin
    {47585,3},--Dispersion
    {46924,3},--Bladestorm
    
    {69558,3},--Unstable Ooze
    {70768,3},--Shroud of the Occult
    {70842,3},--Mana Barrier
    {71730,3},--Lay Waste
    
    {61573,1},--Banner of the Alliance
    
}

local myDebuffs = {
    ["WARRIOR"] = {
        {1715,3},--Hamstring
    },
    ["MAGE"] = {
        {31589,3},--Slow
        {44457,3},--Living Bomb
    },
    ["ROGUE"] = {
        
    },
    ["DRUID"] = {
        {5570,3},--Insect Swarm
        {8921,3},--Moonfire
    },
    ["HUNTER"] = {
        
    },
    ["SHAMAN"] = {
        
    },
    ["PRIEST"] = {
        {589,3},--Shadow Word: Pain
        {34914,3},--Vampiric Touch
        {2944,3},--Devouring Plague
        {48045,3},--Mind Sear
    },
    ["WARLOCK"] = {
        {172,3},--Corruption
        {980,3},--Bane of Agony
        {603,3},--Bane of Doom
        {1714,3},--Curse of Tongues
        {702,3},--Curse of Weakness
        {18223,3},--Curse of Exhaustion
        {348,3},--Immolate
        {48181,3},--Haunt
        {27243,3},--Seed of Corruption
    },
    ["PALADIN"] = {
        
    },
    ["DEATHKNIGHT"] = {
        {59921,3},--Frost Fever
        {59879,3},--Blood Plague
    },
}

local anyDebuffs = {
    {19386,3},--Wyvern Sting
    {60192,3},--Freezing Trap
    {118,3},--Polymorph
    {6770,3},--Sap
    {51514,3},--Hex
    {710,3},--Banish
    {2094,3},--Blind
    
    {73912,3},--Necrotic Plague
}

for i=1,#nameplateHider do
    DocsUI_Nameplates.defaults.global.nameplateHider[nameplateHider[i]] = true
end

for i,v in pairs( nameReplacer ) do
    DocsUI_Nameplates.defaults.global.nameReplacer[i] = v
end

for i=1,#LFGList do
    tinsert( DocsUI_Nameplates.defaults.global.LFGList, LFGList[i] )
end

for i=1,#agressiveList do
    local name = strlower( agressiveList[i] )
    
    tinsert( DocsUI_Nameplates.defaults.global.agressiveList, name )
end

local list = anyBuffs
for i=1,#list do
    local name = GetSpellInfo( list[i][1] )
    
    if name then db.buffFilter.buffs.any[name] = list[i][2] end
end

local list = anyDebuffs
for i=1,#list do
    local name = GetSpellInfo( list[i][1] )
    
    if name then db.buffFilter.debuffs.any[name] = list[i][2] end
end

local list = myBuffs[playerClass]
for i=1,#list do
    local name = GetSpellInfo( list[i][1] )
    
    if name then db.buffFilter.buffs.my[name] = list[i][2] end
end

local list = myDebuffs[playerClass]
for i=1,#list do
    local name = GetSpellInfo( list[i][1] )
    
    if name then db.buffFilter.debuffs.my[name] = list[i][2] end
end