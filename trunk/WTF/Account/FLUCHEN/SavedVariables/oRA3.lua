
oRA3DB = {
	["namespaces"] = {
		["Tanks"] = {
			["factionrealm"] = {
				["Alliance - Crushridge"] = {
					["persistentTanks"] = {
						"Dogbaire", -- [1]
						"Evilgab", -- [2]
						"Kimjo", -- [3]
						"Lifeisgood", -- [4]
						"Galhaad", -- [5]
						"Reon", -- [6]
						"Zodros", -- [7]
						"Drunken", -- [8]
						"Iwin", -- [9]
					},
				},
			},
		},
		["Loot"] = {
			["profiles"] = {
				["Default"] = {
					["enable"] = true,
					["raid"] = {
						["threshold"] = 3,
					},
				},
				["zwe"] = {
					["enable"] = true,
					["raid"] = {
						["threshold"] = 3,
					},
				},
			},
		},
		["Invite"] = {
		},
		["Cooldowns"] = {
			["profiles"] = {
				["Default"] = {
					["lockDisplay"] = true,
					["spells"] = {
						[12975] = true,
						[871] = true,
						[10060] = true,
						[48707] = true,
						[20484] = true,
						[55233] = true,
						[33206] = true,
						[29166] = true,
						[5384] = true,
						[64843] = true,
						[47788] = true,
						[32182] = true,
						[16190] = true,
					},
				},
				["zwe"] = {
					["spells"] = {
						[47788] = true,
						[64901] = true,
						[29166] = true,
						[64843] = true,
						[1022] = true,
						[31821] = true,
						[62618] = true,
						[16190] = true,
						[19236] = false,
						[61336] = true,
						[12975] = true,
						[33206] = true,
						[48707] = true,
						[642] = true,
						[724] = true,
						[5384] = true,
						[22842] = true,
						[22812] = true,
						[871] = true,
						[10060] = true,
						[32182] = true,
						[20484] = true,
						[45438] = true,
					},
					["lockDisplay"] = true,
				},
			},
		},
		["ReadyCheck"] = {
		},
		["Promote"] = {
			["factionrealm"] = {
				["Alliance - Crushridge"] = {
					["promotes"] = {
						"galhaad", -- [1]
						"kimjo", -- [2]
						"dogbaire", -- [3]
						"Dogbaire", -- [4]
						"Sophos", -- [5]
						"Galhaad", -- [6]
						"Drunken", -- [7]
						"Reon", -- [8]
						"Lifeisgood", -- [9]
						"Iwin", -- [10]
					},
					["promoteRank"] = {
						["ReLoad"] = {
							true, -- [1]
							true, -- [2]
							true, -- [3]
						},
					},
					["promoteAll"] = false,
				},
			},
		},
	},
	["profileKeys"] = {
		["Zuira - Crushridge"] = "zwe",
		["Zweèr - Crushridge"] = "zwe",
		["Lexma - Crushridge"] = "zwe",
		["Fluchen - Crushridge"] = "Default",
		["Zweer - Crushridge"] = "zwe",
	},
	["profiles"] = {
		["Default"] = {
			["lastSelectedPanel"] = "Tanks",
			["positions"] = {
				["oRA3ReadyCheck"] = {
					["Height"] = 241.0000048499159,
					["Width"] = 319.9999325229101,
					["PosY"] = 567.6221577464744,
					["PosX"] = 513.3258250162604,
				},
				["oRA3CooldownFrame"] = {
					["Height"] = 227.8947663855285,
					["Width"] = 174.118674629057,
					["PosY"] = 522.7972221074354,
					["PosX"] = 0.09712781828885833,
				},
			},
			["lastSelectedList"] = 1,
		},
		["zwe"] = {
			["lastSelectedList"] = 1,
			["positions"] = {
				["oRA3ReadyCheck"] = {
					["Height"] = 234.0000035144318,
					["PosX"] = 512.5944021782942,
					["PosY"] = 568.2728779878248,
					["Width"] = 319.9999325229101,
				},
				["oRA3CooldownFrame"] = {
					["Height"] = 148.0000115273362,
					["Width"] = 200.0000792855807,
					["PosY"] = 525.7226795387304,
					["PosX"] = -2.097170095587763,
				},
			},
			["lastSelectedPanel"] = "Promote",
		},
	},
}
