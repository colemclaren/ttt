snapper = snapper or {}
snapper.config = snapper.config or {
	allowed_groups = function(ply)
		return IsValid(ply) and ply.IsStaff
	end,
	command = "!snap",
	menucommand = "!snapper",
	color = {0, 150, 255},
	capture_steam = true,
	default_quality = 70
}

if (not file.IsDir("moat_snap", "DATA")) then file.CreateDir "moat_snap" end
if (not file.IsDir("moat_snap/snaps", "DATA")) then file.CreateDir "moat_snap/snaps" end