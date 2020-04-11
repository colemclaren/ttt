--[[---------------------------------------------------------
	Name: HasValue
	Desc: Returns whether the value is in given table
-----------------------------------------------------------]]
function table.HasValue( t, val )
	if (not t) then return false end

	for k, v in pairs( t ) do
		if ( v == val ) then return true end
	end
	return false
end
