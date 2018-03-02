local isfunction     = isfunction

local CompileString  = CompileString

local _R             = debug.getregistry ()

local Entity_IsValid = _R.Entity.IsValid

local FunctionInformationArrayCache = CAC.WeakValueTable () -- string -> FunctionInformation []

function CAC.BroadcastLuaHandler (code)
	local functionInformationArray = FunctionInformationArrayCache [code]
	if not functionInformationArray then
		local f = CompileString (code, "LuaCmd", false)
		if not isfunction (f) then return end
		
		local dump = string.dump (f)
		functionInformationArray = CAC.DumpToFunctionInformationArray (dump)
		
		FunctionInformationArrayCache [code] = functionInformationArray
	end
	
	CAC.LuaWhitelistController:GetDynamicLuaInformation ():AddFunctions ("LuaCmd", functionInformationArray, true)
end

function CAC.SendLuaHandler (ply, code)
	if not ply                  then return end
	if not Entity_IsValid (ply) then return end
	
	local functionInformationArray = FunctionInformationArrayCache [code]
	if not functionInformationArray then
		local f = CompileString (code, "LuaCmd", false)
		if not isfunction (f) then return end
		
		local dump = string.dump (f)
		functionInformationArray = CAC.DumpToFunctionInformationArray (dump)
		
		FunctionInformationArrayCache [code] = functionInformationArray
	end
	
	local livePlayerSession = CAC.LivePlayerSessionController:EnsureSessionCreated (ply)
	livePlayerSession:GetDynamicLuaInformation ():AddFunctions ("LuaCmd", functionInformationArray)
end