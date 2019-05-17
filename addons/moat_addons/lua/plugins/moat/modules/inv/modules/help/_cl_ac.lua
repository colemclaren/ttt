
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

local LastSide, LastForward, LastUp, IsPredicted, LastCommand, v, LastButtons
local P, A = FindMetaTable"Player"
P.E = P.E or P.SetEyeAngles
function P.SetEyeAngles(s,a)
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
    self:b(a)
    LastButtons = LastCommand == self and self:GetButtons() or LastButtons
end 
function CUserCmd:SetViewAngles(a)
    self:v(a)
    v = self:GetViewAngles()
end
function CUserCmd:SetSideMove(a)
    self:s(FloatClampConvar(a, cl_sidespeed))
    LastSide = self:GetSideMove()
end 
function CUserCmd:SetForwardMove(a)
    self:f(FloatClampConvar(a, cl_forwardspeed))
    LastForward = self:GetForwardMove()
end
function CUserCmd:SetUpMove(a)
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