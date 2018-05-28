dlogs.events = dlogs.events or {}
dlogs.IncludedEvents = dlogs.IncludedEvents or {}
function dlogs:AddEvent(event, f)

	local id = #self.events + 1

	function event.CallEvent(tbl, force_time, force_index)
		if GetRoundState() != ROUND_ACTIVE then return end
		local time
		if force_time then
			time = tbl[force_time]
		else
			time = self.Time
		end
		local infos = {
			id = id,
			time = time,
			infos = tbl
		}
		if force_index then
			self.DamageTable[tbl[force_index]] = infos
		else
			table.insert(self.DamageTable, infos)
		end

		local recip = {}
		for k,v in pairs(player.GetHumans()) do
			if v:CanUsedlogs() then
				table.insert(recip, v)
			end
		end
		net.Start("dlogs.Refreshdlogs")
		net.WriteTable(infos)
		net.Send(recip)

	end

	self.events[id] = event
	table.insert(self.IncludedEvents, dlogs.CurrentFile)

end

if SERVER then

	dlogs.event_hooks = {}

	function dlogs:InitializeEventHooks()
		for _,name in pairs(self.event_hooks) do
			hook.Add(name, "dlogs_events_"..name, function(...)
				for k,v in pairs(self.events) do
					if v[name] then
						v[name](v, ...)
					end
				end
			end)
		end
	end

	function dlogs:EventHook(name)
		if not table.HasValue(self.event_hooks, name) then
			table.insert(self.event_hooks, name)
		end
	end

end

function dlogs:InfoFromID(tbl, id)
	return tbl[id] or { steamid64 = -1, role = -1, nick = "<unknown>" }
end

function dlogs:IsTeamkill(role1, role2)
	if role1 == role2 then
		return true
	elseif role1 == ROLE_DETECTIVE and role2 == ROLE_INNOCENT then
		return true
	elseif role1 == ROLE_INNOCENT and role2 == ROLE_DETECTIVE then
		return true
	end
	return false
end

local function includeEventFile(f)
	f = dlogs.Folder .. "/shared/events/"..f
	if SERVER then
		AddCSLuaFile(f)
	end
	include(f)
end

for k,v in pairs(file.Find(dlogs.Folder .. "/shared/events/*.lua", "LUA")) do
	if not table.HasValue(dlogs.IncludedEvents, v) then
		dlogs.CurrentFile = v
		includeEventFile(v)
	end
end
if CLIENT then
	dlogs:SaveColors()
	dlogs:SaveFilters()
else
	dlogs:InitializeEventHooks()
end
