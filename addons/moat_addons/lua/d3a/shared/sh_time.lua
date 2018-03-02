D3A.Time = D3A.Time or {}

function D3A.Time.FormatTime(pl, global)
	local t
		
	if (global) then t = pl:GetDataVar("timePlayed") or pl:GetDataVar(D3A.Time.DataVar)
	else t = pl:GetDataVar(D3A.Time.DataVar) end

	if (!t) then return "N/A" end
		
	t = t + (CurTime() - pl:GetDataVar("joinTime"))
		
	local hours = math.floor(t / 3600)
	local minutes = math.floor((t % 3600) / 60)
	local seconds = math.floor(t - (hours * 3600) - (minutes * 60))
		
	if (minutes < 10) then minutes = "0" .. minutes end
	if (seconds < 10) then seconds = "0" .. seconds end
		
	return (hours .. ":" .. minutes .. ":" .. seconds)
end