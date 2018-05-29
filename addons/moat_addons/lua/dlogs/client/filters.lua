DAMAGELOG_FILTER_BOOL = 0
DAMAGELOG_FILTER_PLAYER = 1

function dlogs:AddFilter(n, t, d)
	self.filters[n] = t
	if (self.filter_settings[n] == nil) then self.filter_settings[n] = d end
end

function dlogs:SaveFilters()
	file.Write(self.Folder .. "/filters.txt", util.TableToJSON(self.filter_settings))
end

function dlogs:GetFilters()
	return file.Read(self.Folder .. "/filters.txt")
end

dlogs.filters = dlogs.filters or {}
dlogs.filter_settings = dlogs:GetFilters() and util.TableToJSON(dlogs:GetFilters()) or {}