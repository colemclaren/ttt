mlogs.aslay = mlogs.aslay or {}

function mlogs.getSlay(id)
	local info = mlogs.GetPlayer(id)
	if (info and info.slays and info.slays[1]) then
		return false, info.slays[1]
	end

	return true
end

function mlogs.removeSlay(id)
	table.remove(mlogs.GetPlayer(id).slays, 1)
end

function mlogs.slay(pl, id, slay)
	if (not IsValid(pl)) then return end
	pl:Kill()

	local msg = {
		mlogs.Colors.moat_cyan, pl:Nick(), 
		mlogs.Colors.moat_white, " has been autoslain by ", 
		mlogs.Colors.moat_cyan, mlogs.FormatNameID(slay.staff_name, slay.staff_steamid), 
		mlogs.Colors.moat_white, mlogs.FormatTimeNow(slay.slay_date) .. " ago with the reason: ",
		mlogs.Colors.moat_green, slay.reason,
		mlogs.Colors.moat_white, "."
	}

	info.served = info.served + 1
	mlogs.addq("UPDATE {database}.mlogs_autoslays SET served = served + 1 WHERE slay_id = ?;", slay.slay_id)
	if (info.served >= info.amount) then
		mlogs.removeSlay(pl:Steam())
	else
		local amt = info.amount - info.served
		table.insert(msg, mlogs.Colors.moat_pink)
		table.insert(msg, " (" .. amt .. " Left)")
	end

	mlogs.chat.broadcast(unpack(msg))
end

function mlogs.aslay(pl)
	if (not IsValid(pl)) then return end
	if (mlogs.DontSlay()) then return end

	local good, slay = mlogs.getSlay(pl:Steam())
	if (good or not slay.slay_id) then return end
	mlogs.slay(pl, pl:Steam(), slay)
end
mlogs:hook("mlogs.ply.begin", mlogs.aslay)