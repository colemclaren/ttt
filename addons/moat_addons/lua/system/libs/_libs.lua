if (DEBUG) then moat.print("loading libraries") end

moat.libs = moat.libs or {}
local mt = {}
mt.__index = mt
mt.__newindex = mt

function moat.lib(n)
	moat.libs[n] = setmetatable({
		name = n,
		author = "the moat team",
		canload = true
	}, mt)

	return moat.libs[n]
end

function mt:setauthor(a)
	self.author = a
	return self
end

function mt:setautofile(f)
	self.autofile = f
	return self
end

function mt:setautopath(p)
	self.autopath = p
	return self
end

function mt:setup()
	if (not self.autofile and not self.autopath) then return end
	if (not self.canload) then return end

	if (type(self.autofile) == "string") then
		moat.include_("libs/" .. self.name .. "/" .. self.autofile)
	elseif (type(self.autofile) == "table") then
		for i = 1, #self.autofile do
			moat.include_("libs/" .. self.name .. "/" .. self.autofile[i])
		end
	end

	if (type(self.autopath) == "string") then
		moat.includepath_("libs/" .. self.name .. "/" .. self.autopath)
	elseif (type(self.autopath) == "table") then
		for i = 1, #self.autopath do
			moat.includepath_("libs/" .. self.name .. "/" .. self.autopath[i])
		end
	end

	return {self.name, self.author}
end

function moat.includelib(str)
	moat.includesh("system/libs/" .. str .. "/lib.lua")
end