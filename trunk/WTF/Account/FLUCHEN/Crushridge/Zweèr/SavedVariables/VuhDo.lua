
VUHDO_CONFIG = {
	["SMARTCAST_CLEANSE"] = true,
	["RANGE_SPELL"] = "Heal",
	["BLIZZ_UI_HIDE_PARTY"] = true,
	["CLUSTER"] = {
		["BELOW_HEALTH_PERC"] = 85,
		["CHAIN_MAX_JUMP"] = 3,
		["DISPLAY_DESTINATION"] = 2,
		["IS_NUMBER"] = false,
		["MODE"] = 1,
		["DISPLAY_SOURCE"] = 1,
		["REFRESH"] = 100,
		["THRESH_GOOD"] = 5,
		["COOLDOWN_SPELL"] = "",
		["RANGE"] = 10,
		["THRESH_FAIR"] = 3,
	},
	["OMIT_PLAYER_TARGETS"] = false,
	["BLIZZ_UI_HIDE_TARGET"] = true,
	["MAX_EMERGENCIES"] = 5,
	["INC_BOMBED_SECS"] = 3,
	["SHOW_INC_BOMBED"] = true,
	["STANDARD_TOOLTIP"] = false,
	["VERSION"] = 2,
	["SHOW_INC_HOTS"] = true,
	["SHOW_INC_CHANNELLED"] = true,
	["DETECT_DEBUFFS_IGNORE_DURATION"] = true,
	["SHOW_INC_CASTED"] = true,
	["PLAYER_TARGET_FRAME_THICKNESS"] = 1,
	["SCAN_RANGE"] = "2",
	["INC_CHANNELLED_SECS"] = 3,
	["SHOW_OVERHEAL"] = true,
	["OMIT_MAIN_ASSIST"] = false,
	["ON_MOUSE_UP"] = false,
	["BLIZZ_UI_HIDE_PLAYER"] = true,
	["DIRECTION"] = {
		["isDistanceText"] = true,
		["enable"] = true,
		["isDeadOnly"] = false,
		["scale"] = 76,
	},
	["RES_ANNOUNCE_TEXT"] = "Wè vuhdo, che stai facendo scemo pagliaccio? Vedi di non farti ressare da nessun altro, pirla!!!",
	["BLIZZ_UI_HIDE_FOCUS"] = 1,
	["DETECT_DEBUFFS_IGNORE_NO_HARM"] = true,
	["DETECT_DEBUFFS_IGNORE_BY_CLASS"] = true,
	["SHOW_OVERHEAL_EXTRA"] = true,
	["RANGE_PESSIMISTIC"] = false,
	["SMARTCAST_RESURRECT"] = true,
	["BLIZZ_UI_HIDE_PET"] = 1,
	["OVERHEAL_EXTRA_SCALE"] = 1,
	["INC_HOTS_SECS"] = 3,
	["SMARTCAST_BUFF"] = false,
	["CUSTOM_DEBUFF"] = {
		["point"] = "TOPRIGHT",
		["scale"] = 0.5,
		["STORED"] = {
			"Acid-Drenched Mandibles", -- [1]
			"Boiling Blood", -- [2]
			"Burning Bile", -- [3]
			"Chilled to the Bone", -- [4]
			"Corrosion", -- [5]
			"Dark Essence", -- [6]
			"Defile", -- [7]
			"Delirious Slash", -- [8]
			"Emerald Vigor", -- [9]
			"Essence of the Blood Queen", -- [10]
			"Expose Weakness", -- [11]
			"Feral Pounce", -- [12]
			"Fire Bomb", -- [13]
			"Frenzied Bloodthirst", -- [14]
			"Frost Beacon", -- [15]
			"Frost Blast", -- [16]
			"Frost Breath", -- [17]
			"Gas Spore", -- [18]
			"Gaseous Bloat", -- [19]
			"Gastric Bloat", -- [20]
			"Glittering Sparks", -- [21]
			"Gravity Bomb", -- [22]
			"Grievous Bite", -- [23]
			"Gut Spray", -- [24]
			"Harvest Soul", -- [25]
			"Ice Tomb", -- [26]
			"Impale", -- [27]
			"Impaled", -- [28]
			"Incinerate Flesh", -- [29]
			"Infest", -- [30]
			"Inoculated", -- [31]
			"Instability", -- [32]
			"Instant Heal", -- [33]
			"Iron Roots", -- [34]
			"Jagged Knife", -- [35]
			"Legion Flame", -- [36]
			"Levitate", -- [37]
			"Light Essence", -- [38]
			"Mark of the Fallen Champion", -- [39]
			"Mistress' Kiss", -- [40]
			"Mutated Infection", -- [41]
			"Mutated Plague", -- [42]
			"Napalm Shell", -- [43]
			"Necrotic Plague", -- [44]
			"Necrotic Strike", -- [45]
			"Necrotic strike", -- [46]
			"Pact of the Darkfallen", -- [47]
			"Paralytic Toxin", -- [48]
			"Penetrating Cold", -- [49]
			"Permafrost", -- [50]
			"Rune of Blood", -- [51]
			"Sara's Blessing", -- [52]
			"Searing Light", -- [53]
			"Shadow Prison", -- [54]
			"Shroud of Sorrow", -- [55]
			"Slag Pot", -- [56]
			"Snobolled!", -- [57]
			"Spinning Pain Spike", -- [58]
			"Stone Grip", -- [59]
			"Swarming Shadows", -- [60]
			"Touch of Darkness", -- [61]
			"Touch of Light", -- [62]
			"Vile Gas", -- [63]
			"Volatile Ooze Adhesive", -- [64]
			"Weakened Soul", -- [65]
			"Web Wrap", -- [66]
			"curse of torpor", -- [67]
			"death plague", -- [68]
			"death plague", -- [69]
			"mystic buffet", -- [70]
			"mystic buffet", -- [71]
			"mystic buffet", -- [72]
		},
		["isIcon"] = true,
		["selected"] = "",
		["SELECTED"] = "Inoculated",
		["SOUND"] = "Interface\\Quiet.mp3",
		["isColor"] = false,
		["animate"] = true,
		["max_num"] = 5,
		["STORED_SETTINGS"] = {
			["Gastric Bloat"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["isIcon"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["timer"] = true,
			},
			["Feral Pounce"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Emerald Vigor"] = {
				["isStacks"] = 1,
				["animate"] = 1,
				["isIcon"] = 1,
				["timer"] = 1,
				["SOUND"] = "Interface\\Quiet.mp3",
			},
			["Impaled"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Searing Light"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Inoculated"] = {
				["isStacks"] = 1,
				["animate"] = 1,
				["isIcon"] = 1,
				["timer"] = 1,
				["SOUND"] = "",
			},
			["Paralytic Toxin"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Mutated Infection"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["timer"] = true,
				["isColor"] = false,
				["SOUND"] = "Interface\\Quiet.mp3",
			},
			["Incinerate Flesh"] = {
				["SOUND"] = "",
				["isIcon"] = 1,
				["timer"] = 1,
				["isColor"] = 1,
				["color"] = {
					["TG"] = 0.5,
					["B"] = 0,
					["TB"] = 0,
					["G"] = 0.3,
					["TR"] = 0.8,
					["TO"] = 1,
					["R"] = 0.6,
					["useBackground"] = true,
					["useText"] = true,
					["O"] = 1,
					["useOpacity"] = true,
				},
			},
			["Shadow Prison"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Ice Tomb"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Corrosion"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Necrotic strike"] = {
				["animate"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
				["color"] = {
					["TG"] = 0.5,
					["B"] = 0,
					["TB"] = 0,
					["G"] = 0.3,
					["TR"] = 0.8,
					["TO"] = 1,
					["R"] = 0.6,
					["useBackground"] = true,
					["useText"] = true,
					["O"] = 1,
					["useOpacity"] = true,
				},
				["isColor"] = 1,
				["isIcon"] = 1,
			},
			["Instant Heal"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Mystic Buffet"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["timer"] = true,
			},
			["Touch of Darkness"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Penetrating Cold"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["mystic buffet"] = {
				["isStacks"] = true,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Harvest Soul"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Essence of the Blood Queen"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["timer"] = true,
			},
			["Vile Gas"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["timer"] = true,
				["isColor"] = false,
				["SOUND"] = "Interface\\Quiet.mp3",
			},
			["Impale"] = {
				["isStacks"] = 1,
				["isIcon"] = 1,
				["timer"] = 1,
				["SOUND"] = "",
			},
			["Jagged Knife"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Boiling Blood"] = {
				["animate"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
				["color"] = {
					["TG"] = 0.5,
					["B"] = 0,
					["TB"] = 0,
					["G"] = 0.3,
					["TR"] = 0.8,
					["TO"] = 1,
					["R"] = 0.6,
					["useBackground"] = true,
					["useText"] = true,
					["O"] = 1,
					["useOpacity"] = true,
				},
				["isColor"] = 1,
				["isIcon"] = 1,
			},
			["Napalm Shell"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Expose Weakness"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Glittering Sparks"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["timer"] = true,
			},
			["Snobolled!"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Frost Beacon"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Mutated Plague"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Pact of the Darkfallen"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["timer"] = true,
			},
			["Acid-Drenched Mandibles"] = {
				["isStacks"] = 1,
				["isIcon"] = 1,
				["timer"] = 1,
				["SOUND"] = "",
			},
			["Shroud of Sorrow"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["timer"] = true,
			},
			["Grievous Bite"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Iron Roots"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Rune of Blood"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Mistress' Kiss"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Necrotic Plague"] = {
				["isStacks"] = 1,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Dark Essence"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Weakened Soul"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Light Essence"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Stone Grip"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Swarming Shadows"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["timer"] = true,
			},
			["Gaseous Bloat"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["timer"] = true,
				["isColor"] = false,
				["SOUND"] = "Interface\\Quiet.mp3",
			},
			["Spinning Pain Spike"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Web Wrap"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["death plague"] = {
				["animate"] = 1,
				["timer"] = 1,
				["isIcon"] = 1,
				["SOUND"] = "Interface\\Quiet.mp3",
			},
			["Defile"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Gravity Bomb"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Legion Flame"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["curse of torpor"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Fire Bomb"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Infest"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Levitate"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Burning Bile"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Slag Pot"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Necrotic Strike"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Delirious Slash"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["timer"] = true,
			},
			["Instability"] = {
				["isStacks"] = 1,
				["animate"] = 1,
				["timer"] = 1,
				["isIcon"] = 1,
				["SOUND"] = "",
			},
			["Permafrost"] = {
				["isStacks"] = true,
				["animate"] = true,
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Frenzied Bloodthirst"] = {
				["animate"] = 1,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = 1,
				["timer"] = 1,
			},
			["Sara's Blessing"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Chilled to the Bone"] = {
				["isStacks"] = false,
				["animate"] = true,
				["timer"] = true,
				["isColor"] = false,
				["isIcon"] = true,
			},
			["Volatile Ooze Adhesive"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["timer"] = true,
			},
			["Touch of Light"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Gut Spray"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
			["Frost Blast"] = {
				["isIcon"] = 1,
				["SOUND"] = "",
				["timer"] = 1,
			},
			["Unbound Plague"] = {
				["isStacks"] = false,
				["animate"] = true,
				["color"] = {
					["TG"] = 0.5,
					["B"] = 0,
					["TB"] = 0,
					["G"] = 0.3,
					["TR"] = 0.8,
					["TO"] = 1,
					["useOpacity"] = true,
					["useBackground"] = true,
					["useText"] = true,
					["O"] = 1,
					["R"] = 0.6,
				},
				["isIcon"] = true,
				["isColor"] = true,
				["timer"] = true,
			},
			["Gas Spore"] = {
				["isStacks"] = false,
				["animate"] = true,
				["isIcon"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isColor"] = false,
				["timer"] = true,
			},
			["Mark of the Fallen Champion"] = {
				["animate"] = 1,
				["timer"] = 1,
				["isIcon"] = 1,
				["SOUND"] = "",
			},
			["Frost Breath"] = {
				["isStacks"] = false,
				["animate"] = true,
				["SOUND"] = "Interface\\Quiet.mp3",
				["isIcon"] = true,
				["isColor"] = false,
				["timer"] = true,
			},
		},
		["version"] = 13,
		["isStacks"] = false,
		["timer"] = true,
		["xAdjust"] = 0,
		["yAdjust"] = -24,
	},
	["EMERGENCY_TRIGGER"] = 100,
	["SHOW_PLAYER_TAGS"] = true,
	["DETECT_DEBUFFS"] = true,
	["UPDATE_HOTS_MS"] = 100,
	["PANEL_FRAME_STRATA"] = "",
	["LOCK_CLICKS_THROUGH"] = false,
	["LOCK_PANELS"] = true,
	["CURRENT_PROFILE"] = "Zweer 1",
	["AUTO_PROFILES"] = {
		["25"] = "Zweer 25",
		["lastAutoSaveSlot"] = 2,
		["5"] = "Zweer 1",
		["dirty"] = false,
		["1"] = "Zweer 1",
		["10"] = "Zweer 10",
	},
	["SHOW_INCOMING"] = true,
	["BLIZZ_UI_HIDE_RAID"] = false,
	["OMIT_FOCUS"] = false,
	["INC_CASTED_SECS"] = 3,
	["SHOW_PANELS"] = true,
	["SHOW_MINIMAP"] = false,
	["DETECT_DEBUFFS_IGNORE_MOVEMENT"] = true,
	["OMIT_OWN_GROUP"] = false,
	["MODE"] = 1,
	["THREAT"] = {
		["AGGRO_USE_TEXT"] = true,
		["AGGRO_TEXT_LEFT"] = ">>",
		["AGGRO_TEXT_RIGHT"] = "<<",
		["AGGRO_REFRESH_MS"] = 100,
	},
	["SHOW_TEXT_OVERHEAL"] = true,
	["RANGE_CHECK_DELAY"] = 200,
	["SHOW_OWN_INCOMING"] = 1,
	["SOUND_DEBUFF"] = "Interface\\Quiet.mp3",
	["DETECT_DEBUFFS_REMOVABLE_ONLY"] = true,
}
VUHDO_PANEL_SETUP = {
	{
		["OVERHEAL_TEXT"] = {
			["show"] = true,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 147.310773539787,
			["x"] = 731.1463346831329,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "BOTTOMLEFT",
			["height"] = 40.00000056230908,
			["growth"] = "BOTTOMLEFT",
			["width"] = 433.0000183453338,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "BACKGROUND",
		["MODEL"] = {
			["ordering"] = 0,
			["sort"] = 1,
			["groups"] = {
				1, -- [1]
			},
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["point"] = "BOTTOMLEFT",
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["y"] = 249.1,
			["x"] = 426.9,
			["relativePoint"] = "BOTTOMLEFT",
			["SCALE"] = 1,
			["position"] = 3,
			["show"] = true,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 1,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 1,
				["B"] = 1,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["B"] = 0.7,
				["useOpacity"] = true,
				["O"] = 1,
				["G"] = 0.7,
				["R"] = 0.7,
			},
			["BORDER"] = {
				["edgeSize"] = 1,
				["B"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["R"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\AddOns\\Quartz\\textures\\Tooltip-BigBorder",
				["O"] = 0,
				["insets"] = 0,
			},
			["barTexture"] = "VuhDo - Aluminium",
			["barBackBrightness"] = 10,
			["classColorsBar"] = false,
			["TEXT"] = {
				["outline"] = false,
				["textSize"] = 13,
				["textSizeLife"] = 13,
				["B"] = 0,
				["TB"] = 0,
				["R"] = 0,
				["useText"] = true,
				["TG"] = 0.82,
				["useOpacity"] = true,
				["font"] = "Interface\\Addons\\Prat-3.0\\fonts\\Bazooka.ttf",
				["TO"] = 1,
				["G"] = 0,
				["TR"] = 1,
				["useBackground"] = true,
				["O"] = 0.25,
				["maxChars"] = 0,
			},
			["classColorsHeader"] = false,
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["HEADER"] = {
				["TG"] = 0.859,
				["B"] = 0.082,
				["TB"] = 0.38,
				["barTexture"] = "Glaze",
				["G"] = 0.514,
				["TR"] = 1,
				["font"] = "",
				["TO"] = 1,
				["useBackground"] = true,
				["textSize"] = 11,
				["useText"] = true,
				["O"] = 0.6,
				["R"] = 0.6,
			},
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Prayer of Mending", -- [1]
				"Abolish Disease", -- [2]
				"Guardian Spirit", -- [3]
				"Power Word: Shield", -- [4]
				"Divine Aegis", -- [5]
				"Renew", -- [6]
				[9] = "Grace",
			},
			["BARS"] = {
				["invertDirection"] = false,
				["radioValue"] = 2,
				["invertOrientation"] = false,
				["show"] = 1,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					false, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					false, -- [2]
				}, -- [5]
				{
					true, -- [1]
					false, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				{
					true, -- [1]
					false, -- [2]
				}, -- [9]
				["1"] = {
					["mine"] = true,
					["others"] = 1,
				},
				["3"] = {
					["mine"] = true,
					["others"] = 1,
				},
				["2"] = {
					["mine"] = true,
					["others"] = 1,
				},
				["5"] = {
					["mine"] = true,
					["others"] = 1,
				},
				["4"] = {
					["mine"] = true,
					["others"] = 1,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["show"] = true,
			["iconRadioValue"] = 1,
			["radioValue"] = 12,
			["stacksRadioValue"] = 2,
			["textSize"] = 100,
			["size"] = 40,
		},
		["SCALING"] = {
			["headerHeight"] = 20,
			["targetWidth"] = 121,
			["scale"] = 1,
			["barHeight"] = 40,
			["alignBottom"] = false,
			["barWidth"] = 250,
			["vertical"] = false,
			["columnSpacing"] = 1,
			["ommitEmptyWhenStructured"] = 1,
			["showTarget"] = true,
			["raidIconScale"] = 1,
			["damFlashFactor"] = 0.75,
			["targetSpacing"] = 1,
			["headerSpacing"] = 5,
			["borderGapX"] = 0,
			["manaBarHeight"] = 3,
			["headerWidth"] = 50,
			["turnAxis"] = false,
			["showHeaders"] = false,
			["totWidth"] = 60,
			["isPlayerOnTop"] = false,
			["totSpacing"] = 1,
			["invertGrowth"] = false,
			["maxRowsWhenLoose"] = 6,
			["targetOrientation"] = 1,
			["borderGapY"] = 0,
			["showTot"] = true,
			["maxColumnsWhenStructured"] = 8,
			["rowSpacing"] = 1,
		},
		["IS_RAID_ICON"] = 1,
		["LIFE_TEXT"] = {
			["show"] = 1,
			["hideIrrelevant"] = true,
			["position"] = 4,
			["mode"] = 3,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["version"] = 2,
			["position"] = "CENTER+CENTER",
			["showTags"] = true,
			["_spacing"] = 26.00000014057727,
			["showPetOwners"] = true,
		},
	}, -- [1]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = false,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 477.4308210464699,
			["x"] = 1359.408784856398,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 29.99999929711365,
			["growth"] = "TOPLEFT",
			["width"] = 301.9999959232591,
		},
		["RAID_ICON"] = {
			["show"] = false,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["ordering"] = 0,
			["sort"] = 1,
			["groups"] = {
				41, -- [1]
			},
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["point"] = "TOPLEFT",
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["y"] = -100,
			["x"] = 100,
			["relativePoint"] = "TOPLEFT",
			["SCALE"] = 1,
			["position"] = 3,
			["inFight"] = false,
			["show"] = true,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["useOpacity"] = true,
				["R"] = 0.7,
				["O"] = 1,
				["mode"] = 0,
				["G"] = 0.7,
				["B"] = 0.7,
			},
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["R"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\Tooltips\\UI-Tooltip-Border",
				["O"] = 0,
				["insets"] = 1,
			},
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["classColorsHeader"] = false,
			["barBackBrightness"] = 10,
			["classColorsBack"] = false,
			["HEADER"] = {
				["TG"] = 0.859,
				["B"] = 0.082,
				["TB"] = 0.38,
				["barTexture"] = "Glaze",
				["G"] = 0.514,
				["TR"] = 1,
				["font"] = "",
				["TO"] = 1,
				["useBackground"] = true,
				["textSize"] = 11,
				["useText"] = true,
				["O"] = 0.6,
				["R"] = 0.6,
			},
			["TEXT"] = {
				["TG"] = 0.82,
				["O"] = 0.25,
				["R"] = 0,
				["TB"] = 0,
				["textSize"] = 17,
				["useText"] = true,
				["useBackground"] = true,
				["useOpacity"] = true,
				["font"] = "Interface\\Addons\\Prat-3.0\\fonts\\Bazooka.ttf",
				["TO"] = 1,
				["maxChars"] = 0,
				["TR"] = 1,
				["G"] = 0,
				["textSizeLife"] = 13,
				["B"] = 0,
			},
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barTexture"] = "Aluminium",
			["classColorsBar"] = false,
			["classColorsName"] = 1,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Renew", -- [1]
				"Prayer of Mending", -- [2]
				"Power Word: Shield", -- [3]
				"Guardian Spirit", -- [4]
				"Abolish Disease", -- [5]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					false, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					true, -- [2]
				}, -- [5]
				{
					true, -- [1]
					false, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				{
					true, -- [1]
					false, -- [2]
				}, -- [9]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["iconRadioValue"] = 2,
			["radioValue"] = 21,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 0,
		},
		["SCALING"] = {
			["headerHeight"] = 20,
			["targetWidth"] = 90,
			["scale"] = 1,
			["showTot"] = 1,
			["borderGapX"] = 0,
			["vertical"] = false,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = true,
			["raidIconScale"] = 1,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 8,
			["manaBarHeight"] = 3,
			["totSpacing"] = 1,
			["barWidth"] = 150,
			["totWidth"] = 60,
			["damFlashFactor"] = 0.75,
			["borderGapY"] = 0,
			["maxColumnsWhenStructured"] = 8,
			["barHeight"] = 45,
			["headerWidth"] = 50,
			["columnSpacing"] = 1,
			["targetOrientation"] = 1,
			["targetSpacing"] = 1,
			["rowSpacing"] = 1,
		},
		["IS_RAID_ICON"] = 1,
		["LIFE_TEXT"] = {
			["show"] = 1,
			["hideIrrelevant"] = true,
			["position"] = 4,
			["mode"] = 3,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["version"] = 2,
			["position"] = "CENTER+CENTER",
			["showTags"] = false,
			["_spacing"] = 29.99999929711365,
		},
	}, -- [2]
	{
		["OVERHEAL_TEXT"] = {
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 296.3789923857024,
			["x"] = 1.400000182750452,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "BOTTOMLEFT",
			["height"] = 93.99999479864098,
			["growth"] = "BOTTOMLEFT",
			["width"] = 431.9999898784365,
		},
		["RAID_ICON"] = {
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["ordering"] = 0,
			["sort"] = 1,
			["groups"] = {
				42, -- [1]
			},
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["point"] = "TOPLEFT",
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["y"] = -100,
			["x"] = 100,
			["relativePoint"] = "TOPLEFT",
			["SCALE"] = 1,
			["position"] = 3,
			["inFight"] = false,
			["show"] = true,
		},
		["PANEL_COLOR"] = {
			["classColorsHeader"] = false,
			["classColorsBackHeader"] = false,
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["R"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\Tooltips\\UI-Tooltip-Border",
				["O"] = 0,
				["insets"] = 1,
			},
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barBackBrightness"] = 10,
			["HEADER"] = {
				["TG"] = 0.859,
				["B"] = 0.082,
				["TB"] = 0.38,
				["barTexture"] = "Glaze",
				["G"] = 0.514,
				["TR"] = 1,
				["font"] = "",
				["TO"] = 1,
				["useBackground"] = true,
				["textSize"] = 11,
				["useText"] = true,
				["O"] = 0.6,
				["R"] = 0.6,
			},
			["TEXT"] = {
				["TG"] = 0.82,
				["textSizeLife"] = 17,
				["B"] = 0,
				["TB"] = 0,
				["textSize"] = 13,
				["G"] = 0,
				["maxChars"] = 0,
				["TR"] = 1,
				["font"] = "Interface\\Addons\\Prat-3.0\\fonts\\Bazooka.ttf",
				["TO"] = 1,
				["useOpacity"] = true,
				["useBackground"] = true,
				["useText"] = true,
				["O"] = 0.25,
				["R"] = 0,
			},
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
			},
			["BARS"] = {
				["useBackground"] = true,
				["useOpacity"] = true,
				["R"] = 0.7,
				["O"] = 1,
				["mode"] = 0,
				["G"] = 0.7,
				["B"] = 0.7,
			},
			["barTexture"] = "VuhDo - Aluminium",
			["classColorsBar"] = false,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Renew", -- [1]
				"Prayer of Mending", -- [2]
				"Power Word: Shield", -- [3]
				"Guardian Spirit", -- [4]
				"Abolish Disease", -- [5]
				[9] = "Grace",
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					false, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					true, -- [2]
				}, -- [5]
				{
					true, -- [1]
					false, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				{
					true, -- [1]
					false, -- [2]
				}, -- [9]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = 1,
				},
				["2"] = {
					["mine"] = true,
					["others"] = 1,
				},
				["5"] = {
					["mine"] = true,
					["others"] = 1,
				},
				["4"] = {
					["mine"] = true,
					["others"] = 1,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["show"] = 1,
			["radioValue"] = 12,
			["iconRadioValue"] = 1,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 50,
		},
		["SCALING"] = {
			["headerHeight"] = 20,
			["targetWidth"] = 110,
			["scale"] = 1,
			["maxColumnsWhenStructured"] = 8,
			["borderGapY"] = 5,
			["targetSpacing"] = 1,
			["barWidth"] = 250,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = 1,
			["raidIconScale"] = 1,
			["showTot"] = 1,
			["rowSpacing"] = 1,
			["headerSpacing"] = 5,
			["borderGapX"] = 5,
			["invertGrowth"] = false,
			["headerWidth"] = 50,
			["damFlashFactor"] = 0.75,
			["totWidth"] = 60,
			["totSpacing"] = 1,
			["manaBarHeight"] = 3,
			["maxRowsWhenLoose"] = 6,
			["barHeight"] = 41,
			["targetOrientation"] = 1,
			["columnSpacing"] = 1,
			["isPlayerOnTop"] = false,
			["arrangeHorizontal"] = false,
			["alignBottom"] = false,
		},
		["IS_RAID_ICON"] = false,
		["LIFE_TEXT"] = {
			["show"] = 1,
			["hideIrrelevant"] = false,
			["position"] = 4,
			["mode"] = 2,
			["verbose"] = false,
		},
		["ID_TEXT"] = {
			["showName"] = 1,
			["version"] = 2,
			["position"] = "TOP+TOP",
			["_spacing"] = 29.99999929711365,
		},
	}, -- [3]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = false,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 355.1788164673059,
			["x"] = 1209.625191896761,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 29.99999929711365,
			["growth"] = "TOPLEFT",
			["width"] = 84.99999950797955,
		},
		["RAID_ICON"] = {
			["show"] = false,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["ordering"] = 1,
			["groups"] = {
				40, -- [1]
			},
			["sort"] = 1,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["point"] = "TOPLEFT",
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["y"] = -100,
			["x"] = 100,
			["relativePoint"] = "TOPLEFT",
			["SCALE"] = 1,
			["position"] = 3,
			["inFight"] = false,
			["show"] = true,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["useOpacity"] = true,
				["R"] = 0.7,
				["O"] = 1,
				["mode"] = 0,
				["G"] = 0.7,
				["B"] = 0.7,
			},
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["R"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\Tooltips\\UI-Tooltip-Border",
				["O"] = 0,
				["insets"] = 1,
			},
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["classColorsHeader"] = false,
			["barBackBrightness"] = 10,
			["classColorsBack"] = false,
			["HEADER"] = {
				["TG"] = 0.859,
				["B"] = 0.082,
				["TB"] = 0.38,
				["barTexture"] = "Glaze",
				["G"] = 0.514,
				["TR"] = 1,
				["font"] = "",
				["TO"] = 1,
				["useBackground"] = true,
				["textSize"] = 11,
				["useText"] = true,
				["O"] = 0.6,
				["R"] = 0.6,
			},
			["TEXT"] = {
				["TG"] = 0.82,
				["O"] = 0.25,
				["R"] = 0,
				["TB"] = 0,
				["textSizeLife"] = 13,
				["G"] = 0,
				["maxChars"] = 0,
				["TR"] = 1,
				["font"] = "Interface\\Addons\\Prat-3.0\\fonts\\Bazooka.ttf",
				["TO"] = 1,
				["useOpacity"] = true,
				["useBackground"] = true,
				["useText"] = true,
				["textSize"] = 8,
				["B"] = 0,
			},
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barTexture"] = "Aluminium",
			["classColorsBar"] = false,
			["classColorsName"] = 1,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Renew", -- [1]
				"Prayer of Mending", -- [2]
				"Power Word: Shield", -- [3]
				"Guardian Spirit", -- [4]
				"Abolish Disease", -- [5]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					false, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					true, -- [2]
				}, -- [5]
				{
					true, -- [1]
					false, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				{
					true, -- [1]
					false, -- [2]
				}, -- [9]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["radioValue"] = 21,
			["iconRadioValue"] = 2,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 20,
		},
		["SCALING"] = {
			["headerHeight"] = 20,
			["targetWidth"] = 30,
			["scale"] = 1,
			["barHeight"] = 20,
			["columnSpacing"] = 2,
			["targetSpacing"] = 3,
			["ommitEmptyWhenStructured"] = 1,
			["targetOrientation"] = 1,
			["raidIconScale"] = 1,
			["barWidth"] = 75,
			["vertical"] = false,
			["headerSpacing"] = 5,
			["borderGapX"] = 5,
			["manaBarHeight"] = 3,
			["headerWidth"] = 50,
			["borderGapY"] = 5,
			["totWidth"] = 30,
			["showTarget"] = false,
			["totSpacing"] = 3,
			["invertGrowth"] = false,
			["maxRowsWhenLoose"] = 8,
			["maxColumnsWhenStructured"] = 8,
			["damFlashFactor"] = 0.75,
			["showTot"] = false,
			["isPlayerOnTop"] = false,
			["rowSpacing"] = 2,
		},
		["IS_RAID_ICON"] = false,
		["LIFE_TEXT"] = {
			["show"] = false,
			["mode"] = 3,
			["position"] = 4,
		},
		["ID_TEXT"] = {
			["showClass"] = false,
			["showName"] = true,
			["version"] = 2,
			["position"] = "CENTER+CENTER",
			["showTags"] = true,
			["_spacing"] = 8.000000562309083,
			["showPetOwners"] = true,
		},
	}, -- [4]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = true,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 578.8,
			["x"] = 510.6,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 312.5,
			["growth"] = "TOPLEFT",
			["width"] = 250,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["ordering"] = 0,
			["sort"] = 1,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["point"] = "TOPLEFT",
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["y"] = -100,
			["x"] = 100,
			["relativePoint"] = "TOPLEFT",
			["SCALE"] = 1,
			["position"] = 3,
			["inFight"] = false,
			["show"] = true,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["useOpacity"] = true,
				["R"] = 0.7,
				["O"] = 1,
				["mode"] = 1,
				["G"] = 0.7,
				["B"] = 0.7,
			},
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["R"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\Tooltips\\UI-Tooltip-Border",
				["O"] = 0,
				["insets"] = 1,
			},
			["barTexture"] = "VuhDo - Convex",
			["barBackBrightness"] = 10,
			["classColorsBack"] = 1,
			["classColorsBar"] = false,
			["TEXT"] = {
				["TG"] = 0.82,
				["O"] = 0,
				["B"] = 1,
				["TB"] = 0,
				["textSize"] = 14,
				["useText"] = true,
				["TR"] = 1,
				["useOpacity"] = true,
				["font"] = "Fonts\\ARIALN.TTF",
				["TO"] = 1,
				["useBackground"] = true,
				["maxChars"] = 0,
				["G"] = 1,
				["textSizeLife"] = 13,
				["R"] = 1,
			},
			["HEADER"] = {
				["TG"] = 0.859,
				["B"] = 0.082,
				["TB"] = 0.38,
				["barTexture"] = "Glaze",
				["G"] = 0.514,
				["TR"] = 1,
				["font"] = "",
				["TO"] = 1,
				["useBackground"] = true,
				["textSize"] = 11,
				["useText"] = true,
				["O"] = 0.6,
				["R"] = 0.6,
			},
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["classColorsHeader"] = false,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Renew", -- [1]
				"Prayer of Mending", -- [2]
				"Power Word: Shield", -- [3]
				"Guardian Spirit", -- [4]
				"Abolish Disease", -- [5]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					false, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					true, -- [2]
				}, -- [5]
				{
					true, -- [1]
					false, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				{
					true, -- [1]
					false, -- [2]
				}, -- [9]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = 1,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["radioValue"] = 21,
			["iconRadioValue"] = 2,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 75,
		},
		["SCALING"] = {
			["headerHeight"] = 20,
			["targetWidth"] = 160,
			["scale"] = 1,
			["maxColumnsWhenStructured"] = 8,
			["columnSpacing"] = 5,
			["vertical"] = false,
			["ommitEmptyWhenStructured"] = true,
			["targetOrientation"] = 1,
			["raidIconScale"] = 1,
			["barWidth"] = 250,
			["targetSpacing"] = 10,
			["headerSpacing"] = 5,
			["borderGapX"] = 0,
			["manaBarHeight"] = 3,
			["totSpacing"] = 5,
			["borderGapY"] = 0,
			["totWidth"] = 70,
			["showTarget"] = 1,
			["headerWidth"] = 50,
			["invertGrowth"] = false,
			["maxRowsWhenLoose"] = 6,
			["showTot"] = 1,
			["damFlashFactor"] = 0.75,
			["barHeight"] = 45,
			["isPlayerOnTop"] = true,
			["rowSpacing"] = 5,
		},
		["IS_RAID_ICON"] = false,
		["LIFE_TEXT"] = {
			["show"] = 1,
			["hideIrrelevant"] = true,
			["position"] = 4,
			["mode"] = 3,
		},
		["ID_TEXT"] = {
			["showName"] = true,
			["version"] = 2,
			["position"] = "CENTER+CENTER",
			["showTags"] = true,
			["_spacing"] = 26.99999936740228,
			["showPetOwners"] = true,
		},
	}, -- [5]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = true,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 488,
			["x"] = 280,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 1,
			["ordering"] = 0,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["point"] = "TOPLEFT",
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["y"] = -100,
			["x"] = 100,
			["relativePoint"] = "TOPLEFT",
			["SCALE"] = 1,
			["position"] = 2,
			["inFight"] = false,
			["show"] = true,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["useOpacity"] = true,
				["R"] = 0.7,
				["O"] = 1,
				["mode"] = 0,
				["G"] = 0.7,
				["B"] = 0.7,
			},
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["R"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\Tooltips\\UI-Tooltip-Border",
				["O"] = 0,
				["insets"] = 1,
			},
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["classColorsHeader"] = false,
			["barBackBrightness"] = 10,
			["classColorsBack"] = false,
			["HEADER"] = {
				["TG"] = 0.859,
				["B"] = 0.082,
				["TB"] = 0.38,
				["barTexture"] = "Glaze",
				["G"] = 0.514,
				["TR"] = 1,
				["font"] = "",
				["TO"] = 1,
				["useBackground"] = true,
				["textSize"] = 11,
				["useText"] = true,
				["O"] = 0.6,
				["R"] = 0.6,
			},
			["TEXT"] = {
				["TG"] = 0.82,
				["O"] = 0.25,
				["R"] = 0,
				["TB"] = 0,
				["textSizeLife"] = 13,
				["G"] = 0,
				["maxChars"] = 0,
				["TR"] = 1,
				["font"] = "Fonts\\ARIALN.TTF",
				["TO"] = 1,
				["useOpacity"] = true,
				["useBackground"] = true,
				["useText"] = true,
				["textSize"] = 14,
				["B"] = 0,
			},
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barTexture"] = "VuhDo - Convex",
			["classColorsBar"] = false,
			["classColorsName"] = 1,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Renew", -- [1]
				"Prayer of Mending", -- [2]
				"Power Word: Shield", -- [3]
				"Guardian Spirit", -- [4]
				"Abolish Disease", -- [5]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					false, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					true, -- [2]
				}, -- [5]
				{
					true, -- [1]
					false, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				{
					true, -- [1]
					false, -- [2]
				}, -- [9]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["show"] = true,
			["iconRadioValue"] = 2,
			["radioValue"] = 21,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 75,
		},
		["SCALING"] = {
			["isPlayerOnTop"] = true,
			["targetWidth"] = 30,
			["scale"] = 1,
			["maxColumnsWhenStructured"] = 8,
			["targetSpacing"] = 3,
			["barWidth"] = 75,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["raidIconScale"] = 1,
			["targetOrientation"] = 1,
			["columnSpacing"] = 5,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 6,
			["invertGrowth"] = false,
			["headerWidth"] = 50,
			["borderGapY"] = 5,
			["showHeaders"] = true,
			["totWidth"] = 30,
			["headerHeight"] = 20,
			["totSpacing"] = 3,
			["manaBarHeight"] = 3,
			["borderGapX"] = 5,
			["showTot"] = false,
			["damFlashFactor"] = 0.75,
			["vertical"] = false,
			["barHeight"] = 25,
			["rowSpacing"] = 2,
		},
		["IS_RAID_ICON"] = false,
		["LIFE_TEXT"] = {
			["show"] = 1,
			["mode"] = 3,
			["position"] = 4,
		},
		["ID_TEXT"] = {
			["showName"] = true,
			["version"] = 2,
			["position"] = "CENTER+CENTER",
			["showTags"] = true,
			["showPetOwners"] = true,
		},
	}, -- [6]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = true,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 458,
			["x"] = 310,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 1,
			["ordering"] = 0,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["point"] = "TOPLEFT",
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["y"] = -100,
			["x"] = 100,
			["relativePoint"] = "TOPLEFT",
			["SCALE"] = 1,
			["position"] = 2,
			["inFight"] = false,
			["show"] = true,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["useOpacity"] = true,
				["R"] = 0.7,
				["O"] = 1,
				["mode"] = 0,
				["G"] = 0.7,
				["B"] = 0.7,
			},
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["R"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\Tooltips\\UI-Tooltip-Border",
				["O"] = 0,
				["insets"] = 1,
			},
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["classColorsHeader"] = false,
			["barBackBrightness"] = 10,
			["classColorsBack"] = false,
			["HEADER"] = {
				["TG"] = 0.859,
				["B"] = 0.082,
				["TB"] = 0.38,
				["barTexture"] = "Glaze",
				["G"] = 0.514,
				["TR"] = 1,
				["font"] = "",
				["TO"] = 1,
				["useBackground"] = true,
				["textSize"] = 11,
				["useText"] = true,
				["O"] = 0.6,
				["R"] = 0.6,
			},
			["TEXT"] = {
				["TG"] = 0.82,
				["O"] = 0.25,
				["B"] = 0,
				["TB"] = 0,
				["textSize"] = 14,
				["useText"] = true,
				["TR"] = 1,
				["useOpacity"] = true,
				["font"] = "Fonts\\ARIALN.TTF",
				["TO"] = 1,
				["useBackground"] = true,
				["maxChars"] = 0,
				["G"] = 0,
				["textSizeLife"] = 13,
				["R"] = 0,
			},
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barTexture"] = "VuhDo - Convex",
			["classColorsBar"] = false,
			["classColorsName"] = 1,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Renew", -- [1]
				"Prayer of Mending", -- [2]
				"Power Word: Shield", -- [3]
				"Guardian Spirit", -- [4]
				"Abolish Disease", -- [5]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					false, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					true, -- [2]
				}, -- [5]
				{
					true, -- [1]
					false, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				{
					true, -- [1]
					false, -- [2]
				}, -- [9]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["show"] = true,
			["iconRadioValue"] = 2,
			["radioValue"] = 21,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 75,
		},
		["SCALING"] = {
			["isPlayerOnTop"] = true,
			["targetWidth"] = 30,
			["scale"] = 1,
			["maxColumnsWhenStructured"] = 8,
			["targetSpacing"] = 3,
			["barWidth"] = 75,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["raidIconScale"] = 1,
			["targetOrientation"] = 1,
			["columnSpacing"] = 5,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 6,
			["invertGrowth"] = false,
			["headerWidth"] = 50,
			["borderGapY"] = 5,
			["showHeaders"] = true,
			["totWidth"] = 30,
			["headerHeight"] = 20,
			["totSpacing"] = 3,
			["manaBarHeight"] = 3,
			["borderGapX"] = 5,
			["showTot"] = false,
			["damFlashFactor"] = 0.75,
			["vertical"] = false,
			["barHeight"] = 25,
			["rowSpacing"] = 2,
		},
		["IS_RAID_ICON"] = false,
		["LIFE_TEXT"] = {
			["show"] = 1,
			["mode"] = 3,
			["position"] = 4,
		},
		["ID_TEXT"] = {
			["showName"] = true,
			["version"] = 2,
			["position"] = "CENTER+CENTER",
			["showTags"] = true,
			["showPetOwners"] = true,
		},
	}, -- [7]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = true,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 428,
			["x"] = 340,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 1,
			["ordering"] = 0,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["point"] = "TOPLEFT",
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["y"] = -100,
			["x"] = 100,
			["relativePoint"] = "TOPLEFT",
			["SCALE"] = 1,
			["position"] = 2,
			["inFight"] = false,
			["show"] = true,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["useOpacity"] = true,
				["R"] = 0.7,
				["O"] = 1,
				["mode"] = 0,
				["G"] = 0.7,
				["B"] = 0.7,
			},
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["R"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\Tooltips\\UI-Tooltip-Border",
				["O"] = 0,
				["insets"] = 1,
			},
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["classColorsHeader"] = false,
			["barBackBrightness"] = 10,
			["classColorsBack"] = false,
			["HEADER"] = {
				["TG"] = 0.859,
				["B"] = 0.082,
				["TB"] = 0.38,
				["barTexture"] = "Glaze",
				["G"] = 0.514,
				["TR"] = 1,
				["font"] = "",
				["TO"] = 1,
				["useBackground"] = true,
				["textSize"] = 11,
				["useText"] = true,
				["O"] = 0.6,
				["R"] = 0.6,
			},
			["TEXT"] = {
				["TG"] = 0.82,
				["O"] = 0.25,
				["B"] = 0,
				["TB"] = 0,
				["textSize"] = 14,
				["useText"] = true,
				["TR"] = 1,
				["useOpacity"] = true,
				["font"] = "Fonts\\ARIALN.TTF",
				["TO"] = 1,
				["useBackground"] = true,
				["maxChars"] = 0,
				["G"] = 0,
				["textSizeLife"] = 13,
				["R"] = 0,
			},
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barTexture"] = "VuhDo - Convex",
			["classColorsBar"] = false,
			["classColorsName"] = 1,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Renew", -- [1]
				"Prayer of Mending", -- [2]
				"Power Word: Shield", -- [3]
				"Guardian Spirit", -- [4]
				"Abolish Disease", -- [5]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					false, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					true, -- [2]
				}, -- [5]
				{
					true, -- [1]
					false, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				{
					true, -- [1]
					false, -- [2]
				}, -- [9]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["show"] = true,
			["iconRadioValue"] = 2,
			["radioValue"] = 21,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 75,
		},
		["SCALING"] = {
			["isPlayerOnTop"] = true,
			["targetWidth"] = 30,
			["scale"] = 1,
			["maxColumnsWhenStructured"] = 8,
			["targetSpacing"] = 3,
			["barWidth"] = 75,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["raidIconScale"] = 1,
			["targetOrientation"] = 1,
			["columnSpacing"] = 5,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 6,
			["invertGrowth"] = false,
			["headerWidth"] = 50,
			["borderGapY"] = 5,
			["showHeaders"] = true,
			["totWidth"] = 30,
			["headerHeight"] = 20,
			["totSpacing"] = 3,
			["manaBarHeight"] = 3,
			["borderGapX"] = 5,
			["showTot"] = false,
			["damFlashFactor"] = 0.75,
			["vertical"] = false,
			["barHeight"] = 25,
			["rowSpacing"] = 2,
		},
		["IS_RAID_ICON"] = false,
		["LIFE_TEXT"] = {
			["show"] = 1,
			["mode"] = 3,
			["position"] = 4,
		},
		["ID_TEXT"] = {
			["showName"] = true,
			["version"] = 2,
			["position"] = "CENTER+CENTER",
			["showTags"] = true,
			["showPetOwners"] = true,
		},
	}, -- [8]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = true,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 398,
			["x"] = 370,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 1,
			["ordering"] = 0,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["point"] = "TOPLEFT",
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["y"] = -100,
			["x"] = 100,
			["relativePoint"] = "TOPLEFT",
			["SCALE"] = 1,
			["position"] = 2,
			["inFight"] = false,
			["show"] = true,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["useOpacity"] = true,
				["R"] = 0.7,
				["O"] = 1,
				["mode"] = 0,
				["G"] = 0.7,
				["B"] = 0.7,
			},
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["R"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\Tooltips\\UI-Tooltip-Border",
				["O"] = 0,
				["insets"] = 1,
			},
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["classColorsHeader"] = false,
			["barBackBrightness"] = 10,
			["classColorsBack"] = false,
			["HEADER"] = {
				["TG"] = 0.859,
				["B"] = 0.082,
				["TB"] = 0.38,
				["barTexture"] = "Glaze",
				["G"] = 0.514,
				["TR"] = 1,
				["font"] = "",
				["TO"] = 1,
				["useBackground"] = true,
				["textSize"] = 11,
				["useText"] = true,
				["O"] = 0.6,
				["R"] = 0.6,
			},
			["TEXT"] = {
				["TG"] = 0.82,
				["O"] = 0.25,
				["B"] = 0,
				["TB"] = 0,
				["textSize"] = 14,
				["useText"] = true,
				["TR"] = 1,
				["useOpacity"] = true,
				["font"] = "Fonts\\ARIALN.TTF",
				["TO"] = 1,
				["useBackground"] = true,
				["maxChars"] = 0,
				["G"] = 0,
				["textSizeLife"] = 13,
				["R"] = 0,
			},
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barTexture"] = "VuhDo - Convex",
			["classColorsBar"] = false,
			["classColorsName"] = 1,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Renew", -- [1]
				"Prayer of Mending", -- [2]
				"Power Word: Shield", -- [3]
				"Guardian Spirit", -- [4]
				"Abolish Disease", -- [5]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					false, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					true, -- [2]
				}, -- [5]
				{
					true, -- [1]
					false, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				{
					true, -- [1]
					false, -- [2]
				}, -- [9]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["show"] = true,
			["iconRadioValue"] = 2,
			["radioValue"] = 21,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 75,
		},
		["SCALING"] = {
			["isPlayerOnTop"] = true,
			["targetWidth"] = 30,
			["scale"] = 1,
			["maxColumnsWhenStructured"] = 8,
			["targetSpacing"] = 3,
			["barWidth"] = 75,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["raidIconScale"] = 1,
			["targetOrientation"] = 1,
			["columnSpacing"] = 5,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 6,
			["invertGrowth"] = false,
			["headerWidth"] = 50,
			["borderGapY"] = 5,
			["showHeaders"] = true,
			["totWidth"] = 30,
			["headerHeight"] = 20,
			["totSpacing"] = 3,
			["manaBarHeight"] = 3,
			["borderGapX"] = 5,
			["showTot"] = false,
			["damFlashFactor"] = 0.75,
			["vertical"] = false,
			["barHeight"] = 25,
			["rowSpacing"] = 2,
		},
		["IS_RAID_ICON"] = false,
		["LIFE_TEXT"] = {
			["show"] = 1,
			["mode"] = 3,
			["position"] = 4,
		},
		["ID_TEXT"] = {
			["showName"] = true,
			["version"] = 2,
			["position"] = "CENTER+CENTER",
			["showTags"] = true,
			["showPetOwners"] = true,
		},
	}, -- [9]
	{
		["OVERHEAL_TEXT"] = {
			["show"] = true,
			["yAdjust"] = 0,
			["point"] = "LEFT",
			["scale"] = 1,
			["xAdjust"] = 24,
		},
		["POSITION"] = {
			["y"] = 368,
			["x"] = 400,
			["scale"] = 1,
			["relativePoint"] = "BOTTOMLEFT",
			["orientation"] = "TOPLEFT",
			["height"] = 200,
			["growth"] = "TOPLEFT",
			["width"] = 200,
		},
		["RAID_ICON"] = {
			["show"] = true,
			["yAdjust"] = -20,
			["point"] = "TOP",
			["scale"] = 1,
			["xAdjust"] = 0,
		},
		["frameStrata"] = "MEDIUM",
		["MODEL"] = {
			["sort"] = 1,
			["ordering"] = 0,
		},
		["TOOLTIP"] = {
			["BACKGROUND"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["point"] = "TOPLEFT",
			["BORDER"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 1,
				["G"] = 0,
				["B"] = 0,
			},
			["showBuffs"] = false,
			["y"] = -100,
			["x"] = 100,
			["relativePoint"] = "TOPLEFT",
			["SCALE"] = 1,
			["position"] = 2,
			["inFight"] = false,
			["show"] = true,
		},
		["PANEL_COLOR"] = {
			["BACK"] = {
				["useOpacity"] = true,
				["R"] = 0,
				["useBackground"] = true,
				["O"] = 0,
				["G"] = 0,
				["B"] = 0,
			},
			["classColorsBackHeader"] = false,
			["BARS"] = {
				["useBackground"] = true,
				["useOpacity"] = true,
				["R"] = 0.7,
				["O"] = 1,
				["mode"] = 0,
				["G"] = 0.7,
				["B"] = 0.7,
			},
			["BORDER"] = {
				["edgeSize"] = 8,
				["B"] = 0,
				["G"] = 0,
				["useBackground"] = true,
				["R"] = 0,
				["useOpacity"] = true,
				["file"] = "Interface\\Tooltips\\UI-Tooltip-Border",
				["O"] = 0,
				["insets"] = 1,
			},
			["TOT"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["classColorsHeader"] = false,
			["barBackBrightness"] = 10,
			["classColorsBack"] = false,
			["HEADER"] = {
				["TG"] = 0.859,
				["B"] = 0.082,
				["TB"] = 0.38,
				["barTexture"] = "Glaze",
				["G"] = 0.514,
				["TR"] = 1,
				["font"] = "",
				["TO"] = 1,
				["useBackground"] = true,
				["textSize"] = 11,
				["useText"] = true,
				["O"] = 0.6,
				["R"] = 0.6,
			},
			["TEXT"] = {
				["TG"] = 0.82,
				["O"] = 0.25,
				["B"] = 0,
				["TB"] = 0,
				["textSize"] = 14,
				["useText"] = true,
				["TR"] = 1,
				["useOpacity"] = true,
				["font"] = "Fonts\\ARIALN.TTF",
				["TO"] = 1,
				["useBackground"] = true,
				["maxChars"] = 0,
				["G"] = 0,
				["textSizeLife"] = 13,
				["R"] = 0,
			},
			["TARGET"] = {
				["TR"] = 1,
				["TO"] = 1,
				["TB"] = 1,
				["useText"] = true,
				["TG"] = 1,
			},
			["barTexture"] = "VuhDo - Convex",
			["classColorsBar"] = false,
			["classColorsName"] = 1,
		},
		["HOTS"] = {
			["SLOTS"] = {
				"Renew", -- [1]
				"Prayer of Mending", -- [2]
				"Power Word: Shield", -- [3]
				"Guardian Spirit", -- [4]
				"Abolish Disease", -- [5]
			},
			["BARS"] = {
				["show"] = false,
				["radioValue"] = 1,
				["invertOrientation"] = false,
				["invertDirection"] = false,
				["width"] = 25,
			},
			["SLOTCFG"] = {
				{
					true, -- [1]
					false, -- [2]
				}, -- [1]
				{
					true, -- [1]
					false, -- [2]
				}, -- [2]
				{
					true, -- [1]
					false, -- [2]
				}, -- [3]
				{
					true, -- [1]
					false, -- [2]
				}, -- [4]
				{
					true, -- [1]
					true, -- [2]
				}, -- [5]
				{
					true, -- [1]
					false, -- [2]
				}, -- [6]
				{
					true, -- [1]
					false, -- [2]
				}, -- [7]
				{
					true, -- [1]
					false, -- [2]
				}, -- [8]
				{
					true, -- [1]
					false, -- [2]
				}, -- [9]
				["1"] = {
					["mine"] = true,
					["others"] = false,
				},
				["3"] = {
					["mine"] = true,
					["others"] = false,
				},
				["2"] = {
					["mine"] = true,
					["others"] = false,
				},
				["5"] = {
					["mine"] = true,
					["others"] = false,
				},
				["4"] = {
					["mine"] = true,
					["others"] = false,
				},
				["7"] = {
					["mine"] = true,
					["others"] = false,
				},
				["6"] = {
					["mine"] = true,
					["others"] = false,
				},
				["9"] = {
					["mine"] = true,
					["others"] = false,
				},
				["8"] = {
					["mine"] = true,
					["others"] = false,
				},
			},
			["isFlatTexture"] = false,
			["show"] = true,
			["iconRadioValue"] = 2,
			["radioValue"] = 21,
			["stacksRadioValue"] = 3,
			["textSize"] = 100,
			["size"] = 75,
		},
		["SCALING"] = {
			["isPlayerOnTop"] = true,
			["targetWidth"] = 30,
			["scale"] = 1,
			["maxColumnsWhenStructured"] = 8,
			["targetSpacing"] = 3,
			["barWidth"] = 75,
			["ommitEmptyWhenStructured"] = true,
			["showTarget"] = false,
			["raidIconScale"] = 1,
			["targetOrientation"] = 1,
			["columnSpacing"] = 5,
			["headerSpacing"] = 5,
			["maxRowsWhenLoose"] = 6,
			["invertGrowth"] = false,
			["headerWidth"] = 50,
			["borderGapY"] = 5,
			["showHeaders"] = true,
			["totWidth"] = 30,
			["headerHeight"] = 20,
			["totSpacing"] = 3,
			["manaBarHeight"] = 3,
			["borderGapX"] = 5,
			["showTot"] = false,
			["damFlashFactor"] = 0.75,
			["vertical"] = false,
			["barHeight"] = 25,
			["rowSpacing"] = 2,
		},
		["IS_RAID_ICON"] = false,
		["LIFE_TEXT"] = {
			["show"] = 1,
			["mode"] = 3,
			["position"] = 4,
		},
		["ID_TEXT"] = {
			["showName"] = true,
			["version"] = 2,
			["position"] = "CENTER+CENTER",
			["showTags"] = true,
			["showPetOwners"] = true,
		},
	}, -- [10]
	["RAID_ICON_FILTER"] = {
		true, -- [1]
		true, -- [2]
		true, -- [3]
		true, -- [4]
		true, -- [5]
		true, -- [6]
		true, -- [7]
		true, -- [8]
	},
	["PANEL_COLOR"] = {
		["classColorsName"] = true,
		["BARS"] = {
			["useOpacity"] = true,
			["B"] = 0.7,
			["R"] = 0.7,
			["G"] = 0.7,
			["O"] = 1,
			["useBackground"] = true,
		},
		["TEXT"] = {
			["TR"] = 1,
			["TO"] = 1,
			["TB"] = 0,
			["useText"] = true,
			["TG"] = 0.8196078431372549,
		},
	},
	["HOTS"] = {
		["show"] = true,
		["font"] = "Interface\\AddOns\\VuhDo\\Fonts\\ariblk.ttf",
		["BARS"] = {
			["radioValue"] = 1,
			["width"] = 25,
		},
		["SLOTS"] = {
			"Renew", -- [1]
			"Prayer of Mending", -- [2]
			"Power Word: Shield", -- [3]
			"Divine Aegis", -- [4]
			"Grace", -- [5]
			[9] = "Abolish Disease",
		},
		["radioValue"] = 12,
		["SLOTCFG"] = {
			["1"] = {
				["mine"] = true,
				["others"] = false,
			},
			["3"] = {
				["mine"] = true,
				["others"] = true,
			},
			["2"] = {
				["mine"] = true,
				["others"] = true,
			},
			["5"] = {
				["mine"] = true,
				["others"] = true,
			},
			["4"] = {
				["mine"] = true,
				["others"] = true,
			},
			["7"] = {
				["mine"] = true,
				["others"] = false,
			},
			["6"] = {
				["mine"] = true,
				["others"] = false,
			},
			["9"] = {
				["mine"] = true,
				["others"] = true,
			},
			["8"] = {
				["mine"] = true,
				["others"] = false,
			},
			["10"] = {
				["mine"] = true,
				["others"] = false,
			},
		},
		["stacksRadioValue"] = 2,
		["iconRadioValue"] = 1,
	},
	["VERSION"] = 4,
	["SCALING"] = {
		["turnAxis"] = false,
		["vertical"] = false,
		["invertGrowth"] = false,
	},
	["BAR_COLORS"] = {
		["OVERHEAL_TEXT"] = {
			["TG"] = 1,
			["TO"] = 1,
			["TB"] = 0.8,
			["TR"] = 0.8,
			["useText"] = true,
			["useOpacity"] = true,
		},
		["HOT7"] = {
			["useBackground"] = true,
			["R"] = 1,
			["O"] = 0.75,
			["G"] = 1,
			["B"] = 1,
		},
		["CLUSTER_FAIR"] = {
			["TG"] = 1,
			["R"] = 0.8,
			["TB"] = 0,
			["G"] = 0.8,
			["TR"] = 1,
			["TO"] = 1,
			["useText"] = true,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 0,
		},
		["HOT1"] = {
			["TG"] = 0.6,
			["countdownMode"] = 1,
			["B"] = 0.3,
			["TB"] = 0.6,
			["useText"] = true,
			["useBackground"] = true,
			["TO"] = 1,
			["TR"] = 1,
			["G"] = 0.3,
			["O"] = 1,
			["R"] = 1,
		},
		["DEBUFF0"] = {
			["useBackground"] = false,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["HOT3"] = {
			["TG"] = 1,
			["countdownMode"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["TR"] = 1,
			["TO"] = 1,
			["useText"] = true,
			["isFullDuration"] = false,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 1,
		},
		["RAID_ICONS"] = {
			["1"] = {
				["TG"] = 1,
				["B"] = 0.3058823529411765,
				["TB"] = 0.6078431372549019,
				["G"] = 0.9764705882352941,
				["TR"] = 0.9803921568627451,
				["TO"] = 1,
				["R"] = 1,
				["useText"] = true,
				["O"] = 1,
				["useBackground"] = true,
			},
			["3"] = {
				["TG"] = 0.6745098039215687,
				["R"] = 0.788235294117647,
				["TB"] = 0.9215686274509803,
				["G"] = 0.2901960784313725,
				["TR"] = 1,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["B"] = 0.8,
			},
			["2"] = {
				["TG"] = 0.8274509803921568,
				["R"] = 1,
				["TB"] = 0.4196078431372549,
				["G"] = 0.5137254901960784,
				["TR"] = 1,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["B"] = 0.0392156862745098,
			},
			["enable"] = false,
			["4"] = {
				["TG"] = 1,
				["R"] = 0,
				["TB"] = 0.6980392156862745,
				["G"] = 0.8,
				["TR"] = 0.6980392156862745,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["B"] = 0.01568627450980392,
			},
			["7"] = {
				["TG"] = 0.6274509803921569,
				["R"] = 0.8,
				["TB"] = 0.6196078431372549,
				["G"] = 0.1843137254901961,
				["TR"] = 1,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["B"] = 0.1294117647058823,
			},
			["6"] = {
				["TG"] = 0.8313725490196078,
				["R"] = 0.1215686274509804,
				["TB"] = 1,
				["G"] = 0.6901960784313725,
				["TR"] = 0.6627450980392157,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["B"] = 0.9725490196078431,
			},
			["8"] = {
				["TG"] = 0.2313725490196079,
				["R"] = 0.8470588235294118,
				["TB"] = 0.2313725490196079,
				["G"] = 0.8666666666666667,
				["TR"] = 0.2313725490196079,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["B"] = 0.8901960784313725,
			},
			["5"] = {
				["TG"] = 0.8705882352941177,
				["R"] = 0.4666666666666667,
				["TB"] = 1,
				["G"] = 0.7176470588235294,
				["TR"] = 0.7254901960784314,
				["TO"] = 1,
				["useText"] = true,
				["useBackground"] = true,
				["O"] = 1,
				["B"] = 0.8,
			},
		},
		["IRRELEVANT"] = {
			["TG"] = 0.82,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = false,
			["useText"] = false,
			["O"] = 0.5,
			["B"] = 0.4,
		},
		["HOT9"] = {
			["TG"] = 1,
			["countdownMode"] = 1,
			["R"] = 0.3,
			["TB"] = 1,
			["G"] = 1,
			["TR"] = 0.6,
			["TO"] = 1,
			["B"] = 1,
			["O"] = 1,
			["useBackground"] = true,
			["isFullDuration"] = false,
			["useText"] = true,
		},
		["HOT_CHARGE_4"] = {
			["TG"] = 1,
			["R"] = 0.8,
			["TB"] = 1,
			["G"] = 0.8,
			["TR"] = 1,
			["TO"] = 1,
			["useText"] = true,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 0.8,
		},
		["DEBUFF5"] = {
			["useBackground"] = false,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["HOT_CHARGE_3"] = {
			["TG"] = 1,
			["R"] = 0.3,
			["TB"] = 0.6,
			["G"] = 1,
			["TR"] = 0.6,
			["TO"] = 1,
			["useText"] = true,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 0.3,
		},
		["CLUSTER_GOOD"] = {
			["TG"] = 1,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0.8,
			["TR"] = 0,
			["TO"] = 1,
			["useText"] = true,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 0,
		},
		["HOT8"] = {
			["useBackground"] = true,
			["R"] = 1,
			["O"] = 0.75,
			["G"] = 1,
			["B"] = 1,
		},
		["INCOMING"] = {
			["TG"] = 0.82,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = false,
			["useText"] = false,
			["O"] = 0.33,
			["B"] = 0,
		},
		["HOT6"] = {
			["useBackground"] = true,
			["R"] = 1,
			["O"] = 0.75,
			["G"] = 1,
			["B"] = 1,
		},
		["DEBUFF4"] = {
			["TG"] = 0,
			["R"] = 0.9450980392156863,
			["TB"] = 1,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0.9450980392156863,
		},
		["DEBUFF1"] = {
			["TG"] = 1,
			["R"] = 0,
			["TB"] = 0.6860000000000001,
			["G"] = 0.592,
			["TR"] = 0,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0.8,
		},
		["HOT5"] = {
			["TG"] = 0.6,
			["countdownMode"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 0.3019607843137255,
			["TR"] = 1,
			["TO"] = 1,
			["useText"] = true,
			["isFullDuration"] = false,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 1,
		},
		["NO_EMERGENCY"] = {
			["TG"] = 0.82,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0.4,
		},
		["HOTS"] = {
			["isFadeOut"] = true,
			["factorDivineAegis"] = 1.2,
			["WARNING"] = {
				["enabled"] = false,
				["lowSecs"] = 3,
				["R"] = 0.5,
				["TB"] = 0.6,
				["G"] = 0.2,
				["TR"] = 1,
				["TO"] = 1,
				["TG"] = 0.6,
				["useBackground"] = true,
				["useText"] = true,
				["O"] = 1,
				["B"] = 0.2,
			},
			["useCountdown"] = true,
			["useAmount"] = true,
			["TEXT"] = {
				["outline"] = true,
				["shadow"] = false,
			},
			["useSquare"] = true,
			["useColorText"] = true,
			["showShieldAbsorb"] = 1,
			["useColorBack"] = true,
		},
		["GCD_BAR"] = {
			["useBackground"] = true,
			["R"] = 0.4,
			["G"] = 0.4,
			["O"] = 0.5,
			["B"] = 0.4,
		},
		["HOT2"] = {
			["TG"] = 1,
			["countdownMode"] = 1,
			["R"] = 1,
			["TB"] = 0.6,
			["G"] = 1,
			["TR"] = 1,
			["TO"] = 1,
			["useText"] = true,
			["isFullDuration"] = false,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 0.3,
		},
		["DEAD"] = {
			["TG"] = 0.5,
			["R"] = 0.3,
			["TB"] = 0.5,
			["G"] = 0.3,
			["TR"] = 0.5,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 0.5,
			["B"] = 0.3,
		},
		["OFFLINE"] = {
			["TG"] = 0.576,
			["R"] = 0.298,
			["TB"] = 0.576,
			["G"] = 0.298,
			["TR"] = 0.576,
			["TO"] = 0.58,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 0.21,
			["B"] = 0.298,
		},
		["OUTRANGED"] = {
			["TG"] = 0,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 0,
			["TO"] = 0.5,
			["useOpacity"] = true,
			["useBackground"] = false,
			["useText"] = false,
			["O"] = 0.25,
			["B"] = 0,
		},
		["AGGRO"] = {
			["useBackground"] = true,
			["useOpacity"] = true,
			["R"] = 1,
			["useText"] = false,
			["O"] = 1,
			["G"] = 0,
			["B"] = 0,
		},
		["DEBUFF3"] = {
			["TG"] = 0.957,
			["R"] = 0.4627450980392157,
			["TB"] = 1,
			["G"] = 0.6549019607843137,
			["TR"] = 0.329,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 1,
		},
		["EMERGENCY"] = {
			["TG"] = 0.82,
			["R"] = 1,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0,
		},
		["DEBUFF2"] = {
			["TG"] = 0,
			["R"] = 0.1137254901960784,
			["TB"] = 0,
			["G"] = 1,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0.09803921568627451,
		},
		["CHARMED"] = {
			["TG"] = 0.31,
			["R"] = 0.51,
			["TB"] = 0.31,
			["G"] = 0.082,
			["TR"] = 1,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0.263,
		},
		["DEBUFF6"] = {
			["TG"] = 0.5,
			["R"] = 0.6,
			["TB"] = 0,
			["G"] = 0.3,
			["TR"] = 0.8,
			["TO"] = 1,
			["useOpacity"] = true,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["B"] = 0,
		},
		["HOT10"] = {
			["TG"] = 1,
			["countdownMode"] = 1,
			["B"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["TR"] = 0.6,
			["TO"] = 1,
			["R"] = 0.3,
			["O"] = 1,
			["useBackground"] = true,
			["isFullDuration"] = false,
			["useText"] = true,
		},
		["THREAT"] = {
			["LOW"] = {
				["useBackground"] = true,
				["R"] = 0,
				["O"] = 1,
				["G"] = 1,
				["B"] = 1,
			},
			["HIGH"] = {
				["useBackground"] = true,
				["R"] = 1,
				["O"] = 1,
				["G"] = 0,
				["B"] = 1,
			},
		},
		["PLAYER_TARGET"] = {
			["useBackground"] = true,
			["R"] = 0.7,
			["O"] = 1,
			["G"] = 0.7,
			["B"] = 0.7,
		},
		["HOT4"] = {
			["TG"] = 0.6,
			["countdownMode"] = 1,
			["R"] = 0.3,
			["TB"] = 1,
			["G"] = 0.3,
			["TR"] = 0.6,
			["TO"] = 1,
			["useText"] = true,
			["isFullDuration"] = false,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 1,
		},
		["BAR_FRAMES"] = {
			["useOpacity"] = true,
			["R"] = 0,
			["useBackground"] = true,
			["O"] = 0.7,
			["G"] = 0,
			["B"] = 0,
		},
		["LIFE_LEFT"] = {
			["GOOD"] = {
				["useBackground"] = true,
				["R"] = 0,
				["G"] = 1,
				["O"] = 1,
				["B"] = 0,
			},
			["LOW"] = {
				["useBackground"] = true,
				["R"] = 1,
				["G"] = 0,
				["O"] = 1,
				["B"] = 0,
			},
			["FAIR"] = {
				["useBackground"] = true,
				["R"] = 1,
				["G"] = 1,
				["O"] = 1,
				["B"] = 0,
			},
		},
		["HOT_CHARGE_2"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 0.6,
			["G"] = 1,
			["TR"] = 1,
			["TO"] = 1,
			["useText"] = true,
			["useBackground"] = true,
			["O"] = 1,
			["B"] = 0.3,
		},
	},
}
VUHDO_SPELL_ASSIGNMENTS = {
	["altshift14"] = {
		"alt-shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["alt13"] = {
		"alt-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["altshift13"] = {
		"alt-shift-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["shift3"] = {
		"shift-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["ctrlshift4"] = {
		"ctrl-shift-", -- [1]
		"4", -- [2]
		"prayer of healing", -- [3]
	},
	["altctrl13"] = {
		"alt-ctrl-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["altctrlshift15"] = {
		"alt-ctrl-shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["ctrl12"] = {
		"ctrl-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["alt12"] = {
		"alt-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["altctrlshift12"] = {
		"alt-ctrl-shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["alt2"] = {
		"alt-", -- [1]
		"2", -- [2]
		"binding heal", -- [3]
	},
	["shift14"] = {
		"shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altctrlshift16"] = {
		"alt-ctrl-shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["shift16"] = {
		"shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["altshift2"] = {
		"alt-shift-", -- [1]
		"2", -- [2]
		"cure disease", -- [3]
	},
	["altshift6"] = {
		"alt-shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["ctrl3"] = {
		"ctrl-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["13"] = {
		"", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["alt8"] = {
		"alt-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrl16"] = {
		"alt-ctrl-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["ctrl2"] = {
		"ctrl-", -- [1]
		"2", -- [2]
		"menu", -- [3]
	},
	["ctrlshift6"] = {
		"ctrl-shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["altctrl5"] = {
		"alt-ctrl-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["altshift16"] = {
		"alt-shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["shift4"] = {
		"shift-", -- [1]
		"4", -- [2]
		"pain suppression", -- [3]
	},
	["ctrl9"] = {
		"ctrl-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["shift15"] = {
		"shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["ctrl11"] = {
		"ctrl-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["altctrlshift6"] = {
		"alt-ctrl-shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["ctrlshift1"] = {
		"ctrl-shift-", -- [1]
		"1", -- [2]
		"circle of healing", -- [3]
	},
	["ctrlshift14"] = {
		"ctrl-shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["alt15"] = {
		"alt-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["shift7"] = {
		"shift-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["altctrlshift5"] = {
		"alt-ctrl-shift-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["ctrl4"] = {
		"ctrl-", -- [1]
		"4", -- [2]
		"power infusion", -- [3]
	},
	["altctrl3"] = {
		"alt-ctrl-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["altctrlshift8"] = {
		"alt-ctrl-shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altshift15"] = {
		"alt-shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altshift1"] = {
		"alt-shift-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["altctrlshift2"] = {
		"alt-ctrl-shift-", -- [1]
		"2", -- [2]
		"dropdown", -- [3]
	},
	["altctrl1"] = {
		"alt-ctrl-", -- [1]
		"1", -- [2]
		"Heal", -- [3]
	},
	["altctrl14"] = {
		"alt-ctrl-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["ctrl15"] = {
		"ctrl-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["ctrl16"] = {
		"ctrl-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["ctrlshift15"] = {
		"ctrl-shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altshift12"] = {
		"alt-shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["altctrlshift11"] = {
		"alt-ctrl-shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["shift6"] = {
		"shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["ctrlshift16"] = {
		"ctrl-shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["ctrlshift13"] = {
		"ctrl-shift-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["altctrlshift3"] = {
		"alt-ctrl-shift-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["altctrlshift14"] = {
		"alt-ctrl-shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["shift1"] = {
		"shift-", -- [1]
		"1", -- [2]
		"greater heal", -- [3]
	},
	["altshift4"] = {
		"alt-shift-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["shift2"] = {
		"shift-", -- [1]
		"2", -- [2]
		"cure disease", -- [3]
	},
	["alt5"] = {
		"alt-", -- [1]
		"5", -- [2]
		"Levitate", -- [3]
	},
	["altctrl11"] = {
		"alt-ctrl-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["alt3"] = {
		"alt-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["16"] = {
		"", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["shift9"] = {
		"shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["altctrlshift7"] = {
		"alt-ctrl-shift-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["12"] = {
		"", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["shift10"] = {
		"shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altctrl7"] = {
		"alt-ctrl-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["ctrlshift12"] = {
		"ctrl-shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["ctrl7"] = {
		"ctrl-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["alt4"] = {
		"alt-", -- [1]
		"4", -- [2]
		"penance", -- [3]
	},
	["alt11"] = {
		"alt-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["shift11"] = {
		"shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["1"] = {
		"", -- [1]
		"1", -- [2]
		"renew", -- [3]
	},
	["altshift9"] = {
		"alt-shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["5"] = {
		"", -- [1]
		"5", -- [2]
		"Power word: fortitude", -- [3]
	},
	["ctrl1"] = {
		"ctrl-", -- [1]
		"1", -- [2]
		"prayer of mending", -- [3]
	},
	["ctrlshift8"] = {
		"ctrl-shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["ctrl5"] = {
		"ctrl-", -- [1]
		"5", -- [2]
		"Shadow protection", -- [3]
	},
	["altctrl10"] = {
		"alt-ctrl-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altctrlshift4"] = {
		"alt-ctrl-shift-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["alt14"] = {
		"alt-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["ctrlshift3"] = {
		"ctrl-shift-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["alt9"] = {
		"alt-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["alt1"] = {
		"alt-", -- [1]
		"1", -- [2]
		"flash heal", -- [3]
	},
	["8"] = {
		"", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["3"] = {
		"", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["2"] = {
		"", -- [1]
		"2", -- [2]
		"Dispel Magic", -- [3]
	},
	["ctrlshift2"] = {
		"ctrl-shift-", -- [1]
		"2", -- [2]
		"holy nova", -- [3]
	},
	["4"] = {
		"", -- [1]
		"4", -- [2]
		"Power Word: Shield", -- [3]
	},
	["7"] = {
		"", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["6"] = {
		"", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["9"] = {
		"", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["15"] = {
		"", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altctrlshift10"] = {
		"alt-ctrl-shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["shift8"] = {
		"shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrlshift1"] = {
		"alt-ctrl-shift-", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["shift13"] = {
		"shift-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["11"] = {
		"", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["altctrl12"] = {
		"alt-ctrl-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["ctrlshift7"] = {
		"ctrl-shift-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["altctrl2"] = {
		"alt-ctrl-", -- [1]
		"2", -- [2]
		"Holy Word: Chastise", -- [3]
	},
	["altctrlshift13"] = {
		"alt-ctrl-shift-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["ctrl14"] = {
		"ctrl-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altctrl8"] = {
		"alt-ctrl-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["alt10"] = {
		"alt-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["ctrlshift5"] = {
		"ctrl-shift-", -- [1]
		"5", -- [2]
		"guardian spirit", -- [3]
	},
	["ctrl6"] = {
		"ctrl-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["alt16"] = {
		"alt-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["shift12"] = {
		"shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["altshift5"] = {
		"alt-shift-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["altctrl6"] = {
		"alt-ctrl-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["ctrlshift11"] = {
		"ctrl-shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["ctrlshift10"] = {
		"ctrl-shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altshift11"] = {
		"alt-shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["altshift10"] = {
		"alt-shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["alt7"] = {
		"alt-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["ctrl10"] = {
		"ctrl-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altshift3"] = {
		"alt-shift-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["altctrl4"] = {
		"alt-ctrl-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["altctrlshift9"] = {
		"alt-ctrl-shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["altshift8"] = {
		"alt-shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrl9"] = {
		"alt-ctrl-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["shift5"] = {
		"shift-", -- [1]
		"5", -- [2]
		"Divine spirit", -- [3]
	},
	["14"] = {
		"", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altshift7"] = {
		"alt-shift-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["ctrl8"] = {
		"ctrl-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrl15"] = {
		"alt-ctrl-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["ctrlshift9"] = {
		"ctrl-shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["alt6"] = {
		"alt-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["ctrl13"] = {
		"ctrl-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["10"] = {
		"", -- [1]
		"10", -- [2]
		"", -- [3]
	},
}
VUHDO_HOSTILE_SPELL_ASSIGNMENTS = {
	["altshift14"] = {
		"alt-shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["shift3"] = {
		"shift-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["ctrl4"] = {
		"ctrl-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["ctrl12"] = {
		"ctrl-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["alt6"] = {
		"alt-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["altctrl13"] = {
		"alt-ctrl-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["alt13"] = {
		"alt-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["altshift13"] = {
		"alt-shift-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["alt12"] = {
		"alt-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["altctrlshift12"] = {
		"alt-ctrl-shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["alt2"] = {
		"alt-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["shift14"] = {
		"shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altctrlshift16"] = {
		"alt-ctrl-shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["ctrl2"] = {
		"ctrl-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["altshift5"] = {
		"alt-shift-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["altshift16"] = {
		"alt-shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["ctrl3"] = {
		"ctrl-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["13"] = {
		"", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["ctrlshift9"] = {
		"ctrl-shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["altctrl16"] = {
		"alt-ctrl-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["altctrlshift8"] = {
		"alt-ctrl-shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["ctrlshift6"] = {
		"ctrl-shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["altshift2"] = {
		"alt-shift-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["altshift6"] = {
		"alt-shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["shift4"] = {
		"shift-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["ctrl9"] = {
		"ctrl-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["shift15"] = {
		"shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["ctrl11"] = {
		"ctrl-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["altctrlshift6"] = {
		"alt-ctrl-shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["ctrlshift1"] = {
		"ctrl-shift-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["ctrlshift14"] = {
		"ctrl-shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["alt15"] = {
		"alt-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["shift7"] = {
		"shift-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["altctrlshift5"] = {
		"alt-ctrl-shift-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["alt8"] = {
		"alt-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrl3"] = {
		"alt-ctrl-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["shift16"] = {
		"shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["altshift15"] = {
		"alt-shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altshift1"] = {
		"alt-shift-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["altctrlshift2"] = {
		"alt-ctrl-shift-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["altctrl1"] = {
		"alt-ctrl-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["altctrl5"] = {
		"alt-ctrl-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["ctrl15"] = {
		"ctrl-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["ctrl16"] = {
		"ctrl-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["ctrlshift15"] = {
		"ctrl-shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altshift12"] = {
		"alt-shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["altctrlshift11"] = {
		"alt-ctrl-shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["shift6"] = {
		"shift-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["ctrlshift16"] = {
		"ctrl-shift-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["ctrlshift5"] = {
		"ctrl-shift-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["altshift9"] = {
		"alt-shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["ctrlshift4"] = {
		"ctrl-shift-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["shift1"] = {
		"shift-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["altshift4"] = {
		"alt-shift-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["shift2"] = {
		"shift-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["alt5"] = {
		"alt-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["altctrl11"] = {
		"alt-ctrl-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["alt3"] = {
		"alt-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["16"] = {
		"", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["shift9"] = {
		"shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["altctrlshift7"] = {
		"alt-ctrl-shift-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["ctrlshift13"] = {
		"ctrl-shift-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["shift10"] = {
		"shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altctrl7"] = {
		"alt-ctrl-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["ctrlshift12"] = {
		"ctrl-shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["ctrl7"] = {
		"ctrl-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["ctrlshift3"] = {
		"ctrl-shift-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["alt11"] = {
		"alt-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["shift11"] = {
		"shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["alt1"] = {
		"alt-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["3"] = {
		"", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["ctrlshift2"] = {
		"ctrl-shift-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["ctrl1"] = {
		"ctrl-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["ctrlshift8"] = {
		"ctrl-shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["ctrl5"] = {
		"ctrl-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["altctrl10"] = {
		"alt-ctrl-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altctrlshift4"] = {
		"alt-ctrl-shift-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["alt14"] = {
		"alt-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["alt4"] = {
		"alt-", -- [1]
		"4", -- [2]
		"penance", -- [3]
	},
	["alt9"] = {
		"alt-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["1"] = {
		"", -- [1]
		"1", -- [2]
		"target", -- [3]
	},
	["8"] = {
		"", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrlshift3"] = {
		"alt-ctrl-shift-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["2"] = {
		"", -- [1]
		"2", -- [2]
		"dispel magic", -- [3]
	},
	["5"] = {
		"", -- [1]
		"5", -- [2]
		"menu", -- [3]
	},
	["4"] = {
		"", -- [1]
		"4", -- [2]
		"menu", -- [3]
	},
	["7"] = {
		"", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["6"] = {
		"", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["9"] = {
		"", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["15"] = {
		"", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altctrlshift10"] = {
		"alt-ctrl-shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["shift8"] = {
		"shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrlshift1"] = {
		"alt-ctrl-shift-", -- [1]
		"1", -- [2]
		"", -- [3]
	},
	["shift13"] = {
		"shift-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["11"] = {
		"", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["altctrl12"] = {
		"alt-ctrl-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["ctrlshift7"] = {
		"ctrl-shift-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["altctrl2"] = {
		"alt-ctrl-", -- [1]
		"2", -- [2]
		"", -- [3]
	},
	["altctrlshift13"] = {
		"alt-ctrl-shift-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["ctrl14"] = {
		"ctrl-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altctrl8"] = {
		"alt-ctrl-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["alt10"] = {
		"alt-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["ctrl6"] = {
		"ctrl-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["12"] = {
		"", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["alt16"] = {
		"alt-", -- [1]
		"16", -- [2]
		"", -- [3]
	},
	["shift12"] = {
		"shift-", -- [1]
		"12", -- [2]
		"", -- [3]
	},
	["altctrl14"] = {
		"alt-ctrl-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altctrl6"] = {
		"alt-ctrl-", -- [1]
		"6", -- [2]
		"", -- [3]
	},
	["ctrlshift11"] = {
		"ctrl-shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["ctrlshift10"] = {
		"ctrl-shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altshift11"] = {
		"alt-shift-", -- [1]
		"11", -- [2]
		"", -- [3]
	},
	["altshift10"] = {
		"alt-shift-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["alt7"] = {
		"alt-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["ctrl10"] = {
		"ctrl-", -- [1]
		"10", -- [2]
		"", -- [3]
	},
	["altshift3"] = {
		"alt-shift-", -- [1]
		"3", -- [2]
		"", -- [3]
	},
	["altctrl4"] = {
		"alt-ctrl-", -- [1]
		"4", -- [2]
		"", -- [3]
	},
	["altctrlshift9"] = {
		"alt-ctrl-shift-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["altshift8"] = {
		"alt-shift-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrl9"] = {
		"alt-ctrl-", -- [1]
		"9", -- [2]
		"", -- [3]
	},
	["shift5"] = {
		"shift-", -- [1]
		"5", -- [2]
		"", -- [3]
	},
	["14"] = {
		"", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altshift7"] = {
		"alt-shift-", -- [1]
		"7", -- [2]
		"", -- [3]
	},
	["ctrl8"] = {
		"ctrl-", -- [1]
		"8", -- [2]
		"", -- [3]
	},
	["altctrl15"] = {
		"alt-ctrl-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["altctrlshift14"] = {
		"alt-ctrl-shift-", -- [1]
		"14", -- [2]
		"", -- [3]
	},
	["altctrlshift15"] = {
		"alt-ctrl-shift-", -- [1]
		"15", -- [2]
		"", -- [3]
	},
	["ctrl13"] = {
		"ctrl-", -- [1]
		"13", -- [2]
		"", -- [3]
	},
	["10"] = {
		"", -- [1]
		"10", -- [2]
		"", -- [3]
	},
}
VUHDO_MM_SETTINGS = {
	["enabled"] = 1,
	["drag"] = "CIRCLE",
	["position"] = -45.75589222951303,
}
VUHDO_PLAYER_TARGETS = {
}
VUHDO_MAINTANK_NAMES = {
}
VUHDO_BUFF_SETTINGS = {
	["Inner Fire"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["B"] = 1,
		},
		["buff"] = "Inner Fire",
		["enabled"] = true,
		["filter"] = {
			[999] = true,
		},
	},
	["Power Infusion"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["B"] = 1,
		},
		["enabled"] = false,
		["name"] = "Zweer",
		["filter"] = {
			[999] = true,
		},
	},
	["Vampiric Embrace"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["B"] = 1,
		},
		["buff"] = "Vampiric Embrace",
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["CONFIG"] = {
		["SWATCH_EMPTY_GROUP"] = {
			["TG"] = 0.8,
			["R"] = 0,
			["TB"] = 0.8,
			["G"] = 0,
			["TR"] = 0.8,
			["TO"] = 0.6,
			["B"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 0.5,
			["useOpacity"] = true,
		},
		["SWATCH_COLOR_BUFF_OUT"] = {
			["TG"] = 0,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 0.8,
			["TO"] = 1,
			["B"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["SHOW_LABEL"] = false,
		["REFRESH_SECS"] = 1,
		["SWATCH_COLOR_BUFF_COOLDOWN"] = {
			["TG"] = 0.6,
			["R"] = 0.3,
			["TB"] = 0.6,
			["G"] = 0.3,
			["TR"] = 0.6,
			["TO"] = 1,
			["B"] = 0.3,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["SWATCH_COLOR_BUFF_OKAY"] = {
			["TG"] = 0.8,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 0,
			["TO"] = 1,
			["B"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["SHOW"] = true,
		["PANEL_BG_COLOR"] = {
			["useBackground"] = true,
			["B"] = 0,
			["R"] = 0,
			["G"] = 0,
			["O"] = 0.5,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["SWATCH_COLOR_BUFF_LOW"] = {
			["TG"] = 0.7,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 1,
			["TO"] = 1,
			["B"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["VERSION"] = 2,
		["SCALE"] = 1,
		["BAR_COLORS_TEXT"] = true,
		["BAR_COLORS_IN_FIGHT"] = false,
		["HIGHLIGHT_COOLDOWN"] = false,
		["HIDE_CHARGES"] = false,
		["IGNORE_PETS"] = true,
		["COMPACT"] = true,
		["PANEL_BORDER_COLOR"] = {
			["useBackground"] = true,
			["B"] = 0,
			["R"] = 0,
			["G"] = 0,
			["O"] = 0.5,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["BAR_COLORS_BACKGROUND"] = true,
		["POSITION"] = {
			["y"] = -22.35618555103233,
			["x"] = -156.4639328276816,
			["point"] = "TOPRIGHT",
			["relativePoint"] = "TOPRIGHT",
		},
		["SWATCH_BG_COLOR"] = {
			["useBackground"] = true,
			["B"] = 0,
			["R"] = 0,
			["G"] = 0,
			["O"] = 1,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["PANEL_MAX_BUFFS"] = 5,
		["REBUFF_MIN_MINUTES"] = 3,
		["SWATCH_BORDER_COLOR"] = {
			["useBackground"] = true,
			["B"] = 0.8,
			["R"] = 0.8,
			["G"] = 0.8,
			["O"] = 0,
			["useText"] = false,
			["useOpacity"] = false,
		},
		["REBUFF_AT_PERCENT"] = 25,
		["WHEEL_SMART_BUFF"] = true,
		["SWATCH_COLOR_OUT_RANGE"] = {
			["TG"] = 0,
			["R"] = 0,
			["TB"] = 0,
			["G"] = 0,
			["TR"] = 0,
			["TO"] = 0.5,
			["B"] = 0,
			["useBackground"] = true,
			["useText"] = true,
			["O"] = 0.5,
			["useOpacity"] = true,
		},
	},
	["Pain Suppression"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["B"] = 1,
		},
		["enabled"] = false,
		["name"] = "Zweer",
		["filter"] = {
			[999] = true,
		},
	},
	["Levitate"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["B"] = 1,
		},
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["Seal"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["B"] = 1,
			["TO"] = 1,
			["useBackground"] = true,
			["TR"] = 1,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["Shadow Protection"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["B"] = 1,
		},
		["enabled"] = true,
		["filter"] = {
			[999] = true,
		},
	},
	["Fear Ward"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["B"] = 1,
		},
		["enabled"] = true,
		["name"] = "Zweer",
		["filter"] = {
			[999] = true,
		},
	},
	["Shadowfiend"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["B"] = 1,
		},
		["buff"] = "Shadowfiend",
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["Fortitude"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["B"] = 1,
		},
		["enabled"] = true,
		["filter"] = {
			[999] = true,
		},
	},
	["Aura"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["B"] = 1,
			["TO"] = 1,
			["useBackground"] = true,
			["TR"] = 1,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["Power Word: Fortitude"] = {
		["missingColor"] = {
			["TG"] = 1,
			["B"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["useOpacity"] = true,
			["TO"] = 1,
			["useBackground"] = true,
			["useText"] = true,
			["TR"] = 1,
			["O"] = 1,
			["R"] = 1,
		},
		["enabled"] = true,
		["filter"] = {
			[999] = true,
		},
	},
	["Blessing"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["B"] = 1,
			["TO"] = 1,
			["useBackground"] = true,
			["TR"] = 1,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["Beacon of Light"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["B"] = 1,
			["TO"] = 1,
			["useBackground"] = true,
			["TR"] = 1,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
	["Righteous Fury"] = {
		["missingColor"] = {
			["TG"] = 1,
			["R"] = 1,
			["TB"] = 1,
			["G"] = 1,
			["show"] = false,
			["B"] = 1,
			["TO"] = 1,
			["useBackground"] = true,
			["TR"] = 1,
			["useText"] = true,
			["O"] = 1,
			["useOpacity"] = true,
		},
		["enabled"] = false,
		["filter"] = {
			[999] = true,
		},
	},
}
VUHDO_POWER_TYPE_COLORS = {
	{
		["useBackground"] = true,
		["R"] = 1,
		["useOpacity"] = true,
		["O"] = 1,
		["G"] = 0,
		["B"] = 0,
	}, -- [1]
	{
		["TG"] = 0.5,
		["R"] = 1,
		["TB"] = 0.25,
		["G"] = 0.5,
		["useOpacity"] = true,
		["useBackground"] = true,
		["O"] = 1,
		["B"] = 0.25,
	}, -- [2]
	{
		["useBackground"] = true,
		["R"] = 1,
		["useOpacity"] = true,
		["O"] = 1,
		["G"] = 1,
		["B"] = 0,
	}, -- [3]
	{
		["useBackground"] = true,
		["R"] = 0,
		["useOpacity"] = true,
		["O"] = 1,
		["G"] = 1,
		["B"] = 1,
	}, -- [4]
	nil, -- [5]
	{
		["TG"] = 0.5,
		["B"] = 0.5,
		["TB"] = 0.5,
		["G"] = 0.5,
		["TR"] = 0.5,
		["useOpacity"] = true,
		["useBackground"] = true,
		["O"] = 1,
		["R"] = 0.5,
	}, -- [6]
	[0] = {
		["useBackground"] = true,
		["R"] = 0,
		["useOpacity"] = true,
		["O"] = 1,
		["G"] = 0,
		["B"] = 1,
	},
}
VUHDO_SPELLS_KEYBOARD = {
	["SPELL15"] = "",
	["SPELL6"] = "",
	["SPELL13"] = "",
	["HOSTILE_WHEEL"] = {
		["alt1"] = {
			"ALT-", -- [1]
			"-w3", -- [2]
			"", -- [3]
		},
		["altctrl2"] = {
			"ALT-CTRL-", -- [1]
			"-w10", -- [2]
			"", -- [3]
		},
		["ctrl2"] = {
			"CTRL-", -- [1]
			"-w6", -- [2]
			"", -- [3]
		},
		["2"] = {
			"", -- [1]
			"-w2", -- [2]
			"", -- [3]
		},
		["shift1"] = {
			"SHIFT-", -- [1]
			"-w7", -- [2]
			"", -- [3]
		},
		["shift2"] = {
			"SHIFT-", -- [1]
			"-w8", -- [2]
			"", -- [3]
		},
		["altshift1"] = {
			"ALT-SHIFT-", -- [1]
			"-w11", -- [2]
			"", -- [3]
		},
		["1"] = {
			"", -- [1]
			"-w1", -- [2]
			"", -- [3]
		},
		["altctrl1"] = {
			"ALT-CTRL-", -- [1]
			"-w9", -- [2]
			"", -- [3]
		},
		["alt2"] = {
			"ALT-", -- [1]
			"-w4", -- [2]
			"", -- [3]
		},
		["altshift2"] = {
			"ALT-SHIFT-", -- [1]
			"-w12", -- [2]
			"", -- [3]
		},
		["altctrlshift2"] = {
			"ALT-CTRL-SHIFT-", -- [1]
			"-w16", -- [2]
			"", -- [3]
		},
		["altctrlshift1"] = {
			"ALT-CTRL-SHIFT-", -- [1]
			"-w15", -- [2]
			"", -- [3]
		},
		["ctrlshift1"] = {
			"CTRL-SHIFT-", -- [1]
			"-w13", -- [2]
			"", -- [3]
		},
		["ctrl1"] = {
			"CTRL-", -- [1]
			"-w5", -- [2]
			"", -- [3]
		},
		["ctrlshift2"] = {
			"CTRL-SHIFT-", -- [1]
			"-w14", -- [2]
			"", -- [3]
		},
	},
	["SPELL3"] = "",
	["SPELL4"] = "",
	["SPELL2"] = "",
	["SPELL16"] = "",
	["SPELL7"] = "",
	["SPELL12"] = "",
	["SPELL5"] = "",
	["SPELL9"] = "",
	["SPELL10"] = "",
	["version"] = 2,
	["SPELL14"] = "",
	["SPELL11"] = "",
	["SPELL8"] = "",
	["SPELL1"] = "",
	["WHEEL"] = {
		["alt1"] = {
			"ALT-", -- [1]
			"-w3", -- [2]
			"", -- [3]
		},
		["altctrl2"] = {
			"ALT-CTRL-", -- [1]
			"-w10", -- [2]
			"", -- [3]
		},
		["ctrl2"] = {
			"CTRL-", -- [1]
			"-w6", -- [2]
			"", -- [3]
		},
		["2"] = {
			"", -- [1]
			"-w2", -- [2]
			"", -- [3]
		},
		["shift1"] = {
			"SHIFT-", -- [1]
			"-w7", -- [2]
			"", -- [3]
		},
		["shift2"] = {
			"SHIFT-", -- [1]
			"-w8", -- [2]
			"", -- [3]
		},
		["altshift1"] = {
			"ALT-SHIFT-", -- [1]
			"-w11", -- [2]
			"", -- [3]
		},
		["1"] = {
			"", -- [1]
			"-w1", -- [2]
			"target", -- [3]
		},
		["altctrl1"] = {
			"ALT-CTRL-", -- [1]
			"-w9", -- [2]
			"", -- [3]
		},
		["alt2"] = {
			"ALT-", -- [1]
			"-w4", -- [2]
			"", -- [3]
		},
		["altshift2"] = {
			"ALT-SHIFT-", -- [1]
			"-w12", -- [2]
			"", -- [3]
		},
		["altctrlshift2"] = {
			"ALT-CTRL-SHIFT-", -- [1]
			"-w16", -- [2]
			"", -- [3]
		},
		["altctrlshift1"] = {
			"ALT-CTRL-SHIFT-", -- [1]
			"-w15", -- [2]
			"", -- [3]
		},
		["ctrlshift1"] = {
			"CTRL-SHIFT-", -- [1]
			"-w13", -- [2]
			"", -- [3]
		},
		["ctrl1"] = {
			"CTRL-", -- [1]
			"-w5", -- [2]
			"", -- [3]
		},
		["ctrlshift2"] = {
			"CTRL-SHIFT-", -- [1]
			"-w14", -- [2]
			"", -- [3]
		},
	},
}
VUHDO_SPELL_CONFIG = {
	["IS_LOAD_HOTS"] = 1,
	["smartCastModi"] = "all",
	["IS_AUTO_FIRE"] = 1,
	["IS_FIRE_CUSTOM_2"] = false,
	["IS_FIRE_TRINKET_2"] = true,
	["IS_FIRE_TRINKET_1"] = true,
	["FIRE_CUSTOM_1_SPELL"] = "Inner Focus",
	["FIRE_CUSTOM_2_SPELL"] = "",
	["IS_FIRE_HOT"] = 1,
	["IS_FIRE_CUSTOM_1"] = 1,
	["IS_KEEP_STANCE"] = true,
}
VUHDO_BUFF_ORDER = {
	["04Inner Fire"] = 4,
	["05Righteous Fury"] = 5,
	["03Seal"] = 3,
	["05Shadowfiend"] = 5,
	["03Fear Ward"] = 3,
	["01Power Word: Fortitude"] = 1,
	["02Aura"] = 2,
	["01Blessing"] = 1,
	["07Vampiric Embrace"] = 7,
	["09Pain Suppression"] = 9,
	["01Fortitude"] = 1,
	["04Beacon of Light"] = 4,
	["08Levitate"] = 8,
	["06Power Infusion"] = 6,
	["02Shadow Protection"] = 2,
}
VUHDO_SPEC_LAYOUTS = {
	["1"] = "Zweer Healer",
	["selected"] = "Zweer Healer",
	["2"] = "Zweer Healer Disci",
}
VUHDO_LAST_AUTO_ARRANG = "Zweer 1"
VUHDO_RAID = {
	["player"] = {
		["visible"] = 1,
		["targetUnit"] = "target",
		["group"] = 1,
		["class"] = "PALADIN",
		["range"] = true,
		["unit"] = "player",
		["zone"] = "Ashenvale",
		["debuff"] = 0,
		["healthmax"] = 976,
		["afk"] = 1,
		["number"] = 1,
		["sortMaxHp"] = 976,
		["classId"] = 23,
		["baseRange"] = true,
		["debuffName"] = "",
		["connected"] = 1,
		["powermax"] = 854,
		["power"] = 854,
		["petUnit"] = "pet",
		["isVehicle"] = false,
		["threatPerc"] = 0,
		["isPet"] = false,
		["powertype"] = 0,
		["health"] = 976,
		["className"] = "Paladin",
		["map"] = "Ashenvale",
		["fullName"] = "Zweèr",
		["aggro"] = false,
		["name"] = "Zweèr",
	},
}
VUHDO_INDICATOR_CONFIG = {
	["CUSTOM"] = {
		["THREAT_BAR"] = {
			["HEIGHT"] = 1,
			["WARN_AT"] = 85,
			["TEXTURE"] = "VuhDo - Polished Wood",
		},
		["MOUSEOVER_HIGHLIGHT"] = {
			["TEXTURE"] = "LiteStepLite",
		},
		["AGGRO_BAR"] = {
			["TEXTURE"] = "VuhDo - Polished Wood",
		},
		["BACKGROUND_BAR"] = {
			["TEXTURE"] = "VuhDo - Minimalist",
		},
		["SWIFTMEND_INDICATOR"] = {
			["SCALE"] = 1,
		},
		["MANA_BAR"] = {
			["HEIGHT"] = 3,
			["TEXTURE"] = "VuhDo - Pipe, light",
		},
		["HEALTH_BAR"] = {
			["turnAxis"] = false,
			["vertical"] = false,
			["invertGrowth"] = false,
		},
		["BAR_BORDER"] = {
			["WIDTH"] = 1,
		},
		["CLUSTER_BORDER"] = {
			["WIDTH"] = 2,
		},
	},
	["BOUQUETS"] = {
		["THREAT_BAR"] = "Threat: Status Bar",
		["MOUSEOVER_HIGHLIGHT"] = "",
		["AGGRO_BAR"] = "Aggro Indicator",
		["BACKGROUND_BAR"] = "Background: Solid",
		["INCOMING_BAR"] = "",
		["CLUSTER_BORDER"] = "Cluster: Mouse Hover",
		["THREAT_MARK"] = "",
		["SWIFTMEND_INDICATOR"] = "",
		["MANA_BAR"] = "Manabars: Mana only",
		["BAR_BORDER"] = "Healer CD",
		["HEALTH_BAR"] = "Vita",
		["DAMAGE_FLASH_BAR"] = "",
		["HEALTH_BAR_PANEL"] = {
			"Vita", -- [1]
			"", -- [2]
			"", -- [3]
			"", -- [4]
			"", -- [5]
			"", -- [6]
			"", -- [7]
			"", -- [8]
			"", -- [9]
			"", -- [10]
		},
	},
}
VUHDO_EVENT_TIMES = nil
