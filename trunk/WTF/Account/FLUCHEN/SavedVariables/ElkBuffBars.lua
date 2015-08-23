
ElkBuffBarsDB = {
	["currentProfile"] = {
		["Zweer - Crushridge"] = "zwe",
	},
	["account"] = {
		["maxcharges"] = {
			["TENCH"] = {
			},
			["DEBUFF"] = {
				["Burning Flames "] = 4,
				["Disorienting Roar "] = 3,
				["Faerie Fire "] = 3,
				["Frost Vulnerability "] = 5,
				["Mind Spike "] = 3,
				["Censure "] = 5,
				["Claw Puncture "] = 5,
				["Crunch Armor "] = 3,
				["Overcharge "] = 6,
				["Ice Blast "] = 2,
				["Frostfire Bolt "] = 2,
				["Burning Corruption "] = 6,
				["Water Bolt "] = 3,
			},
			["BUFF"] = {
				["Shadow Orb "] = 3,
				["Satiated "] = 14,
				["Serendipity "] = 2,
				["Dark Intent "] = 3,
				["Prayer of Mending "] = 5,
				["Bone Shield "] = 3,
				["Reckoning "] = 3,
				["Scent of Blood "] = 3,
				["Backdraft "] = 3,
				["Lock and Load "] = 2,
				["Lifebloom "] = 3,
				["Tranquility "] = 2,
				["Adrenaline "] = 3,
				["Water Shield "] = 3,
				["Rabid Power "] = 3,
				["Grace "] = 10,
				["Jagged Rock Shield "] = 20,
				["Dark Evangelism "] = 5,
				["Mind Melt "] = 2,
				["Evangelism "] = 2,
				["Ancient Power "] = 20,
				["Thirst for Blood "] = 20,
			},
		},
		["maxtimes"] = {
			["TENCH"] = {
			},
			["DEBUFF"] = {
			},
			["BUFF"] = {
			},
		},
		["build"] = "13329",
	},
	["profiles"] = {
		["Default"] = {
			["detachedTooltip"] = {
				["fontSizePercent"] = 1,
			},
			["bargroups"] = {
				{
					["anchorshown"] = false,
					["scale"] = 1,
					["barspacing"] = 5,
					["alpha"] = 1,
					["anchortext"] = "BUFFS",
					["y"] = 986.3506628323747,
					["x"] = 1632.679123171766,
					["growup"] = false,
					["filter"] = {
						["type"] = {
							["BUFF"] = true,
						},
					},
					["target"] = "player",
					["bars"] = {
						["textBR"] = false,
						["textTRfont"] = "Friz Quadrata TT",
						["tooltipanchor"] = "default",
						["textBRfontsize"] = 14,
						["icon"] = "RIGHT",
						["abbreviate_name"] = 0,
						["bgbar"] = false,
						["iconcount"] = true,
						["textTLalign"] = "right",
						["textBLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTR"] = false,
						["bar"] = false,
						["textBL"] = false,
						["textBRfont"] = "Friz Quadrata TT",
						["textTL"] = "TIMELEFT",
						["textTLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTLfont"] = "Friz Quadrata TT",
						["iconcountfont"] = "Arial Narrow",
						["timeformat"] = "CONDENSED",
						["textTRfontsize"] = 14,
						["iconcountanchor"] = "CENTER",
						["timelessfull"] = false,
						["textBRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
						},
						["barcolor"] = {
							0.3, -- [1]
							0.5, -- [2]
							1, -- [3]
							0.8, -- [4]
						},
						["spark"] = false,
						["textTLfontsize"] = 14,
						["bartexture"] = "Otravi",
						["barbgcolor"] = {
							0, -- [1]
							0.5, -- [2]
							1, -- [3]
							0.3, -- [4]
						},
						["iconcountcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["debufftypecolor"] = true,
						["width"] = 250,
						["textBLfont"] = "Friz Quadrata TT",
						["textBLfontsize"] = 14,
						["iconcountfontsize"] = 14,
						["barright"] = false,
						["textTRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["padding"] = 1,
						["textBLalign"] = "left",
						["height"] = 20,
					},
					["id"] = 1,
					["sorting"] = "timeleft",
				}, -- [1]
				{
					["anchorshown"] = false,
					["scale"] = 1,
					["id"] = 2,
					["barspacing"] = 5,
					["alpha"] = 1,
					["y"] = 985.7573682697841,
					["anchortext"] = "DEBUFFS",
					["x"] = 1535.90538812295,
					["growup"] = false,
					["filter"] = {
						["type"] = {
							["DEBUFF"] = true,
						},
					},
					["target"] = "player",
					["bars"] = {
						["textBR"] = false,
						["textTRfont"] = "Friz Quadrata TT",
						["tooltipanchor"] = "default",
						["textBRfontsize"] = 14,
						["icon"] = "LEFT",
						["abbreviate_name"] = 0,
						["bgbar"] = true,
						["iconcount"] = true,
						["textTLalign"] = "LEFT",
						["textBLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTR"] = "TIMELEFT",
						["bar"] = true,
						["textBL"] = false,
						["textBRfont"] = "Friz Quadrata TT",
						["textTL"] = "NAMERANKCOUNT",
						["textTLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTLfont"] = "Friz Quadrata TT",
						["iconcountfont"] = "Arial Narrow",
						["timeformat"] = "CONDENSED",
						["textTRfontsize"] = 14,
						["iconcountanchor"] = "CENTER",
						["timelessfull"] = false,
						["textBRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
						},
						["barcolor"] = {
							1, -- [1]
							0, -- [2]
							0, -- [3]
							0.8, -- [4]
						},
						["spark"] = false,
						["textTLfontsize"] = 14,
						["bartexture"] = "Otravi",
						["barbgcolor"] = {
							1, -- [1]
							0, -- [2]
							0, -- [3]
							0.3, -- [4]
						},
						["iconcountcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["debufftypecolor"] = true,
						["width"] = 250,
						["textBLfont"] = "Friz Quadrata TT",
						["textBLfontsize"] = 14,
						["iconcountfontsize"] = 14,
						["barright"] = false,
						["textTRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["padding"] = 1,
						["textBLalign"] = "LEFT",
						["height"] = 20,
					},
					["stickside"] = "",
					["sorting"] = "timeleft",
				}, -- [2]
				{
					["anchorshown"] = false,
					["id"] = 3,
					["barspacing"] = 0,
					["alpha"] = 1,
					["stickto"] = 2,
					["anchortext"] = "TENCH",
					["scale"] = 1,
					["growup"] = false,
					["filter"] = {
						["type"] = {
							["TENCH"] = true,
						},
					},
					["target"] = "player",
					["bars"] = {
						["textBR"] = false,
						["textTRfont"] = "Friz Quadrata TT",
						["tooltipanchor"] = "default",
						["textBRfontsize"] = 14,
						["icon"] = "LEFT",
						["abbreviate_name"] = 0,
						["bgbar"] = true,
						["iconcount"] = true,
						["textTLalign"] = "LEFT",
						["textBLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTR"] = "TIMELEFT",
						["bar"] = true,
						["textBL"] = false,
						["textBRfont"] = "Friz Quadrata TT",
						["textTL"] = "NAMERANKCOUNT",
						["textTLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTLfont"] = "Friz Quadrata TT",
						["iconcountfont"] = "Arial Narrow",
						["timeformat"] = "CONDENSED",
						["textTRfontsize"] = 14,
						["iconcountanchor"] = "CENTER",
						["timelessfull"] = false,
						["textBRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
						},
						["barcolor"] = {
							0.5, -- [1]
							0, -- [2]
							0.5, -- [3]
							0.8, -- [4]
						},
						["spark"] = false,
						["textTLfontsize"] = 14,
						["bartexture"] = "Otravi",
						["barbgcolor"] = {
							0.5, -- [1]
							0, -- [2]
							0.5, -- [3]
							0.3, -- [4]
						},
						["iconcountcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["debufftypecolor"] = true,
						["width"] = 250,
						["textBLfont"] = "Friz Quadrata TT",
						["textBLfontsize"] = 14,
						["iconcountfontsize"] = 14,
						["barright"] = false,
						["textTRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["padding"] = 1,
						["textBLalign"] = "LEFT",
						["height"] = 20,
					},
					["stickside"] = "",
					["sorting"] = "timeleft",
				}, -- [3]
			},
		},
		["zwe"] = {
			["detachedTooltip"] = {
				["fontSizePercent"] = 1,
			},
			["hidden"] = true,
			["bargroups"] = {
				{
					["sorting"] = "timeleft",
					["scale"] = 1,
					["barspacing"] = 5,
					["alpha"] = 1,
					["id"] = 1,
					["anchortext"] = "BUFFS",
					["x"] = 1632.679123171766,
					["y"] = 986.3506628323747,
					["filter"] = {
						["type"] = {
							["BUFF"] = true,
						},
					},
					["target"] = "player",
					["bars"] = {
						["textBR"] = false,
						["textTRfont"] = "Friz Quadrata TT",
						["tooltipanchor"] = "default",
						["textBRfontsize"] = 14,
						["icon"] = "RIGHT",
						["abbreviate_name"] = 0,
						["bgbar"] = false,
						["iconcount"] = true,
						["textTLalign"] = "right",
						["textBLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTR"] = false,
						["bar"] = false,
						["textBL"] = false,
						["textBRfont"] = "Friz Quadrata TT",
						["textTL"] = "TIMELEFT",
						["barcolor"] = {
							0.3, -- [1]
							0.5, -- [2]
							1, -- [3]
							0.8, -- [4]
						},
						["textTLfont"] = "Friz Quadrata TT",
						["iconcountfont"] = "Arial Narrow",
						["height"] = 20,
						["barbgcolor"] = {
							0, -- [1]
							0.5, -- [2]
							1, -- [3]
							0.3, -- [4]
						},
						["iconcountanchor"] = "CENTER",
						["timelessfull"] = false,
						["textBRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
						},
						["spark"] = false,
						["barright"] = false,
						["textTRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["bartexture"] = "Otravi",
						["iconcountfontsize"] = 14,
						["iconcountcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textBLfont"] = "Friz Quadrata TT",
						["width"] = 250,
						["debufftypecolor"] = true,
						["textBLfontsize"] = 14,
						["textTLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTLfontsize"] = 14,
						["textTRfontsize"] = 14,
						["padding"] = 1,
						["textBLalign"] = "left",
						["timeformat"] = "CONDENSED",
					},
					["growup"] = false,
					["anchorshown"] = false,
				}, -- [1]
				{
					["sorting"] = "timeleft",
					["scale"] = 1,
					["id"] = 2,
					["barspacing"] = 5,
					["alpha"] = 1,
					["y"] = 985.7573682697841,
					["anchortext"] = "DEBUFFS",
					["x"] = 1535.90538812295,
					["growup"] = false,
					["filter"] = {
						["type"] = {
							["DEBUFF"] = true,
						},
					},
					["target"] = "player",
					["bars"] = {
						["textBR"] = false,
						["textTRfont"] = "Friz Quadrata TT",
						["tooltipanchor"] = "default",
						["textBRfontsize"] = 14,
						["icon"] = "LEFT",
						["abbreviate_name"] = 0,
						["bgbar"] = true,
						["iconcount"] = true,
						["textTLalign"] = "LEFT",
						["textBLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTR"] = "TIMELEFT",
						["bar"] = true,
						["textBL"] = false,
						["textBRfont"] = "Friz Quadrata TT",
						["textTL"] = "NAMERANKCOUNT",
						["barcolor"] = {
							1, -- [1]
							0, -- [2]
							0, -- [3]
							0.8, -- [4]
						},
						["textTLfont"] = "Friz Quadrata TT",
						["iconcountfont"] = "Arial Narrow",
						["height"] = 20,
						["barbgcolor"] = {
							1, -- [1]
							0, -- [2]
							0, -- [3]
							0.3, -- [4]
						},
						["iconcountanchor"] = "CENTER",
						["timelessfull"] = false,
						["textBRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
						},
						["spark"] = false,
						["barright"] = false,
						["textTRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["bartexture"] = "Otravi",
						["iconcountfontsize"] = 14,
						["iconcountcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textBLfont"] = "Friz Quadrata TT",
						["width"] = 250,
						["debufftypecolor"] = true,
						["textBLfontsize"] = 14,
						["textTLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTLfontsize"] = 14,
						["textTRfontsize"] = 14,
						["padding"] = 1,
						["textBLalign"] = "LEFT",
						["timeformat"] = "CONDENSED",
					},
					["stickside"] = "",
					["anchorshown"] = false,
				}, -- [2]
				{
					["sorting"] = "timeleft",
					["id"] = 3,
					["barspacing"] = 0,
					["alpha"] = 1,
					["stickto"] = 2,
					["anchortext"] = "TENCH",
					["scale"] = 1,
					["growup"] = false,
					["filter"] = {
						["type"] = {
							["TENCH"] = true,
						},
					},
					["target"] = "player",
					["bars"] = {
						["textBR"] = false,
						["textTRfont"] = "Friz Quadrata TT",
						["tooltipanchor"] = "default",
						["textBRfontsize"] = 14,
						["icon"] = "LEFT",
						["abbreviate_name"] = 0,
						["bgbar"] = true,
						["iconcount"] = true,
						["textTLalign"] = "LEFT",
						["textBLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTR"] = "TIMELEFT",
						["bar"] = true,
						["textBL"] = false,
						["textBRfont"] = "Friz Quadrata TT",
						["textTL"] = "NAMERANKCOUNT",
						["barcolor"] = {
							0.5, -- [1]
							0, -- [2]
							0.5, -- [3]
							0.8, -- [4]
						},
						["textTLfont"] = "Friz Quadrata TT",
						["iconcountfont"] = "Arial Narrow",
						["height"] = 20,
						["barbgcolor"] = {
							0.5, -- [1]
							0, -- [2]
							0.5, -- [3]
							0.3, -- [4]
						},
						["iconcountanchor"] = "CENTER",
						["timelessfull"] = false,
						["textBRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
						},
						["spark"] = false,
						["barright"] = false,
						["textTRcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["bartexture"] = "Otravi",
						["iconcountfontsize"] = 14,
						["iconcountcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textBLfont"] = "Friz Quadrata TT",
						["width"] = 250,
						["debufftypecolor"] = true,
						["textBLfontsize"] = 14,
						["textTLcolor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["textTLfontsize"] = 14,
						["textTRfontsize"] = 14,
						["padding"] = 1,
						["textBLalign"] = "LEFT",
						["timeformat"] = "CONDENSED",
					},
					["stickside"] = "",
					["anchorshown"] = false,
				}, -- [3]
			},
		},
	},
}
