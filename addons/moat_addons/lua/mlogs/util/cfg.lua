mlogs.cfg.Groups = mlogs.cfg.Groups or {}
mlogs.cfg.StaffGroups = mlogs.cfg.StaffGroups or {}

function mlogs.cfg:AddGroup(group, active, staff)
	self.Groups[group] = active
	self.StaffGroups[group] = staff
end