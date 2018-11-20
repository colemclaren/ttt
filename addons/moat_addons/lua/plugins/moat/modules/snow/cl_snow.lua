local mc_replace = {
    ["MINECRAFT/GRASS-TOP"] = "https://i.imgur.com/LqASr7R.jpg",
    ["MINECRAFT/GRASS-SIDE"] = "https://i.imgur.com/7AZOYxi.png",
    ["MINECRAFT/LEAVES"] = "https://i.imgur.com/teH4qh2.png"
}

local function replace_mc()
    print("replace_mc")
    for k,v in pairs(mc_replace) do
        if isstring(k) then
            local replace = cdn.Image(v, function(img) 
                if IsValid(img) and IsValid(Material(k)) then
                    Material(k):SetTexture("$basetexture",img:GetTexture("$basetexture"))
                end
            end, "noclamp")
            if replace then
                if IsValid(replace) and IsValid(Material(k)) then
                    Material(k):SetTexture("$basetexture",replace:GetTexture("$basetexture"))
                end
            end
        else
            if IsValid(MC_DefaultSnow) and IsValid(Material(v)) then
                Material(v):SetTexture("$basetexture",MC_DefaultSnow:GetTexture("$basetexture"))
            end
        end
    end
end

concommand.Add("mc_makesnow",function()
    MC_DefaultSnow = cdn.Image("https://i.imgur.com/4yen59W.jpg", function(img) 
        replace_mc()
    end, "noclamp")
    if MC_DefaultSnow then
        replace_mc()
    end
end)

concommand.Add("mc_debug_texture",function()
    if LocalPlayer():GetEyeTrace().HitTexture then
        print(LocalPlayer():GetEyeTrace().HitTexture)
        SetClipboardText(LocalPlayer():GetEyeTrace().HitTexture)
    end
end)
