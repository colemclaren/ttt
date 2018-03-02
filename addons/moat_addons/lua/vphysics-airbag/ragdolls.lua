VA.Ragdolls = VA.Ragdolls or {}
VA.Ragdolls.Ragdolls = setmetatable ({}, { __mode = "k" })

function VA.Ragdolls.Initialize ()
	hook.Add ("OnEntityCreated", "VA.Ragdolls",
		function (ent)
			if ent:GetClass () ~= "prop_ragdoll" then return end
			
			VA.Ragdolls.Ragdolls [ent] = true
		end
	)

	hook.Add ("EntityRemoved", "VA.Ragdolls",
		function (ent)
			if ent:GetClass () ~= "prop_ragdoll" then return end
			
			VA.Ragdolls.Ragdolls [ent] = false
		end
	)
	
	for _, ent in ipairs (ents.FindByClass ("prop_ragdoll")) do
		VA.Ragdolls.Ragdolls [ent] = true
	end
end

function VA.Ragdolls.Uninitialize ()
	hook.Remove ("OnEntityCreated", "VA.Ragdolls")
	hook.Remove ("EntityRemoved",   "VA.Ragdolls")
	
	VA.Ragdolls.Ragdolls = setmetatable ({}, { __mode = "k" })
end

function VA.Ragdolls.GetEnumerator ()
	for ent, _ in pairs (VA.Ragdolls.Ragdolls) do
		if not ent:IsValid () then
			VA.Ragdolls.Ragdolls [ent] = nil
		end
	end
	
	return pairs (VA.Ragdolls.Ragdolls)
end
