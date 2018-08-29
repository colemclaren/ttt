moat.ranks = moat.ranks or {}

local mt = {}
mt.__index = mt
mt.__newindex = mt

function moat.ranks.add(group)
	if (not moat.ranks.list or not moat.ranks.count) then
		moat.ranks.list, moat.ranks.count = {}, 0
	end

	moat.ranks.count = moat.ranks.count + 1
	moat.ranks.list[moat.ranks.count] = setmetatable({
		g = group,
		n = group,
		w = 0,
		f = "",
		c = Color(255, 255, 255),
		v = false, s = false, m = false, d = false
	}, mt)

	return moat.ranks.list[moat.ranks.count]
end

function mt:group(str) self.g = str return self end
function mt:name(str) self.n = str return self end
function mt:weight(n) self.w = n return self end
function mt:flags(str) self.f = str return self end
function mt:color(clr) self.c = clr return self end
function mt:vip(bool) self.v = bool return self end
function mt:staff(bool) self.s = bool return self:vip(bool) end
function mt:management(bool) self.m = bool return self:staff(bool) end
function mt:dev(bool) self.d = bool return self:management(bool) end