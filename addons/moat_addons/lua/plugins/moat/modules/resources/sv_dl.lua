if (file.Exists("terrorcity.txt", "MOD")) then
	local ids = {
		"1993862543",
		"1993869386"

		-- "1542685010",
		-- "1542687639",
		-- "1542690513",
		-- "1542693501"
	}

	for i = 1, #ids do
		resource.AddWorkshop(ids[i])
	end
end