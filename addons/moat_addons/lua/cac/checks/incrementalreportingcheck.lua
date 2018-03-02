local self = {}
CAC.IncrementalReportingCheck = CAC.MakeConstructor (self, CAC.SingleResponseCheck)

function self:ctor ()
end

function self:ProcessReports (inBuffer, returnValues)
	local data = inBuffer:StringN16 ()
	data = util.Decompress (data)
	
	inBuffer = CAC.StringInBuffer (data)
	
	local reportCount = inBuffer:UInt16 ()
	
	if CAC.IsDebug then
		CAC.Logger:Message ("Received " .. tostring (reportCount) .. " " .. self:GetName () .. " report entr".. (reportCount == 1 and "y" or "ies") .. ".")
	end
	
	for i = 1, reportCount do
		local ret = self:ProcessReportEntry (inBuffer)
		
		if returnValues then
			returnValues [i] = ret
		end
	end
	
	local duration = inBuffer:Double ()
	
	return duration
end

function self:ProcessReportEntry (inBuffer)
	CAC.Error ("CAC.IncrementalReportingCheck:ProcessReportEntry : Not implemented. (" .. self:GetName () .. ")")
end