local self = {}
CAC.MessageFormatter = CAC.MakeConstructor (self, CAC.StringParser)

function CAC.FormatMessage (message, messageParameters)
	local messageFormatter = CAC.MessageFormatter (message, messageParameters)
	return messageFormatter:FormatMessage ()
end

function self:ctor (data, messageParameters)
	self.MessageParameters = messageParameters
end

function self:FormatMessage ()
	return self:Block ()
end

function self:Block (terminator)
	terminator = terminator or ""
	
	local message = ""
	
	local pattern = "[^{" .. terminator .. "]*"
	
	while true do
		message = message .. self:AcceptPattern (pattern)
		if not self:CanAcceptLiteral ("{") then break end
		
		message = message .. (self:DynamicUnit () or "")
	end
	
	return message
end

function self:DynamicUnit ()
	if not self:AcceptLiteral ("{") then return nil end
	
	-- { identifier }
	-- { identifier : identifier }
	-- { identifier ? block : block }
	
	self:AcceptLiteral ("}")
	
	local identifier = self:AcceptPattern ("[^}?:]*")
	local formatter  = nil
	
	if self:CanAcceptLiteral (":") then
		self:AcceptLiteral (":")
		formatterName = self:AcceptPattern ("[^}]*")
		self:AcceptLiteral ("}")
		return self:Parameter (identifier, formatterName)
	elseif self:CanAcceptLiteral ("}") then
		self:AcceptLiteral ("}")
		return self:Parameter (identifier)
	elseif self:CanAcceptLiteral ("?") then
		self:AcceptLiteral ("?")
		local condition = self.MessageParameters:GetParameter (identifier)
		local trueMessage = self:Block (":")
		self:AcceptLiteral (":")
		local falseMessage = self:Block ("}")
		self:AcceptLiteral ("}")
		
		return condition and trueMessage or falseMessage
	end
end

local formatters =
{
	["lowercase"] = string.lower,
	["uppercase"] = string.upper,
	["titlecase"] = function (str)
		return string.upper (string.sub (str, 1, 1)) .. string.sub (str, 2)
	end
}

function self:Parameter (parameterName, formatterName)
	local formatterFunction = formatterName and formatters [string.lower (formatterName)] or function (x) return x end
	
	if parameterName == "{" then
		return "{"
	elseif parameterName == "}" then
		return "}"
	elseif parameterName == "" and
	       formatterName == "" then
		return ":"
	elseif not self.MessageParameters:ContainsParameter (string.lower (parameterName)) then
		return "{" .. parameterName .. "}"
	else
		return formatterFunction (self.MessageParameters:GetParameter (parameterName))
	end
end