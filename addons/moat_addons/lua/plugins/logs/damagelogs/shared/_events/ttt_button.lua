

if SERVER then
	Damagelog:EventHook("TTTTraitorButtonActivated")
else
	Damagelog:AddFilter("Show buttons", DAMAGELOG_FILTER_BOOL, true)
	Damagelog:AddColor("Buttons", Color(220, 25, 220, 255))
end

local event = {}

event.Type = "BUTTON"

function event:TTTTraitorButtonActivated(ent, ply)
	self.CallEvent({
		[1] = (IsValid(ply) and ply:Nick() or "<Disconnected Retriever>"),
		[2] = (IsValid(ply) and ply:GetRole() or "disconnected"),
		[3] = (IsValid(ply) and ply:SteamID() or "<Disconnected Retriever>"),
	})
end

function event:ToString(v)
	return string.format("%s clicked a %s button", v[1], Damagelog:StrRole(v[2])) 
end

function event:IsAllowed(tbl)
	return Damagelog.filter_settings["Show buttons"]
end

function event:Highlight(line, tbl, text)
	return table.HasValue(Damagelog.Highlighted, tbl[1])
end

function event:GetColor(tbl)
	return Damagelog:GetColor "Buttons"
end

function event:RightClick(line, tbl, text)
	line:ShowTooLong(true)
	line:ShowCopy(true, { tbl[1], tbl[3] })
end

Damagelog:AddEvent(event)
