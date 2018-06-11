function mlogs:loaded()
	if (not self.wepsloaded) then return end
	if (not self.mapid) then return end
	if (not self.serverid) then return end
	if (self.InitCalled) then return end
	self.InitCalled = true

	hook.Run("mlogs.init", self)
end