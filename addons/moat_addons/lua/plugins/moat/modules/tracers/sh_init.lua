local ammos = {
    "paintball",
    "laser"
}

TRACERS = TRACERS or {}

for _, type in pairs(ammos) do
    AddCSLuaFile("_" .. type .. ".lua")
    TRACERS[type] = include("_" .. type .. ".lua")
end

if (SERVER) then
    util.AddNetworkString "apply_tracer"
else
    local needed = setmetatable({}, {__mode = "v"})
    hook.Add("NetworkEntityCreated", "apply_tracer", function(e)
        if (e.GetEntityID and needed[e:GetEntityID()]) then
            e:ApplyTracer(needed[e:GetEntityID()])
        end
    end)
    net.Receive("apply_tracer", function()
        local idx = net.ReadUInt(32)
        local tracer = net.ReadString()
        
		for _, ent in pairs(ents.GetAll()) do
            if (ent:IsWeapon() and ent.GetEntityID and ent:GetEntityID() == idx) then
                ent:ApplyTracer(tracer)
                return
			end
        end
        
        needed[idx] = tracer
    end)
end