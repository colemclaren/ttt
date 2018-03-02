-- Generated from: gcad/lua/gcad/signalprocessing/digitalfilters/realiirfilter.lua
-- Original:       https://github.com/notcake/gcad/blob/master/lua/gcad/signalprocessing/digitalfilters/realiirfilter.lua
-- Timestamp:      2015-08-02 20:22:07
local self = {}
CAC.RealIIRFilter = CAC.MakeConstructor (self)

--  Y     b0 + b1 z^-1 + b2 z^-2 + b3 z^-3 + b4 z^-4 + ...
-- --- = --------------------------------------------------
--  X     a0 + a1 z^-1 + a2 z^-2 + a3 z^-3 + a4 z^-4 + ...

function CAC.RealIIRFilter.FromNumeratorAndDenominator (numerator, denominator)
	denominator = denominator or 1
	
	local iirFilter = CAC.RealIIRFilter ()
	iirFilter:SetNumerator (numerator)
	iirFilter:SetDenominator (denominator)
	return iirFilter
end

function self:ctor ()
	self.Numerator   = {}
	self.Denominator = {}
	
	self.Factory = nil
	self.FactoryCode = nil
	self.FactoryValid = false
end

function self:CreateCompiledFilter ()
	if not self.FactoryValid then
		self.FactoryValid = true
		
		local code = CAC.StringBuilder ()
		for i = 1, self:GetOrder () do
			code:Append ("local x" .. tostring (i) .. " = 0\n")
		end
		code:Append ("return function (x)\n")
		
		-- Constant
		local invA0 = 1 / self.Denominator [1]
		
		-- Compute the intermediate value
		code:Append ("\tx = x")
		for i = 2, #self.Denominator do
			code:Append (" - " .. tostring (self.Denominator [i] * invA0) .. " * x" .. tostring (i - 1))
		end
		code:Append ("\n")
		
		-- Compute the output
		code:Append ("\tlocal y = " .. tostring (self.Numerator [1] * invA0) .. " * x")
		for i = 2, #self.Numerator do
			code:Append (" + " .. tostring (self.Numerator [i] * invA0) .. " * x" .. tostring (i - 1))
		end
		code:Append ("\n")
		
		-- Process the unit delays
		for i = self:GetOrder (), 2, -1 do
			code:Append ("\tx" .. tostring (i) .. " = x" .. tostring (i - 1) .. "\n")
		end
		if self:GetOrder () > 0 then
			code:Append ("\tx1 = x\n")
		end
		
		-- Return the output
		code:Append ("\treturn y\n")
		
		code:Append ("end\n")
		
		self.FactoryCode = code:ToString ()
		
		-- MsgN (self.FactoryCode)
		
		local compiled = CompileString (self.FactoryCode, "CAC.RealIIRFilter", false)
		if isstring (compiled) then
			CAC.Error ("RealIIRFilter:CreateCompiledFilter : Failed to compile filter (" .. compiled .. ")")
			self.Factory = function ()
				return function (x)
					return x
				end
			end
		else
			self.Factory = compiled
		end
	end
	
	return self.Factory ()
end

function self:GetDenominator ()
	return self.Denominator
end

function self:GetNumerator ()
	return self.Numerator
end

function self:GetOrder()
	return math.max (#self.Numerator - 1, #self.Denominator - 1)
end

function self:SetDenominator (denominator, ...)
	if isnumber (denominator) then
		denominator = { denominator, ... }
	end
	
	self.Denominator = denominator
	self.FactoryCode = nil
	self.FactoryValid = false
	
	return self
end

function self:SetNumerator (numerator, ...)
	if isnumber (numerator) then
		numerator = { numerator, ... }
	end
	
	self.Numerator = numerator
	self.FactoryCode = nil
	self.FactoryValid = false
	
	return self
end