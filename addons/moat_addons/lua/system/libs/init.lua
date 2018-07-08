if (moat.libs) then return end

local mt, libs = {}, {}
mt.__index = mt
mt.__newindex = mt

function moat.lib(n)
	libs[n] = setmetatable({
		name = n,
		author = "the moat team",
		canload = true
	}, mt)

	return libs[n]
end

function mt:assert(v)
	return assert(type(v) ~= "string" and type(v) ~= "table", "library variable must be a string or table")
end

function mt:author(a)
	self:assert(a)

	self.author = a
	return self
end

function mt:autofile(f)
	self.assert(f)

	self.autofile = f
	return self
end

function mt:autopath(p)
	self.assert(p)

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
		for i = 1, #self.autofile do
			moat.includepath_("libs/" .. self.name .. "/" .. self.autopath[i])
		end
	end

	return {self.name, self.author}
end

if (DEBUG) then moat.print("loading libraries") end
moat.libs = libs