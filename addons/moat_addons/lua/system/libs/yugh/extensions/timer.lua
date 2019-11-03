local Simple = timer.Simple
local Create = timer.Create
local Remove = timer.Remove
local Cooldowns = {}
local time = SysTime
local tm = timer
tm.Destroy = Remove

function tm.Loop(name, delay, func, cb)
	return Create(name, delay or 1, 0, function()
		if (func()) then
			timer.Remove(name)
	
			if (cb) then
				return cb()
			end
		end
	end)
end

function tm.Create(name, delay, reps, func)
	if (reps == 1) then
		return Simple(delay, func)
	end

	return Create(name, delay, reps, func)
end

function tm.Cooldown(...)
	local args = yugh.CheckArgs(...)
	local name, pl, delay = args:Build {isstring, IsValid, isnumber}

	name = name or "Global"
	pl = pl and (pl.SteamID64 and pl:SteamID64() or pl:EntIndex()) or 0
	delay = delay or 1

	Cooldowns[name] = Cooldowns[name] or {}
	Cooldowns[name][pl] = Cooldowns[name][pl] or 0

	if (Cooldowns[name][pl] >= time()) then
		return true
	end

	Cooldowns[name][pl] = time() + delay

	return false
end

function tm.Tick(func)
	return Simple(0, func)
end

function tm.Tiny(func)
	return Simple(0.1, func)
end

function tm.Quater(func)
	return Simple(0.25, func)
end

function tm.Half(func)
	return Simple(0.5, func)
end

function tm.Second(func)
	return Simple(1, func)
end

timer = setmetatable(tm, {
	__call = function(self, ...)
		return self.Simple(...)
	end
})