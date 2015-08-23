--[[
	Copyright (c) 2009, dr_AllCOM3
    All rights reserved.

    You're allowed to use this addon, free of monetary charge,
    but you are not allowed to modify, alter, or redistribute
    this addon without express, written permission of the author.
]]

DocsUI_Nameplates = LibStub("AceAddon-3.0"):NewAddon("DocsUI_Nameplates", "AceEvent-3.0", "AceConsole-3.0", "AceSerializer-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("DocsUI_Nameplates")
local LSM = LibStub("LibSharedMedia-3.0")
local db
local temp, temp2 = nil