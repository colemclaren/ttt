if file.Exists("damagelog/filters.txt", "DATA") then
	file.Delete("damagelog/filters.txt")
end

if file.Exists("damagelog/filters_new.txt", "DATA") and not dlogs.filter_settings then
	local settings = file.Read("damagelog/filters_new.txt", "DATA")
	if settings then
		dlogs.filter_settings = util.JSONToTable(settings)
	end
end

function dlogs:SaveFilters()
	local temp = table.Copy(self.filter_settings)
	file.Write("damagelog/filters_new.txt", util.TableToJSON(temp))
end

dlogs.filters = dlogs.filters or {}
dlogs.filter_settings = dlogs.filter_settings or {}

DAMAGELOG_FILTER_BOOL = 1
DAMAGELOG_FILTER_PLAYER = 2

function dlogs:AddFilter(name, filter_type, default_value)
	self.filters[name] = filter_type
	if self.filter_settings[name] == nil then
		self.filter_settings[name] = default_value
	end
end