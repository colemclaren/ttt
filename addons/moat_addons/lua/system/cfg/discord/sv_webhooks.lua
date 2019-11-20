-- todo replace relay
moat.cfg.webhook = "http://208.103.169.40:5069/"
moat.cfg.oldwebhook = "http://107.191.51.43:3000/"

moat.cfg.discord = {
    primarywebhook = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp"
}

discord.AddChannels {
	["ttt-tv"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
	["general"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
	["ttt-bot"] = "https://discord.moat.gg/api/webhooks/646557108816445440/Z8zcfMxGctXsfVTAkKOiY2J0vobQqo3hT1r4NtT_07LxbT6ONuowDolq2HV3933K3FMj",
	["ttt-challenges"] = "https://discord.moat.gg/api/webhooks/646556647828750337/NGIl7DW12P4YLTRd92l1l0Eyb-nNYwZvmRk-BWGwmRH07kRv1SpMvnnZCG7pborOM4wD",
	["ttt-logs"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
    ["staff-logs"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
    ["boss-logs"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
    ["error-logs"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
    ["testing"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
    ["dev-logs"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
    ["old-staff"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
	["mga-logs"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
	["toxic-logs"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
    ["error-logs-sv"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
    ["server-list"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
    ["enhanced-boss-logs"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
}

discord.AddUsers("ttt-tv", {"Moat TTT Announcements", "Lottery Announcements"}, true)
discord.AddUsers("general", {"Moat TTT Announcement", "Lottery Announcement"}, true)
discord.AddUsers("enhanced-boss-logs", {"AntiCheat - Lua"}, true)
discord.AddUsers("ttt-bot", {"Event", "Drop"})
discord.AddUsers("ttt-challenges", {"Contracts", "Bounties", "Lottery"})
discord.AddUsers("ttt-logs", {"Lottery Win", "Gamble Win"}, true)
discord.AddUsers("staff-logs", {"Anti Cheat", "Past Offences", "Gamble Chat", "Gamble", "Server", "TTS"})
discord.AddUsers("boss-logs", {"Snap", "Skid", "Gamble Log", "Trade", "Bad Map", "ASN Check"})
discord.AddUsers("mga-logs", {"MGA Log"}, true)
discord.AddUsers("dev-logs", {"Developer"})
discord.AddUsers("toxic-logs", {"Toxic"})
discord.AddUsers("error-logs", {"Error Report"}, true)
discord.AddUsers("error-logs-sv", {"Error Report SV"}, true)
discord.AddUsers("server-list", {"Servers"})

function post_discord_server_list()
    Server.IsDev = false
    for k,v in pairs(Servers.Roster) do
        timer.Simple(0.5 * k,function()
            discord.Embed("Servers",{
                author = {
                    name = "moat.gg | ".. v.Name,
                    icon_url = "https://cdn.discordapp.com/avatars/406539243909939200/5a6db1904883070e0f896f3fb0275a2e.webp"
                },
                description = "Click here to connect: " .. v.ConnectURL,
            })
            if k == #Servers.Roster then
                Server.IsDev = true
            end
        end)
    end
end