-- This file is computer-generated.
local self = {}
CAC.HardwareInformation = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

--[[
	Events:
		Changed ()
		CpuVendorChanged (cpuVendor)
		CpuCoreCountChanged (cpuCoreCount)
		GpuVendorChanged (gpuVendor)
		GpuNameChanged (gpuName)
		MemoryChanged (memory)
]]

CAC.HardwareInformation.Networking =
{
	Events =
	{
		CpuVendorChanged    = { Handler = "SetCpuVendor",    Parameters = { "UInt8"     } },
		CpuCoreCountChanged = { Handler = "SetCpuCoreCount", Parameters = { "UInt8"     } },
		GpuVendorChanged    = { Handler = "SetGpuVendor",    Parameters = { "UInt8"     } },
		GpuNameChanged      = { Handler = "SetGpuName",      Parameters = { "StringN8"  } },
		MemoryChanged       = { Handler = "SetMemory",       Parameters = { "UInt64"    } },
	},
	Commands =
	{
	}
}

CAC.HardwareInformationSender   = CAC.CreateObjectSenderFactory   (CAC.HardwareInformation)
CAC.HardwareInformationReceiver = CAC.CreateObjectReceiverFactory (CAC.HardwareInformation)

function self:ctor ()
	self.CpuVendor    = CAC.CpuVendor.Indeterminate
	self.CpuCoreCount = 0
	self.GpuVendor    = CAC.GpuVendor.Indeterminate
	self.GpuName      = ""
	self.Memory       = 0
	
	CAC.EventProvider (self)
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:UInt8     (self.CpuVendor   )
	outBuffer:UInt8     (self.CpuCoreCount)
	outBuffer:UInt8     (self.GpuVendor   )
	outBuffer:StringN8  (self.GpuName     )
	outBuffer:UInt64    (self.Memory      )
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self:SetCpuVendor    (inBuffer:UInt8     ())
	self:SetCpuCoreCount (inBuffer:UInt8     ())
	self:SetGpuVendor    (inBuffer:UInt8     ())
	self:SetGpuName      (inBuffer:StringN8  ())
	self:SetMemory       (inBuffer:UInt64    ())
	
	return self
end

-- HardwareInformation
function self:Clone (clone)
	clone = clone or self.__ictor ()
	
	clone:Copy (self)
	
	return clone
end

function self:Copy (source)
	self:SetCpuVendor    (source.CpuVendor   )
	self:SetCpuCoreCount (source.CpuCoreCount)
	self:SetGpuVendor    (source.GpuVendor   )
	self:SetGpuName      (source.GpuName     )
	self:SetMemory       (source.Memory      )
	
	return self
end

function self:GetCpuVendor ()
	return self.CpuVendor
end

function self:GetCpuCoreCount ()
	return self.CpuCoreCount
end

function self:GetGpuVendor ()
	return self.GpuVendor
end

function self:GetGpuName ()
	return self.GpuName
end

function self:GetMemory ()
	return self.Memory
end

function self:SetCpuVendor (cpuVendor)
	if self.CpuVendor == cpuVendor then return self end
	
	self.CpuVendor = cpuVendor
	
	self:DispatchEvent ("CpuVendorChanged", self.CpuVendor)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetCpuCoreCount (cpuCoreCount)
	if self.CpuCoreCount == cpuCoreCount then return self end
	
	self.CpuCoreCount = cpuCoreCount
	
	self:DispatchEvent ("CpuCoreCountChanged", self.CpuCoreCount)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetGpuVendor (gpuVendor)
	if self.GpuVendor == gpuVendor then return self end
	
	self.GpuVendor = gpuVendor
	
	self:DispatchEvent ("GpuVendorChanged", self.GpuVendor)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetGpuName (gpuName)
	if self.GpuName == gpuName then return self end
	
	self.GpuName = gpuName
	
	self:DispatchEvent ("GpuNameChanged", self.GpuName)
	self:DispatchEvent ("Changed")
	
	return self
end

function self:SetMemory (memory)
	if self.Memory == memory then return self end
	
	self.Memory = memory
	
	self:DispatchEvent ("MemoryChanged", self.Memory)
	self:DispatchEvent ("Changed")
	
	return self
end

