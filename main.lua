local drillSergeantAddOn = {
	timer=0,
	frequency=30,
	enabled=false,
	roleLines={
		["DAMAGER"]={
			"It's impressive how bad your DPS is with that gear.",
			"You're definitely not gonna rank with DPS like that.",
			"If you don't pick up the DPS, the tanks are going to beat you.",
			"Pick it up!",
			"Do you enjoy getting carried?",
		},
		["HEALER"]={
			"You call that healing?!",
			"If you're not careful, both tanks might outheal you there.",
			"They're dying and it's all your fault!"
		},
		["TANK"]={
			"Do you think it'd be possible to take more unnecessary damage?",
			"Maybe try popping a cooldown?",
		},
		["NONE"]={
			"You're so bad at this you don't even have a role!",
			"Get a role, noob!",
		},
	dead={
			"You died? Again? What a surprise",
			"Dead again. Classic " .. name .. "",
			"How's the floor taste?",
			
			}
			}	
	}
};

local dsa = drillSergeantAddOn;

local function inspireTheTroops()
	if (dsa.enabled == true) then
		if (IsInRaid() == true) then
			local raidSize = GetNumGroupMembers();
			local i = math.random(raidSize);
			local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(i);
			if (isDead == false) then
				local playerSpecRole = UnitGroupRolesAssigned(name);
				local j = table.getn(dsa["roleLines"][playerSpecRole]);
				local phrase = dsa["roleLines"][playerSpecRole][math.random(1, j)];
			else
				local d = table.getn(dsa["dead"])
				local phrase = dsa["dead"][math.random(1,d)];

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
local k = 1
SlashCmdList['DRILLSERGEANT'] = function(msg, editbox)
	for value in string.gmatch(msg, "%S+") do
		args [k] = value
		index = k + 1
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
	elseif (cmd == 'stop') then
		dsa.enabled = false
		print("Drill Sergeant Disabled")
	--elseif (cmd == 'frequency') then
		--if args[2] ~= nil then
			--dsa.frequency = math.floor(tonumber(args[2]))
		--else
			--print("frequency requires a numeric argument.")
		--end
	else
		print("/ds usage:")
		print("  start: start the drill sergeant")
		print("  stop: stop the drill sergeant")
		--print("  frequency [int]: adjust how often the drill sergeant inspires the troops")
	end
end
SLASH_DRILLSERGEANT1 = '/ds'
