local drillSergeantAddOn = {
	timer=0,
	enabled=false,
	roleLines={
		["DAMAGER"]={
			"It's impressive how bad your DPS is with that gear.",
			"LOLOLOL",
		},
		["HEALER"]={
			"You call that healing?",
			"If you're not careful, both tanks might outheal you there."
		},
		["TANK"]={
			"Do you think it'd be possible to take more unnecessary damage?",
			"Maybe try popping a cooldown?",
		},
		["NONE"]={
			"You're so bad at this you don't even have a role!",
		},
	}
};

local dsa = drillSergeantAddOn;

local function inspireTheTroops()
	if (dsa.enabled == true) then
		if (IsInRaid() == true) then
			local raidSize = GetNumGroupMembers();
			local i = math.random(raidSize);
			local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(i);
			local playerSpecRole = UnitGroupRolesAssigned(name);
			local j = table.getn(dsa["roleLines"][playerSpecRole]);
			local phrase = dsa["roleLines"][playerSpecRole][math.random(1, j)];

			SendChatMessage("Hey there, " .. name .. "! " .. phrase, "RAID");
		else
			SendChatMessage("not in a raid");
		end
	end
end

local function onUpdate(self, elapsed)
	dsa.timer = dsa.timer - elapsed
	if dsa.timer <= 0 then
		inspireTheTroops()
		dsa.timer = 30
	end
end

local f = CreateFrame("frame");
f:SetScript("OnUpdate", onUpdate);

SLASH DRILLSERGEANT = '/ds';
local function cmd_handler(msg, editbox)
	if msg == 'start' then
		dsa.enabled = true
		dsa.timer = 0
	else if msg == 'stop' then
		dsa.enabled = false
	else
		SendChatMessage("Invalid command, dummy.")
	end
end
SlashCmdList["DRILLSERGEANT"] = cmd_handler;
