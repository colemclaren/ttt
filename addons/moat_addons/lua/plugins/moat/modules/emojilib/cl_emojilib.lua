emoji = emoji or {}

local emojis = {}
local emoji_length = {}

local emoji_text_length = {max = 0}

local function AddEmoji(height, url, ...)
    for i = 1, select("#", ...) do
        local emoji = select(i, ...)
        emojis[emoji] = url:match"(%.[^%.]+)$" and url or string("https://static.moat.gg/ttt/emojis/" .. url .. ".png")
        emoji_length[emoji] = height

        emoji_text_length.max = math.max(emoji_text_length.max, emoji:len())

        emoji_text_length[emoji:len()] = emoji_text_length[emoji:len()] or {}
        emoji_text_length[emoji:len()][emoji] = true
    end
end
-- AddEmoji(16, "ok_hand", ":ok_hand:", "👌")
-- AddEmoji(16, "thinking", ":thinking:", "🤔")
-- AddEmoji(21, "https://static.moat.gg/f/30377462080281024722.gif", ":tv:", "📺")
-- AddEmoji(21, "https://static.moat.gg/ttt/emoticons/smiley_registered_trademark/happy-smile.png", ":)", ":]", "}")

AddEmoji(21, "https://static.moat.gg/ttt/emoticons/smiley_registered_trademark/halloween-pumpkin-1.png", ":pumpkin:")
AddEmoji(21, "https://static.moat.gg/ttt/emoticons/smiley_registered_trademark/halloween-pumpkin-2.png", ":pumpkin~1:")
AddEmoji(21, "https://static.moat.gg/ttt/emoticons/smiley_registered_trademark/halloween-pumpkin-3.png", ":pumpkin~2:", "🎃")
AddEmoji(21, "https://static.moat.gg/ttt/emoticons/smiley_registered_trademark/halloween-pumpkin-4.png", ":pumpkin~3:")
AddEmoji(21, "https://static.moat.gg/f/74627770687536266043.png", "Loading...")
-- AddEmoji(21, "pepega", "pepega")
-- AddEmoji(16, "pepehands", "pepehands")
-- AddEmoji(16, "monkaW", "monkaW")
-- AddEmoji(16, "monkaS", "monkaS")

local AddDiscordEmoji = AddEmoji
-- AddDiscordEmoji(24, "lick", ":lick:")
-- AddDiscordEmoji(16, "disagree", ":disagree:")
-- AddDiscordEmoji(20, "tried", ":tried:")
-- AddDiscordEmoji(16, "LUL", ":LUL:")
-- AddDiscordEmoji(16, "winner", ":winner:")
-- AddDiscordEmoji(16, "late", ":late:")
-- AddDiscordEmoji(16, "optimistic", ":optimistic:")
-- AddDiscordEmoji(16, "useful", ":useful:")
-- AddDiscordEmoji(16, "funny", ":funny:")
-- AddDiscordEmoji(16, "agree", ":agree:")
-- AddDiscordEmoji(16, "Pog", ":Pog:")
-- AddDiscordEmoji(16, "3Head", ":3Head:")
-- AddDiscordEmoji(16, "friendly", ":friendly:")
-- AddDiscordEmoji(16, "PepeYikes", ":PepeYikes:")
-- AddDiscordEmoji(16, "noPing", ":noPing:")
-- AddDiscordEmoji(16, "feelsBruh", ":feelsBruh:")
-- AddDiscordEmoji(16, "thankong", ":thankong:")
-- AddDiscordEmoji(15, "blobthumbsdown", ":blobthumbsdown:")
-- AddDiscordEmoji(18, "blobpolice", ":blobpolice:")
-- AddDiscordEmoji(21, "lovelyGun", ":lovelyGun:")
-- AddDiscordEmoji(16, "blobthumbsup", ":blobthumbsup:")
-- AddDiscordEmoji(16, "monkaW", ":monkaW:")
-- AddDiscordEmoji(16, "BabyRage", ":BabyRage:")
-- AddDiscordEmoji(16, "thonkang", ":thonkang:")
-- AddDiscordEmoji(16, "PepePains", ":PepePains:")
-- AddDiscordEmoji(16, "mg", ":mg:")
-- AddDiscordEmoji(16, "OkayMan", ":OkayMan:")
-- AddDiscordEmoji(23, "toxic", ":toxic:")
-- AddDiscordEmoji(14, "gachiGASM", ":gachiGASM:")
-- AddDiscordEmoji(17, "PepoThink", ":PepoThink:")
-- AddDiscordEmoji(19, "sadcat", ":sadcat:")
-- AddDiscordEmoji(13, "5Head", ":5Head:")
-- AddDiscordEmoji(21, "Pepega", ":Pepega:")
-- AddDiscordEmoji(16, "FeelsOkayMan", ":FeelsOkayMan:")
-- AddDiscordEmoji(16, "veryToxic", ":veryToxic:")
-- AddDiscordEmoji(16, "worryFieri", ":worryFieri:")
-- AddDiscordEmoji(16, "OMEGALUL", ":OMEGALUL:")
-- AddDiscordEmoji(16, "mmmm", ":mmmm:")
-- AddDiscordEmoji(16, "thegoodplace", ":thegoodplace:")
-- AddDiscordEmoji(16, "PepeHands", ":PepeHands:")
-- AddDiscordEmoji(16, "HYPERBRUH", ":HYPERBRUH:")
-- AddDiscordEmoji(17, "doubt", ":doubt:")
-- AddDiscordEmoji(16, "what", ":what:")
-- AddDiscordEmoji(16, "hi", ":hi:")
-- AddDiscordEmoji(16, "HYPERS", ":HYPERS:")
-- AddDiscordEmoji(19, "blobawkward", ":blobawkward:")
-- AddDiscordEmoji(16, "SmileW", ":SmileW:")
-- AddDiscordEmoji(12, "kappa", ":kappa:")
-- AddDiscordEmoji(22, "drool", ":drool:")
-- AddDiscordEmoji(16, "heartpepe", ":heartpepe:")
-- AddDiscordEmoji(16, "stop", ":stop:")
-- AddDiscordEmoji(16, "wow", ":wow:")
-- AddDiscordEmoji(18, "vs", ":vs:")
-- AddDiscordEmoji(14, "LULW", ":LULW:")
-- AddDiscordEmoji(16, "EZ", ":EZ:")
-- AddDiscordEmoji(16, "blobaww", ":blobaww:")
-- AddDiscordEmoji(16, "monkaOMEGA", ":monkaOMEGA:")
-- AddDiscordEmoji(14, "elon", ":elon:")
-- AddDiscordEmoji(23, "Sweaty", ":Sweaty:")
-- AddDiscordEmoji(16, "thebadplace", ":thebadplace:")
-- AddDiscordEmoji(16, "omw", ":omw:")
-- AddDiscordEmoji(17, "PepeLaugh", ":PepeLaugh:")
-- AddDiscordEmoji(23, "flex", ":flex:")
-- AddDiscordEmoji(16, "worryCowboy", ":worryCowboy:")
-- AddDiscordEmoji(16, "pogU", ":pogU:")
-- AddDiscordEmoji(16, "blobastonished", ":blobastonished:")
-- AddDiscordEmoji(16, "blobkissheart", ":blobkissheart:")
-- AddDiscordEmoji(16, "B1", ":B1:")
-- AddDiscordEmoji(16, "bad", ":bad:")
-- AddDiscordEmoji(16, "monkas", ":monkas:")

function emoji.GetTextSize(text)
    local width = 0
    local height = 0
    for _, code in emoji.Codes(text or "|") do
        if (emojis[code]) then
            width = width + emoji_length[code]
        else
            local w, h = surface.GetTextSize(code)
            width = width + w
            height = math.max(height, h)
        end
    end
    return width, height
end

function emoji.GetTextOffsetNeeded(text)
    local _, h = surface.GetTextSize(text or "|")
    return math.max(0, 16 - h)
end

function emoji.Codes(text)
	if (not text) then
		return
	end

    local continue_until = 0
    local split = {}
    local last_valid = 1
    local n = 0
    for pos = 1, text and text:len() or 0 do
        if (continue_until > pos) then
            continue
        end

        for len = 1, emoji_text_length.max do
            local check = emoji_text_length[len]
            if (not check) then
                continue
            end
            local subbed = text:sub(pos, pos + len - 1)
            if (not check[subbed]) then
                continue
            end
    
            if (last_valid < pos) then
                n = n + 1
                split[n] = text:sub(last_valid, pos - 1)
            end

            continue_until = pos + len
            n = n + 1
            split[n] = subbed
            last_valid = continue_until
            break
        end
    end

    if (text and last_valid <= text:len()) then
        split[n + 1] = text:sub(last_valid)
    end

    return ipairs(split)
end

function emoji.SimpleTextOutlined(text, font, tx, ty, color, xalign, yalign, outlinewid, outlinecolor, dont_draw_emojis, emoji_align_bottom)
    surface.SetFont(font)
	local w, h = surface.GetTextSize(text and text[1] or "|")
    local y_minus = yalign == TEXT_ALIGN_BOTTOM and h or yalign == TEXT_ALIGN_CENTER and h / 2 or 0
    for _, text in emoji.Codes(text or "|") do
        if (emojis[text]) then
            if (not dont_draw_emojis) then
                local cy = ty
                if (emoji_align_bottom) then
                    cy = cy - y_minus
                end
                cdn.DrawImage(emojis[text], tx + 2, cy - 2, emoji_length[text], emoji_length[text], nil, "alphatest")
            end
            tx = tx + emoji_length[text] + 4
        else
            draw.SimpleTextOutlined(text, font, tx, ty, color, xalign, yalign, outlinewid, outlinecolor)
            tx = tx + w
        end
    end
end

function emoji.SimpleText(text, font, tx, ty, color, xalign, yalign, dont_draw_emojis, emoji_align_bottom)
	surface.SetFont(font)
	local w, h = surface.GetTextSize(text and text[1] or "|")
    local y_minus = yalign == TEXT_ALIGN_BOTTOM and h or yalign == TEXT_ALIGN_CENTER and h / 2 or 0
    for _, text in emoji.Codes(text or "|") do
        if (emojis[text]) then
            if (not dont_draw_emojis) then
                local cy = ty
                if (emoji_align_bottom) then
                    cy = cy - y_minus
                end
                cdn.DrawImage(emojis[text], tx + 2, cy - 2, emoji_length[text], emoji_length[text], nil, "alphatest")
            end
            tx = tx + emoji_length[text] + 4
        else
            draw.SimpleText(text, font, tx, ty, color, xalign, yalign)
            tx = tx + w
        end
    end
end

function emoji.Text(data)
    emoji.SimpleText(data.text, data.font, data.pos[1], data.pos[2], data.color, data.xalign, data.yalign, false, true)
end