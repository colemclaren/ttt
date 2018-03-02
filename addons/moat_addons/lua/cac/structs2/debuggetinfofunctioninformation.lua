function CAC.DebugGetInfoFunctionInformation.FromFunction (f, debugGetInfoFunctionInformation)
	return CAC.DebugGetInfoFunctionInformation.FromTable (debug.getinfo (f), debugGetInfoFunctionInformation)
end

function CAC.DebugGetInfoFunctionInformation.FromTable (t, debugGetInfoFunctionInformation)
	debugGetInfoFunctionInformation = debugGetInfoFunctionInformation or CAC.DebugGetInfoFunctionInformation ()
	
	debugGetInfoFunctionInformation:SetCurrentLine         (t.currentline    )
	debugGetInfoFunctionInformation:SetVariadic            (t.isvararg       )
	debugGetInfoFunctionInformation:SetLastLineDefined     (t.lastlinedefined)
	debugGetInfoFunctionInformation:SetLineDefined         (t.linedefined    )
	debugGetInfoFunctionInformation:SetNameWhat            (t.namewhat       )
	debugGetInfoFunctionInformation:SetFixedParameterCount (t.nparams        )
	debugGetInfoFunctionInformation:SetUpvalueCount        (t.nups           )
	debugGetInfoFunctionInformation:SetShortSource         (t.short_src      )
	debugGetInfoFunctionInformation:SetSource              (t.source         )
	debugGetInfoFunctionInformation:SetWhat                (t.what           )
	
	return debugGetInfoFunctionInformation
end