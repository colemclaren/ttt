local self = {}
CAC.ConVarList = CAC.MakeConstructor (self)

function self:ctor ()
	self.ConVarNames             = {}
	self.ConVarTypes             = {}
	self.DefaultConVarValues     = {}
	
	self.ReplicatedConVarNames   = {}
	self.ReplicatedConVarNameSet = {}
	self.CheatConVarNames        = {}
	self.CheatConVarNameSet      = {}
end

function self:AddConVar (conVarName, typeName, defaultValue, cheat, replicated)
	if not self.ConVarTypes [conVarName] then
		self.ConVarNames [#self.ConVarNames + 1] = conVarName
		self.ConVarTypes [conVarName] = typeName
	end
	
	self.DefaultConVarValues [conVarName] = defaultValue
	
	if cheat and
	   not self.CheatConVarNameSet [conVarName] then
		self.CheatConVarNames [#self.CheatConVarNames + 1] = conVarName
		self.CheatConVarNameSet [conVarName] = true
	end
	
	if replicated and
	   not self.ReplicatedConVarNameSet [conVarName] then
		self.ReplicatedConVarNames [#self.ReplicatedConVarNames + 1] = conVarName
		self.ReplicatedConVarNameSet [conVarName] = true
	end
end

function self:ContainsConVar (conVarName)
	return self.ConVarTypes ~= nil
end

function self:GetCheatConVarEnumerator ()
	return CAC.ArrayEnumerator (self.CheatConVarNames)
end

function self:GetReplicatedConVarEnumerator ()
	return CAC.ArrayEnumerator (self.ReplicatedConVarNames)
end

function self:GetEnumerator ()
	return CAC.ArrayEnumerator (self.ConVarNames)
end

function self:IsCheatConVar (conVarName)
	return self.CheatConVarNameSet [conVarName] ~= nil
end

function self:IsReplicatedConVar (conVarName)
	return self.ReplicatedConVarNameSet [conVarName] ~= nil
end

function self:GetDefaultConVarValue (conVarName)
	return self.DefaultConVarValues [conVarName]
end

function self:GetConVarType (conVarName)
	return self.ConVarTypes [conVarName]
end

CAC.RestrictedConVars = CAC.ConVarList ()

CAC.RestrictedConVars:AddConVar ("cl_leveloverview",                          "Boolean", false, true,  false)
CAC.RestrictedConVars:AddConVar ("host_timescale",                            "Float",       1, false, true )
CAC.RestrictedConVars:AddConVar ("mat_wireframe",                             "Boolean", false, true,  false)
CAC.RestrictedConVars:AddConVar ("r_DrawBeams",                               "Integer",     1, true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawbrushmodels",                         "Boolean", true,  true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawdecals",                              "Boolean", true,  true,  false)
CAC.RestrictedConVars:AddConVar ("r_DrawDisp",                                "Boolean", true,  true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawentities",                            "Boolean", true,  true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawfuncdetail",                          "Boolean", true,  true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawopaquerenderables",                   "Boolean", true,  true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawopaqueworld",                         "Boolean", true,  true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawothermodels",                         "Integer",     1, true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawparticles",                           "Boolean", true,  true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawropes",                               "Boolean", true,  true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawskybox",                              "Boolean", true,  true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawsprites",                             "Boolean", true,  true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawstaticprops",                         "Integer",     1, true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawtranslucentrenderables",              "Boolean", true,  true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawtranslucentworld",                    "Boolean", true,  true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawvgui",                                "Boolean", true,  true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawviewmodel",                           "Boolean", true,  true,  false)
CAC.RestrictedConVars:AddConVar ("r_drawworld",                               "Boolean", true,  true,  false)
CAC.RestrictedConVars:AddConVar ("sv_allowcslua",                             "Boolean", false, false, true )
CAC.RestrictedConVars:AddConVar ("sv_cheats",                                 "Boolean", false, false, true )
