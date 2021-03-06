local L = LibStub("AceLocale-3.0"):NewLocale("DocsUI_Nameplates", "enUS", true)
if not L then return end

-- Text
L["Close"] = true
L["coreDeleteMsg"] = "If you're using the stand-alone version and just upgraded to version 3, please delete the DocsUI folder in \\World of Warcraft\\Interface\\Addons. Do not do this, if you use any of my other addons."
L["dummy"] = true

-- Icons
do
L["Yellow Star"] = true
L["Orange Circle"] = true
L["Purple Diamond"] = true
L["Green Triangle"] = true
L["White Moon"] = true
L["Blue Square"] = true
L["Red X"] = true
L["White Skull"] = true
end

-- Faction Champions
do
L["Shaabad"] = true
L["Saamul"] = true
L["Broln Stouthorn"] = true
L["Thrakgar"] = true
L["Velanaa"] = true
L["Baelnor Lightbearer"] = true
L["Liandra Suncaller"] = true
L["Malithas Brightblade"] = true
L["Kavina Grovesong"] = true
L["Melador Valestrider"] = true
L["Birana Stormhoof"] = true
L["Erin Misthoof"] = true
L["Anthar Forgemender"] = true
L["Brienna Nightfell"] = true
L["Caiphus the Stern"] = true
L["Vivienne Blackwhisper"] = true
L["Serissa Grimdabbler"] = true
L["Harkzog"] = true
L["Shocuul"] = true
L["Narrhok Steelbreaker"] = true
L["Irieth Shadowstep"] = true
L["Maz'dinah"] = true
L["Tyrius Duskblade"] = true
L["Gorgrim Shadowcleave"] = true
L["Alyssia Moonstalker"] = true
L["Ruj'kah"] = true
L["Noozle Whizzlestick"] = true
L["Ginselle Blightslinger"] = true
end

-- Options
do
L["Level"] = true
L["Social"] = true
L["Class"] = true
L["Role"] = true
L["Debug"] = true
L["Width"] = true
L["Height"] = true
L["Buffs"] = true
L["Totem"] = true
L["showLevel"] = "Show the level."
L["socialIcon"] = "Show the social icon."
L["classIcon"] = "Show the class icon."
L["roleIcon"] = "Show the role icon."
L["debugMode"] = "Debug mode."
L["Debug"] = true
L["Size"] = true
L["Name"] = true
L["Guild"] = true
L["Friend"] = true
L["Enemy"] = true
L["PvE"] = true
L["PvP"] = true
L["healthBar"] = "Show the health for this kind of unit."
L["castBar"] = "Show the cast bar for this kind of unit."
L["Enabled"] = true
L["Icon"] = true
L["Color"] = true
L["Overlap"] = true
L["allowOverlap"] = "Allow overlapping of nameplates."
L["visibilityTt"] = "Show nameplates for this kind of unit."
L["Unit"] = true
L["Pet"] = true
L["Guardian"] = true
L["Totem"] = true
L["Number"] = true
L["buffsNumber"] = "Maximum number of buffs visible."
L["All my buffs"] = true
L["All my debuffs"] = true
L["All any buffs"] = true
L["All any debuffs"] = true
L["allMyBuffs"] = "Show all buffs casted by me."
L["allMyDebuffs"] = "Show all debuffs casted by me."
L["allAnyBuffs"] = "Show all buffs.\nThis can decrease your performance."
L["allAnyDebuffs"] = "Show all debuffs.\nThis can decrease your performance."
L["icon"] = true
L["combat"] = true
L["Config"] = true
L["Arena"] = true
L["threatBar"] = "Show threat as a bar."
L["Bar"] = true
L["buffsTt"] = "Show buffs for this kind of unit."
L["Unknown"] = true
L["unknownIcon"] = "Mark unknown units with a blue icon."
L["Layout"] = true
L["Font"] = true
L["colorTt"] = "Choose the color for this element."
L["Foreground"] = true
L["Background"] = true
L["Border"] = true
L["Threat"] = true
L["safe"] = true
L["unsafe"] = true
L["alert"] = true
L["Castbar"] = true
L["Visibility"] = true
L["Filter"] = true
L["Hider"] = true
L["Statusbar"] = true
L["StatusbarTt"] = "Choose the texture for this element."
L["fontTt"] = "Choose the font for this element."
L["Normal"] = true
L["Bold"] = true
L["Italic"] = true
L["Outline"] = true
L["None"] = true
L["Thin outline"] = true
L["Thick outline"] = true
L["Scale"] = true
L["scale_tt"] = "Choose the scale for this element."
L["size_tt"] = "Choose the size for this element."
L["Presets"] = true
L["Blizzard"] = true
L["1 Pixel"] = true
L["Roth"] = true
L["Caith"] = true
L["Textures"] = true
L["Miscellaneous"] = true
L["Combatlog fix"] = true
L["combatLogFix"] = "Automatically fix the combat log when it breaks and on zoning."
L["Combatlog print"] = true
L["combatLogFixPrint"] = "Announce combat log repairs in chat."
L["Only my"] = true
L["filterOnlyMy"] = "Only cast by me."
L["Buff"] = true
L["filterBuff"] = "This is a buff."
L["Debuff"] = true
L["filterDebuff"] = "This is a debuff."
L["Never show"] = true
L["filterNeverShow"] = "Never show this buff/debuff."
L["High"] = true
L["Medium"] = true
L["Low"] = true
L["priority"] = true
L["deleteTt"] = "Delete this buff/debuff."
L["Debuffs"] = true
L["filterName"] = "The name of the buff or debuff you want to add.\nIt has to be the exact name."
L["priorityTt"] = "The priority of this buff/debuff."
L["My"] = true
L["Any"] = true
L["hiderName"] = "The name of the npc you want to hide.\nIt has to be the exact name."
L["Delete"] = true
L["hiderDeleteTt"] = "Delete this hider entry."
L["Name replacer"] = true
L["Name,Replacement"] = true
L["replacerName"] = "The name of the npc you want to replace.\nIt has to be the exact name.\nSeperate with a comma.\nExample: The Lich King,Mr Frost"
L["replacerDeleteTt"] = "Delete this replacer entry."
L["Profiles"] = true
L["LFG"] = true
L["LFGName"] = "A word or phrase that will trigger the LFG icon.\nLower/upper case does not matter."
L["LFGDeleteTt"] = "Delete this LFG entry."
L["lfgIcon"] = "Enable the LFG icon and text."
L["guildName"] = "Show the guild name and the NPC description."
L["Non-Targets"] = true
L["castBarNonTargets"] = "Show castbars also for nameplates you have not targeted.\nOnly works when in combat and it has some limitations."
L["tot"] = "Target-of-target"
L["percent"] = true
L["showHpPercent"] = "Show the healthbar value as a percent value."
L["absolut"] = true
L["showHpAbsolut"] = "Show the healthbar value as an absolut value."
L["Healthbar"] = true
L["showHpBar"] = "Show a healthbar."
L["Custom"] = true
L["threatEnabled"] = "Enable the threat display and colors the health in the threat value.\nSet maintanks in a raid to see tanked enemies.\nPriority: Custom > PvP > Class > Threat"
L["healthBarColorCustom"] = "Color the health in a custom color.\nPriority: Custom > PvP > Class > Threat"
L["healthBarColorPvP"] = "Color the health in the PvP-team color.\nPriority: Custom > PvP > Class > Threat"
L["healthBarColorClass"] = "Color the health in the class color.\nPriority: Custom > PvP > Class > Threat"
L["very safe"] = true
L["tanked"] = true
L["I want a healthbar"] = true

end