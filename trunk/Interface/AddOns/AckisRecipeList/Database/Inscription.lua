--[[
************************************************************************
Inscription.lua
Inscription data for all of Ackis Recipe List
************************************************************************
File date: 2010-11-05T14:50:23Z
File revision: @file-revision@
Project revision: @project-revision@
Project version: 2.0.5
************************************************************************
Format:

************************************************************************
Please see http://www.wowace.com/addons/arl/ for more information.
************************************************************************
This source code is released under All Rights Reserved.
************************************************************************
]]--

-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local MODNAME	= "Ackis Recipe List"
local addon	= LibStub("AceAddon-3.0"):GetAddon(MODNAME)
local L		= LibStub("AceLocale-3.0"):GetLocale(MODNAME)

local private	= select(2, ...)

-------------------------------------------------------------------------------
-- Filter flags. Acquire types, and Reputation levels.
-------------------------------------------------------------------------------
local F		= private.filter_flags
local A		= private.acquire_types
local Q		= private.item_qualities
local REP	= private.rep_levels
local FAC	= private.faction_ids
local V		= private.game_versions

local initialized = false
local num_recipes = 0

--------------------------------------------------------------------------------------------------------------------
-- Counter and wrapper function
--------------------------------------------------------------------------------------------------------------------
local function AddRecipe(spell_id, skill_level, item_id, quality, genesis, optimal_level, medium_level, easy_level, trivial_level)
	num_recipes = num_recipes + 1
	addon:AddRecipe(spell_id, skill_level, item_id, quality, 45357, nil, genesis, optimal_level, medium_level, easy_level, trivial_level)
end

function addon:InitInscription()
	if initialized then
		return num_recipes
	end
	initialized = true

	-- Scroll of Stamina -- 45382
	AddRecipe(45382, 1, 1180, Q.COMMON, V.WOTLK, 1, 35, 40, 45)
	self:AddRecipeFlags(45382, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeAcquire(45382, A.CUSTOM, 8)

	-- Scroll of Intellect -- 48114
	AddRecipe(48114, 1, 955, Q.COMMON, V.WOTLK, 1, 35, 40, 45)
	self:AddRecipeFlags(48114, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeAcquire(48114, A.CUSTOM, 8)

	-- Scroll of Spirit -- 48116
	AddRecipe(48116, 1, 1181, Q.COMMON, V.WOTLK, 1, 35, 40, 45)
	self:AddRecipeFlags(48116, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeAcquire(48116, A.CUSTOM, 8)

	-- Glyph of Entangling Roots -- 48121
	AddRecipe(48121, 100, 40924, Q.COMMON, V.WOTLK, 100, 105, 110, 115)
	self:AddRecipeFlags(48121, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DRUID)
	self:AddRecipeTrainer(48121, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Mysterious Tarot -- 48247
	AddRecipe(48247, 110, 37168, Q.COMMON, V.WOTLK, 110, 125, 137, 150)
	self:AddRecipeFlags(48247, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(48247, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Recall -- 48248
	AddRecipe(48248, 35, 37118, Q.COMMON, V.WOTLK, 35, 60, 67, 75)
	self:AddRecipeFlags(48248, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(48248, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Intellect II -- 50598
	AddRecipe(50598, 75, 2290, Q.COMMON, V.WOTLK, 75, 75, 80, 85)
	self:AddRecipeFlags(50598, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50598, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Intellect III -- 50599
	AddRecipe(50599, 165, 4419, Q.COMMON, V.WOTLK, 165, 170, 175, 180)
	self:AddRecipeFlags(50599, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50599, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Intellect IV -- 50600
	AddRecipe(50600, 215, 10308, Q.COMMON, V.WOTLK, 215, 220, 225, 230)
	self:AddRecipeFlags(50600, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50600, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Intellect V -- 50601
	AddRecipe(50601, 260, 27499, Q.COMMON, V.WOTLK, 260, 265, 270, 275)
	self:AddRecipeFlags(50601, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50601, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Intellect VI -- 50602
	AddRecipe(50602, 310, 33458, Q.COMMON, V.WOTLK, 310, 310, 315, 320)
	self:AddRecipeFlags(50602, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50602, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Intellect VII -- 50603
	AddRecipe(50603, 360, 37091, Q.COMMON, V.WOTLK, 360, 365, 370, 375)
	self:AddRecipeFlags(50603, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50603, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Scroll of Intellect VIII -- 50604
	AddRecipe(50604, 410, 37092, Q.COMMON, V.WOTLK, 410, 415, 420, 425)
	self:AddRecipeFlags(50604, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50604, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Scroll of Spirit II -- 50605
	AddRecipe(50605, 75, 1712, Q.COMMON, V.WOTLK, 75, 75, 80, 85)
	self:AddRecipeFlags(50605, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50605, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Spirit III -- 50606
	AddRecipe(50606, 160, 4424, Q.COMMON, V.WOTLK, 160, 165, 170, 175)
	self:AddRecipeFlags(50606, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50606, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Spirit IV -- 50607
	AddRecipe(50607, 210, 10306, Q.COMMON, V.WOTLK, 210, 215, 220, 225)
	self:AddRecipeFlags(50607, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50607, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Spirit V -- 50608
	AddRecipe(50608, 255, 27501, Q.COMMON, V.WOTLK, 255, 260, 265, 270)
	self:AddRecipeFlags(50608, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50608, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Spirit VI -- 50609
	AddRecipe(50609, 295, 33460, Q.COMMON, V.WOTLK, 295, 305, 310, 315)
	self:AddRecipeFlags(50609, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50609, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Spirit VII -- 50610
	AddRecipe(50610, 355, 37097, Q.COMMON, V.WOTLK, 355, 360, 365, 370)
	self:AddRecipeFlags(50610, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50610, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Scroll of Spirit VIII -- 50611
	AddRecipe(50611, 405, 37098, Q.COMMON, V.WOTLK, 405, 410, 415, 420)
	self:AddRecipeFlags(50611, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50611, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Scroll of Stamina II -- 50612
	AddRecipe(50612, 75, 1711, Q.COMMON, V.WOTLK, 75, 75, 80, 85)
	self:AddRecipeFlags(50612, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50612, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Stamina III -- 50614
	AddRecipe(50614, 155, 4422, Q.COMMON, V.WOTLK, 155, 160, 165, 170)
	self:AddRecipeFlags(50614, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50614, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Stamina IV -- 50616
	AddRecipe(50616, 205, 10307, Q.COMMON, V.WOTLK, 205, 210, 215, 220)
	self:AddRecipeFlags(50616, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50616, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Stamina V -- 50617
	AddRecipe(50617, 250, 27502, Q.COMMON, V.WOTLK, 250, 255, 260, 265)
	self:AddRecipeFlags(50617, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50617, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Stamina VI -- 50618
	AddRecipe(50618, 290, 33461, Q.COMMON, V.WOTLK, 290, 300, 305, 310)
	self:AddRecipeFlags(50618, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50618, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Stamina VII -- 50619
	AddRecipe(50619, 350, 37093, Q.COMMON, V.WOTLK, 350, 355, 360, 365)
	self:AddRecipeFlags(50619, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50619, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Scroll of Stamina VIII -- 50620
	AddRecipe(50620, 400, 37094, Q.COMMON, V.WOTLK, 400, 405, 410, 415)
	self:AddRecipeFlags(50620, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(50620, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Ivory Ink -- 52738
	AddRecipe(52738, 1, 37101, Q.COMMON, V.WOTLK, 1, 15, 22, 30)
	self:AddRecipeFlags(52738, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeAcquire(52738, A.CUSTOM, 8)

	-- Enchanting Vellum -- 52739
	AddRecipe(52739, 35, 38682, Q.COMMON, V.WOTLK, 35, 75, 87, 100)
	self:AddRecipeFlags(52739, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(52739, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Moonglow Ink -- 52843
	AddRecipe(52843, 35, 39469, Q.COMMON, V.WOTLK, 35, 45, 60, 75)
	self:AddRecipeFlags(52843, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(52843, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Midnight Ink -- 53462
	AddRecipe(53462, 75, 39774, Q.COMMON, V.WOTLK, 75, 75, 77, 80)
	self:AddRecipeFlags(53462, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(53462, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Frenzied Regeneration -- 56943
	AddRecipe(56943, 350, 40896, Q.COMMON, V.WOTLK, 350, 355, 360, 365)
	self:AddRecipeFlags(56943, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DRUID)
	self:AddRecipeTrainer(56943, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Solar Beam -- 56944
	AddRecipe(56944, 385, 40899, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56944, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(56944, A.CUSTOM, 15)

	-- Glyph of Healing Touch -- 56945
	AddRecipe(56945, 115, 40914, Q.COMMON, V.WOTLK, 115, 120, 125, 130)
	self:AddRecipeFlags(56945, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.DRUID)
	self:AddRecipeTrainer(56945, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Hurricane -- 56946
	AddRecipe(56946, 385, 40920, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56946, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(56946, A.CUSTOM, 15)

	-- Glyph of Innervate -- 56947
	AddRecipe(56947, 385, 40908, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56947, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(56947, A.CUSTOM, 15)

	-- Glyph of Insect Swarm -- 56948
	AddRecipe(56948, 150, 40919, Q.COMMON, V.WOTLK, 150, 155, 160, 165)
	self:AddRecipeFlags(56948, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DRUID)
	self:AddRecipeTrainer(56948, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Lifebloom -- 56949
	AddRecipe(56949, 385, 40915, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56949, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(56949, A.CUSTOM, 15)

	-- Glyph of Mangle -- 56950
	AddRecipe(56950, 385, 40900, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56950, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(56950, A.CUSTOM, 15)

	-- Glyph of Moonfire -- 56951
	AddRecipe(56951, 130, 40923, Q.COMMON, V.WOTLK, 130, 135, 140, 145)
	self:AddRecipeFlags(56951, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DRUID)
	self:AddRecipeTrainer(56951, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Rake -- 56952
	AddRecipe(56952, 310, 40903, Q.COMMON, V.WOTLK, 310, 315, 320, 325)
	self:AddRecipeFlags(56952, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DRUID)
	self:AddRecipeTrainer(56952, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Rebirth -- 56953
	AddRecipe(56953, 170, 40909, Q.COMMON, V.WOTLK, 170, 175, 180, 185)
	self:AddRecipeFlags(56953, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DRUID)
	self:AddRecipeTrainer(56953, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Regrowth -- 56954
	AddRecipe(56954, 385, 40912, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56954, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(56954, A.CUSTOM, 15)

	-- Glyph of Rejuvenation -- 56955
	AddRecipe(56955, 80, 40913, Q.COMMON, V.WOTLK, 80, 90, 100, 110)
	self:AddRecipeFlags(56955, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.DRUID)
	self:AddRecipeTrainer(56955, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Rip -- 56956
	AddRecipe(56956, 200, 40902, Q.COMMON, V.WOTLK, 200, 205, 210, 215)
	self:AddRecipeFlags(56956, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DRUID)
	self:AddRecipeTrainer(56956, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Shred -- 56957
	AddRecipe(56957, 260, 40901, Q.COMMON, V.WOTLK, 260, 265, 270, 275)
	self:AddRecipeFlags(56957, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DRUID)
	self:AddRecipeTrainer(56957, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Starfall -- 56958
	AddRecipe(56958, 385, 40921, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56958, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(56958, A.CUSTOM, 15)

	-- Glyph of Starfire -- 56959
	AddRecipe(56959, 220, 40916, Q.COMMON, V.WOTLK, 220, 225, 230, 235)
	self:AddRecipeFlags(56959, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DRUID)
	self:AddRecipeTrainer(56959, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Swiftmend -- 56960
	AddRecipe(56960, 385, 40906, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56960, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(56960, A.CUSTOM, 15)

	-- Glyph of Maul -- 56961
	AddRecipe(56961, 90, 40897, Q.COMMON, V.WOTLK, 90, 100, 110, 120)
	self:AddRecipeFlags(56961, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DRUID)
	self:AddRecipeTrainer(56961, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Wrath -- 56963
	AddRecipe(56963, 85, 40922, Q.COMMON, V.WOTLK, 85, 95, 105, 115)
	self:AddRecipeFlags(56963, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DRUID)
	self:AddRecipeTrainer(56963, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Typhoon -- 56965
	AddRecipe(56965, 310, 44955, Q.COMMON, V.WOTLK, 310, 320, 325, 330)
	self:AddRecipeFlags(56965, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(56965, A.CUSTOM, 14)

	-- Glyph of Arcane Missiles -- 56971
	AddRecipe(56971, 115, 42735, Q.COMMON, V.WOTLK, 115, 120, 125, 130)
	self:AddRecipeFlags(56971, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.MAGE)
	self:AddRecipeTrainer(56971, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Arcane Power -- 56972
	AddRecipe(56972, 335, 42736, Q.COMMON, V.WOTLK, 335, 340, 345, 350)
	self:AddRecipeFlags(56972, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.MAGE)
	self:AddRecipeTrainer(56972, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Blink -- 56973
	AddRecipe(56973, 130, 42737, Q.COMMON, V.WOTLK, 130, 135, 140, 145)
	self:AddRecipeFlags(56973, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.MAGE)
	self:AddRecipeTrainer(56973, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Evocation -- 56974
	AddRecipe(56974, 155, 42738, Q.COMMON, V.WOTLK, 155, 160, 165, 170)
	self:AddRecipeFlags(56974, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.MAGE)
	self:AddRecipeTrainer(56974, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Fireball -- 56975
	AddRecipe(56975, 385, 42739, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56975, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(56975, A.CUSTOM, 15)

	-- Glyph of Frost Nova -- 56976
	AddRecipe(56976, 80, 42741, Q.COMMON, V.WOTLK, 80, 90, 100, 110)
	self:AddRecipeFlags(56976, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.MAGE)
	self:AddRecipeTrainer(56976, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Frostbolt -- 56977
	AddRecipe(56977, 385, 42742, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56977, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(56977, A.CUSTOM, 15)

	-- Glyph of Pyroblast -- 56978
	AddRecipe(56978, 90, 42743, Q.COMMON, V.WOTLK, 90, 100, 110, 120)
	self:AddRecipeFlags(56978, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.MAGE)
	self:AddRecipeTrainer(56978, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Ice Block -- 56979
	AddRecipe(56979, 225, 42744, Q.COMMON, V.WOTLK, 225, 230, 235, 240)
	self:AddRecipeFlags(56979, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.MAGE)
	self:AddRecipeTrainer(56979, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Ice Lance -- 56980
	AddRecipe(56980, 375, 42745, Q.COMMON, V.WOTLK, 375, 380, 385, 390)
	self:AddRecipeFlags(56980, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.MAGE)
	self:AddRecipeTrainer(56980, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Glyph of Icy Veins -- 56981
	AddRecipe(56981, 175, 42746, Q.COMMON, V.WOTLK, 175, 180, 185, 190)
	self:AddRecipeFlags(56981, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.MAGE)
	self:AddRecipeTrainer(56981, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Invisibility -- 56983
	AddRecipe(56983, 385, 42748, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56983, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(56983, A.CUSTOM, 15)

	-- Glyph of Mage Armor -- 56984
	AddRecipe(56984, 325, 42749, Q.COMMON, V.WOTLK, 325, 330, 335, 340)
	self:AddRecipeFlags(56984, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.MAGE)
	self:AddRecipeTrainer(56984, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)
	self:AddRecipeAcquire(56984, A.CUSTOM, 46)

	-- Glyph of Molten Armor -- 56986
	AddRecipe(56986, 385, 42751, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56986, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(56986, A.CUSTOM, 15)

	-- Glyph of Polymorph -- 56987
	AddRecipe(56987, 400, 42752, Q.COMMON, V.WOTLK, 400, 400, 400, 405)
	self:AddRecipeFlags(56987, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.MAGE)
	self:AddRecipeTrainer(56987, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Glyph of Cone of Cold -- 56988
	AddRecipe(56988, 385, 42753, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56988, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(56988, A.CUSTOM, 15)

	-- Glyph of Dragon's Breath -- 56989
	AddRecipe(56989, 385, 42754, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56989, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(56989, A.CUSTOM, 15)

	-- Glyph of Blast Wave -- 56990
	AddRecipe(56990, 310, 44920, Q.COMMON, V.WOTLK, 310, 355, 360, 365)
	self:AddRecipeFlags(56990, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(56990, A.CUSTOM, 14)

	-- Glyph of Arcane Blast -- 56991
	AddRecipe(56991, 315, 44955, Q.COMMON, V.WOTLK, 315, 320, 325, 330)
	self:AddRecipeFlags(56991, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.MAGE)
	self:AddRecipeTrainer(56991, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Aimed Shot -- 56994
	AddRecipe(56994, 175, 42897, Q.COMMON, V.WOTLK, 175, 180, 185, 190)
	self:AddRecipeFlags(56994, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.HUNTER)
	self:AddRecipeTrainer(56994, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Arcane Shot -- 56995
	AddRecipe(56995, 100, 42898, Q.COMMON, V.WOTLK, 100, 105, 110, 115)
	self:AddRecipeFlags(56995, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.HUNTER)
	self:AddRecipeTrainer(56995, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Trap Launcher -- 56996
	AddRecipe(56996, 385, 42899, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56996, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(56996, A.CUSTOM, 15)

	-- Glyph of Mending -- 56997
	AddRecipe(56997, 115, 42900, Q.COMMON, V.WOTLK, 115, 120, 125, 130)
	self:AddRecipeFlags(56997, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.HUNTER)
	self:AddRecipeTrainer(56997, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Concussive Shot -- 56998
	AddRecipe(56998, 385, 42901, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56998, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(56998, A.CUSTOM, 15)

	-- Glyph of Bestial Wrath -- 56999
	AddRecipe(56999, 385, 42902, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(56999, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(56999, A.CUSTOM, 15)

	-- Glyph of Deterrence -- 57000
	AddRecipe(57000, 200, 42903, Q.COMMON, V.WOTLK, 200, 205, 210, 215)
	self:AddRecipeFlags(57000, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.HUNTER)
	self:AddRecipeTrainer(57000, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Disengage -- 57001
	AddRecipe(57001, 225, 42904, Q.COMMON, V.WOTLK, 225, 230, 235, 240)
	self:AddRecipeFlags(57001, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.HUNTER)
	self:AddRecipeTrainer(57001, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Freezing Trap -- 57002
	AddRecipe(57002, 260, 42905, Q.COMMON, V.WOTLK, 260, 265, 270, 275)
	self:AddRecipeFlags(57002, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.HUNTER)
	self:AddRecipeTrainer(57002, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Ice Trap -- 57003
	AddRecipe(57003, 350, 42906, Q.COMMON, V.WOTLK, 350, 355, 360, 365)
	self:AddRecipeFlags(57003, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.HUNTER)
	self:AddRecipeTrainer(57003, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Misdirection -- 57004
	AddRecipe(57004, 80, 42907, Q.COMMON, V.WOTLK, 80, 90, 100, 110)
	self:AddRecipeFlags(57004, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.HUNTER)
	self:AddRecipeTrainer(57004, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Immolation Trap -- 57005
	AddRecipe(57005, 130, 42908, Q.COMMON, V.WOTLK, 130, 135, 140, 145)
	self:AddRecipeFlags(57005, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.HUNTER)
	self:AddRecipeTrainer(57005, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of the Dazzled Prey -- 57006
	AddRecipe(57006, 375, 42909, Q.COMMON, V.WOTLK, 375, 380, 385, 390)
	self:AddRecipeFlags(57006, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.HUNTER)
	self:AddRecipeTrainer(57006, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Glyph of Silencing Shot -- 57007
	AddRecipe(57007, 150, 42910, Q.COMMON, V.WOTLK, 150, 155, 160, 165)
	self:AddRecipeFlags(57007, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.HUNTER)
	self:AddRecipeTrainer(57007, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Rapid Fire -- 57008
	AddRecipe(57008, 315, 42911, Q.COMMON, V.WOTLK, 315, 320, 325, 330)
	self:AddRecipeFlags(57008, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.HUNTER)
	self:AddRecipeTrainer(57008, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Serpent Sting -- 57009
	AddRecipe(57009, 90, 42912, Q.COMMON, V.WOTLK, 90, 100, 110, 120)
	self:AddRecipeFlags(57009, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.HUNTER)
	self:AddRecipeTrainer(57009, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Snake Trap -- 57010
	AddRecipe(57010, 385, 42913, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57010, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(57010, A.CUSTOM, 15)

	-- Glyph of Steady Shot -- 57011
	AddRecipe(57011, 385, 42914, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57011, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(57011, A.CUSTOM, 15)

	-- Glyph of Kill Command -- 57012
	AddRecipe(57012, 385, 42915, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57012, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(57012, A.CUSTOM, 15)

	-- Glyph of Wyvern Sting -- 57014
	AddRecipe(57014, 385, 42917, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57014, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(57014, A.CUSTOM, 15)

	-- Glyph of Focused Shield -- 57019
	AddRecipe(57019, 385, 41101, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57019, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(57019, A.CUSTOM, 15)

	-- Glyph of Cleansing -- 57020
	AddRecipe(57020, 180, 41104, Q.COMMON, V.WOTLK, 180, 185, 190, 195)
	self:AddRecipeFlags(57020, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.PALADIN)
	self:AddRecipeTrainer(57020, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of the Ascetic Crusader -- 57021
	AddRecipe(57021, 385, 41107, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57021, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(57021, A.CUSTOM, 15)

	-- Glyph of Divine Protection -- 57022
	AddRecipe(57022, 80, 41096, Q.COMMON, V.WOTLK, 80, 90, 100, 110)
	self:AddRecipeFlags(57022, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.PALADIN)
	self:AddRecipeTrainer(57022, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Consecration -- 57023
	AddRecipe(57023, 205, 41099, Q.COMMON, V.WOTLK, 205, 210, 215, 220)
	self:AddRecipeFlags(57023, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.PALADIN)
	self:AddRecipeTrainer(57023, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Crusader Strike -- 57024
	AddRecipe(57024, 230, 41098, Q.COMMON, V.WOTLK, 230, 235, 240, 245)
	self:AddRecipeFlags(57024, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.PALADIN)
	self:AddRecipeTrainer(57024, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Exorcism -- 57025
	AddRecipe(57025, 265, 41103, Q.COMMON, V.WOTLK, 265, 270, 275, 280)
	self:AddRecipeFlags(57025, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.PALADIN)
	self:AddRecipeTrainer(57025, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Word of Glory -- 57026
	AddRecipe(57026, 300, 41105, Q.COMMON, V.WOTLK, 300, 305, 310, 315)
	self:AddRecipeFlags(57026, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.PALADIN)
	self:AddRecipeTrainer(57026, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Hammer of Justice -- 57027
	AddRecipe(57027, 90, 41095, Q.COMMON, V.WOTLK, 90, 100, 110, 120)
	self:AddRecipeFlags(57027, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.PALADIN)
	self:AddRecipeTrainer(57027, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Hammer of Wrath -- 57028
	AddRecipe(57028, 385, 41097, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57028, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(57028, A.CUSTOM, 15)

	-- Glyph of Divine Favor -- 57029
	AddRecipe(57029, 105, 41106, Q.COMMON, V.WOTLK, 105, 110, 115, 120)
	self:AddRecipeFlags(57029, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.PALADIN)
	self:AddRecipeTrainer(57029, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Judgement -- 57030
	AddRecipe(57030, 120, 41092, Q.COMMON, V.WOTLK, 120, 125, 130, 135)
	self:AddRecipeFlags(57030, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.PALADIN)
	self:AddRecipeTrainer(57030, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Divinity -- 57031
	AddRecipe(57031, 135, 41108, Q.COMMON, V.WOTLK, 135, 140, 145, 150)
	self:AddRecipeFlags(57031, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.PALADIN)
	self:AddRecipeTrainer(57031, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Righteousness -- 57032
	AddRecipe(57032, 155, 41100, Q.COMMON, V.WOTLK, 155, 160, 165, 170)
	self:AddRecipeFlags(57032, F.RBOP, F.TANK, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.PALADIN)
	self:AddRecipeTrainer(57032, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Rebuke -- 57033
	AddRecipe(57033, 335, 41094, Q.COMMON, V.WOTLK, 335, 340, 345, 350)
	self:AddRecipeFlags(57033, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.PALADIN)
	self:AddRecipeTrainer(57033, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Seal of Insight -- 57034
	AddRecipe(57034, 385, 41110, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57034, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(57034, A.CUSTOM, 15)

	-- Glyph of Light of Dawn -- 57035
	AddRecipe(57035, 385, 41109, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57035, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(57035, A.CUSTOM, 15)

	-- Glyph of Turn Evil -- 57036
	AddRecipe(57036, 375, 41102, Q.COMMON, V.WOTLK, 375, 380, 385, 390)
	self:AddRecipeFlags(57036, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.PALADIN)
	self:AddRecipeTrainer(57036, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Glyph of Adrenaline Rush -- 57112
	AddRecipe(57112, 385, 42954, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57112, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(57112, A.CUSTOM, 15)

	-- Glyph of Ambush -- 57113
	AddRecipe(57113, 340, 42955, Q.COMMON, V.WOTLK, 340, 345, 350, 355)
	self:AddRecipeFlags(57113, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.ROGUE)
	self:AddRecipeTrainer(57113, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Backstab -- 57114
	AddRecipe(57114, 80, 42956, Q.COMMON, V.WOTLK, 80, 90, 100, 110)
	self:AddRecipeFlags(57114, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.ROGUE)
	self:AddRecipeTrainer(57114, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Blade Flurry -- 57115
	AddRecipe(57115, 385, 42957, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57115, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(57115, A.CUSTOM, 15)

	-- Glyph of Crippling Poison -- 57116
	AddRecipe(57116, 385, 42958, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57116, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(57116, A.CUSTOM, 15)

	-- Glyph of Deadly Throw -- 57117
	AddRecipe(57117, 385, 42959, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57117, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(57117, A.CUSTOM, 15)

	-- Glyph of Evasion -- 57119
	AddRecipe(57119, 95, 42960, Q.COMMON, V.WOTLK, 95, 105, 115, 125)
	self:AddRecipeFlags(57119, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.ROGUE)
	self:AddRecipeTrainer(57119, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Eviscerate -- 57120
	AddRecipe(57120, 105, 42961, Q.COMMON, V.WOTLK, 105, 110, 115, 120)
	self:AddRecipeFlags(57120, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.ROGUE)
	self:AddRecipeTrainer(57120, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Expose Armor -- 57121
	AddRecipe(57121, 120, 42962, Q.COMMON, V.WOTLK, 120, 125, 130, 135)
	self:AddRecipeFlags(57121, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.ROGUE)
	self:AddRecipeTrainer(57121, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Feint -- 57122
	AddRecipe(57122, 305, 42963, Q.COMMON, V.WOTLK, 305, 310, 315, 320)
	self:AddRecipeFlags(57122, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.ROGUE)
	self:AddRecipeTrainer(57122, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Garrote -- 57123
	AddRecipe(57123, 135, 42964, Q.COMMON, V.WOTLK, 135, 140, 145, 150)
	self:AddRecipeFlags(57123, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.ROGUE)
	self:AddRecipeTrainer(57123, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Revealing Strike -- 57124
	AddRecipe(57124, 385, 42965, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57124, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(57124, A.CUSTOM, 15)

	-- Glyph of Gouge -- 57125
	AddRecipe(57125, 160, 42966, Q.COMMON, V.WOTLK, 160, 165, 170, 175)
	self:AddRecipeFlags(57125, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.ROGUE)
	self:AddRecipeTrainer(57125, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Hemorrhage -- 57126
	AddRecipe(57126, 385, 42967, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57126, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(57126, A.CUSTOM, 15)

	-- Glyph of Preparation -- 57127
	AddRecipe(57127, 385, 42968, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57127, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(57127, A.CUSTOM, 15)

	-- Glyph of Rupture -- 57128
	AddRecipe(57128, 385, 42969, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57128, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(57128, A.CUSTOM, 15)

	-- Glyph of Sap -- 57129
	AddRecipe(57129, 185, 42970, Q.COMMON, V.WOTLK, 185, 190, 195, 200)
	self:AddRecipeFlags(57129, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.ROGUE)
	self:AddRecipeTrainer(57129, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Kick -- 57130
	AddRecipe(57130, 385, 42971, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57130, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(57130, A.CUSTOM, 15)

	-- Glyph of Sinister Strike -- 57131
	AddRecipe(57131, 210, 42972, Q.COMMON, V.WOTLK, 210, 215, 220, 225)
	self:AddRecipeFlags(57131, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.ROGUE)
	self:AddRecipeTrainer(57131, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Slice and Dice -- 57132
	AddRecipe(57132, 235, 42973, Q.COMMON, V.WOTLK, 235, 240, 245, 250)
	self:AddRecipeFlags(57132, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.ROGUE)
	self:AddRecipeTrainer(57132, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Sprint -- 57133
	AddRecipe(57133, 285, 42974, Q.COMMON, V.WOTLK, 285, 290, 295, 300)
	self:AddRecipeFlags(57133, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.ROGUE)
	self:AddRecipeTrainer(57133, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Shield Slam -- 57152
	AddRecipe(57152, 385, 43425, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57152, F.RBOP, F.TANK, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(57152, A.CUSTOM, 15)

	-- Glyph of Bloody Healing -- 57153
	AddRecipe(57153, 385, 43412, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57153, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(57153, A.CUSTOM, 15)

	-- Glyph of Cleaving -- 57154
	AddRecipe(57154, 240, 43414, Q.COMMON, V.WOTLK, 240, 245, 250, 255)
	self:AddRecipeFlags(57154, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARRIOR)
	self:AddRecipeTrainer(57154, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Devastate -- 57155
	AddRecipe(57155, 385, 43415, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57155, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(57155, A.CUSTOM, 15)

	-- Glyph of Bloodthirst -- 57156
	AddRecipe(57156, 285, 43416, Q.COMMON, V.WOTLK, 285, 290, 295, 300)
	self:AddRecipeFlags(57156, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARRIOR)
	self:AddRecipeTrainer(57156, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Piercing Howl -- 57157
	AddRecipe(57157, 125, 43417, Q.COMMON, V.WOTLK, 125, 130, 135, 140)
	self:AddRecipeFlags(57157, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARRIOR)
	self:AddRecipeTrainer(57157, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Heroic Throw -- 57158
	AddRecipe(57158, 95, 43418, Q.COMMON, V.WOTLK, 95, 105, 115, 125)
	self:AddRecipeFlags(57158, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARRIOR)
	self:AddRecipeTrainer(57158, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Intervene -- 57159
	AddRecipe(57159, 385, 43419, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57159, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(57159, A.CUSTOM, 15)

	-- Glyph of Mortal Strike -- 57160
	AddRecipe(57160, 385, 43421, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57160, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(57160, A.CUSTOM, 15)

	-- Glyph of Overpower -- 57161
	AddRecipe(57161, 170, 43422, Q.COMMON, V.WOTLK, 170, 175, 180, 185)
	self:AddRecipeFlags(57161, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARRIOR)
	self:AddRecipeTrainer(57161, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Rapid Charge -- 57162
	AddRecipe(57162, 85, 43413, Q.COMMON, V.WOTLK, 85, 95, 105, 115)
	self:AddRecipeFlags(57162, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARRIOR)
	self:AddRecipeTrainer(57162, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Slam -- 57163
	AddRecipe(57163, 110, 43423, Q.COMMON, V.WOTLK, 110, 115, 120, 125)
	self:AddRecipeFlags(57163, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARRIOR)
	self:AddRecipeTrainer(57163, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Resonating Power -- 57164
	AddRecipe(57164, 385, 43430, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57164, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(57164, A.CUSTOM, 15)

	-- Glyph of Revenge -- 57165
	AddRecipe(57165, 190, 43424, Q.COMMON, V.WOTLK, 190, 195, 200, 205)
	self:AddRecipeFlags(57165, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARRIOR)
	self:AddRecipeTrainer(57165, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Sunder Armor -- 57167
	AddRecipe(57167, 140, 43427, Q.COMMON, V.WOTLK, 140, 145, 150, 155)
	self:AddRecipeFlags(57167, F.RBOP, F.TANK, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARRIOR)
	self:AddRecipeTrainer(57167, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Sweeping Strikes -- 57168
	AddRecipe(57168, 320, 43428, Q.COMMON, V.WOTLK, 320, 325, 330, 335)
	self:AddRecipeFlags(57168, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARRIOR)
	self:AddRecipeTrainer(57168, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Victory Rush -- 57170
	AddRecipe(57170, 385, 43431, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57170, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(57170, A.CUSTOM, 15)

	-- Glyph of Raging Blow -- 57172
	AddRecipe(57172, 345, 43432, Q.COMMON, V.WOTLK, 345, 350, 355, 360)
	self:AddRecipeFlags(57172, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARRIOR)
	self:AddRecipeTrainer(57172, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Circle of Healing -- 57181
	AddRecipe(57181, 385, 42396, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57181, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(57181, A.CUSTOM, 15)

	-- Glyph of Dispel Magic -- 57183
	AddRecipe(57183, 230, 42397, Q.COMMON, V.WOTLK, 230, 235, 240, 245)
	self:AddRecipeFlags(57183, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.PRIEST)
	self:AddRecipeTrainer(57183, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Fade -- 57184
	AddRecipe(57184, 105, 42398, Q.COMMON, V.WOTLK, 105, 110, 115, 120)
	self:AddRecipeFlags(57184, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.PRIEST)
	self:AddRecipeTrainer(57184, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Fear Ward -- 57185
	AddRecipe(57185, 270, 42399, Q.COMMON, V.WOTLK, 270, 275, 280, 285)
	self:AddRecipeFlags(57185, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.PRIEST)
	self:AddRecipeTrainer(57185, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Flash Heal -- 57186
	AddRecipe(57186, 120, 42400, Q.COMMON, V.WOTLK, 120, 125, 130, 135)
	self:AddRecipeFlags(57186, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.PRIEST)
	self:AddRecipeTrainer(57186, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Holy Nova -- 57187
	AddRecipe(57187, 315, 42401, Q.COMMON, V.WOTLK, 315, 320, 325, 330)
	self:AddRecipeFlags(57187, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.PRIEST)
	self:AddRecipeTrainer(57187, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Inner Fire -- 57188
	AddRecipe(57188, 135, 42402, Q.COMMON, V.WOTLK, 135, 140, 145, 150)
	self:AddRecipeFlags(57188, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.PRIEST)
	self:AddRecipeTrainer(57188, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Lightwell -- 57189
	AddRecipe(57189, 385, 42403, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57189, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(57189, A.CUSTOM, 15)

	-- Glyph of Mass Dispel -- 57190
	AddRecipe(57190, 385, 42404, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57190, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(57190, A.CUSTOM, 15)

	-- Glyph of Psychic Horror -- 57191
	AddRecipe(57191, 385, 42405, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57191, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(57191, A.CUSTOM, 15)

	-- Glyph of Shadow Word: Pain -- 57192
	AddRecipe(57192, 350, 42406, Q.COMMON, V.WOTLK, 350, 355, 360, 365)
	self:AddRecipeFlags(57192, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.PRIEST)
	self:AddRecipeTrainer(57192, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Power Word: Barrier -- 57193
	AddRecipe(57193, 385, 42407, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57193, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(57193, A.CUSTOM, 15)

	-- Glyph of Power Word: Shield -- 57194
	AddRecipe(57194, 80, 42408, Q.COMMON, V.WOTLK, 80, 90, 100, 110)
	self:AddRecipeFlags(57194, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.PRIEST)
	self:AddRecipeTrainer(57194, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Prayer of Healing -- 57195
	AddRecipe(57195, 385, 42409, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57195, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(57195, A.CUSTOM, 15)

	-- Glyph of Psychic Scream -- 57196
	AddRecipe(57196, 95, 42410, Q.COMMON, V.WOTLK, 95, 105, 115, 125)
	self:AddRecipeFlags(57196, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.PRIEST)
	self:AddRecipeTrainer(57196, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Renew -- 57197
	AddRecipe(57197, 160, 42411, Q.COMMON, V.WOTLK, 160, 165, 170, 175)
	self:AddRecipeFlags(57197, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.PRIEST)
	self:AddRecipeTrainer(57197, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Scourge Imprisonment -- 57198
	AddRecipe(57198, 375, 42412, Q.COMMON, V.WOTLK, 375, 380, 385, 390)
	self:AddRecipeFlags(57198, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.PRIEST)
	self:AddRecipeTrainer(57198, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Glyph of Shadow Word: Death -- 57199
	AddRecipe(57199, 385, 42414, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57199, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(57199, A.CUSTOM, 15)

	-- Glyph of Mind Flay -- 57200
	AddRecipe(57200, 180, 42415, Q.COMMON, V.WOTLK, 180, 185, 190, 195)
	self:AddRecipeFlags(57200, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.PRIEST)
	self:AddRecipeTrainer(57200, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Smite -- 57201
	AddRecipe(57201, 210, 42416, Q.COMMON, V.WOTLK, 210, 215, 220, 225)
	self:AddRecipeFlags(57201, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.PRIEST)
	self:AddRecipeTrainer(57201, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Spirit of Redemption -- 57202
	AddRecipe(57202, 385, 42417, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57202, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(57202, A.CUSTOM, 15)

	-- Glyph of Anti-Magic Shell -- 57207
	AddRecipe(57207, 385, 43533, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57207, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DK)
	self:AddRecipeAcquire(57207, A.CUSTOM, 15)

	-- Glyph of Heart Strike -- 57208
	AddRecipe(57208, 385, 43534, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57208, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DK)
	self:AddRecipeAcquire(57208, A.CUSTOM, 15)

	-- Glyph of Blood Tap -- 57209
	AddRecipe(57209, 320, 43535, Q.COMMON, V.WOTLK, 320, 330, 335, 340)
	self:AddRecipeFlags(57209, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DK)
	self:AddRecipeAcquire(57209, A.CUSTOM, 14)

	-- Glyph of Bone Shield -- 57210
	AddRecipe(57210, 265, 43536, Q.COMMON, V.WOTLK, 265, 270, 275, 280)
	self:AddRecipeFlags(57210, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DK)
	self:AddRecipeTrainer(57210, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Chains of Ice -- 57211
	AddRecipe(57211, 385, 43537, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57211, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DK)
	self:AddRecipeAcquire(57211, A.CUSTOM, 15)

	-- Glyph of Death Grip -- 57213
	AddRecipe(57213, 285, 43541, Q.COMMON, V.WOTLK, 285, 290, 295, 300)
	self:AddRecipeFlags(57213, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DK)
	self:AddRecipeTrainer(57213, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Death and Decay -- 57214
	AddRecipe(57214, 385, 43542, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57214, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DK)
	self:AddRecipeAcquire(57214, A.CUSTOM, 15)

	-- Glyph of Death's Embrace -- 57215
	AddRecipe(57215, 300, 43539, Q.COMMON, V.WOTLK, 300, 305, 310, 315)
	self:AddRecipeFlags(57215, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DK)
	self:AddRecipeAcquire(57215, A.CUSTOM, 14)

	-- Glyph of Frost Strike -- 57216
	AddRecipe(57216, 270, 43543, Q.COMMON, V.WOTLK, 270, 275, 280, 285)
	self:AddRecipeFlags(57216, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DK)
	self:AddRecipeTrainer(57216, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Horn of Winter -- 57217
	AddRecipe(57217, 320, 43544, Q.COMMON, V.WOTLK, 320, 330, 335, 340)
	self:AddRecipeFlags(57217, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DK)
	self:AddRecipeAcquire(57217, A.CUSTOM, 14)

	-- Glyph of Icy Touch -- 57219
	AddRecipe(57219, 280, 43546, Q.COMMON, V.WOTLK, 280, 285, 290, 295)
	self:AddRecipeFlags(57219, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DK)
	self:AddRecipeTrainer(57219, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Obliterate -- 57220
	AddRecipe(57220, 385, 43547, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57220, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DK)
	self:AddRecipeAcquire(57220, A.CUSTOM, 15)

	-- Glyph of Pestilence -- 57221
	AddRecipe(57221, 300, 43548, Q.COMMON, V.WOTLK, 300, 305, 310, 315)
	self:AddRecipeFlags(57221, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DK)
	self:AddRecipeTrainer(57221, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Raise Dead -- 57222
	AddRecipe(57222, 350, 43549, Q.COMMON, V.WOTLK, 350, 355, 360, 365)
	self:AddRecipeFlags(57222, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.DK)
	self:AddRecipeTrainer(57222, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Rune Strike -- 57223
	AddRecipe(57223, 385, 43550, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57223, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DK)
	self:AddRecipeAcquire(57223, A.CUSTOM, 15)

	-- Glyph of Scourge Strike -- 57224
	AddRecipe(57224, 330, 43551, Q.COMMON, V.WOTLK, 330, 335, 340, 345)
	self:AddRecipeFlags(57224, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DK)
	self:AddRecipeTrainer(57224, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Strangulate -- 57225
	AddRecipe(57225, 375, 43552, Q.COMMON, V.WOTLK, 375, 380, 385, 390)
	self:AddRecipeFlags(57225, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DK)
	self:AddRecipeTrainer(57225, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Glyph of Pillar of Frost -- 57226
	AddRecipe(57226, 305, 43553, Q.COMMON, V.WOTLK, 305, 310, 315, 320)
	self:AddRecipeFlags(57226, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DK)
	self:AddRecipeTrainer(57226, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Vampiric Blood -- 57227
	AddRecipe(57227, 345, 43554, Q.COMMON, V.WOTLK, 345, 350, 355, 360)
	self:AddRecipeFlags(57227, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DK)
	self:AddRecipeTrainer(57227, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Raise Ally -- 57228
	AddRecipe(57228, 300, 43673, Q.COMMON, V.WOTLK, 300, 305, 310, 315)
	self:AddRecipeFlags(57228, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DK)
	self:AddRecipeAcquire(57228, A.CUSTOM, 14)

	-- Glyph of Path of Frost -- 57229
	AddRecipe(57229, 300, 43671, Q.COMMON, V.WOTLK, 300, 305, 310, 315)
	self:AddRecipeFlags(57229, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DK)
	self:AddRecipeAcquire(57229, A.CUSTOM, 14)

	-- Glyph of Resilient Grip -- 57230
	AddRecipe(57230, 300, 43672, Q.COMMON, V.WOTLK, 300, 305, 310, 315)
	self:AddRecipeFlags(57230, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DK)
	self:AddRecipeAcquire(57230, A.CUSTOM, 14)

	-- Glyph of Chain Heal -- 57232
	AddRecipe(57232, 385, 41517, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57232, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(57232, A.CUSTOM, 15)

	-- Glyph of Chain Lightning -- 57233
	AddRecipe(57233, 385, 41518, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57233, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(57233, A.CUSTOM, 15)

	-- Glyph of Lava Burst -- 57234
	AddRecipe(57234, 385, 41524, Q.COMMON, V.WOTLK, 385, 390, 395, 400)
	self:AddRecipeFlags(57234, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(57234, A.CUSTOM, 15)

	-- Glyph of Shocking -- 57235
	AddRecipe(57235, 385, 41526, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57235, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(57235, A.CUSTOM, 15)

	-- Glyph of Earthliving Weapon -- 57236
	AddRecipe(57236, 300, 41527, Q.COMMON, V.WOTLK, 300, 305, 310, 315)
	self:AddRecipeFlags(57236, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.SHAMAN)
	self:AddRecipeTrainer(57236, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Fire Elemental Totem -- 57237
	AddRecipe(57237, 385, 41529, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57237, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(57237, A.CUSTOM, 15)

	-- Glyph of Fire Nova -- 57238
	AddRecipe(57238, 110, 41530, Q.COMMON, V.WOTLK, 110, 115, 120, 125)
	self:AddRecipeFlags(57238, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.SHAMAN)
	self:AddRecipeTrainer(57238, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Flame Shock -- 57239
	AddRecipe(57239, 85, 41531, Q.COMMON, V.WOTLK, 85, 95, 105, 115)
	self:AddRecipeFlags(57239, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.SHAMAN)
	self:AddRecipeTrainer(57239, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Flametongue Weapon -- 57240
	AddRecipe(57240, 125, 41532, Q.COMMON, V.WOTLK, 125, 130, 135, 140)
	self:AddRecipeFlags(57240, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.SHAMAN)
	self:AddRecipeTrainer(57240, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Frost Shock -- 57241
	AddRecipe(57241, 185, 41547, Q.COMMON, V.WOTLK, 185, 190, 195, 200)
	self:AddRecipeFlags(57241, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.SHAMAN)
	self:AddRecipeTrainer(57241, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Healing Stream Totem -- 57242
	AddRecipe(57242, 215, 41533, Q.COMMON, V.WOTLK, 215, 220, 225, 230)
	self:AddRecipeFlags(57242, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.SHAMAN)
	self:AddRecipeTrainer(57242, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Healing Wave -- 57243
	AddRecipe(57243, 385, 41534, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57243, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(57243, A.CUSTOM, 15)

	-- Glyph of Totemic Recall -- 57244
	AddRecipe(57244, 235, 41535, Q.COMMON, V.WOTLK, 235, 240, 245, 250)
	self:AddRecipeFlags(57244, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.SHAMAN)
	self:AddRecipeTrainer(57244, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Lightning Bolt -- 57245
	AddRecipe(57245, 140, 41536, Q.COMMON, V.WOTLK, 140, 145, 150, 155)
	self:AddRecipeFlags(57245, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.SHAMAN)
	self:AddRecipeTrainer(57245, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Lightning Shield -- 57246
	AddRecipe(57246, 95, 41537, Q.COMMON, V.WOTLK, 95, 105, 115, 125)
	self:AddRecipeFlags(57246, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.SHAMAN)
	self:AddRecipeTrainer(57246, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Grounding Totem -- 57247
	AddRecipe(57247, 385, 41538, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57247, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(57247, A.CUSTOM, 15)

	-- Glyph of Stormstrike -- 57248
	AddRecipe(57248, 375, 41539, Q.COMMON, V.WOTLK, 375, 380, 385, 390)
	self:AddRecipeFlags(57248, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.SHAMAN)
	self:AddRecipeTrainer(57248, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Glyph of Lava Lash -- 57249
	AddRecipe(57249, 165, 41540, Q.COMMON, V.WOTLK, 165, 170, 175, 180)
	self:AddRecipeFlags(57249, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.SHAMAN)
	self:AddRecipeTrainer(57249, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Elemental Mastery -- 57250
	AddRecipe(57250, 385, 41552, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57250, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(57250, A.CUSTOM, 15)

	-- Glyph of Water Shield -- 57251
	AddRecipe(57251, 275, 41541, Q.COMMON, V.WOTLK, 275, 280, 285, 290)
	self:AddRecipeFlags(57251, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.SHAMAN)
	self:AddRecipeTrainer(57251, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Windfury Weapon -- 57252
	AddRecipe(57252, 330, 41542, Q.COMMON, V.WOTLK, 330, 335, 340, 345)
	self:AddRecipeFlags(57252, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER, F.SHAMAN)
	self:AddRecipeTrainer(57252, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Thunderstorm -- 57253
	AddRecipe(57253, 355, 44923, Q.COMMON, V.WOTLK, 355, 355, 360, 365)
	self:AddRecipeFlags(57253, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(57253, A.CUSTOM, 14)

	-- Glyph of Incinerate -- 57257
	AddRecipe(57257, 350, 42453, Q.COMMON, V.WOTLK, 350, 355, 360, 365)
	self:AddRecipeFlags(57257, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARLOCK)
	self:AddRecipeTrainer(57257, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Conflagrate -- 57258
	AddRecipe(57258, 385, 42454, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57258, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(57258, A.CUSTOM, 15)

	-- Glyph of Corruption -- 57259
	AddRecipe(57259, 85, 42455, Q.COMMON, V.WOTLK, 85, 95, 105, 115)
	self:AddRecipeFlags(57259, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARLOCK)
	self:AddRecipeTrainer(57259, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Bane of Agony -- 57260
	AddRecipe(57260, 385, 42456, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57260, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(57260, A.CUSTOM, 15)

	-- Glyph of Death Coil -- 57261
	AddRecipe(57261, 385, 42457, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57261, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(57261, A.CUSTOM, 15)

	-- Glyph of Fear -- 57262
	AddRecipe(57262, 125, 42458, Q.COMMON, V.WOTLK, 125, 130, 135, 140)
	self:AddRecipeFlags(57262, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARLOCK)
	self:AddRecipeTrainer(57262, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Felguard -- 57263
	AddRecipe(57263, 385, 42459, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57263, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(57263, A.CUSTOM, 15)

	-- Glyph of Felhunter -- 57264
	AddRecipe(57264, 385, 42460, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57264, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(57264, A.CUSTOM, 15)

	-- Glyph of Health Funnel -- 57265
	AddRecipe(57265, 110, 42461, Q.COMMON, V.WOTLK, 110, 115, 120, 125)
	self:AddRecipeFlags(57265, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARLOCK)
	self:AddRecipeTrainer(57265, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Healthstone -- 57266
	AddRecipe(57266, 95, 42462, Q.COMMON, V.WOTLK, 95, 105, 115, 125)
	self:AddRecipeFlags(57266, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARLOCK)
	self:AddRecipeTrainer(57266, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Howl of Terror -- 57267
	AddRecipe(57267, 385, 42463, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57267, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(57267, A.CUSTOM, 15)

	-- Glyph of Immolate -- 57268
	AddRecipe(57268, 385, 42464, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57268, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(57268, A.CUSTOM, 15)

	-- Glyph of Imp -- 57269
	AddRecipe(57269, 140, 42465, Q.COMMON, V.WOTLK, 140, 145, 150, 155)
	self:AddRecipeFlags(57269, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARLOCK)
	self:AddRecipeTrainer(57269, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Soul Swap -- 57270
	AddRecipe(57270, 215, 42466, Q.COMMON, V.WOTLK, 215, 220, 225, 230)
	self:AddRecipeFlags(57270, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARLOCK)
	self:AddRecipeTrainer(57270, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Shadow Bolt -- 57271
	AddRecipe(57271, 165, 42467, Q.COMMON, V.WOTLK, 165, 170, 175, 180)
	self:AddRecipeFlags(57271, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARLOCK)
	self:AddRecipeTrainer(57271, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Shadowburn -- 57272
	AddRecipe(57272, 275, 42468, Q.COMMON, V.WOTLK, 275, 280, 285, 290)
	self:AddRecipeFlags(57272, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARLOCK)
	self:AddRecipeTrainer(57272, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Soulstone -- 57274
	AddRecipe(57274, 240, 42470, Q.COMMON, V.WOTLK, 240, 245, 250, 255)
	self:AddRecipeFlags(57274, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARLOCK)
	self:AddRecipeTrainer(57274, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Seduction -- 57275
	AddRecipe(57275, 325, 42471, Q.COMMON, V.WOTLK, 325, 330, 335, 340)
	self:AddRecipeFlags(57275, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARLOCK)
	self:AddRecipeTrainer(57275, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Unstable Affliction -- 57276
	AddRecipe(57276, 385, 42472, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(57276, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(57276, A.CUSTOM, 15)

	-- Glyph of Voidwalker -- 57277
	AddRecipe(57277, 190, 42473, Q.COMMON, V.WOTLK, 190, 195, 200, 205)
	self:AddRecipeFlags(57277, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.WARLOCK)
	self:AddRecipeTrainer(57277, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Hunter's Ink -- 57703
	AddRecipe(57703, 85, 43115, Q.COMMON, V.WOTLK, 85, 85, 90, 95)
	self:AddRecipeFlags(57703, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(57703, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Lion's Ink -- 57704
	AddRecipe(57704, 100, 43116, Q.COMMON, V.WOTLK, 100, 100, 100, 105)
	self:AddRecipeFlags(57704, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(57704, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Dawnstar Ink -- 57706
	AddRecipe(57706, 125, 43117, Q.COMMON, V.WOTLK, 125, 125, 130, 135)
	self:AddRecipeFlags(57706, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(57706, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Jadefire Ink -- 57707
	AddRecipe(57707, 150, 43118, Q.COMMON, V.WOTLK, 150, 150, 150, 155)
	self:AddRecipeFlags(57707, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(57707, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Royal Ink -- 57708
	AddRecipe(57708, 175, 43119, Q.COMMON, V.WOTLK, 175, 175, 175, 180)
	self:AddRecipeFlags(57708, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(57708, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Celestial Ink -- 57709
	AddRecipe(57709, 200, 43120, Q.COMMON, V.WOTLK, 200, 200, 200, 205)
	self:AddRecipeFlags(57709, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(57709, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Fiery Ink -- 57710
	AddRecipe(57710, 225, 43121, Q.COMMON, V.WOTLK, 225, 225, 225, 230)
	self:AddRecipeFlags(57710, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(57710, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Shimmering Ink -- 57711
	AddRecipe(57711, 250, 43122, Q.COMMON, V.WOTLK, 250, 250, 250, 255)
	self:AddRecipeFlags(57711, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(57711, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Ink of the Sky -- 57712
	AddRecipe(57712, 275, 43123, Q.COMMON, V.WOTLK, 275, 290, 295, 300)
	self:AddRecipeFlags(57712, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(57712, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Ethereal Ink -- 57713
	AddRecipe(57713, 290, 43124, Q.COMMON, V.WOTLK, 290, 295, 300, 305)
	self:AddRecipeFlags(57713, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(57713, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Darkflame Ink -- 57714
	AddRecipe(57714, 325, 43125, Q.COMMON, V.WOTLK, 325, 325, 325, 330)
	self:AddRecipeFlags(57714, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(57714, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Ink of the Sea -- 57715
	AddRecipe(57715, 350, 43126, Q.COMMON, V.WOTLK, 350, 350, 350, 355)
	self:AddRecipeFlags(57715, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(57715, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Snowfall Ink -- 57716
	AddRecipe(57716, 375, 43127, Q.COMMON, V.WOTLK, 375, 375, 375, 380)
	self:AddRecipeFlags(57716, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(57716, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Glyph of Aquatic Form -- 58286
	AddRecipe(58286, 75, 43316, Q.COMMON, V.WOTLK, 75, 105, 110, 115)
	self:AddRecipeFlags(58286, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(58286, A.CUSTOM, 14)

	-- Glyph of Challenging Roar -- 58287
	AddRecipe(58287, 150, 43334, Q.COMMON, V.WOTLK, 150, 155, 160, 165)
	self:AddRecipeFlags(58287, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(58287, A.CUSTOM, 14)

	-- Glyph of Unburdened Rebirth -- 58288
	AddRecipe(58288, 95, 43331, Q.COMMON, V.WOTLK, 95, 105, 110, 115)
	self:AddRecipeFlags(58288, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(58288, A.CUSTOM, 14)

	-- Glyph of Thorns -- 58289
	AddRecipe(58289, 75, 43332, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58289, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(58289, A.CUSTOM, 14)

	-- Glyph of the Wild -- 58296
	AddRecipe(58296, 75, 43335, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58296, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(58296, A.CUSTOM, 14)

	-- Glyph of Aspect of the Pack -- 58297
	AddRecipe(58297, 195, 43355, Q.COMMON, V.WOTLK, 195, 205, 210, 215)
	self:AddRecipeFlags(58297, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(58297, A.CUSTOM, 14)

	-- Glyph of Scare Beast -- 58298
	AddRecipe(58298, 75, 43356, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58298, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(58298, A.CUSTOM, 14)

	-- Glyph of Revive Pet -- 58299
	AddRecipe(58299, 75, 43338, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58299, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(58299, A.CUSTOM, 14)

	-- Glyph of Mend Pet -- 58301
	AddRecipe(58301, 75, 43350, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58301, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(58301, A.CUSTOM, 14)

	-- Glyph of Feign Death -- 58302
	AddRecipe(58302, 150, 43351, Q.COMMON, V.WOTLK, 150, 155, 160, 165)
	self:AddRecipeFlags(58302, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(58302, A.CUSTOM, 14)

	-- Glyph of Arcane Intellect -- 58303
	AddRecipe(58303, 75, 43339, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58303, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(58303, A.CUSTOM, 14)

	-- Glyph of Conjuring -- 58306
	AddRecipe(58306, 75, 43359, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58306, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(58306, A.CUSTOM, 14)

	-- Glyph of the Monkey -- 58307
	AddRecipe(58307, 120, 43360, Q.COMMON, V.WOTLK, 120, 130, 135, 140)
	self:AddRecipeFlags(58307, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(58307, A.CUSTOM, 14)

	-- Glyph of Slow Fall -- 58308
	AddRecipe(58308, 75, 43364, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58308, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(58308, A.CUSTOM, 14)

	-- Glyph of the Penguin -- 58310
	AddRecipe(58310, 75, 43361, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58310, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(58310, A.CUSTOM, 14)

	-- Glyph of Blessing of Kings -- 58311
	AddRecipe(58311, 95, 43365, Q.COMMON, V.WOTLK, 95, 105, 110, 115)
	self:AddRecipeFlags(58311, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(58311, A.CUSTOM, 14)

	-- Glyph of Insight -- 58312
	AddRecipe(58312, 75, 43366, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58312, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(58312, A.CUSTOM, 14)

	-- Glyph of Lay on Hands -- 58313
	AddRecipe(58313, 75, 43367, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58313, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(58313, A.CUSTOM, 14)

	-- Glyph of Blessing of Might -- 58314
	AddRecipe(58314, 75, 43340, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58314, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(58314, A.CUSTOM, 14)

	-- Glyph of Truth -- 58315
	AddRecipe(58315, 95, 43368, Q.COMMON, V.WOTLK, 95, 105, 110, 115)
	self:AddRecipeFlags(58315, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(58315, A.CUSTOM, 14)

	-- Glyph of Justice -- 58316
	AddRecipe(58316, 150, 43369, Q.COMMON, V.WOTLK, 150, 155, 160, 165)
	self:AddRecipeFlags(58316, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(58316, A.CUSTOM, 14)

	-- Glyph of Fading -- 58317
	AddRecipe(58317, 75, 43342, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58317, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(58317, A.CUSTOM, 14)

	-- Glyph of Fortitude -- 58318
	AddRecipe(58318, 75, 43371, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58318, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(58318, A.CUSTOM, 14)

	-- Glyph of Levitate -- 58319
	AddRecipe(58319, 170, 43370, Q.COMMON, V.WOTLK, 170, 180, 185, 190)
	self:AddRecipeFlags(58319, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(58319, A.CUSTOM, 14)

	-- Glyph of Shackle Undead -- 58320
	AddRecipe(58320, 95, 43373, Q.COMMON, V.WOTLK, 95, 105, 110, 115)
	self:AddRecipeFlags(58320, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(58320, A.CUSTOM, 14)

	-- Glyph of Shadow Protection -- 58321
	AddRecipe(58321, 150, 43372, Q.COMMON, V.WOTLK, 150, 155, 160, 165)
	self:AddRecipeFlags(58321, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(58321, A.CUSTOM, 14)

	-- Glyph of Shadowfiend -- 58322
	AddRecipe(58322, 345, 43374, Q.COMMON, V.WOTLK, 345, 355, 360, 365)
	self:AddRecipeFlags(58322, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(58322, A.CUSTOM, 14)

	-- Glyph of Blurred Speed -- 58323
	AddRecipe(58323, 75, 43379, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58323, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(58323, A.CUSTOM, 14)

	-- Glyph of Distract -- 58324
	AddRecipe(58324, 120, 43376, Q.COMMON, V.WOTLK, 120, 130, 135, 140)
	self:AddRecipeFlags(58324, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(58324, A.CUSTOM, 14)

	-- Glyph of Pick Lock -- 58325
	AddRecipe(58325, 95, 43377, Q.COMMON, V.WOTLK, 95, 105, 110, 115)
	self:AddRecipeFlags(58325, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(58325, A.CUSTOM, 14)

	-- Glyph of Pick Pocket -- 58326
	AddRecipe(58326, 75, 43343, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58326, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(58326, A.CUSTOM, 14)

	-- Glyph of Safe Fall -- 58327
	AddRecipe(58327, 195, 43378, Q.COMMON, V.WOTLK, 195, 205, 210, 215)
	self:AddRecipeFlags(58327, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(58327, A.CUSTOM, 14)

	-- Glyph of Poisons -- 58328
	AddRecipe(58328, 120, 43380, Q.COMMON, V.WOTLK, 120, 130, 135, 140)
	self:AddRecipeFlags(58328, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(58328, A.CUSTOM, 14)

	-- Glyph of Astral Recall -- 58329
	AddRecipe(58329, 150, 43381, Q.COMMON, V.WOTLK, 150, 155, 160, 165)
	self:AddRecipeFlags(58329, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(58329, A.CUSTOM, 14)

	-- Glyph of Renewed Life -- 58330
	AddRecipe(58330, 150, 43385, Q.COMMON, V.WOTLK, 150, 155, 160, 165)
	self:AddRecipeFlags(58330, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(58330, A.CUSTOM, 14)

	-- Glyph of Water Breathing -- 58331
	AddRecipe(58331, 120, 43344, Q.COMMON, V.WOTLK, 120, 130, 135, 140)
	self:AddRecipeFlags(58331, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(58331, A.CUSTOM, 14)

	-- Glyph of the Arctic Wolf -- 58332
	AddRecipe(58332, 95, 43386, Q.COMMON, V.WOTLK, 95, 105, 110, 115)
	self:AddRecipeFlags(58332, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(58332, A.CUSTOM, 14)

	-- Glyph of Water Walking -- 58333
	AddRecipe(58333, 150, 43388, Q.COMMON, V.WOTLK, 150, 155, 160, 165)
	self:AddRecipeFlags(58333, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(58333, A.CUSTOM, 14)

	-- Glyph of Unending Breath -- 58336
	AddRecipe(58336, 95, 43389, Q.COMMON, V.WOTLK, 95, 105, 110, 115)
	self:AddRecipeFlags(58336, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(58336, A.CUSTOM, 14)

	-- Glyph of Drain Soul -- 58337
	AddRecipe(58337, 75, 43390, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58337, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(58337, A.CUSTOM, 14)

	-- Glyph of Curse of Exhaustion -- 58338
	AddRecipe(58338, 150, 43392, Q.COMMON, V.WOTLK, 150, 155, 160, 165)
	self:AddRecipeFlags(58338, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(58338, A.CUSTOM, 14)

	-- Glyph of Enslave Demon -- 58339
	AddRecipe(58339, 150, 43393, Q.COMMON, V.WOTLK, 150, 155, 160, 165)
	self:AddRecipeFlags(58339, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(58339, A.CUSTOM, 14)

	-- Glyph of Kilrogg -- 58340
	AddRecipe(58340, 120, 43391, Q.COMMON, V.WOTLK, 120, 130, 135, 140)
	self:AddRecipeFlags(58340, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(58340, A.CUSTOM, 14)

	-- Glyph of Souls -- 58341
	AddRecipe(58341, 345, 43394, Q.COMMON, V.WOTLK, 345, 355, 360, 365)
	self:AddRecipeFlags(58341, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(58341, A.CUSTOM, 14)

	-- Glyph of Battle -- 58342
	AddRecipe(58342, 75, 43395, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58342, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(58342, A.CUSTOM, 14)

	-- Glyph of Berserker Rage -- 58343
	AddRecipe(58343, 75, 43396, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58343, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(58343, A.CUSTOM, 14)

	-- Glyph of Long Charge -- 58344
	AddRecipe(58344, 75, 43397, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58344, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(58344, A.CUSTOM, 14)

	-- Glyph of Demoralizing Shout -- 58345
	AddRecipe(58345, 95, 43398, Q.COMMON, V.WOTLK, 95, 105, 110, 115)
	self:AddRecipeFlags(58345, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(58345, A.CUSTOM, 14)

	-- Glyph of Thunder Clap -- 58346
	AddRecipe(58346, 75, 43399, Q.COMMON, V.WOTLK, 75, 80, 85, 90)
	self:AddRecipeFlags(58346, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(58346, A.CUSTOM, 14)

	-- Glyph of Enduring Victory -- 58347
	AddRecipe(58347, 320, 43400, Q.COMMON, V.WOTLK, 320, 330, 335, 340)
	self:AddRecipeFlags(58347, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(58347, A.CUSTOM, 14)

	-- Scroll of Agility -- 58472
	AddRecipe(58472, 15, 3012, Q.COMMON, V.WOTLK, 15, 35, 40, 45)
	self:AddRecipeFlags(58472, F.RBOP, F.TANK, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(58472, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Agility II -- 58473
	AddRecipe(58473, 85, 1477, Q.COMMON, V.WOTLK, 85, 85, 90, 95)
	self:AddRecipeFlags(58473, F.RBOP, F.TANK, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(58473, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Agility III -- 58476
	AddRecipe(58476, 175, 4425, Q.COMMON, V.WOTLK, 175, 180, 185, 190)
	self:AddRecipeFlags(58476, F.RBOP, F.TANK, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(58476, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Agility IV -- 58478
	AddRecipe(58478, 225, 10309, Q.COMMON, V.WOTLK, 225, 230, 235, 240)
	self:AddRecipeFlags(58478, F.RBOP, F.TANK, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(58478, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Agility V -- 58480
	AddRecipe(58480, 270, 27498, Q.COMMON, V.WOTLK, 270, 275, 280, 285)
	self:AddRecipeFlags(58480, F.RBOP, F.TANK, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(58480, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Agility VI -- 58481
	AddRecipe(58481, 310, 33457, Q.COMMON, V.WOTLK, 310, 320, 325, 330)
	self:AddRecipeFlags(58481, F.RBOP, F.TANK, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(58481, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Agility VII -- 58482
	AddRecipe(58482, 370, 43463, Q.COMMON, V.WOTLK, 370, 375, 380, 385)
	self:AddRecipeFlags(58482, F.RBOP, F.TANK, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(58482, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Scroll of Agility VIII -- 58483
	AddRecipe(58483, 420, 43464, Q.COMMON, V.WOTLK, 420, 425, 430, 435)
	self:AddRecipeFlags(58483, F.RBOP, F.TANK, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(58483, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Scroll of Strength -- 58484
	AddRecipe(58484, 15, 954, Q.COMMON, V.WOTLK, 15, 35, 40, 45)
	self:AddRecipeFlags(58484, F.RBOP, F.TANK, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(58484, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Strength II -- 58485
	AddRecipe(58485, 80, 2289, Q.COMMON, V.WOTLK, 80, 80, 85, 90)
	self:AddRecipeFlags(58485, F.RBOP, F.TANK, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(58485, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Strength III -- 58486
	AddRecipe(58486, 170, 4426, Q.COMMON, V.WOTLK, 170, 175, 180, 185)
	self:AddRecipeFlags(58486, F.RBOP, F.TANK, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(58486, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Strength IV -- 58487
	AddRecipe(58487, 220, 10310, Q.COMMON, V.WOTLK, 220, 225, 230, 235)
	self:AddRecipeFlags(58487, F.RBOP, F.TANK, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(58487, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Strength V -- 58488
	AddRecipe(58488, 265, 27503, Q.COMMON, V.WOTLK, 265, 270, 275, 280)
	self:AddRecipeFlags(58488, F.RBOP, F.TANK, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(58488, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Strength VI -- 58489
	AddRecipe(58489, 305, 33462, Q.COMMON, V.WOTLK, 305, 315, 320, 325)
	self:AddRecipeFlags(58489, F.RBOP, F.TANK, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(58489, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Strength VII -- 58490
	AddRecipe(58490, 365, 43465, Q.COMMON, V.WOTLK, 365, 370, 375, 380)
	self:AddRecipeFlags(58490, F.RBOP, F.TANK, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(58490, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Scroll of Strength VIII -- 58491
	AddRecipe(58491, 415, 43466, Q.COMMON, V.WOTLK, 415, 420, 425, 430)
	self:AddRecipeFlags(58491, F.RBOP, F.TANK, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(58491, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Mystic Tome -- 58565
	AddRecipe(58565, 110, 43515, Q.COMMON, V.WOTLK, 110, 125, 137, 150)
	self:AddRecipeFlags(58565, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.ONE_HAND)
	self:AddRecipeTrainer(58565, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Dash -- 59315
	AddRecipe(59315, 150, 43674, Q.COMMON, V.WOTLK, 150, 155, 160, 165)
	self:AddRecipeFlags(59315, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(59315, A.CUSTOM, 14)

	-- Glyph of Ghost Wolf -- 59326
	AddRecipe(59326, 95, 43725, Q.COMMON, V.WOTLK, 95, 105, 110, 115)
	self:AddRecipeFlags(59326, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(59326, A.CUSTOM, 14)

	-- Glyph of Rune Tap -- 59338
	AddRecipe(59338, 310, 43825, Q.COMMON, V.WOTLK, 310, 315, 320, 325)
	self:AddRecipeFlags(59338, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DK)
	self:AddRecipeTrainer(59338, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Blood Boil -- 59339
	AddRecipe(59339, 320, 43826, Q.COMMON, V.WOTLK, 320, 325, 330, 335)
	self:AddRecipeFlags(59339, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DK)
	self:AddRecipeTrainer(59339, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Glyph of Death Strike -- 59340
	AddRecipe(59340, 340, 43827, Q.COMMON, V.WOTLK, 340, 345, 350, 355)
	self:AddRecipeFlags(59340, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DK)
	self:AddRecipeTrainer(59340, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Certificate of Ownership -- 59387
	AddRecipe(59387, 200, 43850, Q.COMMON, V.WOTLK, 200, 205, 210, 215)
	self:AddRecipeFlags(59387, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.HUNTER)
	self:AddRecipeTrainer(59387, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Tome of the Dawn -- 59475
	AddRecipe(59475, 125, 43654, Q.COMMON, V.WOTLK, 125, 150, 162, 175)
	self:AddRecipeFlags(59475, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.ONE_HAND)
	self:AddRecipeTrainer(59475, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Book of Survival -- 59478
	AddRecipe(59478, 125, 43655, Q.COMMON, V.WOTLK, 125, 150, 162, 175)
	self:AddRecipeFlags(59478, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.ONE_HAND)
	self:AddRecipeTrainer(59478, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Strange Tarot -- 59480
	AddRecipe(59480, 125, nil, Q.COMMON, V.WOTLK, 125, 150, 162, 175)
	self:AddRecipeFlags(59480, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(59480, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Tome of Kings -- 59484
	AddRecipe(59484, 175, 43656, Q.COMMON, V.WOTLK, 175, 200, 205, 210)
	self:AddRecipeFlags(59484, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.ONE_HAND)
	self:AddRecipeTrainer(59484, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Royal Guide of Escape Routes -- 59486
	AddRecipe(59486, 175, 43657, Q.COMMON, V.WOTLK, 175, 200, 205, 210)
	self:AddRecipeFlags(59486, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.ONE_HAND)
	self:AddRecipeTrainer(59486, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Arcane Tarot -- 59487
	AddRecipe(59487, 175, nil, Q.COMMON, V.WOTLK, 175, 200, 205, 210)
	self:AddRecipeFlags(59487, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(59487, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Fire Eater's Guide -- 59489
	AddRecipe(59489, 225, 43660, Q.COMMON, V.WOTLK, 225, 240, 245, 250)
	self:AddRecipeFlags(59489, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.ONE_HAND)
	self:AddRecipeTrainer(59489, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Book of Stars -- 59490
	AddRecipe(59490, 225, 43661, Q.COMMON, V.WOTLK, 225, 240, 245, 250)
	self:AddRecipeFlags(59490, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.ONE_HAND)
	self:AddRecipeTrainer(59490, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Shadowy Tarot -- 59491
	AddRecipe(59491, 225, nil, Q.COMMON, V.WOTLK, 225, 240, 245, 250)
	self:AddRecipeFlags(59491, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(59491, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Stormbound Tome -- 59493
	AddRecipe(59493, 275, 43663, Q.COMMON, V.WOTLK, 275, 290, 295, 300)
	self:AddRecipeFlags(59493, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.ONE_HAND)
	self:AddRecipeTrainer(59493, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Manual of Clouds -- 59494
	AddRecipe(59494, 275, 43664, Q.COMMON, V.WOTLK, 275, 290, 295, 300)
	self:AddRecipeFlags(59494, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.ONE_HAND)
	self:AddRecipeTrainer(59494, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Hellfire Tome -- 59495
	AddRecipe(59495, 325, 43666, Q.COMMON, V.WOTLK, 325, 340, 345, 350)
	self:AddRecipeFlags(59495, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.ONE_HAND)
	self:AddRecipeTrainer(59495, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Book of Clever Tricks -- 59496
	AddRecipe(59496, 325, 43667, Q.COMMON, V.WOTLK, 325, 340, 345, 350)
	self:AddRecipeFlags(59496, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.ONE_HAND)
	self:AddRecipeTrainer(59496, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Iron-bound Tome -- 59497
	AddRecipe(59497, 400, 38322, Q.COMMON, V.WOTLK, 400, 425, 437, 450)
	self:AddRecipeFlags(59497, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.ONE_HAND)
	self:AddRecipeTrainer(59497, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Faces of Doom -- 59498
	AddRecipe(59498, 400, 44210, Q.COMMON, V.WOTLK, 400, 425, 437, 450)
	self:AddRecipeFlags(59498, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.ONE_HAND)
	self:AddRecipeTrainer(59498, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Darkmoon Card -- 59502
	AddRecipe(59502, 275, nil, Q.COMMON, V.WOTLK, 275, 290, 295, 300)
	self:AddRecipeFlags(59502, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(59502, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Greater Darkmoon Card -- 59503
	AddRecipe(59503, 325, nil, Q.COMMON, V.WOTLK, 325, 340, 345, 350)
	self:AddRecipeFlags(59503, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(59503, 26959, 30721, 33603, 30722, 33679, 26995, 26977, 26916, 28702, 33615)

	-- Darkmoon Card of the North -- 59504
	AddRecipe(59504, 400, nil, Q.COMMON, V.WOTLK, 400, 425, 450, 475)
	self:AddRecipeFlags(59504, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(59504, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Glyph of Holy Wrath -- 59559
	AddRecipe(59559, 385, 43867, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(59559, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(59559, A.CUSTOM, 15)

	-- Glyph of Dazing Shield -- 59560
	AddRecipe(59560, 385, 43868, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(59560, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(59560, A.CUSTOM, 15)

	-- Glyph of Seal of Truth -- 59561
	AddRecipe(59561, 385, 43869, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(59561, F.RBOP, F.IBOE, F.DPS, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(59561, A.CUSTOM, 15)

	-- Scroll of Recall II -- 60336
	AddRecipe(60336, 200, 44314, Q.COMMON, V.WOTLK, 200, 215, 220, 225)
	self:AddRecipeFlags(60336, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(60336, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Scroll of Recall III -- 60337
	AddRecipe(60337, 350, 44315, Q.COMMON, V.WOTLK, 350, 350, 350, 355)
	self:AddRecipeFlags(60337, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(60337, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Master's Inscription of the Axe -- 61117
	AddRecipe(61117, 400, nil, Q.COMMON, V.WOTLK, 400, 400, 400, 405)
	self:AddRecipeFlags(61117, F.RBOP, F.IBOE, F.DPS, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(61117, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Master's Inscription of the Crag -- 61118
	AddRecipe(61118, 400, nil, Q.COMMON, V.WOTLK, 400, 400, 400, 405)
	self:AddRecipeFlags(61118, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(61118, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Master's Inscription of the Pinnacle -- 61119
	AddRecipe(61119, 400, nil, Q.COMMON, V.WOTLK, 400, 400, 400, 405)
	self:AddRecipeFlags(61119, F.RBOP, F.TANK, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(61119, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Master's Inscription of the Storm -- 61120
	AddRecipe(61120, 400, nil, Q.COMMON, V.WOTLK, 400, 400, 400, 405)
	self:AddRecipeFlags(61120, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(61120, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Northrend Inscription Research -- 61177
	AddRecipe(61177, 385, nil, Q.COMMON, V.WOTLK, 385, 425, 437, 450)
	self:AddRecipeFlags(61177, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(61177, 26916, 26959, 26995, 33603, 33679, 26977, 28702)

	-- Minor Inscription Research -- 61288
	AddRecipe(61288, 75, nil, Q.COMMON, V.WOTLK, 75, 125, 137, 150)
	self:AddRecipeFlags(61288, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(61288, 26995, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 30715)

	-- Glyph of Frostfire -- 61677
	AddRecipe(61677, 385, 44684, Q.COMMON, V.WOTLK, 385, 390, 397, 405)
	self:AddRecipeFlags(61677, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(61677, A.CUSTOM, 15)

	-- Glyph of Focus -- 62162
	AddRecipe(62162, 375, 44928, Q.COMMON, V.WOTLK, 375, 380, 385, 390)
	self:AddRecipeFlags(62162, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DRUID)
	self:AddRecipeTrainer(62162, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Rituals of the New Moon -- 64051
	AddRecipe(64051, 350, 46108, Q.UNCOMMON, V.WOTLK, 350, 375, 387, 400)
	self:AddRecipeFlags(64051, F.MOB_DROP, F.CASTER, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.ONE_HAND)
	self:AddRecipeMobDrop(64051, 26708, 26679, 27676, 27546)

	-- Twilight Tome -- 64053
	AddRecipe(64053, 350, 45849, Q.COMMON, V.WOTLK, 350, 375, 387, 400)
	self:AddRecipeFlags(64053, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.ALLIANCE, F.HORDE, F.TRAINER, F.ONE_HAND)
	self:AddRecipeTrainer(64053, 26916, 26959, 26995, 28702, 26977, 33603)

	-- Glyph of Raptor Strike -- 64246
	AddRecipe(64246, 425, 45735, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64246, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(64246, A.CUSTOM, 40)

	-- Glyph of Stoneclaw Totem -- 64247
	AddRecipe(64247, 425, 45778, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64247, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(64247, A.CUSTOM, 40)

	-- Glyph of Life Tap -- 64248
	AddRecipe(64248, 425, 45785, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64248, F.CASTER, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(64248, A.CUSTOM, 40)

	-- Glyph of Scatter Shot -- 64249
	AddRecipe(64249, 425, 45734, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64249, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(64249, A.CUSTOM, 40)

	-- Glyph of Soul Link -- 64250
	AddRecipe(64250, 425, 45789, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64250, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(64250, A.CUSTOM, 40)

	-- Glyph of Salvation -- 64251
	AddRecipe(64251, 425, 45747, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64251, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(64251, A.CUSTOM, 40)

	-- Glyph of Shield Wall -- 64252
	AddRecipe(64252, 425, 45797, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64252, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(64252, A.CUSTOM, 40)

	-- Glyph of Master's Call -- 64253
	AddRecipe(64253, 425, 45733, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64253, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(64253, A.CUSTOM, 40)

	-- Glyph of Holy Shock -- 64254
	AddRecipe(64254, 425, 45746, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64254, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(64254, A.CUSTOM, 40)

	-- Glyph of Furious Sundering -- 64255
	AddRecipe(64255, 425, 45793, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64255, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(64255, A.CUSTOM, 40)

	-- Glyph of Barkskin -- 64256
	AddRecipe(64256, 425, 45623, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64256, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(64256, A.CUSTOM, 40)

	-- Glyph of Ice Barrier -- 64257
	AddRecipe(64257, 425, 45740, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64257, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(64257, A.CUSTOM, 40)

	-- Glyph of Monsoon -- 64258
	AddRecipe(64258, 250, 45622, Q.COMMON, V.WOTLK, 250, 255, 262, 270)
	self:AddRecipeFlags(64258, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DRUID)
	self:AddRecipeTrainer(64258, 30715, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 26995)

	-- Glyph of Pain Suppression -- 64259
	AddRecipe(64259, 255, 45760, Q.COMMON, V.WOTLK, 255, 255, 262, 270)
	self:AddRecipeFlags(64259, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.PRIEST)
	self:AddRecipeTrainer(64259, 30715, 30716, 30717, 33603, 30706, 30722, 30709, 30710, 28702, 30711, 33615, 26959, 26977, 30713, 26916, 30721, 33679)

	-- Glyph of Mutilate -- 64260
	AddRecipe(64260, 255, 45768, Q.COMMON, V.WOTLK, 255, 255, 262, 270)
	self:AddRecipeFlags(64260, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.ROGUE)
	self:AddRecipeTrainer(64260, 30715, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 26995)

	-- Glyph of Earth Shield -- 64261
	AddRecipe(64261, 250, 45775, Q.COMMON, V.WOTLK, 250, 255, 262, 270)
	self:AddRecipeFlags(64261, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.SHAMAN)
	self:AddRecipeTrainer(64261, 30715, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 26995)

	-- Glyph of Shamanistic Rage -- 64262
	AddRecipe(64262, 255, 45776, Q.COMMON, V.WOTLK, 255, 255, 262, 270)
	self:AddRecipeFlags(64262, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.SHAMAN)
	self:AddRecipeTrainer(64262, 30715, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 26995)

	-- Glyph of Death Coil -- 64266
	AddRecipe(64266, 275, 45804, Q.COMMON, V.WOTLK, 275, 280, 287, 295)
	self:AddRecipeFlags(64266, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DK)
	self:AddRecipeTrainer(64266, 30715, 30716, 28702, 33603, 30706, 30722, 30709, 26977, 26959, 30721, 30711, 33615, 30717, 33679, 30713, 26916, 30710, 26995)

	-- Glyph of Berserk -- 64268
	AddRecipe(64268, 425, 45601, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64268, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(64268, A.CUSTOM, 40)

	-- Glyph of Wild Growth -- 64270
	AddRecipe(64270, 425, 45602, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64270, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(64270, A.CUSTOM, 40)

	-- Glyph of Chimera Shot -- 64271
	AddRecipe(64271, 425, 45625, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64271, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(64271, A.CUSTOM, 40)

	-- Glyph of Explosive Shot -- 64273
	AddRecipe(64273, 425, 45731, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64273, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(64273, A.CUSTOM, 40)

	-- Glyph of Deep Freeze -- 64274
	AddRecipe(64274, 425, 45736, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64274, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(64274, A.CUSTOM, 40)

	-- Glyph of Slow -- 64275
	AddRecipe(64275, 425, 45737, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64275, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(64275, A.CUSTOM, 40)

	-- Glyph of Arcane Barrage -- 64276
	AddRecipe(64276, 425, 45738, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64276, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(64276, A.CUSTOM, 40)

	-- Glyph of Beacon of Light -- 64277
	AddRecipe(64277, 425, 45741, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64277, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(64277, A.CUSTOM, 40)

	-- Glyph of Hammer of the Righteous -- 64278
	AddRecipe(64278, 425, 45742, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64278, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(64278, A.CUSTOM, 40)

	-- Glyph of Templar's Verdict -- 64279
	AddRecipe(64279, 425, 45743, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64279, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(64279, A.CUSTOM, 40)

	-- Glyph of Dispersion -- 64280
	AddRecipe(64280, 425, 45753, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64280, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(64280, A.CUSTOM, 40)

	-- Glyph of Guardian Spirit -- 64281
	AddRecipe(64281, 425, 45755, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64281, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(64281, A.CUSTOM, 40)

	-- Glyph of Penance -- 64282
	AddRecipe(64282, 425, 45756, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64282, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(64282, A.CUSTOM, 40)

	-- Glyph of Divine Accuracy -- 64283
	AddRecipe(64283, 425, 45758, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64283, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(64283, A.CUSTOM, 40)

	-- Glyph of Vendetta -- 64284
	AddRecipe(64284, 425, 45761, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64284, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(64284, A.CUSTOM, 40)

	-- Glyph of Killing Spree -- 64285
	AddRecipe(64285, 425, 45762, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64285, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(64285, A.CUSTOM, 40)

	-- Glyph of Shadow Dance -- 64286
	AddRecipe(64286, 425, 45764, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64286, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(64286, A.CUSTOM, 40)

	-- Glyph of Thunder -- 64287
	AddRecipe(64287, 425, 45770, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64287, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(64287, A.CUSTOM, 40)

	-- Glyph of Feral Spirit -- 64288
	AddRecipe(64288, 425, 45771, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64288, F.CASTER, F.RBOP, F.IBOE, F.HEALER, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(64288, A.CUSTOM, 40)

	-- Glyph of Riptide -- 64289
	AddRecipe(64289, 425, 45772, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64289, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(64289, A.CUSTOM, 40)

	-- Glyph of Haunt -- 64291
	AddRecipe(64291, 425, 45779, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64291, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(64291, A.CUSTOM, 40)

	-- Glyph of Chaos Bolt -- 64294
	AddRecipe(64294, 425, 45781, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64294, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(64294, A.CUSTOM, 40)

	-- Glyph of Bladestorm -- 64295
	AddRecipe(64295, 425, 45790, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64295, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(64295, A.CUSTOM, 40)

	-- Glyph of Shockwave -- 64296
	AddRecipe(64296, 425, 45792, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64296, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(64296, A.CUSTOM, 40)

	-- Glyph of Dancing Rune Weapon -- 64297
	AddRecipe(64297, 425, 45799, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64297, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DK)
	self:AddRecipeAcquire(64297, A.CUSTOM, 40)

	-- Glyph of Hungering Cold -- 64298
	AddRecipe(64298, 425, 45800, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64298, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DK)
	self:AddRecipeAcquire(64298, A.CUSTOM, 40)

	-- Glyph of Howling Blast -- 64300
	AddRecipe(64300, 425, 45806, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64300, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DK)
	self:AddRecipeAcquire(64300, A.CUSTOM, 40)

	-- Glyph of Spell Reflection -- 64302
	AddRecipe(64302, 425, 45795, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64302, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(64302, A.CUSTOM, 40)

	-- Glyph of Cloak of Shadows -- 64303
	AddRecipe(64303, 425, 45769, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64303, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(64303, A.CUSTOM, 40)

	-- Glyph of Kill Shot -- 64304
	AddRecipe(64304, 425, 45732, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64304, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.HUNTER)
	self:AddRecipeAcquire(64304, A.CUSTOM, 40)

	-- Glyph of Divine Plea -- 64305
	AddRecipe(64305, 425, 45745, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64305, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(64305, A.CUSTOM, 40)

	-- Glyph of Savage Roar -- 64307
	AddRecipe(64307, 425, 45604, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64307, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(64307, A.CUSTOM, 40)

	-- Glyph of Shield of the Righteous -- 64308
	AddRecipe(64308, 425, 45744, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64308, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PALADIN)
	self:AddRecipeAcquire(64308, A.CUSTOM, 40)

	-- Glyph of Spirit Tap -- 64309
	AddRecipe(64309, 425, 45757, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64309, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.PRIEST)
	self:AddRecipeAcquire(64309, A.CUSTOM, 40)

	-- Glyph of Tricks of the Trade -- 64310
	AddRecipe(64310, 425, 45767, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64310, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(64310, A.CUSTOM, 40)

	-- Glyph of Shadowflame -- 64311
	AddRecipe(64311, 425, 45783, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64311, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(64311, A.CUSTOM, 40)

	-- Glyph of Intimidating Shout -- 64312
	AddRecipe(64312, 425, 45794, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64312, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(64312, A.CUSTOM, 40)

	-- Glyph of Starsurge -- 64313
	AddRecipe(64313, 425, 45603, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64313, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeAcquire(64313, A.CUSTOM, 40)

	-- Glyph of Mirror Image -- 64314
	AddRecipe(64314, 425, 45739, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64314, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(64314, A.CUSTOM, 40)

	-- Glyph of Fan of Knives -- 64315
	AddRecipe(64315, 425, 45766, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64315, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeAcquire(64315, A.CUSTOM, 40)

	-- Glyph of Hex -- 64316
	AddRecipe(64316, 425, 45777, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64316, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.SHAMAN)
	self:AddRecipeAcquire(64316, A.CUSTOM, 40)

	-- Glyph of Demonic Circle -- 64317
	AddRecipe(64317, 425, 45782, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64317, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(64317, A.CUSTOM, 40)

	-- Glyph of Metamorphosis -- 64318
	AddRecipe(64318, 425, 45780, Q.COMMON, V.WOTLK, 425, 430, 435, 440)
	self:AddRecipeFlags(64318, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeAcquire(64318, A.CUSTOM, 40)

	-- Glyph of Ferocious Bite -- 67600
	AddRecipe(67600, 100, 48720, Q.COMMON, V.WOTLK, 100, 105, 110, 115)
	self:AddRecipeFlags(67600, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER, F.DRUID)
	self:AddRecipeTrainer(67600, 30710, 28702, 26959, 30706, 33679, 30722, 33603)

	-- Glyph of Command -- 68166
	AddRecipe(68166, 355, 49084, Q.COMMON, V.WOTLK, 355, 355, 360, 365)
	self:AddRecipeFlags(68166, F.RBOP, F.IBOE, F.DISC, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(68166, A.CUSTOM, 14)

	-- Runescroll of Fortitude -- 69385
	AddRecipe(69385, 440, 49632, Q.COMMON, V.WOTLK, 440, 440, 442, 460)
	self:AddRecipeFlags(69385, F.RBOP, F.IBOE, F.ALLIANCE, F.HORDE, F.TRAINER)
	self:AddRecipeTrainer(69385, 26916, 28702, 26995, 26959, 26977, 33603)

	-- Glyph of Mana Shield -- 71101
	AddRecipe(71101, 250, 50045, Q.COMMON, V.WOTLK, 250, 255, 260, 265)
	self:AddRecipeFlags(71101, F.VENDOR, F.RBOE, F.CASTER, F.IBOE, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeVendor(71101, 30734, 30735, 28723)

	-- Glyph of Lash of Pain -- 71102
	AddRecipe(71102, 375, 50077, Q.COMMON, V.WOTLK, 375, 380, 382, 385)
	self:AddRecipeFlags(71102, F.VENDOR, F.RBOE, F.CASTER, F.IBOE, F.ALLIANCE, F.HORDE, F.WARLOCK)
	self:AddRecipeVendor(71102, 28723)
	
	-- Glyph of Colossus Smash -- 89815
	AddRecipe(89815, 430, 63481, Q.COMMON, V.WOTLK, 430, 430, 435, 440)
	self:AddRecipeFlags(89815, F.VENDOR, F.RBOE, F.IBOE, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeAcquire(89815, A.CUSTOM, 40)

	-- Vanishing Powder -- 92026
	AddRecipe(92026, 75, 64670, Q.COMMON, V.WOTLK, 75, 90, 100, 110)
	self:AddRecipeFlags(92026, F.TRAINER, F.RBOE, F.IBOE, F.ALLIANCE, F.HORDE)
	self:AddRecipeTrainer(92026, 30706, 30713, 30717, 28702)

	-- Glyph of Blind -- 92579
	AddRecipe(92579, 180, 64493, Q.COMMON, V.WOTLK, 180, 185, 190, 195)
	self:AddRecipeFlags(92579, F.TRAINER, F.RBOE, F.IBOE, F.ALLIANCE, F.HORDE, F.ROGUE)
	self:AddRecipeTrainer(92579, 30706, 30713, 30717, 28702)

	-- Glyph of Living Bomb -- 94000
	AddRecipe(94000, 390, 63539, Q.COMMON, V.WOTLK, 390, 390, 397, 405)
	self:AddRecipeFlags(94000, F.DISC, F.RBOE, F.CASTER, F.IBOE, F.ALLIANCE, F.HORDE, F.MAGE)
	self:AddRecipeAcquire(94000, A.CUSTOM, 15)

	-- Glyph of Tiger's Fury -- 94401
	AddRecipe(94401, 120, 67487, Q.COMMON, V.WOTLK, 120, 125, 130, 135)
	self:AddRecipeFlags(94401, F.TRAINER, F.RBOE, F.IBOE, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeTrainer(94401, 30706, 30713, 30717, 28702)

	-- Glyph of Lacerate -- 94402
	AddRecipe(94402, 330, 67484, Q.COMMON, V.WOTLK, 330, 335, 340, 345)
	self:AddRecipeFlags(94402, F.TRAINER, F.RBOE, F.IBOE, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeTrainer(94402, 30706, 30713, 30717, 28702)

	-- Glyph of Faerie Fire -- 94403
	AddRecipe(94403, 120, 67485, Q.COMMON, V.WOTLK, 120, 125, 130, 135)
	self:AddRecipeFlags(94403, F.TRAINER, F.RBOE, F.IBOE, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeTrainer(94403, 30706, 30713, 30717, 28702)

	-- Glyph of Feral Charge -- 94404
	AddRecipe(94404, 150, 67486, Q.COMMON, V.WOTLK, 150, 155, 160, 165)
	self:AddRecipeFlags(94404, F.TRAINER, F.RBOE, F.IBOE, F.ALLIANCE, F.HORDE, F.DRUID)
	self:AddRecipeTrainer(94404, 30706, 30713, 30717, 28702)

	-- Glyph of Death Wish -- 94405
	AddRecipe(94405, 150, 67483, Q.COMMON, V.WOTLK, 150, 155, 160, 165)
	self:AddRecipeFlags(94405, F.TRAINER, F.RBOE, F.IBOE, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeTrainer(94405, 30706, 30713, 30717, 28702)

	-- Glyph of Intercept -- 94406
	AddRecipe(94406, 250, 67482, Q.COMMON, V.WOTLK, 250, 255, 260, 265)
	self:AddRecipeFlags(94406, F.TRAINER, F.RBOE, F.IBOE, F.ALLIANCE, F.HORDE, F.WARRIOR)
	self:AddRecipeTrainer(94406, 30706, 30713, 30717, 28702)

	return num_recipes
end
