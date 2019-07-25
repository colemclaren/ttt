

surface.CreateFont("moat_wdl", {
	font = "DermaLarge",
	size = 22,
	weight = 700
})

surface.CreateFont("moat_wdls", {
	font = "DermaLarge",
	size = 22,
	weight = 700,
	blursize = 3
})

surface.CreateFont("moat_wdl2", {
	font = "DermaLarge",
	size = 20,
	weight = 600
})

surface.CreateFont("moat_wdl2s", {
	font = "DermaLarge",
	size = 20,
	weight = 600,
	blursize = 3
})

surface.CreateFont("moat_ItemDescShadow3", {
    font = "DermaLarge",
    size = 14,
    weight = 800,
	blursize = 2
})

surface.CreateFont("moat_wdlb3", {
	font = "DermaLarge",
	size = 41,
	weight = 200
})

surface.CreateFont("moat_wdlb3s", {
	font = "DermaLarge",
	size = 41,
	weight = 500,
	blursize = 5
})

local info = steamworks.FileInfo
local dl = steamworks.Download
local sub = steamworks.IsSubscribed
local gma = game.MountGMA
local exist = file.Exists
Content = Content or {}
Content.cur = 1
Content.ids = {
	[1] = "1542685010",
	[2] = "1542687639",
	[3] = "1542690513",
	[4] = "1542693501"
}

Content.name = ""
Content.done = false
Content.start = 0

local grad_r = Material("vgui/gradient-l")

function Content.DrawHUD()
	if (Content.done == true) then return end
	if (Content.start < CurTime() and Content.done == true) then return end
	local scrw = ScrW()
	local dl_num = math.Round(100 - (100/(#Content.ids)) * Content.cur)
	local dl_bar = 1 - (dl_num / 100)
	
	surface.SetDrawColor(0, 0, 0, 175)
	surface.DrawRect((scrw/2) - 250, 130, 500, 30)

	surface.SetDrawColor(165, 165, 165, 150)
	surface.DrawOutlinedRect((scrw/2) - 250, 130, 500, 30)

	surface.SetDrawColor(0, 0, 0, 50)
	surface.DrawOutlinedRect((scrw/2) - 251, 129, 502, 32)

	surface.SetDrawColor(175, 25, 25, 255)
	surface.DrawRect((scrw/2) - 249, 131, 498 * dl_bar, 28)

	surface.SetDrawColor(110, 25, 25, 255)
	surface.SetMaterial(grad_r)
	surface.DrawTexturedRect((scrw/2) - 249, 131, 498 * dl_bar, 28)

	draw.Text({
		text = "|",
		font = "moat_wdlb3", 
		pos = {(scrw/2 - 256) + (498 * dl_bar), 121},
		color = Color(255, 255, 255, 100)
	})

	draw.Text({
		text = "|",
		font = "moat_wdlb3s", 
		pos = {(scrw/2 - 256) + (498 * dl_bar), 121},
		color = Color(255, 255, 255, 255)
	})

	draw.Text({
		text = "|",
		font = "moat_wdlb3s", 
		pos = {(scrw/2 - 256) + (498 * dl_bar), 125},
		color = Color(255, 255, 255, 255)
	})

	local dl_text = "Fixing Errors: " .. dl_num .. "% Remaining.."
	if (dl_num == 0) then dl_text = "Finishing Fixing Errors.. Yay!" end

	draw.Text({
		text = dl_text,
		font = "moat_wdl2s", 
		pos = {scrw/2 - 239, 135},
		color = Color(0, 0, 0, 255)
	})

	draw.Text({
		text = dl_text,
		font = "moat_wdl2", 
		pos = {scrw/2 - 240, 134},
		color = Color(200, 200, 200, 255)
	})

	draw.Text({
		text = "Woah, welcome to the server! We're fixing these errors you see for you",
		font = "moat_wdls", 
		pos = {scrw/2 + 1, 76},
		xalign = TEXT_ALIGN_CENTER,
		color = Color(0, 0, 0, 255)
	})

	draw.Text({
		text = "Woah, welcome to the server! We're fixing these errors you see for you",
		font = "moat_wdl", 
		pos = {scrw/2, 75},
		xalign = TEXT_ALIGN_CENTER
	})

	draw.Text({
		text = "Don't worry, you won't see errors after this!",
		font = "moat_ItemDescShadow3", 
		pos = {scrw/2 + 1, 101},
		xalign = TEXT_ALIGN_CENTER,
		color = Color(0, 0, 0, 255)
	})

	draw.Text({
		text = "Don't worry, you won't see errors after this!",
		font = "moat_ItemDesc", 
		pos = {scrw/2, 100},
		xalign = TEXT_ALIGN_CENTER
	})

	draw.Text({
		text = "You might experience a slight stutter while we do, it's normal <3",
		font = "moat_ItemDescShadow3", 
		pos = {scrw/2 + 1, 176},
		xalign = TEXT_ALIGN_CENTER,
		color = Color(0, 0, 0, 255)
	})

	draw.Text({
		text = "You might experience a slight stutter while we do, it's normal <3",
		font = "moat_ItemDesc", 
		pos = {scrw/2, 175},
		xalign = TEXT_ALIGN_CENTER,
	})
end
hook.Add("HUDPaint", "Content.drawhud", Content.DrawHUD)

local tries = 0
function Content:DownloadID(id, t)
	dl(id, true, function(c)
		if (not c) then
			if (tries < 10) then self:DownloadAddon(self.cur) return end

			-- MsgC(Color(0, 255, 255), "[MG Content] ", Color(255, 0, 0), "Failed to Download Resource " .. self.ids[self.cur] .. ".\n")
			self:NextAddon()

			return
		end

		gma(c)
		-- MsgC(Color(0, 255, 255), "[MG Content] ", Color(255, 255, 255), "Loaded Resource " .. self.ids[self.cur] .. ".\n")

		if (t) then
			timer.Simple(5, function() self:NextAddon() end)
		else
			self:NextAddon()
		end
	end)
end

function Content:DownloadAddon(n)
	local wid = self.ids[n] or n
	tries = tries + 1

	if (sub(wid)) then
		self:NextAddon()
		return
	end

	info(wid, function(r)
		if (not r) then
			if (tries < 10) then self:DownloadAddon(self.cur) return end

			-- MsgC(Color(0, 255, 255), "[MG Content] ", Color(255, 0, 0), "Failed to Load Resource " .. self.ids[self.cur] .. ".\n")
			self:NextAddon()

			return
		end

		local id = r.fileid
		local t = !exist("cache/workshop/" .. id .. ".cache", "GAME")

		self:DownloadID(id, t)
	end)
end

function Content:NextAddon()
	self.cur = self.cur + 1
	tries = 0

	if (self.ids[self.cur]) then
		self:DownloadAddon(self.cur)
	else
		self:FinishDownloads()
	end
end

function Content:HotMount(wid)
	if (sub(wid)) then
		MsgC(Color(0, 255, 255), "[Moat Content] ", Color(255, 0, 0), "We're subbed to " .. tostring(wid) .. ".\n")

		return
	end

	info(wid, function(r)
		if (not r) then
			if (tries < 10) then self:HotMount(wid) return end
			return MsgC(Color(0, 255, 255), "[Moat Content] ", Color(255, 0, 0), "Failed to Hot Load " .. tostring(wid) .. ".\n")
		end

		dl(r.fileid, true, function(c)
			if (not c) then
				if (tries < 10) then self:HotMount(wid) return end
				return MsgC(Color(0, 255, 255), "[Moat Content] ", Color(255, 0, 0), "Failed to Mount " .. tostring(wid) .. ".\n")
			end

			gma(c)

			MsgC(Color(0, 255, 255), "[Moat Content] ", Color(255, 0, 0), "Hot Loaded " .. tostring(wid) .. ".\n")
		end)
	end)
end

function Content:FinishDownloads()
	self.done = true
	-- MsgC(Color(0, 255, 255), "[MG Content] ", Color(0, 255, 0), "Finished Mounting all Addons!\n")
end

local disable_downloads = CreateClientConVar("disable_downloads", 0, true, false)

function Content.InitDownloads()
	if (util.NetworkStringToID "ttt_enable_tc" ~= 0) then Content.done = true return end
	
	Content.start = CurTime() + 15
	Content:DownloadAddon(Content.cur)
end

hook.Add("InitPostEntity", "Content.init", Content.InitDownloads)