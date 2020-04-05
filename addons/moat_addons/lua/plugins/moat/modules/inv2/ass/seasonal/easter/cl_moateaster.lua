MOAT_EASTER = MOAT_EASTER or {}
MOAT_EASTER.Models = {}
MOAT_EASTER.Frame = {
	w = 800,
	h = 100
}
MOAT_EASTER.Message = "AN EASTER EGG HAS SPAWNED SOMEWHERE ON THE MAP!!!"

local audio_sound = nil
local max_height = 1200
local audio_width = (ScrW() / 256) * 2
local sound_cache = {}
local audio_color = Color(0, 255, 255)
local audio_beat = 0
local moat_URL = "https://i.moat.gg/servers/tttsounds/easteregg"
local moat_Songs = 55

function m_ChooseRandomSong(song_num)
    local song_url = moat_URL .. song_num .. ".mp3"

    return song_url
end

local lr_size = 20
local lr_amt = math.floor(ScrH() / lr_size) + 3
local tb_amt = math.floor(ScrW() / lr_size) + 2
local left_side = {}
local right_side = {}
local top_side = {}
local bottom_side = {}
local color1 = Color(255, 255, 255)
local color2 = Color(0, 0, 0)
local color_delay = CurTime()

function moat_FFTFunc(music_id)
    local music_url = m_ChooseRandomSong(music_id)

    sound.PlayURL(music_url, "mono", function(song, error, errorstring)
        if (IsValid(song)) then
            audio_sound = song
            song:Play()
            song:SetVolume(.5)

            for i = 1, 256 do
                sound_cache[i] = 0
            end
        end
    end)

    for i = 1, lr_amt do
        left_side[i] = (i * lr_size) - lr_size
        right_side[i] = (i * lr_size) - lr_size
    end

    for i = 1, tb_amt do
        top_side[i] = (i * lr_size) - lr_size
        bottom_side[i] = (i * lr_size) - lr_size
    end
end

function moat_PaintFFT()
    if (not audio_sound) then return end
    local soundtbl = {}
    audio_sound:FFT(soundtbl, FFT_512)
    if (not soundtbl[2]) then return end

    if ((soundtbl[2] > audio_beat * 3) and (color_delay <= CurTime())) then
        color1 = ColorRand()
        color2 = ColorRand()
        color_delay = CurTime() + 0.1
    end

    audio_beat = Lerp(15 * FrameTime(), audio_beat, soundtbl[2])

    -- Left/Right Side
    for i = 1, lr_amt do
        local color = color1

        if (i % 2 == 0) then
            color = color2
        end

        draw.RoundedBox(lr_size / 2, (lr_size / 2) * -1, left_side[i], lr_size, lr_size, color)

        if (left_side[i] >= ScrH()) then
            local next_pos = 0

            if (not left_side[i + 1]) then
                next_pos = left_side[1]
            else
                next_pos = left_side[i + 1]
            end

            left_side[i] = next_pos - lr_size
        end

        draw.RoundedBox(lr_size / 2, ScrW() - (lr_size / 2), right_side[i], lr_size, lr_size, color)

        if (right_side[i] <= (lr_size * -1)) then
            local next_pos = 0

            if (not right_side[i - 1]) then
                next_pos = right_side[#right_side]
            else
                next_pos = right_side[i - 1]
            end

            right_side[i] = next_pos + lr_size
        end
    end

    for i = 1, lr_amt do
        left_side[i] = Lerp(5 * FrameTime(), left_side[i], left_side[i] + (5 + (100 * audio_beat)))
        right_side[i] = Lerp(5 * FrameTime(), right_side[i], right_side[i] - (5 + (100 * audio_beat)))
    end

    -- Top/Bottom Side
    for i = 1, tb_amt do
        local color = color1

        if (i % 2 == 0) then
            color = color2
        end

        draw.RoundedBox(lr_size / 2, top_side[i], (lr_size / 2) * -1, lr_size, lr_size, color)

        if (top_side[i] <= (lr_size * -1)) then
            local next_pos = 0

            if (not top_side[i - 1]) then
                next_pos = top_side[#top_side]
            else
                next_pos = top_side[i - 1]
            end

            top_side[i] = next_pos + lr_size
        end

        draw.RoundedBox(lr_size / 2, bottom_side[i], ScrH() - (lr_size / 2), lr_size, lr_size, color)

        if (bottom_side[i] >= ScrW()) then
            local next_pos = 0

            if (not bottom_side[i + 1]) then
                next_pos = bottom_side[1]
            else
                next_pos = bottom_side[i + 1]
            end

            bottom_side[i] = next_pos - lr_size
        end
    end

    for i = 1, tb_amt do
		top_side[i] = Lerp(5 * FrameTime(), top_side[i], top_side[i] - (5 + (100 * audio_beat)))
    	bottom_side[i] = Lerp(5 * FrameTime(), bottom_side[i], bottom_side[i] + (5 + (100 * audio_beat)))
    end
end

hook.Add("HUDPaint", "moatFFTPaint", moat_PaintFFT)

function MOAT_EASTER.EggSpawned()
	local music_num = net.ReadUInt(4)
	moat_FFTFunc(music_num)

	local opx, opy = (ScrW()/2) - (MOAT_EASTER.Frame.w/2), -MOAT_EASTER.Frame.h

	local bg = vgui.Create("DFrame")
	bg:SetSize(MOAT_EASTER.Frame.w, MOAT_EASTER.Frame.h)
	bg:SetPos(opx, opy)
	bg:ShowCloseButton(false)
	bg:SetAlpha(0)
	bg:SetTitle("")
	bg:MoveTo((ScrW()/2) - (MOAT_EASTER.Frame.w/2), 200, 4, 0, -1, function(a, pnl)
		timer.Simple(10, function()
			pnl:MoveTo(opx, opy, 4, 0, -1, function(a, pnl)
				pnl:Remove()
			end)
			pnl:AlphaTo(0, 3)
		end)
	end)
	bg:AlphaTo(255, 4)
	bg.Think = function(s) end
	bg.Paint = function(s, w, h)
		surface.SetFont("moat_ItemDescLarge3")
		local tw = surface.GetTextSize(MOAT_EASTER.Message)
		DrawShadowedText(1, MOAT_EASTER.Message, "moat_ItemDescLarge3", (w/2) - (tw/2), 50, Color(0, 0, 0))
		DrawEnchantedText(1, MOAT_EASTER.Message, "moat_ItemDescLarge3", (w/2) - (tw/2), 50, HSVToColor(CurTime() * 10 % 360, 1, 1), HSVToColor(CurTime() * 70 % 360, 1, 1))
	end

	--sound.PlayURL("http://server.moatgaming.org/tttsounds/easteregg" .. music_num .. ".mp3", "mono", function(snd) if(IsValid(snd))then snd:Play() end end)
end

net.Receive("moat_easter_egg", MOAT_EASTER.EggSpawned)

net.Receive("moat_easter_egg_found", function()
	local str = net.ReadString()

	chat.AddText(Material("icon16/information.png"), Color(255, 105, 180), str, Color(100, 149, 237), " has found an easter egg!!")
end)

net.Receive("moat_easter_basket_found", function()
    local str = net.ReadString()

    chat.AddText(Material("icon16/information.png"), Color(255, 105, 180), str, Color(100, 149, 237), " has found a " .. (net.ReadBool() and "easter basket" or "easter egg") .. "!!")
end)
