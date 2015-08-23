local L = LibStub("AceLocale-3.0"):NewLocale("Broker_Group","deDE")
if not L then return end

L["Minimalistic LDB plugin to track down rolls and perform basic loot functions."] = "Minimalistisches LDB plugin zum verfolgen vom Würfen und zum Ausführen von Plünderfunktionen"
L["Solo"] = "Alleine"
L["group"] = "Plündern als Gruppe"
L["master"] = "Plündermeister"
L["freeforall"] = "Jeder gegen Jeden"
L["roundrobin"] = "Reihum"
L["needbeforegreed"] = "Bedarf vor Gier"
L["ML (%s)"] = "PM (%s)"
L["No rolls"] = "Keine Würfe"

L["Roll ending in 5 seconds, recorded %d of %d rolls."] = "Würfeln endet in 5 Sekunden, %d von %d Würfen aufgezeichnet."

L["Winner: %s."] = "Gewinner: %s."
L[", "] = ", "
L["Tie: %s are tied at %d."] = "Gleichstand: %s sind gleich mit %d)"
L["%s (%d/%d)"] = "%s (%d/%d)"
L["%s [%s]"] = "%s [%s]"
L["%d of expected %d rolls recorded."] = "%d von %d erwarteten Würfen aufgezeichnet."

L["Perform roll when clicked"] = "Würfeln wenn gedrückt"
L["Perform a standard 1-100 roll when the plugin is clicked."] = "Führe einen standard 1-100 Wurf aus, wenn das plugin gedrückt wird."
L["Announce"] = "Ansagen"
L["Only accept 1-100"] = "Nur 1-100 akzeptieren"
L["Accept standard (1-100) rolls only."] = "Nur standard Würfe (1-100) akzeptieren."
L["Set the loot type."] = "Setze das Plündern."
L["Loot threshold"] = "Seltenheitsschwelle"
L["Set the loot threshold."] = "Setze die Seltenheitsschwelle."

L["Where to output roll results."] = "Wo soll das Ergebis angesagt werden."
L["Auto (based on group)"] = "Automatisch (basierend auf Gruppe)"
L["Local"] = "Lokal"
L["Say"] = "Sagen"
L["Party"] = "Gruppe"
L["Raid"] = "Schlachtzug"
L["Guild"] = "Gilde"
L["Don't announce"] = "Nicht ansagen"

L["Roll clearing"] = "Würfe löschen"
L["When to clear the rolls."] = "Wann sollen die Würfe gelöscht werden."
L["Never"] = "Nie"
L["10 seconds"] = "Nach 10 Sekunden"
L["15 seconds"] = "Nach 15 Sekunden"
L["30 seconds"] = "Nach 30 Sekunden"
L["45 seconds"] = "Nach 45 Sekunden"
L["60 seconds"] = "Nach 60 Sekunden"

L["Roll"] = "Würfeln"
L["Player"] = "Spieler"
L["Loot method"] = "Plündern"
L["Master looter"] = "Plündermeister"
L["Leader"] = "Führer"
L["Officers"] = "Offiziere"
L["|cffeda55fClick|r to roll, |cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "|cffeda55fDrücken|r zum Würfeln, |cffeda55fCtrl-Drücken|r zum Ansagen des Gewinners, |cffeda55fShift-Click|r zum Löschen der Würfe."
L["|cffeda55fCtrl-Click|r to output winner, |cffeda55fShift-Click|r to clear the list."] = "|cffeda55fCtrl-Drücken|r zum Ansagen des Gewinners, |cffeda55fShift-Drücken|r zum Löschen der Würfe."

L["Pass"] = "Passen"
L["Everyone passed."] = "Jeder passt."
	
L["Leave Party"] = "Gruppe verlassen"
L["Leave your current party or raid."] = "Verlasse deine aktuelle Gruppe oder Schlachtzug."
	
L["Reset Instances"] = "Instanzen zurücksetzen"
L["Reset all available instance the group leader has active."] = "Alle aktiven Instanzen des Gruppenführers zurücksetzen."

L["Dungeon Difficulty"] = "Schwierigkeitsgrad"
L["Set the dungeon difficulty for instances."] = "Setze dem Schwierigkeitsgrad für Instanzen."
L["Pass on random loot"] = "Passe auf Beute"
L["Enable this setting to auto-pass on random loot."] = "Aktiviert das automatische Passen auf Beute."

-- Translation needed
--L["Raid Difficulty"] = true
--L["Set the raid difficulty for instances."] = true
--L["Show instance difficulty"] = true
--L["Toggles instance difficulty display on the button/block."] = true
--L["Difficulty type"] = true
--L["Set the difficulty type text shown on the button/block. 'Auto' means the difficulty will only be shown if you are grouped and will reflect your group type."] = true
--L["Show loot method"] = true
--L["Toggles loot method display on the button/block."] = true

--L["5 N"] = true
--L["5 H"] = true
--L["10 N"] = true
--L["25 N"] = true
--L["10 H"] = true
--L["25 H"] = true
--L["Short text for instance difficulty"] = true
--L["Trims the instance difficulty text label. For example 25 player Heroic difficulty will display as '25 H'."] = true