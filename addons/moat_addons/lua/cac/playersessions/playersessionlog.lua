local self = {}
CAC.PlayerSessionLog = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Text (text)
			Fired when text has been appended to the log.
]]

function self:ctor ()
	self.Path = nil
	
	self.Text = { "" }
	
	self.SaveNeeded = false
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:StringN32 (self:GetText ())
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self.Text = { inBuffer:StringN32 () }
	
	return self
end

-- PlayerSessionLog
function self:GetPath ()
	return self.Path
end

function self:SetPath (path)
	if self.Path == path then return self end
	
	self.Path = path
	
	return self
end

function self:Load ()
	if not file.Exists (self.Path, "DATA") then return end
	
	local data = file.Read (self.Path, "DATA")
	
	local inBuffer = CAC.StringInBuffer (data)
	
	self:Deserialize (inBuffer)
	
	self.SaveNeeded = false
end

function self:Save ()
	if not self.SaveNeeded then return end
	
	local outBuffer = CAC.StringOutBuffer ()
	self:Serialize (outBuffer)
	
	file.Write (self.Path, outBuffer:GetString ())
	
	self.SaveNeeded = false
end

function self:Append (text)
	self.Text [#self.Text + 1] = text
	
	self.SaveNeeded = true
	
	self:DispatchEvent ("Text", text)
end

function self:AppendLine (text)
	self:Append (self:FormatTime () .. text .. "\r\n")
end

function self:FormatTime (t)
	t = t or os.time ()
	return os.date ("[%Y-%m-%d %H:%M:%S] ", t)
end

function self:GetText ()
	self:Flatten ()
	return self.Text [1]
end

-- Internal, do not call
function self:Flatten ()
	if #self.Text <= 1 then return end
	
	self.Text = { table.concat (self.Text) }
end
