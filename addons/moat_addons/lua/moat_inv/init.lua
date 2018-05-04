MOAT_INV = MOAT_INV or {
	Config = {},
	Version = "2.0"
}

MOAT_INV.IncludeSV = (SERVER) and include or function() end
MOAT_INV.IncludeCL = (SERVER) and AddCSLuaFile or include
MOAT_INV.IncludeSH = function(path) MOAT_INV.IncludeSV(path) MOAT_INV.IncludeCL(path) end
MOAT_INV.ModulePath = "moat_inv/modules/"
MOAT_INV.ModulePrefixes = {
	["sv"] = MOAT_INV.IncludeSV,
	["cl"] = MOAT_INV.IncludeCL,
	["sh"] = MOAT_INV.IncludeSH,
	["sq"] = function() end
}

function MOAT_INV:InitializeModule(folder, num)
	if (not folder) then return end
	local files, folders = file.Find(self.ModulePath .. folder .. "/*", "LUA")

	for _, v in SortedPairs(files) do
		if (v:GetExtensionFromFilename() ~= "lua") then continue end
		local pref = v:sub(1, 2)

		if (self.ModulePrefixes[pref]) then
			self.ModulePrefixes[pref](self.ModulePath .. folder .. "/" .. v)
			self.Log(string.rep(" | ", num) .. v)
		else
			self.Log("Unable to load module files in folder: " .. folder, true)
			self.Log("Files must start with realm prefix.", true)
		end
	end

	num = num + 1

	for _, v in SortedPairs(folders) do
		self.Log(string.rep(" | ", num - 1) .. v)
		self:InitializeModule(folder .. "/" .. v, num)
	end
end

function MOAT_INV:InitializeModules()
	self.IncludeSH(self.ModulePath .. "sh_util.lua")
	self:BigLog "------Welcome to Moat Gaming------"
	self:BigLog "---------Loading Modules----------"
	local _, folders = file.Find(self.ModulePath .. "*", "LUA")
	for _, fldr in SortedPairs(folders) do
		self.Log(fldr)
		self:InitializeModule(fldr, 1)
	end
	self:BigLog "-----Finished Loading Modules-----"
end
MOAT_INV:InitializeModules()