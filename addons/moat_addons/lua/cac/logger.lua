local self = {}
CAC.Logger = CAC.MakeConstructor (self)

function self:ctor (path)
	self.Path = nil
	
	if path then
		self.Path = "cac/" .. path
		
		file.CreateDir ("cac")
		file.Write (self.Path, CAC.Unicode.Characters.ByteOrderMark)
	end
	
	self.T0              = SysTime ()
	self.LastMessageTime = SysTime ()
end

function self:GetLastMessageTime ()
	return self.LastMessageTime
end

function self:Message (message)
	message = "[CAC] " .. self:FormatElapsedTime () .. " " .. message .. "\r\n"
	
	Msg (message)
	if self.Path then
		file.Append (self.Path, message)
	end
	
	self.LastMessageTime = SysTime ()
end

function self:FormatElapsedTime (t)
	t = t or SysTime ()
	t = t - self.T0
	
	return string.format ("%02d:%02d.%03d", math.floor (t / 60), math.floor (t % 60), math.floor ((t * 1000) % 1000))
end

function self:__call (path)
	return self.__ictor (path)
end