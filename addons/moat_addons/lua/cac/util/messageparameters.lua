local self = {}
CAC.MessageParameters = CAC.MakeConstructor (self)

function self:ctor ()
	self.Parameters = {}
end

function self:AddParameter (parameterName, parameterValue)
	self.Parameters [parameterName] = parameterValue
end

function self:ContainsParameter (parameterName)
	return self.Parameters [parameterName] ~= nil
end

function self:GetParameter (parameterName)
	return self.Parameters [parameterName]
end

function self:SetParameter (parameterName, parameterValue)
	self.Parameters [parameterName] = parameterValue
end