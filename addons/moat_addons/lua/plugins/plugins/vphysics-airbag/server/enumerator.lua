VA.Enumerator = VA.Enumerator or {}

function VA.Enumerator.All (enumerator, predicate, ...)
	for item in enumerator do
		if not predicate (item, ...) then return false end
	end
	
	return true
end

function VA.Enumerator.Any (enumerator, predicate, ...)
	for item in enumerator do
		if predicate (item, ...) then return true end
	end
	
	return false
end

function VA.Enumerator.ForEach (enumerator, action, ...)
	for item in enumerator do
		action (item, ...)
	end
end
