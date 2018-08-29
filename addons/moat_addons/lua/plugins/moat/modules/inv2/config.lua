local cfg = {}
cfg.CacheKey = "moat_test1_slots"
cfg.MinSlots = 40 --Default Slots
cfg.Tester = {
	old = "STEAM_0:0:93667545", -- who's old inventory & stats we are using for testing
	plySpoof = "76561198050165746" -- who's id we will use to load player for inv2
}
cfg.DefaultInv = {
	"weapon_ttt_mac10",
	"weapon_zm_improvised",
	"weapon_zm_revolver",
	"weapon_zm_pistol",
	"weapon_zm_mac10",
	"weapon_zm_rifle",
	"weapon_zm_shotgun",
	"weapon_zm_sledge",
	"weapon_ttt_ak47",
	"weapon_ttt_glock",
	"weapon_ttt_m16",
	"weapon_ttt_sg552",
	"weapon_ttt_shotgun",
	"weapon_ttt_galil",
	"weapon_ttt_aug",
	"Alpha Crate",
	"Alpha Crate",
	"Alpha Crate",
	"Alpha Crate",
	"Alpha Crate"
}

mi.Config = cfg