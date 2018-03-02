-- Generated from: gcad/lua/gcad/signalprocessing/digitalfilters/realfirfilter.lua
-- Original:       https://github.com/notcake/gcad/blob/master/lua/gcad/signalprocessing/digitalfilters/realfirfilter.lua
-- Timestamp:      2015-08-02 20:22:07
local self = {}
CAC.RealFIRFilter = CAC.MakeConstructor (self)

-- Y / X = b0 + b1 z^-1 + b2 z^-2 + b3 z^-3 + b4 z^-4 + ...
-- y_n = b0 x_n + b1 x_n-1 + b2 x_n-2 

function CAC.RealFIRFilter.FromImpulseResponse (...)
	local firFilter = CAC.RealFIRFilter ()
	firFilter:SetImpulseResponse (...)
	return firFilter
end

function self:ctor ()
	-- Impulse response
	-- Starts from index 1
	-- Impulse response is t [1], t [2], t [3], ...
	self.ImpulseResponse = {}
	
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
		
		-- Compute the output
		code:Append ("\tlocal y = " .. tostring (self.ImpulseResponse [1]) .. " * x")
		for i = 2, #self.ImpulseResponse do
			code:Append (" + " .. tostring (self.ImpulseResponse [i]) .. " * x" .. tostring (i - 1))
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
		
		local compiled = CompileString (self.FactoryCode, "CAC.RealFIRFilter", false)
		if isstring (compiled) then
			CAC.Error ("RealFIRFilter:CreateCompiledFilter : Failed to compile filter (" .. compiled .. ")")
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

function self:GetImpulseResponse ()
	return self.ImpulseResponse
end

function self:GetOrder()
	return #self.ImpulseResponse - 1
end

function self:SetImpulseResponse (impulseResponse, ...)
	if isnumber (impulseResponse) then
		impulseResponse = { impulseResponse, ... }
	end
	
	self.ImpulseResponse = impulseResponse
	self.FactoryCode = nil
	self.FactoryValid = false
	
	return self
end