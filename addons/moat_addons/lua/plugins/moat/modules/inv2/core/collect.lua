concommand.Add("_collect", function(name)
	for k, v in pairs(MOAT_COLLECT) do
		local str = string (
			"------------------------------------\n", 
			"--\n", 
			"-- ", k, "\n",
			"--\n",
			"------------------------------------\n\n")

		if (v.Crate) then
			str = string (str, v.Crate)
		end
		
		local rars = {}
		for r = 1, 10 do
			if (r == 9) then continue end

			for i = 1, #v do
				if (v[i].Rarity and v[i].Rarity == r) then
					rars[r] = true
					continue
				end
			end
		end


		for r = 1, 10 do
			if (r == 9 or not rars[r]) then continue end

			str = string (str,
				"\n\n------------------------------------\n", 
				"-- ", inv.Rarity(r).Name .. " Items", "\n",
				"------------------------------------\n\n")

			for i = 1, #v do
				if (v[i].Rarity and v[i].Rarity == r) then
					str = string (str, v[i].String)
				end
			end
		end
		file.Write("collect/" .. string.Replace(string.lower(k), " ", "_") .. ".txt", str)
	end
end)