ROLES = {}
AddCSLuaFile()

local to_hook = {}

function InstallRoleHook(event, plyargnorfn)
    to_hook[event] = plyargnorfn
end

local function include_role(roleid, rolename)
    ROLE = {
        ID = roleid,
        Name = rolename
    }
    local fpath = "roles/"..rolename.."/shared.lua"
    AddCSLuaFile(fpath)
    include(fpath)
    ROLES[roleid] = ROLE
    ROLE = nil
end

local function include_role_sv(roleid, rolename)
    include("roles/"..rolename.."/sv_init.lua")
end

local function include_role_sh(roleid, rolename)
    include("roles/"..rolename.."/sv_init.lua")
    AddCSLuaFile("roles/"..rolename.."/cl_init.lua")
    include("roles/"..rolename.."/cl_init.lua")
end

include_role(ROLE_KILLER, "killer")
include_role(ROLE_JESTER, "jester")
include_role(ROLE_BEACON, "beacon")

include_role_sh(ROLE_XENOMORPH, "xenomorph")
include_role_sv(ROLE_SURVIVOR, "survivor")

function GM.InitializeRoles()
    for event, plyargn in pairs(to_hook) do
        local gm = gmod.GetGamemode()
        gm.RoleHook_cache = gm.RoleHook_cache or {}

        if (not gm.RoleHook_cache[event]) then
            gm.RoleHook_cache[event] = true
            local old = gm[event]

            gm[event] = function(self, ...)
                local ply
                if (type(plyargn) == "number") then
                    ply = select(plyargn, ...)
                else
                    ply = plyargn(...)
                end

                if (IsValid(ply)) then
                    local ROLE = ROLES[ply:GetRole()]
                    if (ROLE and ROLE[event]) then

                        local a, b, c, d, e, f = ROLE[event](ply, ...)
                        if (a ~= nil) then
                            return a, b, c, d, e, f
                        end
                    end
                end

                if (old) then
                    return old(self, ...)
                end
            end
        end
    end
end

function GM:Role_TTTBeginRound()
    for k, ply in ipairs(player.GetAll()) do
        local event = "TTTBeginRound"

        local ROLE = ROLES[ply:GetRole()]
        if (ROLE and ROLE[event]) then
            local a, b, c, d, e, f = ROLE[event](ply)
            if (a ~= nil) then
                return a, b, c, d, e, f
            end
        end
    end
end
function GM:Role_TTTEndRound()
    for k, ply in ipairs(player.GetAll()) do
        local event = "TTTEndRound"

        local ROLE = ROLES[ply:GetRole()]
        if (ROLE and ROLE[event]) then
            local a, b, c, d, e, f = ROLE[event](ply)
            if (a ~= nil) then
                return a, b, c, d, e, f
            end
        end
    end
end