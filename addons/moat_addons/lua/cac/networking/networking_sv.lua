if not SERVER then return end

CAC.Identifiers = CAC.Identifiers or {}

util.AddNetworkString (CAC.Identifiers.MultiplexedDataChannelName)

util.AddNetworkString (CAC.Identifiers.AdminChannelName          )

net.Receive (CAC.Identifiers.MultiplexedDataChannelName,
	function (bitCount, ply)
		if CAC.IsDebug then
			CAC.Logger:Message ("Received anticheat data (" .. CAC.FormatFileSize (bitCount / 8) .. ") from " .. ply:Nick () .. " (" .. ply:SteamID () .. ") via MultiplexedDataChannel.")
		end
		
		local livePlayerSession = CAC.LivePlayerSessionController:EnsureSessionCreated (ply)
		
		if Profiler then Profiler:Begin ("CAC.Identifiers.MultiplexedDataChannelName") end
		livePlayerSession:HandleMessage (bitCount)
		if Profiler then Profiler:End () end
	end
)

CAC.VNetSystem:AddReceiver (CAC.Identifiers.DataChannelName,
	function (ply, livePlayerSession, inBuffer)
		if CAC.IsDebug then
			CAC.Logger:Message ("Received anticheat data (" .. CAC.FormatFileSize (inBuffer:GetSize ()) .. ") from " .. ply:Nick () .. " (" .. ply:SteamID () .. ") via DataChannel.")
		end
		
		if Profiler then Profiler:Begin ("CAC.Identifiers.DataChannelName") end
		livePlayerSession:HandleReceivedData (inBuffer)
		if Profiler then Profiler:End () end
	end
)

CAC.VNetSystem:AddReceiver (CAC.Identifiers.TamperingReportingChannelName,
	function (ply, livePlayerSession, inBuffer)
		if CAC.IsDebug then
			CAC.Logger:Message ("Received anticheat data (" .. CAC.FormatFileSize (inBuffer:GetSize ()) .. ") from " .. ply:Nick () .. " (" .. ply:SteamID () .. ") via TamperingReportingChannel.")
		end
		
		local tamperingType = inBuffer:UInt8 ()
		
		if tamperingType == 0 then
			-- Timer
			
			-- Disabled until this bug is fixed in gmod.
			-- local timerId = inBuffer:StringN8 ()
			-- livePlayerSession:GetPlayerSession ():AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Anticheat tampering detected: Anticheat timer " .. CAC.String.EscapeNonprintable (timerId) .. " was removed unexpectedly.")
		elseif tamperingType == 1 then
			-- Hook
			local eventName = inBuffer:StringN8 ()
			local hookName  = inBuffer:StringN8 ()
			
			if CAC.Plugins:GetPlugin ("QACCompatibility") and
			   CAC.Plugins:GetPlugin ("QACCompatibility"):IsQACPresent () and
			   CAC.Plugins:GetPlugin ("QACCompatibility"):IsQACHook (eventName, hookName) then
				return
			end
			
			livePlayerSession:GetPlayerSession ():AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Anticheat tampering detected: Anticheat hook " .. CAC.String.EscapeNonprintable (eventName) .. ", " .. CAC.String.EscapeNonprintable (hookName) .. " was removed unexpectedly.")
		elseif tamperingType == 2 then
			-- Net receiver
			local channelName = inBuffer:StringN8 ()
			
			if CAC.Plugins:GetPlugin ("QACCompatibility") and
			   CAC.Plugins:GetPlugin ("QACCompatibility"):IsQACPresent () and
			   CAC.Plugins:GetPlugin ("QACCompatibility"):IsQACNetReceiver (channelName) then
				return
			end
			
			livePlayerSession:GetPlayerSession ():AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Anticheat tampering detected: Anticheat net receiver " .. CAC.String.EscapeNonprintable (channelName) .. " was removed unexpectedly.")
		else
			livePlayerSession:GetPlayerSession ():AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Anticheat tampering detected: Invalid data sent to tampering reporting channel.")
		end
	end
)

CAC.VNetSystem:AddReceiver (CAC.Identifiers.FunctionReportingChannelName,
	function (ply, livePlayerSession, inBuffer)
		if CAC.IsDebug then
			CAC.Logger:Message ("Received anticheat data (" .. CAC.FormatFileSize (inBuffer:GetSize ()) .. ") from " .. ply:Nick () .. " (" .. ply:SteamID () .. ") via FunctionReportingChannel.")
		end
		
		local livePlayerSessionData = livePlayerSession:GetData ()
		livePlayerSessionData.FunctionReportingBuffer = livePlayerSessionData.FunctionReportingBuffer or {}
		
		local functionReportingBuffer = livePlayerSessionData.FunctionReportingBuffer
		
		local isFinalBlock = not inBuffer:Boolean ()
		
		local reportCount  = inBuffer:UInt8 ()
		
		local data = inBuffer:StringN16 ()
		
		functionReportingBuffer [#functionReportingBuffer + 1] = data
		
		if not isFinalBlock then
			if #functionReportingBuffer > 8 and
			   not livePlayerSessionData.OverlongFunctionReportReported then
				-- This is ridiculous
				livePlayerSessionData.OverlongFunctionReportReported = true
				
				livePlayerSession:GetPlayerSession ():AddDetectionReasonFiltered ("AnticheatTruthEngineering", "Improbably long function report received (" .. #functionReportingBuffer .. " blocks" ..  (isFinalBlock and "" or " and counting") .. ").")
			end
			
			return
		end
		
		-- Build compressed report from chunks
		local data = #functionReportingBuffer == 1 and functionReportingBuffer [1] or table.concat (functionReportingBuffer)
		
		-- Flush function reporting buffer
		for i = 1, #functionReportingBuffer do
			functionReportingBuffer [i] = nil
		end
		
		if CAC.IsDebug then
			CAC.Logger:Message ("Received " .. tostring (reportCount) .. " function reports (" .. CAC.FormatFileSize (#data) .. ") from " .. ply:Nick () .. " (" .. ply:SteamID () .. ")" .. ".")
		end
		
		-- Process report
		data = util.Decompress (data)
		local inBuffer = CAC.StringInBuffer (data)
		
		for i = 1, reportCount do
			livePlayerSession:HandleFunctionReport (inBuffer)
		end
	end
)

CAC.VNetSystem:AddReceiver (CAC.Identifiers.AdminUILoaderChannelName,
	function (ply, livePlayerSession, inBuffer)
		if CAC.IsDebug then
			CAC.Logger:Message ("Received admin UI loader data (" .. CAC.FormatFileSize (inBuffer:GetSize ()) .. ") from " .. ply:Nick () .. " (" .. ply:SteamID () .. ") via AdminUILoaderChannel.")
		end
		
		CAC.AdminUIBootstrapper:HandlePacket (ply, livePlayerSession, inBuffer)
	end
)