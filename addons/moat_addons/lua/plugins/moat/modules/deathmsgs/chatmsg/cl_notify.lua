local bg_colors = {
    background_main = Color(0, 0, 10, 200),
    noround = Color(100, 100, 100, 200)
}

net.Receive("ClientDeathNotify", function()
    local NameColor = Color(236, 240, 241)
    local White = Color(236, 240, 241)
    local name = net.ReadString()
    local role = tonumber(net.ReadString())
    local reason = net.ReadString()
    local col = GetRoleColor(role) or bg_colors.noround
    role = LANG.GetRawTranslation(GetRoleStringRaw(role))

    if reason == "suicide" then
        chat.AddText(NameColor, "You ", White, "killed ", NameColor, "Yourself!")
    elseif reason == "burned" then
        chat.AddText(NameColor, "You", White, " burned to death!")
    elseif reason == "prop" then
        chat.AddText(NameColor, "You", White, " were killed by a prop!")
    elseif reason == "ply" then
        chat.AddText(NameColor, "You", White, " were killed by ", col, name, White, ", he was a ", col, role, White, "!")
    elseif reason == "fell" then
        chat.AddText(NameColor, "You", White, " fell to your death!")
    elseif reason == "water" then
        chat.AddText(NameColor, "You", White, " drowned!")
    else
        chat.AddText(White, "It was ", NameColor, "unknown ", White, "how you were killed!")
    end
end)