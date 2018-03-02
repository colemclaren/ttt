function ENT:InitAftermath()
	self.m_tbDialogue = {}
end

function ENT:AddDialogue(ID,text,fc,parent)
	local data = {
		text = text,
		call = fc,
		parent = parent,
		children = {}
	}
	self.m_tbDialogue[ID] = data
	if(parent) then
		table.insert(self.m_tbDialogue[parent],ID)
	end
end

function ENT:RemoveDialogue(ID)
	local data = self.m_tbDialogue[ID]
	if(data.parent) then
		local p = self.m_tbDialogue[data.parent]
		if(p) then
			for _,c in ipairs(p.children) do
				if(c == ID) then
					table.remove(p.children,_)
					break
				end
			end
		end
	end
	self.m_tbDialogue[ID] = nil
end

function ENT:GetDialogue() return self.m_tbDialogue end

function ENT:ShowDialogue(parent)
	local dl = self:GetDialogue()
	dialogue.Start()
		for ID,data in pairs(dl) do
			if(data.parent == parent) then
				dialogue.AddOption(data.text,function()
					if(data.call) then pcall(data.call) end
					if(data.children) then self:ShowDialogue(ID)
					else dialogue.Close() end
				end)
			end
		end
	dialogue.Open()
end