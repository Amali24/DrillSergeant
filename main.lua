drillSergeantAddOn = { };
local dsa = drillSergeantAddOn;
dsa.inRaid = IsInRaid(); -- Checks if in raid group
if (dsa.inRaid == true)then
	
	dsa.raidSize = GetNumGroupMembers();
	
	SendChatMessage("There are " .. dsa.raidSize .. " people in your raid." , "PARTY")
	dsa name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(1)
	SendChatMessage("and the first member is a " .. dsa.class .. " named " .. dsa.name .. "." , "PARTY")

else
	message("No");

end
