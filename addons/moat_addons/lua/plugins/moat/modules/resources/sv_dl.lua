if (file.Exists("terrorcity.txt", "MOD")) then
	local ids = {
		"785934793",
		"847230994",
		"863940132",
		"863942563",
		"889902236",
		"938750501",
		"1186879315",
		"1239007209",
		"1343169881"
	}

	for i = 1, #ids do
		resource.AddWorkshop(ids[i])
	end
end