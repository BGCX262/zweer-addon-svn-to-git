local L = LibStub("AceLocale-3.0"):NewLocale("EnsidiaFails", "enUS", true)

--- Addon Description and Options ----
L["addon_desc"] = "EnsidiaFails is an addon that reports if a player in the raid fails to avoid an ability during a boss encoutner, that could have been avoided.\n"

L["filter"] = "Filter"
L["filter_desc"] = "Tick in the fails you want to track! If a fail doesn't have a tick next to its name, that fail won't be tracked or announced!"
L["general"] = "General"

L["Trade"] = "Trade"
L["LocalDefense"] = "LocalDefense"

L["sensitive"] = "sensitive"

L["How much damage taken needed for a fail from "] = "How much damage taken needed for a fail from "
L["How many stack is still not a fail"] = "How many stack is still not a fail"
L["How much healing taken is still not a fail"] = "How much healing taken is still not a fail"
L["How much time do you have for moving before adding a fail for "] = "How much time do you have for moving before adding a fail for "
L["How close combatlog events have to be, when determining who failed"] = "How close combatlog events have to be, when determining who failed"
L["At how many stacks are you supposed to stop dps"] = "At how many stacks are you supposed to stop dps"
L["Top X Stats"] = "Top X Stats"
L["Amount of entries to display"] = "Amount of entries to display"
L["Show all"] = "Show all"

L["noexceptions"] = "No exceptions"
L["noexceptions_desc"] = "No exceptions, every fail is a fail!"
L["Talent based Exception"] = "Talent based Exception"
L["Use talent scanning for determining tanks"] = "Use talent scanning for determining tanks"

L["reset on combat"] = "Reset on combat"
L["reset"] = "Reset"
L["reset_desc"] = "Reset the fail counter"
L["oreset"] = "Reset Overall"
L["oreset_desc"] = "Reset the overall fail counter"

L["announce"] = "Announce to"
L["announce_desc"] = "Set Announce output"
L["announce_style"] = "Announce style"
L["announce_style_desc"] = "When to report fails"
L["announce_after_style"] = "Announce after style"
L["announce_after_style_desc"] = "How should the fail report look after combat"
L["Disabled"] = "Disabled"
L["stats"] = "Stats"
L["stats_desc"] = "Report Stats"
L["ostats"] = "Overall Stats"
L["ostats_desc"] = "Report Overall Stats"

L["Say"] = "Say"
L["Party"] = "Party"
L["Raid"] = "Raid"
L["Guild"] = "Guild"
L["Officer"] = "Officer"
L["Channel"] = "Channel"
L["Self"] = "Self"

L["during"] = "During combat"
L["after"] = "After combat"
L["during_and_after"] = "During and after combat"

L["Group by player"] = "Group by player"
L["Group by fails"] = "Group by fails"

L["remove"] = "Remove a Fail"
L["remove_desc"] = "Remove a fail from the player"
L["Wrong name!"] = "Wrong name!"

L["Reset EnsidiaFails?"] = "Reset EnsidiaFails?"
L["Reset Data?"] = "Reset Data?"
L["Yes"] = "Yes"
L["No"] = "No"

L["Auto Delete New Instance"] = "Auto Delete New Instance"
L["Delete New Instance Only"] = "Delete New Instance Only"
L["Confirm Delete Instance"] = "Confirm Delete Instance"
L["Delete on Raid Join"] = "Delete on Raid Join"
L["Confirm Delete on Raid Join"] = "Confirm Delete on Raid Join"

L["Disable announce override"] = "Disable announce override"
L["Announcing Disabled! %s is the main announcer. (He/She has the same version as you (%s))"] = "Announcing Disabled! %s is the main announcer. (He/She has the same version as you (%s))"
L["Disallows accepting commands from other users that'd change the announcing settings"] = "Disallows accepting commands from other users that'd change the announcing settings"
L["Announcing Enabled! YOU are the main announcer for EnsidiaFails, please check your announcing settings"] = "Announcing Enabled! YOU are the main announcer for EnsidiaFails, please check your announcing settings"
L["Announcing Disabled! %s is the main announcer. (Please consider updating your addon his/her version was %s)(yours: %s)"] = "Announcing Disabled! %s is the main announcer. (Please consider updating your addon his/her version was %s)(yours: %s)"

---------------------------------------

--- Fail Reporting ---
L["susped"] = "Fail reporting suspended for 60 seconds."
L["resume"] = "Fail reporting resumed."
L["removed"] = "Removed a fail from "
L["fails_at"] = " has failed at "
L["reseted"] = "Fail counter reset."
L["oreseted"] = "Overall fail counter reset."

L["nobody_failed"] = "EnsidiaFails - Nobody failed!"

L["we_have"] = "EnsidiaFails - We have "
L["fails_on"] = " FAILS on "
L["diff..."] = " different players! Displaying the TOP10..."

L["admiral"] = "Admiral of the FAILFLEET is: "
L["captain"] = "Captain of the FAILBOAT is: "

L["failed"] = " failed "

L["didnt_fail"] = "Players who did not fail: "
---------------------------------------

--- Fail Sources ---
L["Proximity Mine"] = "Proximity Mine"
L["The Halls of Winter"] = "The Halls of Winter"
L["Frost Bomb"] = "Frost Bomb"
L["Snaplasher"] = "Snaplasher"
L["Marked Immortal Guardian"] = "Marked Immortal Guardian"
L["The Prison of Yogg-Saron"] = "The Prison of Yogg-Saron"
L["Deep Breath"] = "Deep Breath"

---------------------------------------

--- Fail messages ---
L["not moving"] = "not moving"
L["moving"] = "moving"
L["not spreading"] = "not spreading"
L["spreading"] = "spreading"
L["dispelling"] = "dispelling"
L["being at the wrong place"] = "being at the wrong place"
L["not_dispelling"] = "not dispelling"
L["casting"] = "casting"
L["not_casting"] = "not casting"
L["jumping"] = "jumping"
L["left and right"] = "left and right"
L["turning away"] = "turning away"

L["shaman_healing"] = "Shaman Healing"
---------------------------------------