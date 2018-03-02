local self = {}
CAC.BanSystemStatus = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

function self:ctor ()
	self.BestBanSystem = CAC.SystemRegistry:GetBestSystem ("BanSystem"):GetId ()
	
	self.AvailableBanSystems = {}
	
	for banSystem in CAC.SystemRegistry:GetSystemEnumerator ("BanSystem") do
		if banSystem:IsAvailable () then
			self.AvailableBanSystems [banSystem] = true
		end
	end
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:StringN8 (self:GetBestBanSystem ())
	
	for banSystem, _ in pairs (self.AvailableBanSystems) do
		outBuffer:StringN8 (banSystem:GetId ())
	end
	outBuffer:StringN8 ("")
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SetBestBanSystem (inBuffer:StringN8 ())
	
	self:ClearAvailableBanSystems ()
	local banSystem = inBuffer:StringN8 ()
	while banSystem ~= "" do
		self:AddAvailableBanSystem (banSystem)
		
		banSystem = inBuffer:StringN8 ()
	end
	
	return self
end

-- BanSystemStatus
function self:GetBestBanSystem ()
	return self.BestBanSystem
end

function self:SetBestBanSystem (banSystem)
	self.BestBanSystem = banSystem
	return self
end

function self:AddAvailableBanSystem (banSystem)
	self.AvailableBanSystems [banSystem] = true
end

function self:ClearAvailableBanSystems ()
	self.AvailableBanSystems = {}
end

function self:GetAvailableBanSystemEnumerator ()
	return CAC.KeyEnumerator (self.AvailableBanSystems)
end

function self:IsBanSystemAvailable (banSystem)
	return self.AvailableBanSystems [banSystem] or false
end