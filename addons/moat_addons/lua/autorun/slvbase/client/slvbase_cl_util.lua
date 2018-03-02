local numFCCall = 0
function util.CallOnEntityValid(fcCall,index,timeOut,fcTimeOut)
	local ent = ents.GetByIndex(index)
	if IsValid(ent) then fcCall(ent); return end
	local i = numFCCall
	numFCCall = numFCCall +1
	timeOut = timeOut && CurTime() +timeOut || nil
	hook.Add("OnEntityCreated","waitForEntValid" .. i,function(ent)
		if timeOut && CurTime() >= timeOut then
			hook.Remove("OnEntityCreated","waitForEntValid" .. i)
			if fcTimeOut then fcTimeOut() end
		elseif ent:IsValid() && ent:EntIndex() == index then
			hook.Remove("OnEntityCreated","waitForEntValid" .. i)
			fcCall(ent)
		end
	end)
end