function CAC.JitUtilFuncInfoFunctionInformation.FromFunction (f, jitUtilFuncInfoFunctionInformation)
	return CAC.JitUtilFuncInfoFunctionInformation.FromTable (jit.util.funcinfo (f), jitUtilFuncInfoFunctionInformation)
end

function CAC.JitUtilFuncInfoFunctionInformation.FromTable (t, jitUtilFuncInfoFunctionInformation)
	jitUtilFuncInfoFunctionInformation = jitUtilFuncInfoFunctionInformation or CAC.JitUtilFuncInfoFunctionInformation ()
	
	jitUtilFuncInfoFunctionInformation:SetAddress                         (t.addr           )
	jitUtilFuncInfoFunctionInformation:SetFFID                            (t.ffid           )
	jitUtilFuncInfoFunctionInformation:SetBytecodeCount                   (t.bytecodes      )
	jitUtilFuncInfoFunctionInformation:SetChildren                        (t.children       )
	jitUtilFuncInfoFunctionInformation:SetCurrentLine                     (t.currentline    )
	jitUtilFuncInfoFunctionInformation:SetGarbageCollectableConstantCount (t.gcconsts       )
	jitUtilFuncInfoFunctionInformation:SetVariadic                        (t.isvararg       )
	jitUtilFuncInfoFunctionInformation:SetLastLineDefined                 (t.lastlinedefined)
	jitUtilFuncInfoFunctionInformation:SetLineDefined                     (t.linedefined    )
	jitUtilFuncInfoFunctionInformation:SetLocation                        (t.loc            )
	jitUtilFuncInfoFunctionInformation:SetConstantCount                   (t.nconsts        )
	jitUtilFuncInfoFunctionInformation:SetFixedParameterCount             (t.params         )
	jitUtilFuncInfoFunctionInformation:SetSource                          (t.source         )
	jitUtilFuncInfoFunctionInformation:SetStackSize                       (t.stackslots     )
	jitUtilFuncInfoFunctionInformation:SetUpvalueCount                    (t.upvalues       )
	
	return jitUtilFuncInfoFunctionInformation
end