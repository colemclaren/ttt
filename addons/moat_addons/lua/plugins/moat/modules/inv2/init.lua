inv = inv or {}
mi = mi or {
	Version = "2.0",
	Config = {
		CacheKey = "moat_inv_test55", --"moat_test" .. math.random(9999999) .. "_slots",
		OldInvTable = "moat_inventories",
		ColumnCount = 5,
		MinSlots = 40,
		Tester = {
			old = "STEAM_0:0:46558052", -- who's old inventory & stats we are using for testing
			plySpoof = "76561198053381832" -- who's id we will use to load player for inv2
		},
		DefaultInv = {
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
			"Beta Crate",
			"Beta Crate",
			"Beta Crate",
			"Beta Crate",
			"Beta Crate"
		},
		PlayerStats = {
			{"k", "Kills"},
			{"x", "XP"},
			{"d", "Deaths"},
			{"o", "Drops"},
			{"l", "Level", 1},
			{"r", "Deconstructs"},
			{"c", "IC"}
		}
	}
}

function mi:SQLQuery(str, ...)
    local args = {n = select("#", ...), ...}
    local succ, err = isfunction(args[args.n]), isfunction(args[args.n - 1])
	if (succ) then
		succ, err = err and args[args.n - 1] or args[args.n], err and args[args.n] or nil
		args.n = args.n - (err and 2 or 1)
	end

    self.SQL:Query(self.SQL:CreateQuery(str, unpack(args, 1, args.n)), succ, err or function(er)
		mi.Print("Query Error: " .. er .. " | With Query: " .. str, true)
    end)
end

mi.db = mi.SQLQuery
if (SERVER) then
	local orm = include "utils/sql/mysqloo.lua"
	AddCSLuaFile "utils/sql/sqlite.lua"

	hook("SQLConnected", function(db)
		mi.SQL = orm(db)

		hook.Run "InventoryPrepare"
	end)
else
	mi.SQL = include "utils/sql/sqlite.lua"()

    timer.Tick(function()
		hook.Run "InventoryPrepare"
	end)
end