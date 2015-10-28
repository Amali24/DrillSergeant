local drillSergeantAddOn = {
	timer=0,
	frequency=30,
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
			print("not in a raid");
		end
	end
end

local function onUpdate(self, elapsed)
	dsa.timer = dsa.timer - elapsed
	if dsa.timer <= 0 then
		inspireTheTroops()
		dsa.timer = dsa.frequency
	end
end

local f = CreateFrame("frame");
f:SetScript("OnUpdate", onUpdate);

local args = {}
local index = 1
SlashCmdList['DRILLSERGEANT'] = function(msg, editbox)
	for value in string.gmatch(msg, "%S+") do
		args [index] = value
		index = index + 1
		end
		cmd = args[1]
	if (cmd == 'start') then
		if (dsa.enabled == false) then
			dsa.enabled = true
			dsa.timer = 0
			print("Drill Sergeant Enabled")
		else
			print("Drill Sergeant Already Enabled, Dummy.")
		end
	elseif cmd == 'stop' then
		dsa.enabled = false
		print("Drill Sergeant Disabled")
	elseif cmd == 'frequency' then
		if args[2] ~= nil then
			dsa.frequency = math.floor(tonumber(args[1]))
		else
			print("frequency requires a numeric argument.")
		end
	else
		print("/ds usage:")
		print("  start: start the drill sergeant")
		print("  stop: stop the drill sergeant")
		print("  frequency [int]: adjust how often the drill sergeant inspires the troops")
	end
end
SLASH_DRILLSERGEANT1 = '/ds'
