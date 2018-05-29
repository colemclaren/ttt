function dlogs:AddColor(id, def)
	if (not self.colors) then self.colors = {} end
	self.colors[id] = self.colors[id] or {Custom = def}
	self.colors[id].Default = def
end

function dlogs:GetColor(n)
	return self.colors[n] and self.colors[n].Custom or (self.colors[n] and self.colors[n].Default or Color(0, 0, 0))
end

function dlogs:SaveColors()
	file.Write(self.Folder .. "/colors.txt", util.TableToJSON(self.colors))
end

function dlogs:GetColors()
	return file.Read(self.Folder .. "/colors.txt")
end

dlogs.colors = dlogs:GetColors() and util.TableToJSON(dlogs:GetColors()) or {}