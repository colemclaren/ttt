------------------------------------
--
-- 	Stats Available to All Weapons
--
------------------------------------

mi.Stat('Damage', 1, 'd')
	:SetMethods {'Primary', 'Damage', {
		function(num, wep) return wep * (1 + (num/100)) end,
		function(mod, num, wep) return mod end
	}, 1}
	:SetTags {'DMG', 'Base Body Damage ', 2}
	:SetDisplay {1, 'Tag', '+'}
	:SetDefaults {'Gun',
		Min = {-2,    0,    4,    8,    11,    14,    17},
		Max = { 3, 	  5,	8,   15,	19,    23,    28}
	}
	:SetDefaults {'Melee',
		Min = {10,   10,   10,   10,    10,    10,    10},
		Max = {25, 	 25,   25,   25,	25,    25,    25}
	}

mi.Stat('Firerate', 2, 'f')
	:SetMethods {'Primary', 'Delay', {
		function(num, wep) return wep * (1 - (num/100)) end,
		function(mod, num, wep) return (60 * (1 / wep)) * (1 + (num/100)) end
	}, 1}
	:SetTags {'RPM', 'Rounds Per Minute', 2}
	:SetDisplay {2, 'Tag', '+'}
	:SetDefaults {'Gun',
		Min = {-3,    0,    5,    8,    11,    14,    17},
		Max = { 3, 	  5,   10,   15,	19,    23,    28}
	}
	:SetDefaults {'Melee',
		Min = {10,   10,   10,   10,    10,    10,    10},
		Max = {30, 	 30,   30,   30,	30,    30,    30}
	}

mi.Stat('Range', 3, 'r')
	:SetMethods {'Range', {
		function(num, wep) return 1 + (num/100) end,
		function(mod, num, wep) return num end
	}, 1}
	:SetTags {'OTR', 'Optimal Target Range', 2}
	:SetDisplay {8, 'Name', '+'}
	:SetDefaults {'Gun',
		Min = {-7,    5,   10,   13,    16,    19,    23},
		Max = { 8, 	 10,   15,   20,	24,    28,    33}
	}
	:SetDefaults {'Melee',
		Min = { 0,    0,    0,    0,     0,     0,     0},
		Max = { 0, 	  0,    0,    0,	 0,     0,     0}
	}

mi.Stat('Weight', 4, 'w')
	:SetMethods {'Weight', {
		function(num, wep) return 1 + (num/100) end,
		function(mod, num, wep) return num * -1 end
	}, 1}
	:SetTags {'MSI', 'Movement Speed Impact', 2}
	:SetDisplay {9, 'Name', '+'}
	:SetDefaults {'Gun',
		Min = { 0,    0,   -1,   -2,    -3,    -4,    -5},
		Max = { 0, 	  0,   -3,   -5,	-7,    -7,    -7}
	}
	:SetDefaults {'Melee',
		Min = { 0,    0,    0,    0,     0,     0,     0},
		Max = { 0, 	  0,    0,    0,	 0,     0,     0}
	}

------------------------------------
--
-- 	Stats Available to Guns
--
------------------------------------

mi.Stat('Accuracy', 5, 'a')
	:SetMethods {'Primary', 'Cone', {
		function(num, wep) return wep * (1 - (num/100)) end,
		function(mod, num, wep) return (1 - (mod * 10)) * 100 end
	}, 1}
	:SetTags {'ACR', 'Accuracy Cone Rating', 2}
	:SetDisplay {4, 'Name', '+'}
	:SetDefaults {'Gun',
		Min = {-2,    0,    5,    8,    11,    14,    17},
		Max = { 2, 	  5,   10,   15,	19,    23,    28}
	}


mi.Stat('Kick', 6, 'k')
	:SetMethods {'Primary', 'Recoil', {
		function(num, wep) return wep * (1 + (num/100)) end,
		function(mod, num, wep) return mod * 100 end
	}, 1}
	:SetTags {'KPB', 'Kick Per Bullet', 2}
	:SetDisplay {5, 'Name', '-'}
	:SetDefaults {'Gun',
		Min = {-2,   -1,   -5,   -8,   -11,   -14,   -17},
		Max = { 2, 	 -5,  -10,  -15,   -19,   -23,   -28}
	}

mi.Stat('Magazine', 7, 'm')
	:SetMethods {'Primary', 'ClipSize', {
		function(num, wep) return wep * (1 + (num/100)) end,
		function(mod, num, wep) return mod end
	}, 1}
	:SetTags {'MAG', 'Bullets Per Clip', 2}
	:SetDisplay {3, 'Tag', '+'}
	:SetDefaults {'Gun',
		Min = {-7,    5,   10,   13,    16,    19,    23},
		Max = { 7, 	 10,   15,   20,	24,    28,    33}
	}

------------------------------------
--
-- 	Stats Available to Melees
--
------------------------------------

mi.Stat('Push Delay', 8, 'p')
	:SetMethods {'Secondary', 'Delay', {
		function(num, wep) return wep * (1 - (num/100)) end,
		function(mod, num, wep) return (60 * (1 / wep)) * (1 + (num/100)) end
	}, 1}
	:SetTags {'PEM', 'Pushes Each Minute', 2}
	:SetDisplay {7, 'Name', '+'}
	:SetDefaults {'Melee',
		Min = { 5,    5,    5,    5,     5,     5,     5},
		Max = {10, 	 10,   10,   10,	10,    10,    10}
	}


mi.Stat('Push Force', 9, 'v')
	:SetMethods {'PushForce', {
		function(num, wep) return wep * (1 + (num/100)) end,
		function(mod, num, wep) return 100 * mod end
	}, 1}
	:SetTags {'PFV', 'Push Force Velocity', 2}
	:SetDisplay {7, 'Name', '+'}
	:SetDefaults {'Melee',
		Min = {10,   10,   10,   10,    10,    10,    10},
		Max = {35, 	 35,   35,   35,	35,    35,    35}
	}

------------------------------------
--
-- 	Stats for Levels and XP
--
------------------------------------

mi.Stat('Level', 10, 'l')
mi.Stat('EXP', 11, 'x')
mi.Stat('Mutated', 12, 'tr')