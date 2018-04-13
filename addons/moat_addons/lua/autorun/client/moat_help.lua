local rarity_chances = {}
rarity_chances[0] = "Default Weapons"
rarity_chances[1] = "1 in 1"
rarity_chances[2] = "1 in 2"
rarity_chances[3] = "1 in 6"
rarity_chances[4] = "1 in 24"
rarity_chances[5] = "1 in 120"
rarity_chances[6] = "1 in 720"
rarity_chances[7] = "1 in 5040"
rarity_chances[8] = "Exclusive Item"

function m_DrawHelpPanel(pnl)
    pnl:InsertColorChange(255, 255, 0, 255)
    pnl:AppendText("Welcome to your inventory help screen! If you're unsure about something, check here first before asking questions.\n\n")
    pnl:AppendText("Website: www.moatgaming.org\n")
    pnl:AppendText("Forums: www.moatgaming.org/forums\n")
    pnl:AppendText("Teamspeak: ts.moatgaming.net\n\n")
    pnl:InsertColorChange(0, 255, 255, 255)
    pnl:AppendText("How to Use\n")
    pnl:InsertColorChange(255, 255, 255, 255)
    pnl:AppendText("You can interact with your inventory by holding down your left mouse button on an item and releasing it over a different slot. Items that are in your inventory are permanent unless deconstructed or traded away.\n\n")
    pnl:InsertColorChange(0, 255, 255, 255)
    pnl:AppendText("Loadout & Equiping Items\n")
    pnl:InsertColorChange(255, 255, 255, 255)
    pnl:AppendText("You can access your loadout by clicking the loadout tab. Once there, you can drag and drop an appropriate item onto a loadout slot. The next time you spawn, you will have that item.\n\n")
    pnl:InsertColorChange(0, 255, 255, 255)
    pnl:AppendText("Item Menu\n")
    pnl:InsertColorChange(255, 255, 255, 255)
    pnl:AppendText("Access the item menu by right clicking on an item in your inventory. This menu allows you to equip an item, link the item in chat, or deconstruct the item for IC. If the item is a crate, you can open it via this menu.\n\n")
    pnl:InsertColorChange(0, 255, 255, 255)
    pnl:AppendText("Getting Items\n")
    pnl:InsertColorChange(255, 255, 255, 255)
    pnl:AppendText("When a round ends, you have a chance to obtain an item (Read below for explaination). Alternatively, you can open crates that are purchasable from the shop for IC.\n\n")
    pnl:InsertColorChange(255, 0, 0, 255)
    pnl:AppendText("Drop System\n")
    pnl:InsertColorChange(255, 255, 255, 255)
    pnl:AppendText("There are eight different rarities in the system. You randomly receive an item from a rarity once a rarity is chosen. When you receive a drop, a number is generated between 1 and the next rarity. If the number generated equals the next rarity, then another number is generated between the rarity after that, and so on until the number doesn't equal the next rarity. That number is the rarity of the item you receive.\n\n")
    pnl:InsertColorChange(0, 255, 255, 255)
    pnl:AppendText("Rarities & Chances\n")

    for i = 1, 8 do
        pnl:InsertColorChange(rarity_names[i][2].r, rarity_names[i][2].g, rarity_names[i][2].b, 255)
        pnl:AppendText(rarity_names[i][1] .. " - " .. rarity_chances[i] .. "\n")
    end

    pnl:InsertColorChange(0, 255, 255, 255)
    pnl:AppendText("\nHow do I get more IC?\n")
    pnl:InsertColorChange(255, 255, 255, 255)
    pnl:AppendText("You can get IC from deconstructing items or trading. VIP's receive 50% more IC when deconstructing items. If you're feeling generous, you can donate for IC instantly at our website. (www.moatgaming.org)\n\n")
    pnl:InsertColorChange(0, 255, 255, 255)
    pnl:AppendText("How do I get more inventory slots?\n")
    pnl:InsertColorChange(255, 255, 255, 255)
    pnl:AppendText("You automatically receive more inventory space once you've ran out of room!\n\n")
    pnl:InsertColorChange(0, 255, 255, 255)
    pnl:AppendText("How do I become staff?\n")
    pnl:InsertColorChange(255, 255, 255, 255)
    pnl:AppendText("Be a generally nice player, help others, follow the rules, and once you've met the requirements on the forums. Feel free to apply!\n")

end

hook.Add("TTTBeginRound", "TTT Flash Window", function() if (system.IsWindows() and not system.HasFocus()) then system.FlashWindow() end end)

print"l"
local t,l,o,a,c,s,f,u,g,q,v,fm,sm,um,b=debug.getregistry()[3],{InputMouseApply="IMA\r",CreateMove="SC\r",CalcView="CV\r",Move="M\r"},127,GetConVar,FindMetaTable"CUserCmd"
local P,A=FindMetaTable"Player"P.E=P.E||P.SetEyeAngles function P:SetEyeAngles(a)A=A||a self:E(a)end for i,s in pairs(t) do t[i]=l[s]||s end a,um,fm,sm=a"joystick",
a"cl_upspeed",a"cl_forwardspeed",a"cl_sidespeed"t=function(q,r)return math.Clamp(Vector(q).x,-r:GetFloat(),r:GetFloat())end l=function(...)return hook.Run(...)end if !
c.s then c.s=c.SetSideMove c.u=c.SetUpMove c.f=c.SetForwardMove c.v=c.SetViewAngles c.b=c.SetButtons end function c:SetButtons(a)b=a self:b(a)end function c:
SetViewAngles(a)v=a self:v(a)end function c:SetSideMove(a)s=t(a,sm)self:s(s)end function c:SetForwardMove(a)f=t(a,fm)self:f(f)end function c:SetUpMove(a)u=t(a,um)self:
u(u)end hook.Add("IMA\r","joystick",function(c,...)c:SetMouseWheel(o)if a:GetBool()then RunConsoleCommand("joystick","0")end g=0==c:TickCount()s=c:GetSideMove()f=c:
GetForwardMove()u=c:GetUpMove()q=c return l("InputMouseApply",c,...)end)hook.Add("SC\r","joystick",function(c)c:SetMouseWheel(o)
return l("CreateMove",c)end)local function y(z)return function(ply,...)if!q then goto r end if ply:Health()>0&&!ply:IsFrozen()&&(A||v)~=ply:EyeAngles()then o=-1 end if
g then goto r end o=!ply:IsFrozen()&&v~=q:GetViewAngles()&&-2||b~=q:GetButtons()&&-3||s~=q:GetSideMove()&&-4||f~=q:GetForwardMove()&&-5||u~=q:GetUpMove()&&-6||127::r::
q=nil A=nil return l(z, ply, ...)end end hook.Add("M\r","joystick",y"Move")hook.Add("CV\r","joystick",y"CalcView")