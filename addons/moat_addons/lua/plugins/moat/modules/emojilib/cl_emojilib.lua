emoji = emoji or {}

local emojis = {}
local emoji_length = {}

local function AddEmoji(width, url, ...)
    for i = 1, select("#", ...) do
        emojis[select(i, ...)] = url
        emoji_length[select(i, ...)] = width
    end
end
AddEmoji(16, "ok_hand", ":ok_hand:", "👌")
AddEmoji(16, "thinking", ":thinking:", "🤔")
AddEmoji(21, "pepega", "pepega")
AddEmoji(16, "pepehands", "pepehands")
AddEmoji(16, "monkaW", "monkaW")
AddEmoji(16, "monkaS", "monkaS")

local AddDiscordEmoji = AddEmoji
AddDiscordEmoji(24, "lick", ":lick:")
AddDiscordEmoji(16, "disagree", ":disagree:")
AddDiscordEmoji(20, "tried", ":tried:")
AddDiscordEmoji(16, "LUL", ":LUL:")
AddDiscordEmoji(16, "winner", ":winner:")
AddDiscordEmoji(16, "late", ":late:")
AddDiscordEmoji(16, "optimistic", ":optimistic:")
AddDiscordEmoji(16, "useful", ":useful:")
AddDiscordEmoji(16, "funny", ":funny:")
AddDiscordEmoji(16, "agree", ":agree:")
AddDiscordEmoji(16, "Pog", ":Pog:")
AddDiscordEmoji(16, "3Head", ":3Head:")
AddDiscordEmoji(16, "friendly", ":friendly:")
AddDiscordEmoji(16, "PepeYikes", ":PepeYikes:")
AddDiscordEmoji(16, "noPing", ":noPing:")
AddDiscordEmoji(16, "feelsBruh", ":feelsBruh:")
AddDiscordEmoji(16, "thankong", ":thankong:")
AddDiscordEmoji(15, "blobthumbsdown", ":blobthumbsdown:")
AddDiscordEmoji(18, "blobpolice", ":blobpolice:")
AddDiscordEmoji(21, "lovelyGun", ":lovelyGun:")
AddDiscordEmoji(16, "blobthumbsup", ":blobthumbsup:")
AddDiscordEmoji(16, "monkaW", ":monkaW:")
AddDiscordEmoji(16, "BabyRage", ":BabyRage:")
AddDiscordEmoji(16, "thonkang", ":thonkang:")
AddDiscordEmoji(16, "PepePains", ":PepePains:")
AddDiscordEmoji(16, "mg", ":mg:")
AddDiscordEmoji(16, "OkayMan", ":OkayMan:")
AddDiscordEmoji(23, "toxic", ":toxic:")
AddDiscordEmoji(14, "gachiGASM", ":gachiGASM:")
AddDiscordEmoji(17, "PepoThink", ":PepoThink:")
AddDiscordEmoji(19, "sadcat", ":sadcat:")
AddDiscordEmoji(13, "5Head", ":5Head:")
AddDiscordEmoji(21, "Pepega", ":Pepega:")
AddDiscordEmoji(16, "FeelsOkayMan", ":FeelsOkayMan:")
AddDiscordEmoji(16, "veryToxic", ":veryToxic:")
AddDiscordEmoji(16, "worryFieri", ":worryFieri:")
AddDiscordEmoji(16, "OMEGALUL", ":OMEGALUL:")
AddDiscordEmoji(16, "mmmm", ":mmmm:")
AddDiscordEmoji(16, "thegoodplace", ":thegoodplace:")
AddDiscordEmoji(16, "PepeHands", ":PepeHands:")
AddDiscordEmoji(16, "HYPERBRUH", ":HYPERBRUH:")
AddDiscordEmoji(17, "doubt", ":doubt:")
AddDiscordEmoji(16, "what", ":what:")
AddDiscordEmoji(16, "hi", ":hi:")
AddDiscordEmoji(16, "HYPERS", ":HYPERS:")
AddDiscordEmoji(19, "blobawkward", ":blobawkward:")
AddDiscordEmoji(16, "SmileW", ":SmileW:")
AddDiscordEmoji(12, "kappa", ":kappa:")
AddDiscordEmoji(22, "drool", ":drool:")
AddDiscordEmoji(16, "heartpepe", ":heartpepe:")
AddDiscordEmoji(16, "stop", ":stop:")
AddDiscordEmoji(16, "wow", ":wow:")
AddDiscordEmoji(18, "vs", ":vs:")
AddDiscordEmoji(14, "LULW", ":LULW:")
AddDiscordEmoji(16, "EZ", ":EZ:")
AddDiscordEmoji(16, "blobaww", ":blobaww:")
AddDiscordEmoji(16, "monkaOMEGA", ":monkaOMEGA:")
AddDiscordEmoji(14, "elon", ":elon:")
AddDiscordEmoji(23, "Sweaty", ":Sweaty:")
AddDiscordEmoji(16, "thebadplace", ":thebadplace:")
AddDiscordEmoji(16, "omw", ":omw:")
AddDiscordEmoji(17, "PepeLaugh", ":PepeLaugh:")
AddDiscordEmoji(23, "flex", ":flex:")
AddDiscordEmoji(16, "worryCowboy", ":worryCowboy:")
AddDiscordEmoji(16, "pogU", ":pogU:")
AddDiscordEmoji(16, "blobastonished", ":blobastonished:")
AddDiscordEmoji(16, "blobkissheart", ":blobkissheart:")
AddDiscordEmoji(16, "B1", ":B1:")
AddDiscordEmoji(16, "bad", ":bad:")
AddDiscordEmoji(16, "monkas", ":monkas:")

function emoji.GetTextSize(text)
    local emoji_width = 0
    for emoji in pairs(emojis) do
        local amt
        text, amt = text:gsub(emoji, "")
        emoji_width = emoji_width + (emoji_length[emoji] + 1) * amt
    end

    local x, y = surface.GetTextSize(text)
    return x + emoji_width, y
end

function emoji.GetTextOffsetNeeded(text)
    local _, h = surface.GetTextSize(text)
    return math.max(0, 16 - h)
end

function emoji.Codes(text)
    local continue_until = 0
    local split = {}
    for pos, code in utf8.codes(text) do
        if (continue_until > pos) then
            continue
        end

        local found = false
        for emoji in pairs(emojis) do
            if (text:find("^" .. emoji, pos)) then
                continue_until = pos + emoji:len()
                split[#split + 1] = emoji
                found = true
            end
        end
        if (not found) then
            split[#split + 1] = utf8.char(code)
        end
    end

    local pos = 0
    return function()
        pos = pos + 1
        if (split[pos]) then
            return pos, split[pos]
        end
        return nil
    end
end

function emoji.SimpleTextOutlined(text, font, tx, ty, color, xalign, yalign, outlinewid, outlinecolor, dont_draw_emojis, emoji_align_bottom)
    surface.SetFont(font)
    for _, text in emoji.Codes(text) do
        if (emojis[text]) then
            if (not dont_draw_emojis) then
                local cy = ty
                if (emoji_align_bottom) then
                    local _, tall = surface.GetTextSize "|"
                    cy = cy - 16 + tall
                end
                cdn.DrawImage("https://cdn.moat.gg/ttt/emojis/" .. emojis[text] .. ".png", tx, cy, emoji_length[text], 16, nil, "alphatest")
                tx = tx + emoji_length[text] + 2
            end
        else
            local w, h = surface.GetTextSize(text)
            draw.SimpleTextOutlined(text, font, tx, ty, color, xalign, yalign, outlinewid, outlinecolor)
            tx = tx + w
        end
    end
end

function emoji.SimpleText(text, font, tx, ty, color, xalign, yalign, dont_draw_emojis, emoji_align_bottom)
    surface.SetFont(font)
    for _, text in emoji.Codes(text) do
        if (emojis[text]) then
            if (not dont_draw_emojis) then
                local cy = ty
                if (emoji_align_bottom) then
                    local _, tall = surface.GetTextSize "|"
                    cy = cy - 16 + tall
                end
                cdn.DrawImage("https://cdn.moat.gg/ttt/emojis/" .. emojis[text] .. ".png", tx, cy, emoji_length[text], 16, nil, "alphatest")
                tx = tx + emoji_length[text] + 2
            end
        else
            local w, h = surface.GetTextSize(text)
            draw.SimpleText(text, font, tx, ty, color, xalign, yalign)
            tx = tx + w
        end
    end
end