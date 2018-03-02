hook.Add("ShouldCollide", "HLR_ShouldCollide", function(entA, entB)
	if(entA:CanCollide(entB) == false) then return false end
end)
