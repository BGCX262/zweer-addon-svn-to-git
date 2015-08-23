local f = CreateFrame("Frame")

local spellIdPlague = 70338
local damagePerStack = 50000

local unitDamaged = "%s was damaged by a %d stack of %s."
local unitKilled = "%s was killed by a %d stack of %s!"

f:SetScript("OnEvent", function(self, _, _, event, _, _, _, _, unit, _, spellId, spellName, _, amount, overkill)
	if event == "SPELL_PERIODIC_DAMAGE" and spellId == spellIdPlague then
		local stacks = amount / damagePerStack
		if overkill > 0.0 then
			SendChatMessage(unitKilled:format(unit, stacks, spellName), "RAID", nil, nil)
		else
			SendChatMessage(unitDamaged:format(unit, stacks, spellName), "RAID", nil, nil)
		end
	end
end)

f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:Hide()
