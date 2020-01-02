mi.Weapons = mi.Weapons or {
	Count = 0
}

function mi:WepFromID(str)
	if (not str or tostring(str) == "nil") then
		print("WepFromID:", str)
		debug.Trace()

		return nil
	end

	return mi.Weapons[str].Class, mi.Weapons[str].Name
end

function mi:WepToID(str)
	if (not str or tostring(str) == "nil") then
		print("WepToID:", str)
		debug.Trace()

		return nil
	end

	return mi.Weapons[str].ID, mi.Weapons[str].Name
end

mi.Weapons.Register = function(id, class, name)
	assert(id and class and mi.Weapons[id] == nil and mi.Weapons[class] == nil, 
		"Failed on mi.Weapons.Add call attempt!\n	id: " .. tostring(id) .. "\n	class: " .. tostring(class))

	mi.Weapons[class] = {
		Class = class, 
		Name = name, 
		ID = id
	}

	mi.Weapons[id] = mi.Weapons[class]
	mi.Weapons.Count = mi.Weapons.Count + 1

	return true
end