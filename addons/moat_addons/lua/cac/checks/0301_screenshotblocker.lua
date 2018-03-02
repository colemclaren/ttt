local self, info = CAC.Checks:RegisterCheck ("ScreenshotBlocker", CAC.SingleResponseCheck)

info:SetName ("Screenshot Verification")
info:SetDescription ("Verifies the integrity of the render.Capture.")

function self:ctor (livePlayerSession)
	self:SetPayloadId ("ScreenCaptureCheck")
end

function self:OnStarted ()
	self:SetStatus ("Sending render.Capture integrity check...")
	self:SetStatus ("Waiting for render.Capture integrity check...")
end

function self:OnResponse (inBuffer)
	self:SetStatus ("Received screenshot capture information!")
	
	local compressedData = inBuffer:StringN16 ()
	local duration       = inBuffer:Double ()
	inBuffer = CAC.StringInBuffer (util.Decompress (compressedData))
	
	local isWindows = self:GetLivePlayerSession ():GetPlayerSession ():GetOperatingSystemInformation ():GetOperatingSystem () == CAC.OperatingSystem.Windows
	
	local jitUtilFuncInfoFunctionInformation = CAC.JitUtilFuncInfoFunctionInformation ()
	jitUtilFuncInfoFunctionInformation:Deserialize (inBuffer)
	
	-- Ensure that the function is native
	local functionAddress = jitUtilFuncInfoFunctionInformation:GetAddress ()
	if not functionAddress then
		self:SetStatus ("Anomaly in render.Capture detected.")
		self:AddDetectionReasonFiltered ("ClientsideLuaExecution", "render.Capture is supposed to be native, but isn't.")
	
	-- Ensure that the function lies within client.dll
	elseif isWindows and
	       not self:GetLivePlayerSession():IsClientDllAddress (functionAddress) then
		if self:GetLivePlayerSession():IsClientDllAddressRangeCertain () then
			self:SetStatus ("render.Capture override detected.")
			self:AddDetectionReasonFiltered ("AntiScreenshot", "render.Capture has been overridden (" .. string.format ("0x%08x", functionAddress) .. " not in " .. self:GetLivePlayerSession ():GetFormattedClientDllAddressRange () .. ").")
		end
	end
	
	local boolean = inBuffer:Boolean ()
	for i = 1, 5 do
		local black         = inBuffer:Boolean ()
		local imageData     = inBuffer:StringN16 ()
		local imageDataHash = tonumber (util.CRC (imageData))
		
		local referenceLength = black and 115 or 143
		local referenceHash   = black and 0x2debf2f2 or 0x1c2e9540
		
		if #imageData ~= referenceLength or
		   imageDataHash ~= referenceHash then
			-- Disabled
			-- self:SetStatus ("Returned render.Capture image is incorrect.")
			-- if boolean then
			-- 	self:AddDetectionReasonFiltered ("AntiScreenshot", "render.Capture returned an image that does not match the reference rendering (" .. #imageData .. ", " .. string.format ("0x%08x", imageDataHash) .. "): " .. string.gsub ("data:image/png;base64," .. (util.Base64Encode (string.sub (imageData, 1, 256)) or ""), "\n", ""))
			-- end
			
			break
		end
	end
end

function self:OnTimedOut ()
	self:SetStatus ("Wait for render.Capture integrity check timed out.")
	
	self:AddDetectionReasonFiltered ("AnticheatTruthTimeout", "render.Capture integrity check results did not arrive on time.")
end

function self:OnFinished ()
end