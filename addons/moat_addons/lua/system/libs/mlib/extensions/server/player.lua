local PLAYER = FindMetaTable "Player"

function PLAYER:MoveKeysDown()
	return (self:KeyDown(IN_BACK) 
		or self:KeyDown(IN_DUCK) 
		or self:KeyDown(IN_FORWARD) 
		or self:KeyDown(IN_JUMP) 
		or self:KeyDown(IN_MOVELEFT) 
		or self:KeyDown(IN_MOVERIGHT) 
		or self:KeyDown(IN_RELOAD) 
		or self:KeyDown(IN_WALK) 
		or self:KeyDown(IN_USE))
end

function player.GetStaff()
	local pls, staff, cnt = player.GetAll(), {}, 0

	for _, pl in ipairs(pls) do
		if (pl.IsStaff) then
			cnt = cnt + 1
			staff[cnt] = v
		end
	end

	return staff, cnt > 0
end