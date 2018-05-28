local PLAYER = FindMetaTable("Player")

DAMAGELOG_NOTIFY_ALERT = 0
DAMAGELOG_NOTIFY_INFO = 1

function PLAYER:dlogs_Notify(enum, msg, _, snd)
	if (CLIENT) then
		dlogs:Notify(enum, msg, 5, snd)
		return
	end

	net.Start "dlogs.Notify"
		net.WriteUInt(enum, 1)
		net.WriteString(msg)
		net.WriteBool(snd and #snd > 0)
		if (snd and #snd > 0) then
			net.WriteString(snd)
		end
	net.Send(self)
end

if (SERVER) then
	util.AddNetworkString "dlogs.Notify"
	return
end

dlogs.Notifications = dlogs.Notifications or {}
local icons = {
    [DAMAGELOG_NOTIFY_ALERT] = Material("icon16/exclamation.png"),
    [DAMAGELOG_NOTIFY_INFO] = Material("icon16/information.png")
}

function dlogs:Notify(enum, msg, time, snd)
    if (snd and GetConVar("ttt_dmglogs_enablesound"):GetBool() and (system.HasFocus() or GetConVar("ttt_dmglogs_enablesoundoutside"):GetBool())) then
		sound.PlayURL(dlogs.Config.SoundsURL .. snd)
    end

    table.insert(dlogs.Notifications, {
        text = msg,
        icon = icons[msg_type] or icons[DAMAGELOG_NOTIFY_ALERT],
        _time = time,
        start = UnPredictedCurTime()
    })
end

net.Receive("dlogs.Notify", function()
    dlogs:Notify(net.ReadUInt(1), net.WriteString(), 5, net.ReadBool() and net.ReadString())
end)

local function DrawNotif(x, y, w, h, text, icon)
    local red = 75 + (175 * math.abs(math.sin(UnPredictedCurTime() * 2)))
    local b = 2
    draw.RoundedBox(0, x, y, w, h, Color(red, 75, 75, 255))
    draw.RoundedBox(0, x + b, y + b, w - b * 2, h - b * 2, Color(150, 150, 150, 255))
    x = x + 10
    y = y + h / 2 - 8
    surface.SetDrawColor(Color(255, 255, 255, 255))
    surface.SetMaterial(icon)
    surface.DrawTexturedRect(x, y, 16, 16)
    x = x + 26
    surface.SetTextColor(Color(255, 255, 255, 255))
    surface.SetTextPos(x, y)
    surface.DrawText(text)
end

hook.Add("HUDPaint", "RDM_Manager", function()
    local notifications = dlogs.Notifications

    if #notifications > 0 then
        local curtime = UnPredictedCurTime()
        surface.SetFont("CenterPrintText")

        for k, v in pairs(notifications) do
            local w, h = surface.GetTextSize(v.text)
            w = w + 50
            h = h + 8
            local tx = ScrW() - w
            local ty = ScrH() * 0.2 + (h + 5) * k

            if v.rollBack then
                tx = tx + (((1 - math.max(v.start + 1 - curtime, 0)) ^ 2) * tx)
                DrawNotif(tx, ty, w, h, v.text, v.icon)

                if v.start + 1 <= curtime then
                    table.remove(notifications, k)
                end
            else
                tx = tx + ((math.max(v.start + 1 - curtime, 0) ^ 2) * tx)
                DrawNotif(tx, ty, w, h, v.text, v.icon)

                if v.start + v._time <= curtime then
                    v.rollBack = true
                    v.start = curtime
                end
            end
        end
    end
end)