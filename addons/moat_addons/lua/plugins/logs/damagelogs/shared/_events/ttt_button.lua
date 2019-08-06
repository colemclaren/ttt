

if SERVER then
	Damagelog:EventHook("TTTTraitorButtonActivated")
	Damagelog:EventHook("PlayerUse")
else
	Damagelog:AddFilter("Show buttons", DAMAGELOG_FILTER_BOOL, true)
	Damagelog:AddColor("Buttons", Color(220, 25, 220, 255))
end

local event = {}

event.Type = "BTN"

function event:TTTTraitorButtonActivated(ent, ply)
	self.CallEvent({
		[1] = (IsValid(ply) and ply:Nick() or "<Disconnected Retriever>"),
		[2] = (IsValid(ply) and ply:GetRole() or "disconnected"),
        [3] = (IsValid(ply) and ply:SteamID() or "<Disconnected Retriever>"),
        [4] = ent:GetPos(),
        [5] = " button"
	})
end

function event:PlayerUse(ply, ent)
    ent.LastUse = ent.LastUse or {}
    if (ent.LastUse[ply] and ent.LastUse[ply] > CurTime() - 1) then
        return
    end
    ent.LastUse[ply] = CurTime()
	self.CallEvent({
		[1] = (IsValid(ply) and ply:Nick() or "<Disconnected Retriever>"),
		[2] = "",
        [3] = (IsValid(ply) and ply:SteamID() or "<Disconnected Retriever>"),
        [4] = ent:GetPos(),
        [5] = ent:GetClass(),
	})
end

function event:ToString(v)
	return string.format("%s clicked a %s%s at %.0f %.0f %.0f", v[1], v[2] == "" and v[2] or Damagelog:StrRole(v[2]), v[5], v[4].x, v[4].y, v[4].z) 
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
