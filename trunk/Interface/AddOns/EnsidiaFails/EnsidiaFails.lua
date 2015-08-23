local AceConfig = LibStub("AceConfig-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("EnsidiaFails")
local BB = LibStub("LibBabble-Boss-3.0"):GetUnstrictLookupTable()
local BZ = LibStub("LibBabble-Zone-3.0"):GetUnstrictLookupTable()
EnsidiaFails = CreateFrame("Frame")
local addon = EnsidiaFails
LibStub("AceConsole-3.0"):Embed(addon)
LibStub("LibSimpleTimer-1.0"):Embed(addon)
local local_revision = tonumber("233")
local TalentQuery = LibStub:GetLibrary("LibTalentQuery-1.0")
local LGT = LibStub("LibGroupTalents-1.0")
local fail = LibStub("LibFail-1.0")
local fail_events = fail:GetSupportedEvents()
local boss_fail_table = {}
local fails_where_tanks_dont_fail = fail:GetFailsWhereTanksDoNotFail()

local sensitive_fail_list = {
    "Fail_Gunship_Explosion"
}

local zone_list = {
    "Icecrown Citadel",
    "Onyxia's Lair",
    "Trial of the Crusader",
    "Ulduar",
    "Naxxramas",
    "The Obsidian Sanctum",
    "Eye of Eternity",
    "Vault of Archavon",
    "The Ruby Sanctum",
}

local optionsmenu_zone_list = {
    "IcecrownCitadel",
    "Onyxia",
    "TrialoftheCrusader",
    "Ulduar",
    "Naxxramas",
    "Sartharion",
    "Malygos",
    "Vault",
    "RubySanctum"
}

local announce_to = {
    SAY = L["Say"],
    RAID = L["Raid"],
    GUILD = L["Guild"],
    PARTY = L["Party"],
    OFFICER = L["Officer"],
    CHANNEL = L["Channel"],
    SELF = L["Self"],
}

local announce_style = {
    during = L["during"],
    after = L["after"],
    during_and_after = L["during_and_after"],
}

local announce_after_style = {
    group_by_player = L["Group by player"],
    group_by_fail = L["Group by fails"],
}

local function generate_boss_fail_table(ftable)
    for i=1, #ftable do
        local boss = nil
        if ftable[i] == "Fail_Frogger" then
            boss = "Patchwerk"
        elseif ftable[i] == "Fail_ColdflameTrap" then
            boss = "Saurfang"
        else
            local sstart, send = ftable[i]:find("_%a+_")
            sstart, send = sstart +1, send-1
            boss = ftable[i]:sub(sstart,send)
        end
        if boss_fail_table[boss] == nil then
           boss_fail_table[boss] = {}
           boss_fail_table[boss][1] = ftable[i]
        else
           boss_fail_table[boss][#boss_fail_table[boss]+1]=ftable[i]
        end
    end
end


local function generate_boss_name_table_by_zone(zone)
    local ftable = fail:GetSupportedZoneEvents(zone)
    local boss_names = {}
    for i=1, #ftable do
        local boss = nil
        if ftable[i] == "Fail_Frogger" then
            boss = "Patchwerk"
        elseif ftable[i] == "Fail_ColdflameTrap" then
            boss = "Saurfang"
        else
            local sstart, send = ftable[i]:find("_%a+_")
            sstart, send = sstart +1, send-1
            boss = ftable[i]:sub(sstart,send)
        end
        if i == 1 then
            boss_names[i] = boss
        else
            for j=1, #boss_names do
                if boss_names[j] == boss then
                    break
                else
                    if j == #boss_names then
                        boss_names[#boss_names+1] = boss
                    end
                end
            end
        end
    end
    return boss_names
end

local function onFail(event, who, event_type)
    if addon:wipe_called() then return end

    local event_spellId = fail:GetEventSpellId(event) or ""

    if not addon.db.profile[event] then return end

    if addon:CheckForTankFailEvents(event) then -- if it's a tank exclusion event
        if addon.db.profile.noexceptions then -- but our profile doesn't allow exceptions
        addon:AddFail(who,event_type,event_spellId) -- add the fail anyway
        else -- if we allow exceptions
            if LGT:GetUnitRole(who) ~= "tank" then -- but it's not a tank
            addon:AddFail(who,event_type,event_spellId) -- add the fail anyway
            end
        end -- if it was a tank NOP (do nothing)
    else
    addon:AddFail(who,event_type,event_spellId) -- if it's not a tank exclusion event add the fail normally.
    end
end

function addon:CheckForTankFailEvents(event)
    for _, v in pairs(fails_where_tanks_dont_fail) do
        if v == event then return true end
    end
end

function addon:Initialize()
    if EnsidiaFails_FailCount == nil then
        EnsidiaFails_FailCount = {}
    end
    if EnsidiaFails_OFailCount == nil then
        EnsidiaFails_OFailCount = {}
    end
end

function addon:InitializeCustomFailValues()
    fail.COUNCIL_RUNE_THRESHOLD = addon.db.profile.COUNCIL_RUNE_THRESHOLD
    fail.COUNCIL_OVERLOAD_THRESHOLD = addon.db.profile.COUNCIL_OVERLOAD_THRESHOLD
    fail.ALGALON_SMASH_THRESHOLD = addon.db.profile.ALGALON_SMASH_THRESHOLD
    fail.ONYXIA_DEEPBREATH_THRESHOLD = addon.db.profile.ONYXIA_DEEPBREATH_THRESHOLD
    fail.EMALON_NOVA_THRESHOLD = addon.db.profile.EMALON_NOVA_THRESHOLD
    fail.VEZAX_LEECH_THRESHOLD = addon.db.profile.VEZAX_LEECH_THRESHOLD
    fail.SINDRAGOSA_FROSTBOMB_THRESHOLD = addon.db.profile.SINDRAGOSA_FROSTBOMB_THRESHOLD
    fail.SINDRAGOSA_MYSTICBUFFET_THRESHOLD = addon.db.profile.SINDRAGOSA_MYSTICBUFFET_THRESHOLD
    fail.HODIR_COLD_THRESHOLD = addon.db.profile.HODIR_COLD_THRESHOLD
    fail.BLOODPRINCES_FLAMES = addon.db.profile.BLOODPRINCES_FLAMES_THRESHOLD
end

function addon:MenuButtonRemove(info, input)
    if self.db.profile.announce == "CHANNEL" then
        whisper=self.db.profile.channelnumber
        target=self.db.profile.announce
    else
        target=self.db.profile.announce
    end
    local firstletter = input:sub(0,1):upper()
    local rest = input:sub(2)
    local p = firstletter..rest
    addon:RemoveFail(p,target,whisper)
end

function addon:OpenMenu(input)
    if input == "" then InterfaceOptionsFrame_OpenToCategory("EnsidiaFails")
    elseif input == "wipe" then
        addon:Wipe()
    elseif input=="reset" then
        addon:reset()
    elseif input=="oreset" then
        addon:oreset()
    elseif input:sub(0,6) == "remove" then
        if self.db.profile.announce == "CHANNEL" then
            whisper=self.db.profile.channelnumber
            target=self.db.profile.announce
        else
            target=self.db.profile.announce
        end
        if input:len() > 6 then
            local name = input:sub(8)
            local firstletter = name:sub(0,1):upper()
            local rest = name:sub(2)
            local p = firstletter..rest
            addon:RemoveFail(p,target,whisper)
        end
    elseif input=="stats" then
        addon:Stats(addon.db.profile.announce,"stats",addon.db.profile.channelnumber)
    elseif input=="ostats" then
        addon:Stats(addon.db.profile.announce,"ostats",addon.db.profile.channelnumber)
    end
end

function addon:SetChannelNumber(info, input)
    if input:find(L["general"]) or input:find(L["Trade"]) or input:find(L["LocalDefense"]) then return end
    self.db.profile.channelnumber = GetChannelName(input)
end

function addon:GetChannelNumber(input)
    return addon.db.profile.channelnumber
end

local defaults = {
----------------FAILS that are turned off by default
                Fail_Gunship_Explosion = false,
                Fail_Saurfang_Rune = false,
                Fail_Saurfang_Beasts = false,
                Fail_Deathwhisper_ShadeExplosion = false,
                Fail_Sindragosa_MysticBuffet = false,
----------------ADDITIONAL FAIL OPTIONS
----FIXED
                BLOODPRINCES_FLAMES_THRESHOLD = 25000,
                COUNCIL_RUNE_THRESHOLD = 3,
                COUNCIL_OVERLOAD_THRESHOLD = 5000,
                ALGALON_SMASH_THRESHOLD = 7000,
                ONYXIA_DEEPBREATH_THRESHOLD = 7000,
                EMALON_NOVA_THRESHOLD = 20000,
                VEZAX_LEECH_THRESHOLD = 350000,
                SINDRAGOSA_FROSTBOMB_THRESHOLD = 5000,
                SINDRAGOSA_MYSTICBUFFET_THRESHOLD = 14,
                HODIR_COLD_THRESHOLD = 2,
----STILL NEEDS FIXING
                hardened_bark_value = 50,
                natures_fury_combatlog_time = 0.3,
                natures_fury_move_time = 3,
                focused_anger_value = 50,
----------------NOT IN LIBFAIL YET
                natures_fury = true,
                overwhelming_power = true,
                hardened_bark = true,
                focused_anger = true,
                shadow_beacon_taunt = true,
----------------GENERAL OPTIONS
                disable_announce_override = false,
                AutoDeleteNewInstance = true,
                DeleteNewInstanceOnly = true,
                ConfirmDeleteInstance = false,
                DeleteJoinRaid = true,
                ConfirmDeleteRaid = false,
                noexceptions = false,
                stats_value = 10,
                stats_all = false,
                disabled = false,
                announce = "RAID",
                announce_style = "during_and_after",
                announce_after_style = "group_by_fails",
}

function addon:SetProfileDefaultFailValuesTrue()
    for i=1, #fail_events do
       defaults[fail_events[i]] = true
    end
end

addon:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        for _, event in ipairs(fail_events) do
            fail:RegisterCallback(event, onFail)
        end
        generate_boss_fail_table(fail_events)
        addon:SetProfileDefaultFailValuesTrue()
        if not tonumber(local_revision) then local_revision = 999 end
        addon:ScheduleTimer("InitPartyBasedDeletion", addon.InitPartyBasedDeletion, 2)
        local name = ...
        if name:lower() ~= "ensidiafails" then return end
        addon:Initialize()
        self.db = LibStub("AceDB-3.0"):New("EnsidiaFailsDB", { profile = defaults, },  "Default")

        local args = {
            type = "group",
            handler = self,
            get = function(info) return self.db.profile[info[1]] end,
            set = function(info, v) self.db.profile[info[1]] = v end,
            args = {
                desc = {
                    type = "description",
                    name = L["addon_desc"],
                    order = 1,
                    fontSize = "medium",
                },
                reset_header = {
                    type = "header",
                    name = L["reset"],
                    order = 70,
                },
                reset = {
                    order = 80,
                    type = "execute",
                    name = L["reset"],
                    desc = L["reset_desc"],
                    func = function()
                        addon:reset()
                    end
                },
                oreset = {
                    order = 80,
                    type = "execute",
                    name = L["oreset"],
                    desc = L["oreset_desc"],
                    func = function()
                        addon:oreset()
                    end
                },
                newline1 = {
                    type = "description",
                    name = "\n",
                    order = 81,
                },
                AutoDeleteNewInstance = {
                    type = "toggle",
                    name = L["Auto Delete New Instance"],
                    order = 82,
                },
                DeleteNewInstanceOnly = {
                    type = "toggle",
                    name = L["Delete New Instance Only"],
                    order = 83,
                    disabled = function() return not addon.db.profile.AutoDeleteNewInstance end,
                },
                ConfirmDeleteInstance = {
                    type = "toggle",
                    name = L["Confirm Delete Instance"],
                    order = 84,
                    disabled = function() return not addon.db.profile.AutoDeleteNewInstance end,
                },
                newline2 = {
                    type = "description",
                    name = "\n",
                    order = 85,
                },
                DeleteJoinRaid = {
                    type = "toggle",
                    name = L["Delete on Raid Join"],
                    order = 86,
                },
                ConfirmDeleteRaid  = {
                    type = "toggle",
                    name = L["Confirm Delete on Raid Join"],
                    order = 87,
                    disabled = function() return not addon.db.profile.DeleteJoinRaid end,
                },
                announce_header = {
                    type = "header",
                    name = L["announce"],
                    order = 100,
                },
                announce_style = {
                    order = 210,
                    type = "select",
                    name = L["announce_style"],
                    desc = L["announce_style_desc"],
                    values = announce_style,
                },
                announce_after_style = {
                  order = 210,
                    type = "select",
                    name = L["announce_after_style"],
                    desc = L["announce_after_style_desc"],
                    values = announce_after_style,
                    disabled = function() if addon.db.profile.announce_style == "during" then return true else return false end end,
                },
                announce = {
                    order = 210,
                    type = "select",
                    name = L["announce"],
                    desc = L["announce_desc"],
                    values = announce_to,
                },
                channel = {
                    order = 210,
                    type = "input",
                    name = L["Channel"],
                    desc = L["Channel"],
                    set = "SetChannelNumber",
                    get = "GetChannelNumber",
                },
                disabled = {
                    type = "toggle",
                    name = L["Disabled"],
                    order = 211,
                },
                disable_announce_override = {
                    type = "toggle",
                    name = L["Disable announce override"],
                    desc = L["Disallows accepting commands from other users that'd change the announcing settings"],
                    order = 212,
                },
                newline = {
                    type = "description",
                    name = "\n",
                    order = 213,
                },
                stats = {
                    order = 214,
                    type = "execute",
                    name = L["stats"],
                    desc = L["stats_desc"],
                    func = function()
                        addon:Stats(addon.db.profile.announce,"stats",addon.db.profile.channelnumber)
                    end
                },
                ostats = {
                    order = 218,
                    type = "execute",
                    name = L["ostats"],
                    desc = L["ostats_desc"],
                    func = function()
                        addon:Stats(addon.db.profile.announce,"ostats",addon.db.profile.channelnumber)
                    end
                },
                stats_value = {
                    type = "range",
                    order = 219,
                    name = L["Top X Stats"],
                    desc = L["Amount of entries to display"],
                    min = 1, max = 25, step = 1,
                    disabled = function() return addon.db.profile.stats_all end,
                },
                stats_all = {
                    type = "toggle",
                    name = L["Show all"],
                    order = 220    ,
                },
                remove_header = {
                    type = "header",
                    name = L["remove"],
                    order = 225,
                },
                menubuttonremove = {
                    order = 330,
                    type = "input",
                    name = L["remove"],
                    desc = L["remove_desc"],
                    set = "MenuButtonRemove",
                },
            },
        }

        LibStub("AceConfig-3.0"):RegisterOptionsTable("EnsidiaFails", args)
        LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("EnsidiaFails-Filter", self.GenerateFilterOptions)
        LibStub("AceConfigDialog-3.0"):AddToBlizOptions("EnsidiaFails", "EnsidiaFails")
        LibStub("AceConfigDialog-3.0"):AddToBlizOptions("EnsidiaFails-Filter", L["filter"], "EnsidiaFails")
        self:RegisterChatCommand("ef", "OpenMenu")
        self:RegisterChatCommand("EnsidiaFails", "OpenMenu")
        addon:InitializeCustomFailValues()
    elseif (event=="COMBAT_LOG_EVENT_UNFILTERED") then
        addon:CombatLog(event,...)
    elseif (event=="PLAYER_REGEN_ENABLED") then
        addon:KeepCheckingForWipe()
        if ((addon.db.profile.announce_style == "after") or (addon.db.profile.announce_style == "during_and_after")) then
            addon:AnnounceAfter()
        end
    elseif (event=="ZONE_CHANGED_NEW_AREA") then
        if addon.db.profile.AutoDeleteNewInstance == true then
            addon:DetectInstanceChange(event,...)
        end
    elseif (event=="RAID_ROSTER_UPDATE") then
        addon:PartyMembersChanged(event,...)
    elseif (event=="CHAT_MSG_ADDON") then
        addon:AddonMsgHandler(event,...)
    else--if event == "CHAT_MSG_RAID_LEADER" or "CHAT_MSG_RAID" or "CHAT_MSG_PARTY" or "CHAT_MSG_SAY" or "CHAT_MSG_GUILD" or "CHAT_MSG_CHANNEL" then
        addon:ChatEventHandler(event, ...)
    end
end)

function addon.GenerateFilterOptions()
    if not addon.FilterOptions then
        addon.GenerateFilterOptionsInternal()
        addon.GenerateFilterOptionsInternal = nil
        moduleFilterOptions = nil
    end
    return addon.FilterOptions
end

function addon.GenerateFilterOptionsInternal()
    addon.FilterOptions = {
        type = "group",
        name = "Filter",
        get = function(info) return addon.db.profile[ info[#info] ] end,
        set = function(info, value) addon.db.profile[ info[#info] ] = value end,
        args = {
            General = {
                order = 1,
                type = "group",
                name = L["general"],
                args = {
                    desc = {
                        type = "description",
                        name = L["filter_desc"],
                        order = 1,
                        fontSize = "large",
                        width = "full",
                    },
                    noexceptions = {
                        type = "toggle",
                        name = L["noexceptions"],
                        desc = L["noexceptions_desc"],
                        order = 10,
                    },
                },
            },
            TrialoftheCrusader = {
                order = 2,
                type = "group",
                name = BZ["Trial of the Crusader"],
                args = {
                    Gormok = {
                        order = 1,
                        type = "group",
                        name = BB["Gormok the Impaler"],
                        args = {
                        },
                    },
                    Acidmaw = {
                        order = 1,
                        type = "group",
                        name = BB["Acidmaw"],
                        args = {
                        },
                    },
                    Dreadscale = {
                        order = 1,
                        type = "group",
                        name = BB["Dreadscale"],
                        args = {
                        },
                    },
                    Icehowl = {
                        order = 1,
                        type = "group",
                        name = BB["Icehowl"],
                        args = {
                        },
                    },
                    Jaraxxus = {
                        order = 2,
                        type = "group",
                        name = BB["Lord Jaraxxus"],
                        args = {
                        },
                    },
                    FactionChampions = {
                        order = 3,
                        type = "group",
                        name = BB["Faction Champions"],
                        args = {
                        },
                    },
                    Valkyr = {
                        order = 4,
                        type = "group",
                        name = BB["The Twin Val'kyr"],
                        args = {
                        },
                    },
                    Anubarak = {
                        order = 5,
                        type = "group",
                        name = BB["Anub'arak"],
                        args = {
                        },
                    },
                },
            },
            Ulduar = {
                order = 3,
                type = "group",
                name = BZ["Ulduar"],
                args = {
                    Razorscale = {
                        order = 2,
                        type = "group",
                        name = BB["Razorscale"],
                        args = {
                        },
                    },
                    Ignis = {
                        order = 3,
                        type = "group",
                        name = BB["Ignis the Furnace Master"],
                        args = {
                        },
                    },
                    Deconstructor = {
                        order = 4,
                        type = "group",
                        name = BB["XT-002 Deconstructor"],
                        args = {
                        },
                    },
                    Council = {
                        order = 5,
                        type = "group",
                        name = BB["The Iron Council"],
                        args = {
                            COUNCIL_OVERLOAD_THRESHOLD = {
                                type = "range",
                                order = 25,
                                name = GetSpellInfo(61878),
                                desc = L["How much damage taken needed for a fail from "]..(GetSpellInfo(61878)),
                                min = 4000, max = 10000, step = 500,
                                disabled = function() return not addon.db.profile.Fail_Council_Overload end,
                                set = function(info, value) addon.db.profile[ info[#info] ],fail.COUNCIL_OVERLOAD_THRESHOLD = value,value end,
                            },
                            COUNCIL_RUNE_THRESHOLD = {
                                type = "range",
                                order = 35,
                                name = GetSpellInfo(63490),
                                desc = L["How much time do you have for moving before adding a fail for "]..(GetSpellInfo(63490)),
                                min = 1, max = 5, step = 1,
                                disabled = function() return not addon.db.profile.Fail_Council_RuneOfDeath end,
                                set = function(info, value) addon.db.profile[ info[#info] ],fail.COUNCIL_RUNE_THRESHOLD = value,value end,
                            },
                        },
                    },
                    Kologarn = {
                        order = 6,
                        type = "group",
                        name = BB["Kologarn"],
                        args = {
                        },
                    },
                    Auriaya = {
                        order = 7,
                        type = "group",
                        name = BB["Auriaya"],
                        args = {
                        },
                    },
                    Hodir = {
                        order = 8,
                        type = "group",
                        name = BB["Hodir"],
                        args = {
                            HODIR_COLD_THRESHOLD = {
                                type = "range",
                                order = 45,
                                name = GetSpellInfo(62039),
                                desc = L["How many stack is still not a fail"],
                                min = 2, max = 10, step = 1,
                                disabled = function() return not addon.db.profile.Fail_Hodir_BitingCold end,
                                set = function(info, value) addon.db.profile[ info[#info] ],fail.HODIR_COLD_THRESHOLD = value,value end,
                            },
                        },
                    },
                    Thorim = {
                        order = 9,
                        type = "group",
                        name = BB["Thorim"],
                        args = {
                        },
                    },
                    Freya = {
                        order = 10,
                        type = "group",
                        name = BB["Freya"],
                        args = {
                            hardened_bark = {
                                type = "toggle",
                                name = GetSpellInfo(64190),
                                order = 60,
                            },
                            hardened_bark_value = {
                                type = "range",
                                order = 65,
                                name = GetSpellInfo(64190),
                                desc = L["At how many stacks are you supposed to stop dps"],
                                min = 1, max = 99, step = 1,
                                disabled = function() return not addon.db.profile.hardened_bark end,
                            },
                            natures_fury = {
                                type = "toggle",
                                name = GetSpellInfo(63570),
                                order = 70,
                            },
                            natures_fury_combatlog_time = {
                                type = "range",
                                order = 72,
                                name = GetSpellInfo(63570),
                                desc = L["How close combatlog events have to be, when determining who failed"],
                                min = 0.1, max = 0.5, step = 0.05,
                                disabled = function() return not addon.db.profile.natures_fury end,
                            },
                            natures_fury_move_time = {
                                type = "range",
                                order = 75,
                                name = GetSpellInfo(63570),
                                desc = L["How much time do you have for moving before adding a fail for "]..(GetSpellInfo(63570)),
                                min = 1, max = 5, step = 1,
                                disabled = function() return not addon.db.profile.natures_fury end,
                            },
                        },
                    },
                    Mimiron = {
                        order = 11,
                        type = "group",
                        name = BB["Mimiron"],
                        args = {
                        },
                    },
                    Vezax = {
                        order = 12,
                        type = "group",
                        name = BB["General Vezax"],
                        args = {
                            VEZAX_LEECH_THRESHOLD = {
                                type = "range",
                                order = 45,
                                name = GetSpellInfo(63276),
                                desc = L["How much healing taken is still not a fail"],
                                min = 350000, max = 1000000, step = 50000,
                                disabled = function() return not addon.db.profile.Fail_Vezax_Leech end,
                                set = function(info, value) addon.db.profile[ info[#info] ],fail.VEZAX_LEECH_THRESHOLD = value,value end,
                            },
                        },
                    },
                    Yogg = {
                        order = 13,
                        type = "group",
                        name = BB["Yogg-Saron"],
                        args = {
                            shadow_beacon_taunt = {
                                type = "toggle",
                                name = GetSpellInfo(64465),
                                order = 55,
                            },
                            focused_anger = {
                                type = "toggle",
                                name = GetSpellInfo(57689),
                                order = 60,
                            },
                            focused_anger_value = {
                                type = "range",
                                order = 65,
                                name = GetSpellInfo(57689),
                                desc = L["At how many stacks are you supposed to stop dps"],
                                min = 1, max = 99, step = 1,
                                disabled = function() return not addon.db.profile.focused_anger end,
                            },
                        },
                    },
                    Algalon = {
                        order = 14,
                        type = "group",
                        name = BB["Algalon the Observer"],
                        args = {
                            ALGALON_SMASH_THRESHOLD = {
                                type = "range",
                                order = 45,
                                name = GetSpellInfo(62311),
                                desc = L["How much damage taken needed for a fail from "]..(GetSpellInfo(62311)),
                                min = 5000, max = 15000, step = 1000,
                                disabled = function() return not addon.db.profile.Fail_Algalon_CosmicSmash end,
                                set = function(info, value) addon.db.profile[ info[#info] ],fail.ALGALON_SMASH_THRESHOLD = value,value end,
                            },
                        },
                    },
                },
            },
            Naxxramas = {
                order = 4,
                type = "group",
                name = BZ["Naxxramas"],
                args = {
                    Patchwerk = {
                        order = 1,
                        type = "group",
                        name = BB["Patchwerk"],
                        args = {
                        },
                    },
                    Grobbulus = {
                        order = 2,
                        type = "group",
                        name = BB["Grobbulus"],
                        args = {
                        },
                    },
                    Heigan = {
                        order = 3,
                        type = "group",
                        name = BB["Heigan the Unclean"],
                        args = {
                        },
                    },
                    Thaddius = {
                        order = 4,
                        type = "group",
                        name = BB["Thaddius"],
                        args = {
                        },
                    },
                    Horsemen = {
                        order = 5,
                        type = "group",
                        name = BB["The Four Horsemen"],
                        args = {
                        },
                    },
                    Sapphiron = {
                        order = 6,
                        type = "group",
                        name = BB["Sapphiron"],
                        args = {
                        },
                    },
                    KelThuzad = {
                        order = 7,
                        type = "group",
                        name = BB["Kel'Thuzad"],
                        args = {
                        },
                    },
                },
            },
            Vault = {
                order = 5,
                type = "group",
                name = BZ["Vault of Archavon"],
                args = {
                    Archavon = {
                        order = 2,
                        type = "group",
                        name = BB["Archavon the Stone Watcher"],
                        args = {
                        },
                    },
                    Emalon = {
                        order = 2,
                        type = "group",
                        name = BB["Emalon the Storm Watcher"],
                        args = {
                            EMALON_NOVA_THRESHOLD = {
                                type = "range",
                                order = 25,
                                name = GetSpellInfo(65279),
                                desc = L["How much damage taken needed for a fail from "]..(GetSpellInfo(65279)),
                                min = 15000, max = 30000, step = 1000,
                                disabled = function() return not addon.db.profile.Fail_Emalon_LightningNova end,
                                set = function(info, value) addon.db.profile[ info[#info] ],fail.EMALON_NOVA_THRESHOLD = value,value end,
                            },
                        },
                    },
                    Koralon = {
                        order = 3,
                        type = "group",
                        name = BB["Koralon the Flame Watcher"],
                        args = {
                        },
                    },
                },
            },
            Sartharion = {
                order = 6,
                type = "group",
                name = BZ["The Obsidian Sanctum"],
                args = {
                    Sartharion = {
                        order = 1,
                        type = "group",
                        name = BB["Sartharion"],
                        args = {
                        },
                    },
                },
            },
            Onyxia = {
                order = 7,
                type = "group",
                name = BZ["Onyxia's Lair"],
                args = {
                    Onyxia = {
                        order = 1,
                        type = "group",
                        name = BB["Onyxia"],
                        args = {
                            ONYXIA_DEEPBREATH_THRESHOLD = {
                                type = "range",
                                order = 45,
                                name = L["Deep Breath"],
                                desc = L["How much damage taken needed for a fail from "]..L["Deep Breath"],
                                min = 5000, max = 15000, step = 500,
                                disabled = function() return not addon.db.profile.Fail_Onyxia_DeepBreath end,
                                set = function(info, value) addon.db.profile[ info[#info] ],fail.ONYXIA_DEEPBREATH_THRESHOLD = value,value end,
                            },
                        },
                    },
                },
            },
            Malygos = {
                order = 8,
                type = "group",
                name = BZ["The Eye of Eternity"],
                args = {
                    Malygos = {
                        order = 1,
                        type = "group",
                        name = BB["Malygos"],
                        args = {
                        },
                    },
                },
            },
            IcecrownCitadel = {
                order = 9,
                type = "group",
                name = BZ["Icecrown Citadel"],
                args = {
                    Marrowgar = {
                        order = 1,
                        type = "group",
                        name = BB["Lord Marrowgar"],
                        args = {
                        },
                    },
                    Deathwhisper = {
                        order = 2,
                        type = "group",
                        name = BB["Lady Deathwhisper"],
                        args = {
                        },
                    },
                    Gunship = {
                        order = 3,
                        type = "group",
                        name = BB["Icecrown Gunship Battle"],
                        args = {
                        },
                    },
					Saurfang = {
                        order = 4,
                        type = "group",
                        name = BB["Deathbringer Saurfang"],
                        args = {
                        },
                    },
                    Festergut = {
                        order = 5,
                        type = "group",
                        name = BB["Festergut"],
                        args = {
                        },
                    },
                    Rotface = {
                        order = 6,
                        type = "group",
                        name = BB["Rotface"],
                        args = {
                        },
                    },
                    Professor = {
                        order = 7,
                        type = "group",
                        name = BB["Professor Putricide"],
                        args = {
                        },
                    },
                    BloodPrinces = {
                        order = 8,
                        type = "group",
                        name = BB["Blood Princes"],
                        args = {
                            BLOODPRINCES_FLAMES_THRESHOLD = {
                                type = "range",
                                order = 1,
                                name = GetSpellInfo(72789),
                                desc = L["How much damage taken needed for a fail from "]..GetSpellInfo(72789),
                                min = 10000, max = 25000, step = 500,
                                disabled = function() return not addon.db.profile.Fail_BloodPrinces_Flames end,
                                set = function(info, value) addon.db.profile[ info[#info] ],fail.BLOODPRINCES_FLAMES_THRESHOLD = value,value end,
                            },
                        },
                    },
                    LanaThel = {
                        order = 9,
                        type = "group",
                        name = BB["Blood-Queen Lana'thel"],
                        args = {
                        },
                    },
                    Valithria = {
                        order = 10,
                        type = "group",
                        name = BB["Valithria Dreamwalker"],
                        args = {
                        },
                    },
                    Sindragosa = {
                        order = 11,
                        type = "group",
                        name = BB["Sindragosa"],
                        args = {
                            SINDRAGOSA_FROSTBOMB_THRESHOLD = {
                                type = "range",
                                order = 1,
                                name = GetSpellInfo(69846),
                                desc = L["How much damage taken needed for a fail from "]..GetSpellInfo(69846),
                                min = 3000, max = 15000, step = 1000,
                                disabled = function() return not addon.db.profile.Fail_Sindragosa_FrostBomb end,
                                set = function(info, value) addon.db.profile[ info[#info] ],fail.SINDRAGOSA_FROSTBOMB_THRESHOLD = value,value end,
                            },
                            SINDRAGOSA_MYSTICBUFFET_THRESHOLD = {
                                type = "range",
                                order = 1,
                                name = GetSpellInfo(70127),
                                desc = L["How many stack is still not a fail"],
                                min = 1, max = 50, step = 1,
                                disabled = function() return not addon.db.profile.Fail_Sindragosa_MysticBuffet end,
                                set = function(info, value) addon.db.profile[ info[#info] ],fail.SINDRAGOSA_MYSTICBUFFET_THRESHOLD = value,value end,
                            },
                        },
                    },
                    TheLichKing = {
                        order = 12,
                        type = "group",
                        name = BB["The Lich King"],
                        args = {
                        },
                    },
                },
            },
            RubySanctum = {
                order = 10,
                type = "group",
                name = BZ["The Ruby Sanctum"],
                args = {
                    Halion = {
                        order = 1,
                        type = "group",
                        name = BB["Halion"],
                        args = {
                        },
                    },
                },
            },
        }
    }

    for j=1, #zone_list do
        boss_list = generate_boss_name_table_by_zone(zone_list[j])
        for i=1, #boss_list do
            addon:generate_options_table_by_boss(optionsmenu_zone_list[j],boss_list[i])
        end
    end

end

function addon:generate_options_table_by_boss(zone,boss)
    for i=1, #boss_fail_table[boss] do
        addon.FilterOptions.args[zone]["args"][boss]["args"][boss_fail_table[boss][i]] = {
            type = "toggle",
            name = addon:generate_name_for_special_fails(boss_fail_table[boss][i])
        }
    end
end

function addon:generate_name_for_special_fails(failname)
    local name = nil
    for i=1, #sensitive_fail_list do
        if failname == sensitive_fail_list[i] then
            name = GetSpellInfo(fail:GetEventSpellId(failname)).." "..L["sensitive"]
        elseif failname == "Fail_Onyxia_Cleave" then
            name = "Onyxia "..GetSpellInfo(fail:GetEventSpellId(failname))
        elseif failname == "Fail_Valkyr_Vortex" then
            name = function() if GetLocale() == "deDE" then return (GetSpellInfo(66046)):sub(0,5).."/"..(GetSpellInfo(66058)) else return (GetSpellInfo(66046)):sub((GetSpellInfo(66046)):find("^.*%s")).."/ "..(GetSpellInfo(66058)) end end
        elseif failname == "Fail_Valkyr_Orb" then
            name = (GetSpellInfo(67174)).."/"..(GetSpellInfo(67240)):sub(((GetSpellInfo(67240)):find('%s'))+1)
        else
            name = GetSpellInfo(fail:GetEventSpellId(failname))
        end
    end
    return name
end

function addon:ChatEventHandler(event, ...)
    local msg,sender,_,_,target,_,_,channelnum = ...
    msg = msg:lower()
    if event == "CHAT_MSG_RAID_LEADER" then
        if msg:find("!wipe") then
            addon:Wipe()
        end
    elseif event == "CHAT_MSG_RAID" then
        if msg:find("!wipe") then
            addon:Wipe()
        end
    elseif event == "CHAT_MSG_CHANNEL" then
        local _,channelname = GetChannelName(channelnum)
        if channelname then
            if channelname:find(L["general"]) or channelname:find(L["Trade"]) or channelname:find(L["LocalDefense"]) then return end
        end
        if msg:find("!stats") then
            target = event:sub(10)
            local Time = GetTime()
            if LastTime == nil then
                LastTime = Time
                addon:Stats(target,"stats",channelnum)
            elseif LastTime+10.000 < Time then
                addon:Stats(target,"stats",channelnum)
                LastTime=nil
            end
        elseif msg:find("!ostats") then
            target = event:sub(10)
            local Time = GetTime()
            if LastTime == nil then
                LastTime = Time
                addon:Stats(target,"ostats",channelnum)
            elseif LastTime+10.000 < Time then
                addon:Stats(target,"ostats",channelnum)
                LastTime=nil
            end
        end
    end
    if msg:find("!stats") then
        target = event:sub(10)
        if target == "RAID_LEADER" then
            target = "RAID"
        end
        local Time = GetTime()
        if LastTime == nil then
            LastTime = Time
            addon:Stats(target,"stats",channelnum)
        elseif LastTime+10.000 < Time then
            addon:Stats(target,"stats",channelnum)
            LastTime=nil
        end
    elseif msg:find("!ostats") then
        target = event:sub(10)
        if target == "RAID_LEADER" then
            target = "RAID"
        end
        local Time = GetTime()
        if LastTime == nil then
            LastTime = Time
            addon:Stats(target,"ostats",channelnum)
        elseif LastTime+10.000 < Time then
            addon:Stats(target,"ostats",channelnum)
            LastTime=nil
        end
    end
end


addon:RegisterEvent("PLAYER_REGEN_ENABLED")
addon:RegisterEvent("ADDON_LOADED")
addon:RegisterEvent("CHAT_MSG_RAID")
addon:RegisterEvent("CHAT_MSG_RAID_LEADER")
addon:RegisterEvent("CHAT_MSG_PARTY")
addon:RegisterEvent("CHAT_MSG_SAY")
addon:RegisterEvent("CHAT_MSG_GUILD")
addon:RegisterEvent("CHAT_MSG_CHANNEL")
addon:RegisterEvent("CHAT_MSG_ADDON")
addon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "CombatLog")
addon:RegisterEvent("ZONE_CHANGED_NEW_AREA","DetectInstanceChange") -- Elsia: This is needed for zone change deletion and collection
addon:RegisterEvent("RAID_ROSTER_UPDATE","PartyMembersChanged")

--Ripped from Ora
function addon:SetupFrames()
    if check then return end

    local f = GameFontNormal:GetFont()

    check = CreateFrame("Frame", nil, UIParent)
    check:Hide()
    check:SetWidth(325)
    check:SetHeight(125)
    check:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
        insets = {left = 4, right = 4, top = 4, bottom = 4},
    })
    check:SetBackdropBorderColor(.5, .5, .5)
    check:SetBackdropColor(0,0,0)
    check:ClearAllPoints()
    check:SetPoint("CENTER", WorldFrame, "CENTER", 0, 0)

    local cfade = check:CreateTexture(nil, "BORDER")
    cfade:SetWidth(319)
    cfade:SetHeight(25)
    cfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
    cfade:SetPoint("TOP", check, "TOP", 0, -4)
    cfade:SetBlendMode("ADD")
    cfade:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .25, .25, .25, 1)

    header = check:CreateFontString(nil,"OVERLAY")
    header:SetFont(f, 14)
    header:SetWidth(300)
    header:SetText("header")
    header:SetTextColor(1, .8, 0)
    header:ClearAllPoints()
    header:SetPoint("TOP", check, "TOP", 0, -10)

    info = check:CreateFontString(nil,"OVERLAY")
    info:SetFont(f, 10)
    info:SetWidth(300)
    info:SetText("info")
    info:SetTextColor(1, .8, 0)
    info:ClearAllPoints()
    info:SetPoint("TOP", header, "BOTTOM", 0, -10)

    leftButton = CreateFrame("Button", nil, check)
    leftButton:SetWidth(125)
    leftButton:SetHeight(32)
    leftButton:SetPoint("RIGHT", check, "CENTER", -10, -20)

    local t = leftButton:CreateTexture()
    t:SetWidth(125)
    t:SetHeight(32)
    t:SetPoint("CENTER", leftButton, "CENTER")
    t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
    t:SetTexCoord(0, 0.625, 0, 0.6875)
    leftButton:SetNormalTexture(t)

    t = leftButton:CreateTexture(nil, "BACKGROUND")
    t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down")
    t:SetTexCoord(0, 0.625, 0, 0.6875)
    t:SetAllPoints(leftButton)
    leftButton:SetPushedTexture(t)

    t = leftButton:CreateTexture()
    t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
    t:SetTexCoord(0, 0.625, 0, 0.6875)
    t:SetAllPoints(leftButton)
    t:SetBlendMode("ADD")
    leftButton:SetHighlightTexture(t)
    leftButtonText = leftButton:CreateFontString(nil,"OVERLAY")
    leftButtonText:SetFontObject(GameFontHighlight)
    leftButtonText:SetText("left")
    leftButtonText:SetAllPoints(leftButton)

    rightButton = CreateFrame("Button", nil, check)
    rightButton:SetWidth(125)
    rightButton:SetHeight(32)
    rightButton:SetPoint("LEFT", check, "CENTER", 10, -20)

    t = rightButton:CreateTexture()
    t:SetWidth(125)
    t:SetHeight(32)
    t:SetPoint("CENTER", rightButton, "CENTER")
    t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
    t:SetTexCoord(0, 0.625, 0, 0.6875)
    rightButton:SetNormalTexture(t)

    t = rightButton:CreateTexture(nil, "BACKGROUND")
    t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down")
    t:SetTexCoord(0, 0.625, 0, 0.6875)
    t:SetAllPoints(rightButton)
    rightButton:SetPushedTexture(t)

    t = rightButton:CreateTexture()
    t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
    t:SetTexCoord(0, 0.625, 0, 0.6875)
    t:SetAllPoints(rightButton)
    t:SetBlendMode("ADD")
    rightButton:SetHighlightTexture(t)
    rightButtonText = rightButton:CreateFontString(nil,"OVERLAY")
    rightButtonText:SetFontObject(GameFontHighlight)
    rightButtonText:SetText("right")
    rightButtonText:SetAllPoints(rightButton)
end

local function hideCheck()
    check:Hide()
end

function addon:ShowReset()
    self:SetupFrames()

    header:SetText(L["Reset EnsidiaFails?"])
    info:SetText(L["Reset Data?"])
    leftButtonText:SetText(L["Yes"])
    rightButtonText:SetText(L["No"])

    leftButton:SetScript("OnClick", function()
        self:reset()
        check:Hide()
    end)
    rightButton:SetScript("OnClick", function()
        check:Hide()
    end)
    check:Show()

    self:ScheduleTimer("Reset_HideCheck", hideCheck, 10)
end

local broadcast_version = {}
function addon:AddonMsgHandler(event,...)
    if select(2, IsInInstance()) == "pvp" then return end
    local prefix, msg, channel, sender = ...
    if prefix == "EnsidiaFails" and channel == "RAID" and UnitInRaid(sender) then
        --print(string.format("[%s] [%s]: %s", channel,sender,msg))
        if msg:find("revision") then
            broadcast_version[sender] = tonumber(msg:match("[%d]+"))
            addon:CheckForSelfPartyMembersChange()
            addon:ScheduleTimer("Versioncheck", addon.Versioncheck, 2)
        elseif msg:find("NOTChanged") then
            if addon:IsTimerScheduled("Versioncheck") then addon:CancelTimer("Versioncheck") end
        end
    end
end

function addon:Versioncheck()
    local v_sorttable = {}
    for k,v in pairs(broadcast_version) do
        table.insert(v_sorttable, {v..";"..k})
    end
    table.sort(v_sorttable,function(a,b) return a[1] > b[1] end)
    if broadcast_version == nil then --[[print("broadcast_version")]] return end
    if v_sorttable == nil then --[[print("v_sorttable")]] return end
    if v_sorttable[1] == nil then --[[print("v_sorttable[1]")]] return end
    if v_sorttable[1][1] == nil then --[[print("v_sorttable[1][1]")]] return end
    local delimiter_index = (v_sorttable[1][1]):find(";")
    local name = (v_sorttable[1][1]):sub(delimiter_index+1,(v_sorttable[1][1]):len())
    local new_version = (v_sorttable[1][1]):sub(1,delimiter_index-1)
    if name == UnitName("player") then
        if addon.db.profile.disabled and not addon.db.profile.disable_announce_override then
            addon.db.profile.disabled = false
            print("|cFF00FFFFEnsidiaFails: |r"..L["Announcing Enabled! YOU are the main announcer for EnsidiaFails, please check your announcing settings"])
        end
    else
        if not addon.db.profile.disabled and not addon.db.profile.disable_announce_override then
            addon.db.profile.disabled = true
            if new_version == local_revision then
                print(("|cFF00FFFFEnsidiaFails: |r"..L["Announcing Disabled! %s is the main announcer. (He/She has the same version as you (%s))"]) :format(name,local_revision))
            else
                print(("|cFF00FFFFEnsidiaFails: |r"..L["Announcing Disabled! %s is the main announcer. (Please consider updating your addon his/her version was %s)(yours: %s)"]):format(name,new_version,local_revision))
            end
        end
    end
end

function addon:SendRevision()
    if select(2, IsInInstance()) == "pvp" then return end
    SendAddonMessage("EnsidiaFails", "revision "..local_revision, "RAID")
end

function addon:CheckForSelfPartyMembersChange()
    if self_party_members_changed == false then
        if select(2, IsInInstance()) == "pvp" then return end
        SendAddonMessage("EnsidiaFails", "NOTChanged", "RAID")
    end
end

function addon:StartSync()
    self_party_members_changed = true
    addon:SendRevision()
    addon:ScheduleTimer("PartyMembersChangedTimout", addon.PartyMembersChangedTimout, 4)
end

function addon:PartyMembersChangedTimout()
    self_party_members_changed = false
    broadcast_version = {}
end

-- Majorly ripped from Recount
function addon:PartyMembersChanged(event,...)

    addon:StartSync()

    if not next(EnsidiaFails_FailCount,nil) then return end
    local NumRaidMembers = GetNumRaidMembers()

    if addon.db.profile.DeleteJoinRaid and not addon.inRaid and NumRaidMembers > 0 then
        if addon.db.profile.ConfirmDeleteRaid then
            addon:ShowReset() -- Elsia: Confirm & Delete!
        else
            addon:reset()        -- Elsia: Delete!
        end
    end

    local change = false

    if NumRaidMembers > 0 or UnitInRaid("player") then
        change = change or not addon.inRaid
       addon.inRaid = true
    else
        change = change or addon.inRaid
        addon.inRaid = false
    end

    end

function addon:InitPartyBasedDeletion()
    local NumRaidMembers = GetNumRaidMembers()

    addon.inRaid = false

    if NumRaidMembers > 0 then addon.inRaid = true end
end

function addon:ReleasePartyBasedDeletion()
    if addon.db.profile.DeleteJoinRaid == false then
        addon:UnregisterEvent("RAID_ROSTER_UPDATE")
    end
end

function addon:DetectInstanceChange(event,...) -- Elsia: With thanks to Loggerhead

    local zone = GetRealZoneText()

    if zone == nil or zone == "" then
        -- zone hasn't been loaded yet, try again in 5 secs.
        addon:ScheduleTimer("DetectInstanceChange",addon.DetectInstanceChange,5)
        return
    end

    --addon:UpdateZoneGroupFilter()


    if addon.db.profile.AutoDeleteNewInstance == false then return end

    if not next(EnsidiaFails_FailCount,nil) then return end

    local inInstance = IsInInstance()

    if inInstance and (not addon.db.profile.DeleteNewInstanceOnly or LastInstanceName ~= zone) then
        if addon.db.profile.ConfirmDeleteInstance == true then
            addon:ShowReset() -- Elsia: Confirm & Delete!
        else
            addon:reset()        -- Elsia: Delete!
        end
        if not UnitIsGhost("player") then LastInstanceName = zone end-- Elsia: We'll set the instance even if the user opted to not delete...
    end
end

addon:ScheduleTimer("DetectInstanceChange",addon.DetectInstanceChange,5) -- Elsia: We need to do this regardless for Zone filtering.

-- local variables --
local wipe_called = false
local GetSpellInfo = GetSpellInfo
local LastTime = nil
local whisper, target = nil, nil
local self_party_members_changed = false
local LastInstanceName = ""
local brain_stun = false
local searing_applied = nil
local hardened_bark = false
local focused_anger = false
local event_fails ={}
local sorttable ={}
local failed_at={}
local FailsForTheSession = {}
local fury_on = nil
local fury_on1 = nil
local fury_on2 = nil
local LastEvent1 = {}
local LastEvent3 = nil
local LastEvent2 = {}
local ChargeCounter = {}

function addon:Stats(target, stat, whisper)
    local Count = nil
    if stat == "ostats" then
        Count = EnsidiaFails_OFailCount
    else
        Count = EnsidiaFails_FailCount
    end
    local count,players=0,0
    local sorttable={}
    for k,v in pairs(Count) do
        count = count + v
        players = players + 1
        table.insert(sorttable, {k,v})
    end
    if (players == 0) then
        if addon.db.profile.announce == "SELF" then
            DEFAULT_CHAT_FRAME:AddMessage(L["nobody_failed"])
        else
            SendChatMessage(L["nobody_failed"],target, nil, whisper)
        end
    else
        table.sort(sorttable,function(a,b) return a[2] > b[2] end)
        if addon.db.profile.announce == "SELF" then
            DEFAULT_CHAT_FRAME:AddMessage(L["we_have"]..count..L["fails_on"]..players..L["diff..."])
        else
            SendChatMessage(L["we_have"]..count..L["fails_on"]..players..L["diff..."],target, nil, whisper)
        end
        local b,amount=1,addon.db.profile.stats_value
        if addon.db.profile.stats_all then
            amount = #sorttable
        end
        for k,v in ipairs(sorttable) do
            if (b <= amount) then
                if b == 1 then
                    if stat == "ostats" then
                        if addon.db.profile.announce == "SELF" then
                            DEFAULT_CHAT_FRAME:AddMessage(L["admiral"]..v[1]..L["failed"]..v[2].."x ("..string.format("%02.1f",v[2]/count*100).."%)")
                        else
                            SendChatMessage(L["admiral"]..v[1]..L["failed"]..v[2].."x ("..string.format("%02.1f",v[2]/count*100).."%)",target, nil, whisper)
                        end
                    else
                        if addon.db.profile.announce == "SELF" then
                            DEFAULT_CHAT_FRAME:AddMessage(L["captain"]..v[1]..L["failed"]..v[2].."x ("..string.format("%02.1f",v[2]/count*100).."%)")
                        else
                            SendChatMessage(L["captain"]..v[1]..L["failed"]..v[2].."x ("..string.format("%02.1f",v[2]/count*100).."%)",target, nil, whisper)
                        end
                    end
                else
                    if addon.db.profile.announce == "SELF" then
                        DEFAULT_CHAT_FRAME:AddMessage(b..". "..v[1]..L["failed"]..v[2].."x ("..string.format("%02.1f",v[2]/count*100).."%)")
                    else
                        SendChatMessage(b..". "..v[1]..L["failed"]..v[2].."x ("..string.format("%02.1f",v[2]/count*100).."%)",target, nil, whisper)
                    end
                end
            end
            b=b+1
        end
        if (GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0) then
            local r,name={},""
            if (GetNumRaidMembers() > 0) then
                for i=1,GetNumRaidMembers() do
                    name=GetRaidRosterInfo(i)
                    if (Count[name] == nil) then
                        table.insert(r,name)
                    end
                end
            else
                for i=1,GetNumPartyMembers() do
                    name = UnitName("party"..i)
                    if (Count[name] == nil) then
                        table.insert(r,name)
                    end
                end
                name = UnitName("player")
                if (Count[name] == nil) then
                    table.insert(r,name)
                end
            end
            if addon.db.profile.announce == "SELF" then
                DEFAULT_CHAT_FRAME:AddMessage(L["didnt_fail"]..table.concat(r,", "))
            else
                SendChatMessage(L["didnt_fail"]..table.concat(r,", "),target, nil, whisper)
            end
        end
    end
end

local debug = false
--[===[@debug@
function addon:Debug()
    if debug then
        debug = false
    else
        debug = true
    end
end
--@end-debug@]===]
    LastEvent = {}

    -- Last whatever
    for i=1, #fail_events do
        LastEvent[fail_events[i]] = {}
    end
    
function addon:CombatLog(event,...)
    local timestamp, type, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = ...

    if (sourceName=="Mirror Image") or (destName=="Mirror Image") then
        return;
    end
--------------------------------------------------------------------------------
--------------------    DEBUG EVENTS    ----------------------------------------
--------------------------------------------------------------------------------



if debug then
    if timestamp then
        local temp_stamp = tostring(timestamp)
        if temp_stamp:find(":") then
            local hour = temp_stamp:sub(1,2)
            local minute = temp_stamp:sub(4,5)
            local sec = temp_stamp:sub(7,8)
            local milisec = temp_stamp:sub(9)
            timestamp = tonumber("10000"..hour*3600+minute*60+sec..milisec)
        end
    end

    if (type=="SPELL_AURA_APPLIED") then
        local spellId = select(9,...)
        if ((spellId==1987911111) or (spellId==198801111)) then
            print("debug1")
            addon:AddFail(destName,"blabla",spellId)
    elseif (spellId == 19879 or spellId == 19880) then
        print("event recognized "..destName)
        
        if LastEvent.Fail_Koralon_FlameCinder[destName] ~= nil then        
            deltaT = (timestamp - LastEvent.Fail_Koralon_FlameCinder[destName])
            print("not the very first time deltaT: "..deltaT)
            if (((deltaT) > 3) and ((deltaT) < 6)) then--If >3 times threshold reset timestamp since it's probably from earlier fight and not genuine fail.
                addon:AddFail(destName, "wrongplace", spellId)
    	    else
                print("parameteren kivuli ertek")
                LastEvent.Fail_Koralon_FlameCinder[destName] = timestamp
            end
        else
            print("nil")
        end
        
        
        LastEvent.Fail_Koralon_FlameCinder[destName] = timestamp
        harr = timestamp
        print(LastEvent.Fail_Koralon_FlameCinder[destName])

        return
    elseif spellId==696 or spellId==28189 then
            print(LGT:GetUnitRole(destName))
                --addon:AddFail(destName,"blabla",spellId)
        end
    end

    if (type=="SPELL_CAST_START") then
        local spellId = select(9,...)
        if (spellId==635) then
            print("debug2")
            addon:AddFail(sourceName,L["shaman_healing"],635)
        end
    end

    if type=="SPELL_CAST_SUCCESS" then
        local spellId = select(9,...)
        if (spellId==20154) then
            addon:AddFail(sourceName,"SEAL",20154)
        end
    end


    if (type=="SPELL_CAST_START") then
        local spellId = select(9,...)
        if ((spellId==49273) or (spellId==49276)) then
            addon:AddFail(sourceName,L["shaman_healing"],spellId)
        end
    end

    if (type=="SPELL_CAST_START") then
        local spellId = select(9,...)
        if (spellId==55459) then
            addon:AddFail(sourceName,L["moving"].."( "..L["Frost Bomb"]..")",spellId)
        end
    end

    if (type=="SPELL_DAMAGE") then
        local spellId = select(9,...)
        if (spellId=="Earth Shock") then
            if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
                addon:AddFail(destName,"ETest",spellId)
            end
        end
    end

    if (type=="SPELL_DAMAGE") then
        local spellId = select(9,...)
        if ((spellId==49236) or (spellId==49231)) then
            if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
                addon:AddFail(destName,"FTest",spellId)
            end
        end
    end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


----------------
---- ULDUAR ----
----------------

if (type=="SPELL_MISSED") or (type=="SPELL_DAMAGE") then
    local spellId,_,_,amount,overkill = select(9,...)
    if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
--6/8 20:57:56.781  SPELL_DAMAGE,0x0000000000000000,nil,0x80000000,0x0300000002289DD9,"Spritzor",0x512,62590,"Nature's Fury",0x8,4272,0,8,0,0,0,nil,nil,nil
--6/4 20:54:31.468  SPELL_DAMAGE,0x0000000000000000,nil,0x80000000,0xF14052F12D001360,"Flaadhun",0x1114,63570,"Nature's Fury",0x8,1577,0,8,951,0,0,nil,nil,nil
-- Nature's Fury -- Freya
        if ((spellId==62590) or (spellId==63570)) then
            if addon.db.profile.natures_fury then
                local roots = GetSpellInfo(62861)
                local debuff_name, debuff_name1, debuff_name2 = nil, nil, nil
                if fury_on then
                    debuff_name = UnitDebuff(fury_on, roots)
                elseif fury_on1 then
                    debuff_name1 = UnitDebuff(fury_on1, roots)
                elseif fury_on2 then
                    debuff_name2 = UnitDebuff(fury_on2, roots)
                end

                if (destName == fury_on) then            -- 1st guy is taking damage
                    if LastEvent1[fury_on] then                -- someone already took damage
                        if (timestamp - LastEvent1[fury_on]) < addon.db.profile.natures_fury_combatlog_time then     --someone took damage from the 1st guy just before he took damage
                            if LastEvent2[fury_on] == nil then        -- 1st time the 1st guy takes damage
                                LastEvent2[fury_on] = timestamp
                            else
                                if (timestamp - LastEvent2[fury_on]) > addon.db.profile.natures_fury_move_time or (timestamp - ChargeCounter[fury_on]) > addon.db.profile.natures_fury_move_time then    -- 1st guy had at least 3 sec to move
                                    if debuff_name ~= roots then
                                        addon:AddFail(fury_on,L["moving"],spellId)
                                        ChargeCounter[fury_on] = timestamp
                                    end
                                end
                            end
                        end
                    end
                    LastEvent2[fury_on] = timestamp
                else            -- not the 1st guy is taking damage
                    if fury_on then
                        if LastEvent1[fury_on] == nil then  -- 1st time someone else took damage
                            LastEvent1[fury_on] = timestamp
                        else                    -- not the 1st guy and not the 1st time someone else took damage
                            if LastEvent2[fury_on] then        -- 1st guy already took damage
                                if (timestamp - LastEvent2[fury_on]) < addon.db.profile.natures_fury_combatlog_time then -- 1st guy took took damage just before he took damage
                                    if (timestamp - ChargeCounter[fury_on]) > addon.db.profile.natures_fury_move_time then -- antispam, someone took damage, and it was 3 sec ago that 1st guy damaged 1 guy
                                        if debuff_name ~= roots then
                                            addon:AddFail(fury_on,L["moving"],spellId)
                                            ChargeCounter[fury_on] = LastEvent2[fury_on] -- store the last time this happened
                                        end
                                    end
                                end
                            end
                            LastEvent1[fury_on] = timestamp -- regardless if the 1st guy took damage or not, store when someone else took damage
                        end
                    end
                end

                if (destName == fury_on1) then            -- 2nd guy is taking damage
                    if LastEvent1[fury_on1] then                -- someone already took damage
                        if (timestamp - LastEvent1[fury_on1]) < addon.db.profile.natures_fury_combatlog_time then     --someone took damage from the 2nd guy just before he took damage
                            if LastEvent2[fury_on1] == nil then        -- 1st time the 2nd guy takes damage
                                LastEvent2[fury_on1] = timestamp
                            else
                                if (timestamp - LastEvent2[fury_on1]) > addon.db.profile.natures_fury_move_time or (timestamp - ChargeCounter[fury_on1]) > addon.db.profile.natures_fury_move_time then    -- 2nd guy had at least 3 sec to move
                                    if debuff_name1 ~= roots then
                                        addon:AddFail(fury_on1,L["moving"],spellId)
                                        ChargeCounter[fury_on1] = timestamp
                                    end
                                end
                            end
                        end
                    end
                    LastEvent2[fury_on1] = timestamp
                else            -- not the 2nd guy is taking damage
                    if fury_on1 then

                        if LastEvent1[fury_on1] == nil then  -- 1st time someone else took damage
                            LastEvent1[fury_on1] = timestamp
                        else                    -- not the 2nd guy and not the 1st time someone else took damage
                            if LastEvent2[fury_on1] then        -- 2nd guy already took damage
                                if (timestamp - LastEvent2[fury_on1]) < addon.db.profile.natures_fury_combatlog_time then -- 2nd guy took took damage just before he took damage
                                    if (timestamp - ChargeCounter[fury_on1]) > addon.db.profile.natures_fury_move_time then -- antispam, someone took damage, and it was 3 sec ago that 2nd guy damaged 1 guy
                                        if debuff_name1 ~= roots then
                                            addon:AddFail(fury_on1,L["moving"],spellId)
                                            ChargeCounter[fury_on1] = LastEvent2[fury_on1] -- store the last time this happened
                                        end
                                    end
                                end
                            end
                            LastEvent1[fury_on1] = timestamp -- regardless if the 2nd guy took damage or not, store when someone else took damage
                        end
                    end
                end

                if (destName == fury_on2) then            -- 3rd guy is taking damage
                    if LastEvent1[fury_on2] then                -- someone already took damage
                        if (timestamp - LastEvent1[fury_on2]) < addon.db.profile.natures_fury_combatlog_time then     --someone took damage from the 3rd guy just before he took damage
                            if LastEvent2[fury_on2] == nil then        -- 1st time the 3rd guy takes damage
                                LastEvent2[fury_on2] = timestamp
                            else
                                if (timestamp - LastEvent2[fury_on2]) > addon.db.profile.natures_fury_move_time or (timestamp - ChargeCounter[fury_on2]) > addon.db.profile.natures_fury_move_time then    -- 3rd guy had at least 3 sec to move
                                    if debuff_name2 ~= roots then
                                        addon:AddFail(fury_on2,L["moving"],spellId)
                                        ChargeCounter[fury_on2] = timestamp
                                    end
                                end
                            end
                        end
                    end
                    LastEvent2[fury_on2] = timestamp
                else            -- not the 3rd guy is taking damage
                    if fury_on2 then

                        if LastEvent1[fury_on2] == nil then  -- 1st time someone else took damage
                            LastEvent1[fury_on2] = timestamp
                        else                    -- not the 3rd guy and not the 1st time someone else took damage
                            if LastEvent2[fury_on2] then        -- 3rd guy already took damage
                                if (timestamp - LastEvent2[fury_on2]) < addon.db.profile.natures_fury_combatlog_time then -- 3rd guy took took damage just before he took damage
                                    if (timestamp - ChargeCounter[fury_on2]) > addon.db.profile.natures_fury_move_time then -- antispam, someone took damage, and it was 3 sec ago that 3rd guy damaged 1 guy
                                        if debuff_name2 ~= roots then
                                            addon:AddFail(fury_on2,L["moving"],spellId)
                                            ChargeCounter[fury_on2] = LastEvent2[fury_on2] -- store the last time this happened
                                        end
                                    end
                                end
                            end
                            LastEvent1[fury_on2] = timestamp -- regardless if the 3rd guy took damage or not, store when someone else took damage
                        end
                    end
                end
            end
        end
    end
end

if (type=="SPELL_AURA_APPLIED_DOSE") then
    local spellId,_,_,_,stack = select(9,...)
---- FREYA ----
--6/10 21:54:38.953  SPELL_AURA_APPLIED_DOSE,0xF1300080940356BC,"Snaplasher",0xa48,0xF1300080940356BC,"Snaplasher",0xa48,64190,"Hardened Bark",0x1,BUFF,84
--6/8 20:56:06.781  SPELL_AURA_APPLIED_DOSE,0xF130008094007DBD,"Snaplasher",0xa48,0xF130008094007DBD,"Snaplasher",0xa48,62663,"Hardened Bark",0x1,BUFF,2
    if ((spellId == 64190) or (spellId==62663)) and stack > addon.db.profile.hardened_bark_value then
        if addon.db.profile.hardened_bark then
            hardened_bark = true
        end
---- YOGG-SARON ----
--6/8 21:59:13.015  SPELL_AURA_APPLIED_DOSE,0xF1300084AE00BD56,"Crusher Tentacle",0xa48,0xF1300084AE00BD56,"Crusher Tentacle",0xa48,57689,"Focused Anger",0x1,BUFF,3
--6/15 21:05:29.765  SPELL_AURA_APPLIED_DOSE,0xF1300084AE000650,"Crusher Tentacle",0xa48,0xF1300084AE000650,"Crusher Tentacle",0xa48,57689,"Focused Anger",0x1,BUFF,6
    elseif (spellId==57689) and stack > addon.db.profile.focused_anger_value then
        if addon.db.profile.focused_anger then
            focused_anger = true
        end
    end
end

if (type=="SPELL_DAMAGE") or (type=="SWING_DAMAGE") then
local spellId = select(9,...)
    if destName ==     L["Snaplasher"] then
        if hardened_bark and addon.db.profile.hardened_bark then
            if bit.band(sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
                if LastEvent1[sourceName] == nil then
                    LastEvent1[sourceName] = timestamp
                    if type=="SWING_DAMAGE" then
                        addon:AddFail(sourceName,(GetSpellInfo(64190)).." ("..(GetSpellInfo(5547))..")",64190)
                    else
                        addon:AddFail(sourceName,(GetSpellInfo(64190)).." ("..(GetSpellInfo(spellId))..")",64190)
                    end
                else
                    if (timestamp - LastEvent1[sourceName]) > 3 then
                        if type=="SWING_DAMAGE" then
                            addon:AddFail(sourceName,(GetSpellInfo(64190)).." ("..(GetSpellInfo(5547))..")",64190)
                        else
                            addon:AddFail(sourceName,(GetSpellInfo(64190)).." ("..(GetSpellInfo(spellId))..")",64190)
                        end
                    end
                    LastEvent1[sourceName] = timestamp
                end
            else
                local name, num = nil, GetNumRaidMembers()
                for i=1 ,num do
                    if sourceName == UnitName("raidpet"..i) then
                        name = UnitName("raid"..i)
                    end
                end
                if name then
                    if LastEvent1[sourceName] == nil then
                        LastEvent1[sourceName] = timestamp
                        addon:AddFail(name,(GetSpellInfo(64190)).." (pet)",64190)
                    else
                        if (timestamp - LastEvent1[sourceName]) > 3 then
                            addon:AddFail(name,(GetSpellInfo(64190)).." (pet)",64190)
                        end
                        LastEvent1[sourceName] = timestamp
                    end
                end
            end
        end
    elseif destName == GetSpellInfo(64139) then
        if focused_anger and addon.db.profile.focused_anger and not brain_stun then
            if bit.band(sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
                if LastEvent1[sourceName] == nil then
                    LastEvent1[sourceName] = timestamp
                    if type=="SWING_DAMAGE" then
                        addon:AddFail(sourceName,(GetSpellInfo(57689)).." ("..(GetSpellInfo(5547))..")",57689)
                    else
                        addon:AddFail(sourceName,(GetSpellInfo(57689)).." ("..(GetSpellInfo(spellId))..")",57689)
                    end
                else
                    if (timestamp - LastEvent1[sourceName]) > 3 then
                        if type=="SWING_DAMAGE" then
                            addon:AddFail(sourceName,(GetSpellInfo(57689)).." ("..(GetSpellInfo(5547))..")",57689)
                        else
                            addon:AddFail(sourceName,(GetSpellInfo(57689)).." ("..(GetSpellInfo(spellId))..")",57689)
                        end
                    end
                    LastEvent1[sourceName] = timestamp
                end
            end
        end
    end
end


if (type=="SPELL_AURA_APPLIED") then
    local spellId = select(9,...)
---- THE IRON COUNCIL ----
--6/25 21:26:13.890  SPELL_AURA_APPLIED,0xF130008063022707,"Steelbreaker",0x10a48,0x0300000001D63C15,"Clozern",0x512,64637,"Overwhelming Power",0x1,DEBUFF
-- Overwhelming Power -- The Iron Council
    if ((spellId==64637) or (spellId==61888)) then
        if addon.db.profile.overwhelming_power then
            if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
                if LGT:GetUnitRole(destName) ~= "tank" then
                    addon:AddFail(destName,(GetSpellInfo(spellId)),spellId)
                end
            end
        end

---- FREYA ----
--6/4 20:54:30.328  SPELL_AURA_APPLIED,0xF1300081B3070438,"Ancient Conservator",0x10a48,0x03000000022B3CAF,"Implied",0x512,63571,"Nature's Fury",0x8,DEBUFF
--6/8 20:57:46.750  SPELL_AURA_APPLIED,0xF1300081B3007F9F,"Ancient Conservator",0x10a48,0x0300000002289DD9,"Spritzor",0x512,62589,"Nature's Fury",0x8,DEBUFF
    elseif ((spellId==63571) or (spellId==62589)) then
        if addon.db.profile.natures_fury then
            if fury_on == nil then
                fury_on = destName
                ChargeCounter[fury_on] = timestamp
            elseif fury_on1 == nil then
                fury_on1 = destName
                ChargeCounter[fury_on1] = timestamp
            elseif fury_on2 == nil then
                fury_on2 = destName
                ChargeCounter[fury_on2] = timestamp
            end
        end
-- 20736 = Distracting shot
    elseif (spellId==20736) then
        if addon.db.profile.shadow_beacon_taunt and GetSubZoneText() == L["The Prison of Yogg-Saron"] then
            if destName ~= L["Marked Immortal Guardian"] then
                addon:AddFail(sourceName,(GetSpellInfo(64465)),64465)
            end
        end
    end
end


if (type=="SPELL_CAST_SUCCESS") then
--7/8 23:24:58.267  SPELL_CAST_SUCCESS,0xF13000846204192D,"Brain of Yogg-Saron",0xa48,0x0000000000000000,nil,0x80000000,64173,"Shattered Illusion",0x8
    local spellId = select(9,...)
    if spellId == 64173 then
        brain_stun = true
    end
end

if (type=="SPELL_AURA_REMOVED") then
    local spellId = select(9,...)
-- Hardened Bark -- Freya -- Snaplasher
    if (spellId==64190) or (spellId==62663) then
        hardened_bark = false
-- Focused Anger -- Yogg-Saron -- Crusher Tentacle
    elseif (spellId==57689) then
        focused_anger = false
--7/8 23:25:12.205  SPELL_AURA_REMOVED,0xF13000846204192D,"Brain of Yogg-Saron",0x10a48,0xF1300084AE042654,"Crusher Tentacle",0xa48,64173,"Shattered Illusion",0x8,BUFF
    elseif spellId == 64173 then
        brain_stun = false
    end
end
end

function addon:Wipe()
    addon:Msg(L["susped"],addon.db.profile.announce)
    addon:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    addon:ScheduleTimer("ResumeFailReporting", self.Resume, 60)
    wipe_called = true
end

function addon:Resume()
    addon:Msg(L["resume"],addon.db.profile.announce)
    addon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "CombatLog")
    wipe_called = false
end

function addon:wipe_called()
    return wipe_called
end

function addon:CheckForWipe()
    local wipe = true
    local num = GetNumRaidMembers()
    for i = 1, num do
        local name = GetRaidRosterInfo(i)
        if name then
            if UnitAffectingCombat(name) ~= nil then
                wipe = false
            end
        end
    end
    if wipe then 
        LastEvent1, LastEvent2, LastEvent3 = {}, {}, nil
        addon:ScheduleTimer("ReInitalizeSessionFailTables", self.ReInitalizeSessionFailTables, 1)
    end
    return wipe
end

function addon:ReInitalizeSessionFailTables()
    FailsForTheSession = {}
    event_fails ={}
    sorttable ={}
    failed_at={}
end

function addon:KeepCheckingForWipe()
    local wipe = false
    if not addon:CheckForWipe() then
        addon:ScheduleTimer("KeepCheckingForWipe", addon.KeepCheckingForWipe, 2)
    else
        wipe = true
    end
    return wipe
end

function addon:AnnounceAfter()
    if addon:CheckForWipe() and not addon.db.profile.disabled then
        if addon.db.profile.announce_after_style == "group_by_player" then            
            local event_fails1, failed_at1 = 0, ""
            for k, v in pairs(FailsForTheSession) do
               event_fails1 = 0
               failed_at1 = ""
               for j, e in pairs(v) do
                  event_fails1 = e + event_fails1
                  failed_at1 = failed_at1..e.."x ("..(GetSpellInfo(j)).."), "
               end
               event_fails[k]= event_fails1
               failed_at[k] = failed_at1
            end
            local Count = event_fails
            for k,v in pairs(Count) do
               table.insert(sorttable, {k,v})
            end
            table.sort(sorttable,function(a,b) return a[2] > b[2] end)
            for k, v in pairs(sorttable) do
                if k==1 then
                    if addon.db.profile.announce == "SELF" then
                        DEFAULT_CHAT_FRAME:AddMessage("--------------")
                    else
                        SendChatMessage("-------------",addon.db.profile.announce,nil,addon.db.profile.channelnumber)
                    end
                end
                for j, e in pairs(failed_at) do
                    if v[1] == j then
                        if addon.db.profile.announce == "SELF" then
                            DEFAULT_CHAT_FRAME:AddMessage(v[1].. L["failed"] ..v[2].."x ("..strsub(e,0,strlen(e)-3).."))")
                        else
                            SendChatMessage(v[1].. L["failed"] ..v[2].."x ("..strsub(e,0,strlen(e)-3).."))",addon.db.profile.announce,nil,addon.db.profile.channelnumber)
                        end
                    end
                end
            end
            addon:ReInitalizeSessionFailTables()
        elseif addon.db.profile.announce_after_style == "group_by_fail" then
            local list = {}
            for k, v in pairs(FailsForTheSession) do
                for j, e in pairs(v) do
                    if list[j] == nil then
                        list[j] = {}
                        list[j][1] = k.." ("..e..")"
                    else
                        list[j][1] = list[j][1]..", "..k.." ("..e..")"
                    end
                end
            end
            for k,v in pairs(list) do
               table.insert(sorttable, {k,v})
            end
            table.sort(sorttable,function(a,b) return a[1] > b[1] end)
            for k=1, #sorttable do
                if k==1 then
                    if addon.db.profile.announce == "SELF" then
                        DEFAULT_CHAT_FRAME:AddMessage("--------------")
                    else
                        SendChatMessage("-------------",addon.db.profile.announce,nil,addon.db.profile.channelnumber)
                    end
                end
                if addon.db.profile.announce == "SELF" then
                    DEFAULT_CHAT_FRAME:AddMessage(GetSpellInfo(sorttable[k][1])..": "..sorttable[k][2][1])
                else
                    SendChatMessage(GetSpellInfo(sorttable[k][1])..": "..sorttable[k][2][1],addon.db.profile.announce,nil,addon.db.profile.channelnumber)
                end
            end
            addon:ReInitalizeSessionFailTables()
        end
    else
        addon:ScheduleTimer("CheckForWipe", addon.AnnounceAfter, 2)
    end
end

function addon:AddFail(p,s,spellId)
    addon:Initialize()
    if addon.db.profile.announce_style == "after" then
        if FailsForTheSession[p] == nil then
            FailsForTheSession[p] = {}
        end
        if FailsForTheSession[p][spellId] == nil then
            FailsForTheSession[p][spellId] = 1
        else
            FailsForTheSession[p][spellId] = FailsForTheSession[p][spellId] + 1
        end
        if EnsidiaFails_OFailCount[p] == nil then
            EnsidiaFails_OFailCount[p] = 1
            EnsidiaFails_FailCount[p] = 1
        else
            if EnsidiaFails_FailCount[p] == nil then
                EnsidiaFails_FailCount[p] = 1
            else
                EnsidiaFails_OFailCount[p] = EnsidiaFails_OFailCount[p] + 1
                EnsidiaFails_FailCount[p] = EnsidiaFails_FailCount[p] + 1
            end
        end
    elseif ((addon.db.profile.announce_style == "during") or (addon.db.profile.announce_style == "during_and_after")) then
        if FailsForTheSession[p] == nil then
            FailsForTheSession[p] = {}
        end
        if FailsForTheSession[p][spellId] == nil then
            FailsForTheSession[p][spellId] = 1
        else
            FailsForTheSession[p][spellId] = FailsForTheSession[p][spellId] + 1
        end
        if EnsidiaFails_OFailCount[p] == nil then
            EnsidiaFails_OFailCount[p] = 1
            EnsidiaFails_FailCount[p] = 1
        else
            if EnsidiaFails_FailCount[p] == nil then
                EnsidiaFails_FailCount[p] = 1
            else
                EnsidiaFails_OFailCount[p] = EnsidiaFails_OFailCount[p] + 1
                EnsidiaFails_FailCount[p] = EnsidiaFails_FailCount[p] + 1
            end
        end
        if s == "notmoving" then s = L["not moving"]
            addon:SendChatMessage(p,s.." ("..(GetSpellInfo(spellId))..")")
        elseif s == "moving" then s = L["moving"]
            addon:SendChatMessage(p,s.." ("..(GetSpellInfo(spellId))..")")
        elseif s == "notspreading" then s = L["not spreading"]
            addon:SendChatMessage(p,s.." ("..(GetSpellInfo(spellId))..")")
        elseif s == "spreading" then s = L["spreading"]
            addon:SendChatMessage(p,s.." ("..(GetSpellInfo(spellId))..")")
        elseif s == "dispelling" then s = L["dispelling"]
            addon:SendChatMessage(p,s.." ("..(GetSpellInfo(spellId))..")")
        elseif s == "notdispelling" then s = L["not_dispelling"]
            addon:SendChatMessage(p,s.." ("..(GetSpellInfo(spellId))..")")
        elseif s == "wrongplace" then s = L["being at the wrong place"]
            addon:SendChatMessage(p,s.." ("..(GetSpellInfo(spellId))..")")
        elseif s == "notcasting" then s = L["not_casting"]
            addon:SendChatMessage(p,s.." ("..(GetSpellInfo(spellId))..")")
        elseif s == "casting" then s = L["casting"]
            addon:SendChatMessage(p,s.." ("..(GetSpellInfo(spellId))..")")
        else
            addon:SendChatMessage(p,s)
        end
    end
end

function addon:RemoveFail(p,t,w)
    if EnsidiaFails_OFailCount[p] == nil then
        DEFAULT_CHAT_FRAME:AddMessage(L["Wrong name!"])
        return
    elseif EnsidiaFails_OFailCount[p] > 0 then
        EnsidiaFails_OFailCount[p] = EnsidiaFails_OFailCount[p] - 1
        if EnsidiaFails_FailCount[p] == nil then
            DEFAULT_CHAT_FRAME:AddMessage(L["Wrong name!"])
            return
        elseif EnsidiaFails_FailCount[p] > 0 then
            EnsidiaFails_FailCount[p] = EnsidiaFails_FailCount[p] - 1
            if addon.db.profile.announce == "SELF" then
                DEFAULT_CHAT_FRAME:AddMessage(L["removed"]..p)
            else
                SendChatMessage(L["removed"]..p,t,nil,w)
            end
        end
    end
end

function addon:SendChatMessage(p,s)
    if not addon.db.profile.disabled then
        addon:Msg(p..L["fails_at"]..s.." ("..EnsidiaFails_FailCount[p]..")",self.db.profile.announce)
    end
end

function addon:Msg(m,t)
    local w = self.db.profile.channelnumber
    if addon.db.profile.announce == "SELF" then
        DEFAULT_CHAT_FRAME:AddMessage(m)
    else
        SendChatMessage(m,t,nil,w)
    end
end

function addon:reset()
    EnsidiaFails_FailCount = {}
    DEFAULT_CHAT_FRAME:AddMessage(L["reseted"]);
end

function addon:oreset()
    EnsidiaFails_FailCount = {}
    EnsidiaFails_OFailCount = {}
    DEFAULT_CHAT_FRAME:AddMessage(L["oreseted"]);
end
