ROLES = ROLES or {}
AddCSLuaFile()

local HOOKS = {}

function InstallRoleHook(event, plyargnorfn)
    HOOKS[event] = HOOKS[event] or {}
    HOOKS[event][ROLE.ID] = plyargnorfn
end

local function include_role(roleid, rolename, sv, cl, sh)
    sh = sh == nil and true or sh
    sv = sv or false
    cl = cl or false
    ROLE = ROLES[roleid] or {
        ID = roleid,
        Name = rolename
    }
    local fpath = "roles/"..rolename.."/%s.lua"
    if (sh) then
        AddCSLuaFile(fpath:format "shared")
        include(fpath:format "shared")
    end
    if (cl) then
        if (SERVER) then
            AddCSLuaFile(fpath:format "cl_init")
        else
            include(fpath:format "cl_init")
        end
    end
    if (SERVER and sv) then
        include(fpath:format "sv_init")
    end
    ROLES[roleid] = ROLE
    ROLE = nil
end

include_role(ROLE_JESTER, "jester", true, false, true)

function GM.InitializeRoles()
    for event, roles in pairs(HOOKS) do
        local gm = gmod.GetGamemode()
        gm.RoleHook_cache = gm.RoleHook_cache or {}

        if (gm.RoleHook_cache[event]) then
            continue
        end
        gm.RoleHook_cache[event] = true
        local old = gm[event]

        gm[event] = function(self, ...)
            for roleid, plyargn in pairs(roles) do
                local ply
                if (type(plyargn) == "number") then
                    ply = select(plyargn, ...)
                else
                    ply = plyargn(...)
                end

                if (IsValid(ply) and ply:IsPlayer() and ply:GetRole() == roleid) then
                    local ROLE = ROLES[ply:GetRole()]
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