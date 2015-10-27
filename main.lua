drillSergeantAddOn = {
	inRaid=false,
	roleLines={
		["damage"]={
			"It's impressive how bad your DPS is with that gear.",
		},
		["healing"]={
			"You call that healing?",
			"If you're not careful, both tanks might outheal you there."
		},
		["tanking"]={
			"Do you think it'd be possible to take more unnecessary damage?",
			"Maybe try popping a cooldown?",
		},
	}
};

local dsa = drillSergeantAddOn;

-- Checks if in raid group
dsa.inRaid = IsInRaid();

if (dsa.inRaid == true) then
	-- grab the number of members in the raid
	dsa.raidSize = GetNumGroupMembers();
	-- select a random player
	local index = math.random(dsa.raidSize)
	-- get information about that player
	-- role appears to only be MAINTANK or TANK...
	local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(index)

	-- using player name, we'll want to target the player
	-- get that player's specialization, and grab the global ID for the spec
	-- use GetSpecializationRoleByID(int) to figure out if it's tank/dps/hps
	NotifyInspect(name)
	local playerSpec = GetInspectSpecialization()
	local playerSpecRole = GetSpecializationRoleByID(playerSpec)

	SendChatMessage(playerSpecRole, "RAID")

	-- grab a phrase
	local j = table.getn(dsa["roleLines"][playerSpecRole])
	local phrase = dsa["roleLines"][playerSpecRole][math.random(0, j-1)]
		
	-- SendChatMessage("Hey there, " .. name .. "! " .. phrase, "RAID")
else
	message("Not in a raid. Sorry there, chief.");
end