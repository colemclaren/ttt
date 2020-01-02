local tostring = tostring
local CH_Detect = function()
    return tostring ~= select(2, debug.getupvalue(m_DrawHelpPanel, 1))
end
local LocalPlayer = LocalPlayer
local InputMouseApplyCount = 0
local Detection = 127
local SC_Overrode = false
local GetConVar = GetConVar
local RegistryHookLookup = debug.getregistry()[3]
local CUserCmd = FindMetaTable"CUserCmd"

local bxor = bit.bxor
local band = bit.band
local bnot = bit.bnot
local rshift = bit.rshift
local rrotate = bit.ror

local k = {
    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
    0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
    0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
    0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
    0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
    0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
    0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
    0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
    0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
    0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
    0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
    0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
    0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
}
local function str2hexa(s)
    return (s:gsub(".", function(c) return ("%02x"):format(c:byte(1, 1)) end))
end
local function num2s(l, n)
    local s = ""
    for i = 1, n do
        local rem = l % 256
        s = string.char(rem) .. s
        l = (l - rem) / 256
    end
    return s
end
local function s232num(s, i)
    local n = 0
    for i = i, i + 3 do n = n*256 + string.byte(s, i) end
    return n
end
local function preproc(msg, len)
    local extra = 64 - ((len + 9) % 64)
    len = num2s(8 * len, 8)
    msg = msg .. "\128" .. string.rep("\0", extra) .. len
    assert(#msg % 64 == 0)
    return msg
end
local function initH256(H)
    H[1] = 0x6a09e667
    H[2] = 0xbb67ae85
    H[3] = 0x3c6ef372
    H[4] = 0xa54ff53a
    H[5] = 0x510e527f
    H[6] = 0x9b05688c
    H[7] = 0x1f83d9ab
    H[8] = 0x5be0cd19
    return H
end
local function digestblock(msg, i, H)
    local w = {}
    for j = 1, 16 do w[j] = s232num(msg, i + (j - 1)*4) end
    for j = 17, 64 do
        local v = w[j - 15]
        local s0 = bxor(rrotate(v, 7), rrotate(v, 18), rshift(v, 3))
        v = w[j - 2]
        w[j] = w[j - 16] + s0 + w[j - 7] + bxor(rrotate(v, 17), rrotate(v, 19), rshift(v, 10))
    end
    local a, b, c, d, e, f, g, h = H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8]
    for i = 1, 64 do
        local s0 = bxor(rrotate(a, 2), rrotate(a, 13), rrotate(a, 22))
        local maj = bxor(band(a, b), band(a, c), band(b, c))
        local t2 = s0 + maj
        local s1 = bxor(rrotate(e, 6), rrotate(e, 11), rrotate(e, 25))
        local ch = bxor (band(e, f), band(bnot(e), g))
        local t1 = h + s1 + ch + k[i] + w[i]
        h, g, f, e, d, c, b, a = g, f, e, d + t1, c, b, a, t1 + t2
    end
    H[1] = band(H[1] + a)
    H[2] = band(H[2] + b)
    H[3] = band(H[3] + c)
    H[4] = band(H[4] + d)
    H[5] = band(H[5] + e)
    H[6] = band(H[6] + f)
    H[7] = band(H[7] + g)
    H[8] = band(H[8] + h)
end
local function sha256sum(msg)
    msg = preproc(msg, #msg)
    local H = initH256({})
    for i = 1, #msg, 64 do digestblock(msg, i, H) end
    return (num2s(H[1], 4) .. num2s(H[2], 4) .. num2s(H[3], 4) .. num2s(H[4], 4) ..
        num2s(H[5], 4) .. num2s(H[6], 4) .. num2s(H[7], 4) .. num2s(H[8], 4))
end

local Reported = {}

local jit_status = jit.status
local debug_getinfo = debug.getinfo
local debug_getupvalue = debug.getupvalue
local debug_traceback = debug.traceback
local debug_getlocal = debug.getlocal
local jit_util_funcuvname = jit.util.funcuvname
local jit_util_funck = jit.util.funck
local jit_util_funcinfo = jit.util.funcinfo
local insert = function(t, x)
    if (type(x) ~= "string") then
        debug.Trace()
    end
    table.insert(t, x)
end
local util_TableToJSON = util.TableToJSON

local function consistency(f1, f2, idx)
    local r = f1[idx]
    if (r ~= f2[idx]) then
        return {r, f2[idx]}
    end
    return r
end

local wait_for_x_many = 500
local cur_amount = 0

local function SumStack(forwhat)
    cur_amount = cur_amount + 1

    if (cur_amount >= wait_for_x_many) then
        cur_amount = 0
    else
        return
    end

    local t = {debug_traceback(forwhat)}

    local stack = 0
    while true do
        stack = stack + 1
        local info = debug.getinfo(stack)
        if (not info) then
            break
        end
        local fi = jit_util_funcinfo(info.func)

        for _, v in ipairs {
            info.linedefined,
            fi.linedefined,
            info.currentline,
            info.isvararg,
            fi.isvararg,
            info.namewhat,
            info.lastlinedefined,
            fi.lastlinedefined,
            info.source,
            info.nups,
            info.what,
            info.nparams,
            info.short_src,
            fi.params,
            fi.stackslots,
            fi.upvalues,
            fi.bytecodes,
            fi.gcconsts,
            fi.nconsts,
            fi.children,
            fi.ffid,
            fi.loc,
        } do
            insert(t, tostring(v))
        end

        if (info.what ~= "C") then
            insert(t, "a")
            for localidx = 1, 1024 do
                local name = debug_getlocal(info.func, localidx)
                if (not name) then
                    break
                end
                insert(t, name or "~0")
            end

            insert(t, "b")
            for uvidx = 1, 1024 do
                local name = debug_getupvalue(info.func, uvidx)
                local name2 = jit_util_funcuvname(info.func, uvidx - 1)
                if (not name and not name2) then
                    break
                end
                insert(t, name or "~a")
                insert(t, name2 or "~b")
            end

            insert(t, "c")

            for idx = -1, -1024, -1 do
                local constant = jit.util.funck(info.func, idx)
                if (constant == nil) then
                    break
                end
                if (type(constant) == "string") then
                    insert(t, constant or "~c")
                end
            end
        end
    end

    local sum = sha256sum(table.concat(t, "\x01"))

    if (Reported[sum]) then
        return
    end

    Reported[sum] = true

    net.Start(util.NetworkIDToString(util.NetworkStringToID "joystick" + 1))
        net.WriteData(sum, 32)
    net.SendToServer()
end

local LastSide, LastForward, LastUp, IsPredicted, LastCommand, v, LastButtons
local P, A = FindMetaTable"Player"
P.E = P.E or P.SetEyeAngles
function P.SetEyeAngles(s,a)
    SumStack "SEA"
    if s == LocalPlayer() then
        A = a
    end
    s:E(a)
end
for i, s in pairs(RegistryHookLookup) do
    RegistryHookLookup[i] = ({
        InputMouseApply="IMA\r",
        CreateMove="CM\r",
        CalcView="CV\r",
        SetupMove="SM\r",
        StartCommand="SC\r"
    })[s] or s
end
local joystick, cl_upspeed, cl_forwardspeed, cl_sidespeed = GetConVar "joystick", GetConVar "cl_upspeed", GetConVar "cl_forwardspeed", GetConVar "cl_sidespeed"
local function FloatClampConvar(flt, cv)
    return Vector(math.Clamp(flt, -cv:GetFloat(), cv:GetFloat())).x
end
local function HookRun(...)
    return hook.Run(...)
end
if (not CUserCmd.s) then
    CUserCmd.s = CUserCmd.SetSideMove
    CUserCmd.u = CUserCmd.SetUpMove
    CUserCmd.f = CUserCmd.SetForwardMove
    CUserCmd.v = CUserCmd.SetViewAngles
    CUserCmd.b = CUserCmd.SetButtons
end
function CUserCmd:SetButtons(a)
    SumStack "SB"
    self:b(a)
    LastButtons = LastCommand == self and self:GetButtons() or LastButtons
end 
function CUserCmd:SetViewAngles(a)
    SumStack "SVA"
    self:v(a)
    v = self:GetViewAngles()
end
function CUserCmd:SetSideMove(a)
    SumStack "SSM"
    self:s(FloatClampConvar(a, cl_sidespeed))
    LastSide = self:GetSideMove()
end 
function CUserCmd:SetForwardMove(a)
    SumStack "SFM"
    self:f(FloatClampConvar(a, cl_forwardspeed))
    LastForward = self:GetForwardMove()
end
function CUserCmd:SetUpMove(a)
    SumStack "SUM"
    self:u(FloatClampConvar(a,cl_upspeed))
    LastUp = self:GetUpMove()
end

local function y(z)
    return function(ply,...)
        if not z then
            A = nil
            HookRun("SetupMove", ply, ...)
        end
        if (not LastCommand or IsPredicted) then
            goto r
        end
        Detection = false 
            or not ply:IsFrozen() and v ~= LastCommand:GetViewAngles() and -2 
            or not IsPredicted and LastButtons ~= LastCommand:GetButtons() and -3
            or LastSide ~= LastCommand:GetSideMove() and -4
            or LastForward ~= LastCommand:GetForwardMove() and -5
            or LastUp ~= LastCommand:GetUpMove() and -6
            or 127
        ::r::
        LastCommand = nil
        return z and HookRun("CalcView", ply, ...)
    end
end
hook.Add("SM\r", "joystick", y())
hook.Add("CV\r", "joystick", y"")

hook.Add("CM\r","joystick",function(c)
    c:SetMouseWheel(CH_Detect() and -100
        or SC_Overrode and -99
        or Detection)
    Detection = 127
    v = c:GetViewAngles()
    LastButtons = c:GetButtons()
    return HookRun("CreateMove",c)
end)

hook.Add("SC\r", "joystick", function()
    if (InputMouseApplyCount > 1) then
        SC_Overrode = true
    end
    InputMouseApplyCount = 0
end)

hook.Add("IMA\r","joystick",function(c,...)
    InputMouseApplyCount = InputMouseApplyCount + 1
    if not IsPredicted and (A or v) ~= LocalPlayer():EyeAngles() then
        Detection = -1
    end
    c:SetMouseWheel(CH_Detect() and -100
        or SC_Overrode and -99
        or Detection)
    if joystick:GetBool() then
        RunConsoleCommand("joystick","0")
    end
    IsPredicted = 0 == c:TickCount()
    LastSide = c:GetSideMove()
    LastForward = c:GetForwardMove()
    LastUp = c:GetUpMove()
    LastCommand = c
    return HookRun("InputMouseApply", c, ...)
end)