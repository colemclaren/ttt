local debug_info = debug.getinfo
local hook_Add = hook.Add
local hook_Remove = hook.Remove
local invalid = {
	["string"] = true,
	["function"] = true,
	["number"] = true
}

function IsValid(var)
	if (not var or invalid[type(var)]) then
		return false
	end

	local isvalid = var.IsValid
	if (not isvalid) then
		return false
	end

	return isvalid(var)
end

function EntIndex(ent)
	return IsValid(ent) and ent:EntIndex() or 0
end

local EntityHook = function(event, id, func, classes)
	return hook_Add(event, id, function(ent)
		if (classes[ent:GetClass()]) then
			func(ent, ent:GetClass())
		end
	end)
end

local function HookEvent(event, Add, Remove, Classes, Callback)
	assert((Classes and istable(Classes)) and (Callback and isfunction(Callback)), "ent hooking failed")

	local id, ev, cl, cb, add, rem = debug_info(Callback).short_src, 
	event and "OnEntityCreated" or "EntityRemoved",
	Classes, Callback,
	Add or false,
	Remove or false


	if (add) then
		hook_Add(add, id, function()
			EntityHook(ev, id, cb, cl)
		end)
	else
		EntityHook(ev, id, cb, cl)
	end

	if (rem) then
		hook_Add(rem, id, function()
			hook_Remove(ev, id)
			hook_Remove(add, id)
		end)
	end
end

function ents.Removed(Classes, Add, Remove, Callback)
	return HookEvent("EntityRemoved", Add or false, Remove or false, Classes, Callback)
end

function ents.Created(Classes, Add, Remove, Callback)
	return HookEvent("OnEntityCreated", Add or false, Remove or false, Classes, Callback)
end