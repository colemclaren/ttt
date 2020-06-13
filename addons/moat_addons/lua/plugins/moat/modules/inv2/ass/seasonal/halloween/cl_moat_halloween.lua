MOAT_HALLOWEEN = MOAT_HALLOWEEN or {}
MOAT_HALLOWEEN.Models = {}
MOAT_HALLOWEEN.Frame = {
	w = 800,
	h = 100
}
MOAT_HALLOWEEN.Message = "A PUMPKIN CRATE HAS SPAWNED ON THE MAP!!!"

local audio_sound = nil
local max_height = 1200
local audio_width = (ScrW() / 256) * 2
local sound_cache = {}
local audio_color = Color(0, 255, 255)
local audio_beat = 0
local moat_URL = "https://static.moat.gg/ttt/halloween/"
local moat_Songs = 17


function m_ChooseRandomSongH(song_num)
    local song_url = moat_URL .. song_num .. ".mp3"

    return song_url
end
-- i think my git is broken so im just testing
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

function moat_FFTFuncH(music_id)
    local music_url = moat_URL .. music_id .. ".mp3"

    sound.PlayURL(music_url, "mono", function(song, error, errorstring)
        if (IsValid(song)) then
            audio_sound = song
            song:Play()
            song:SetVolume(1)

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

function moat_PaintFFTH()
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

hook.Add("HUDPaint", "moatFFTPaint_Halloween", moat_PaintFFTH)

function MOAT_HALLOWEEN.EggSpawned()
	local music_num = net.ReadUInt(8)
	moat_FFTFuncH(music_num)

	local opx, opy = (ScrW()/2) - (MOAT_HALLOWEEN.Frame.w/2), -MOAT_HALLOWEEN.Frame.h

	local bg = vgui.Create("DFrame")
	bg:SetSize(MOAT_HALLOWEEN.Frame.w, MOAT_HALLOWEEN.Frame.h)
	bg:SetPos(opx, opy)
	bg:ShowCloseButton(false)
	bg:SetAlpha(0)
	bg:SetTitle("")
	bg:MoveTo((ScrW()/2) - (MOAT_HALLOWEEN.Frame.w/2), 200, 4, 0, -1, function(a, pnl)
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
		local tw = surface.GetTextSize(MOAT_HALLOWEEN.Message)
		DrawShadowedText(1, MOAT_HALLOWEEN.Message, "moat_ItemDescLarge3", (w/2) - (tw/2), 50, Color(0, 0, 0))
		DrawEnchantedText(1, MOAT_HALLOWEEN.Message, "moat_ItemDescLarge3", (w/2) - (tw/2), 50, HSVToColor(CurTime() * 10 % 360, 1, 1), HSVToColor(CurTime() * 70 % 360, 1, 1))
	end

	--sound.PlayURL("http://server.moatgaming.org/tttsounds/easteregg" .. music_num .. ".mp3", "mono", function(snd) if(IsValid(snd))then snd:Play() end end)
end

net.Receive("moat_halloween_pumpkin", MOAT_HALLOWEEN.EggSpawned)

net.Receive("moat_halloween_pumpkin_found", function()
	local str = net.ReadString()

	chat.AddText(Material("icon16/information.png"), Color(255, 105, 180), str, Color(100, 149, 237), " has found a pumpkin crate!!")
end)