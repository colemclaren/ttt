-- todo replace relay
moat.cfg.webhook = "http://208.103.169.40:5059/"
moat.cfg.oldwebhook = "http://107.191.51.43:3000/"

moat.cfg.discord = {
    primarywebhook = "https://discord.moat.gg/api/webhooks/646571044856922122/BUuwLVCY_MvtGeFn7BokO5wkxWv8IyFaakDfLDcItKS6JmehO6JOE7U330GueXibHuXX"
}

discord.AddChannels {
	["ttt-tv"] = "https://discord.moat.gg/api/webhooks/646571044856922122/BUuwLVCY_MvtGeFn7BokO5wkxWv8IyFaakDfLDcItKS6JmehO6JOE7U330GueXibHuXX",
	["general"] = "https://discord.moat.gg/api/webhooks/646571044856922122/BUuwLVCY_MvtGeFn7BokO5wkxWv8IyFaakDfLDcItKS6JmehO6JOE7U330GueXibHuXX",
	["ttt-bot"] = "https://discord.moat.gg/api/webhooks/646557108816445440/Z8zcfMxGctXsfVTAkKOiY2J0vobQqo3hT1r4NtT_07LxbT6ONuowDolq2HV3933K3FMj",
	["tradinglounge"] = "https://discord.moat.gg/api/webhooks/651274013095755786/ks7Bcs6pkyHZQiHOYt0z3Rhb6fOOLGEGiZbSb86dx0UzDExboVijpL-OsyGu6z0sOA7d",
	["ttt-challenges"] = "https://discord.moat.gg/api/webhooks/646556647828750337/NGIl7DW12P4YLTRd92l1l0Eyb-nNYwZvmRk-BWGwmRH07kRv1SpMvnnZCG7pborOM4wD",
	["ttt-logs"] = "https://discord.moat.gg/api/webhooks/649226000374169610/rMMJA1P0pVIE2KCmFt1OUidUtbI-XRwDtT-u7a0GBgt4GohFKKaWwRVbpqBc9G29oNUV",
    ["staff-logs"] = "https://discord.moat.gg/api/webhooks/649226000374169610/rMMJA1P0pVIE2KCmFt1OUidUtbI-XRwDtT-u7a0GBgt4GohFKKaWwRVbpqBc9G29oNUV",
    ["boss-logs"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
    ["error-logs"] = "https://discord.moat.gg/api/webhooks/649251773478862848/3I4dvO5uVkSdM0xiJ_U4fnuX7Jrb1i4dMckEqqf51Jm_z1mMi_n_ohO0DYc4kliQZm9d",
    ["testing"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
    ["dev-logs"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
    ["old-staff"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
	["mga-logs"] = "https://discord.moat.gg/api/webhooks/678100316561997835/Z7n8hC_aDNLBecb2__jI_vNKlUe3qELm3Jcp-G0b-iBfE2MkN6FVGSKPH873wJ_HHihO",
	["toxic-logs"] = "https://discord.moat.gg/api/webhooks/649226000374169610/rMMJA1P0pVIE2KCmFt1OUidUtbI-XRwDtT-u7a0GBgt4GohFKKaWwRVbpqBc9G29oNUV",
    ["error-logs-sv"] = "https://discord.moat.gg/api/webhooks/649252891328118794/TROJAC0Ak48HEpaiRdAz6BzgCbUUoyQVSd9EC99Hy22YUodK2w09lIx5p3FqbALN0Oyj",
    ["server-list"] = "https://discord.moat.gg/api/webhooks/646559826037440532/_Wmu7hnC3Je1aiQcGRupEf_vX5k8Hid-_fcPzIO5OH8yCNY7bYjiCCUYqwcl6ERGrkMe",
    ["enhanced-boss-logs"] = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp",
}

discord.AddUsers("ttt-tv", {"Moat TTT Announcements", "Lottery Announcements"}, true)
discord.AddUsers("general", {"Moat TTT Announcement", "Lottery Announcement"}, true)
discord.AddUsers("enhanced-boss-logs", {"AntiCheat - Lua"}, true)
discord.AddUsers("ttt-bot", {"Event", "Drop"})
discord.AddUsers("tradinglounge", {"Events", "Drops"})
discord.AddUsers("ttt-challenges", {"Contracts", "Bounties", "Lottery"})
discord.AddUsers("ttt-logs", {"Lottery Win", "Gamble Win"}, true)
discord.AddUsers("staff-logs", {"Anti Cheat", "Past Offences", "Gamble Chat", "Gamble", "Server", "TTS"})
discord.AddUsers("boss-logs", {"Snap", "Skid", "Gamble Log", "Trade", "Bad Map", "ASN Check"})
discord.AddUsers("mga-logs", {"MGA Log"}, true)
discord.AddUsers("dev-logs", {"Developer"})
discord.AddUsers("toxic-logs", {"Toxic TTT Loggers"})
discord.AddUsers("error-logs", {"Client Error Reports"}, true)
discord.AddUsers("error-logs-sv", {"Server Error Reports"}, true)
discord.AddUsers("server-list", {"Servers"})

slack.AddChannels {
	["mod-log"] = 'https://hooks.slack.com/services/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'
}

slack.AddUsers("mod-log", {"MGA Log"}, true)

function post_discord_server_list()
    Server.IsDev = false
    for k,v in pairs(Servers.Roster) do
        timer.Simple(0.5 * k,function()
            discord.Embed("Servers",{
                author = {
                    name = "★▶Moat ".. v.Name .. " ★ Official Inventory ★ Chill ★ Fun",
                    icon_url = "https://ttt.dev/60433443430256164487.jpg"
                },
                description = "Join: " .. v.ConnectURL,
            })
            if k == #Servers.Roster then
                Server.IsDev = true
            end
        end)
    end
end