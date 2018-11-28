AddCSLuaFile()

function moat.print(...)
	local args = {n = select("#", ...), ...}
	if (args.n <= 0) then return end
	local msgt, msgc = {}, 3
	msgt[1] = Color(0, 255, 0)
	msgt[2] = "[MOAT.GG] "
	msgt[3] = Color(255, 255, 255)

	for i = 1, args.n do
		msgc = msgc + 1
		msgt[msgc] = args[i]
	end

	MsgC(unpack(msgt))
	MsgC "\n"
end

function moat.spacer(n)
	for i = 1, n or 2 do
		moat.print "---------------------------------------------------------------------------------------"
	end
end

function moat.debug(...)
	if (not DEBUG) then return end
	local args = {n = select("#", ...), ...}
	if (args.n <= 0) then return end

	local fn = debug.getinfo(2)
	local msgt, msgc = {}, 8
	msgt[1] = Color(0, 255, 255)
	msgt[2] = "debug | "
	msgt[3] = Color(255, 0, 0)
	msgt[4] = SERVER and "SV" or "CL"
	msgt[5] = Color(0, 255, 255)
	msgt[6] = " | "
	msgt[7] = Color(255, 255, 0)
	msgt[8] = fn and fn.name or "unknown"

	if (not DEBUG_LOAD and (msgt[8] == "includesv" or msgt[8] == "includecl" or msgt[8] == "includepath")) then
		return
	end

	for i = 1, args.n do
		msgc = msgc + 1
		msgt[msgc] = Color(0, 255, 255)
		msgc = msgc + 1
		msgt[msgc] = " | "
		msgc = msgc + 1
		msgt[msgc] = Color(255, 255, 255)
		msgc = msgc + 1
		msgt[msgc] = args[i] or "nil"
	end

	MsgC(unpack(msgt))
	MsgC "\n"
end


if (CLIENT) then
	if (not _SCF) then _SCF = surface.CreateFont end
	THE_FONTS = {}
	function surface.CreateFont(name, tbl)
		/*
		table.insert(THE_FONTS, {Name = name, Tbl = tbl})
		_SCF(name, tbl)
		*/
	end

	concommand.Add("list_fonts", function()
		local fs = ""
		for i = 1, #THE_FONTS do
			local f = THE_FONTS[i]
			if (not f.Name or not f.Tbl) then continue end
			local s = "surface.CreateFont('" .. f.Name .. "', {"
			if (f.Tbl.font) then s = s .. "font = '" .. f.Tbl.font .. "'," end
			if (f.Tbl.extended) then s = s .. "extended = true," end
			if (f.Tbl.size) then s = s .. "size = " .. f.Tbl.size .. "," end
			if (f.Tbl.weight) then s = s .. "weight = " .. f.Tbl.weight .. "," end
			if (f.Tbl.blursize) then s = s .. "blursize = " .. f.Tbl.blursize .. "," end
			if (f.Tbl.scanlines) then s = s .. "scanlines = " .. f.Tbl.scanlines .. "," end
			if (f.Tbl.antialias != nil and f.Tbl.antialias == false) then s = s .. "antialias = false," end
			if (f.Tbl.underline) then s = s .. "underline = true," end
			if (f.Tbl.italic) then s = s .. "italic = true," end
			if (f.Tbl.strikeout) then s = s .. "strikeout = true," end
			if (f.Tbl.symbol) then s = s .. "symbol = true," end
			if (f.Tbl.rotary) then s = s .. "rotary = true," end
			if (f.Tbl.shadow) then s = s .. "shadow = true," end
			if (f.Tbl.additive) then s = s .. "additive = true," end
			if (f.Tbl.outline) then s = s .. "outline = true," end
			fs = fs .. string.TrimRight(s, ',') .. "})\n"
		end

		file.Write("fonts.txt", fs)
	end)
end
/*
moat.spacer()

for k, v in ipairs({"\n\n",
[[                        .-'''-.                                             ]],
[[                       '   _    \                                           ]],
[[     __  __   ___    /   /` '.   \                                          ]],
[[    |  |/  `.'   `. .   |     \  '                        .--./)   .--./)   ]],
[[    |   .-.  .-.   '|   '      |  '           .|         /.''\\   /.''\\    ]],
[[    |  |  |  |  |  |\    \     / /  __      .' |_       | |  | | | |  | |   ]],
[[    |  |  |  |  |  | `.   ` ..' /.:--.'.  .'     |       \`-' /   \`-' /    ]],
[[    |  |  |  |  |  |    '-...-'`/ |   \ |'--.  .-'       /("'`    /("'`     ]],
[[    |  |  |  |  |  |            `" __ | |   |  |   ,.--. \ '---.  \ '---.   ]],
[[    |__|  |__|  |__|             .'.''| |   |  |  //    \ /'""'.\  /'""'.\  ]],
[[                                / /   | |_  |  '.'\\    /||     ||||     || ]],
[[                                \ \._,\ '/  |   /  `'--' \'. __// \'. __//  ]],
[[                                 `--'  `"   `'-'          `'---'   `'---'   ]]
,"\n\n"}) do MsgC(Color(103, 152, 235), v .. "\n") end

moat.spacer()
*/
for k, v in ipairs({"\n\n",
[[            yyyhhdddmmmNNNM                                              MNNNmmmdddhhyyy        ]],
[[          /mMMMMMMMMMMMMMMMMm.                                        .mMMMMMMMMMMMMMMMNy`      ]],
[[        `:NMMMMMMMMMMMMMMMMMMms/.                                  ./smMMMMMMMMMMMMMMMMMMd:`    ]],
[[      -yNMMMMMMMMMMMMMMMMMMMMMMMNd/                              /dNMMMMMMMMMMMMMMMMMMMMMMMNy-  ]],
[[     sNMMMMMMMMMMMMMMMMMMMMMMMMMMMMh.                          .hMMMMMMMMMMMMMMMMMMMMMMMMMMMMNs ]],
[[    sMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN+`                      `+NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMs]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd-                    :dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNs`                `sNMMMMMMMMMMMMMMMMMMh/--/hMMMMMMMMMMM]],
[[    MMMMMMMMMMMMNNNNMMMMMMMMMMMMMMMMMMMMMm/              /mMMMMMMMMMMMMMMMMMMMy     `hMMMMMMMMMM]],
[[    MMMMMMMMMms::::::odMMMMMMMMMMMMMMMMMMMMy.          .yMMMMMMMMMMMMMMMMMMMMMh`    `dMMMMMMMMMM]],
[[    MMMMMMMNo.+dmNNmdo./NMMMMMMMMMMMMMMMMMMMN+`      `+NMMMMMMMMMMMMMMMMMmddNMMd+::+dMMmddmMMMMM]],
[[    MMMMMMMo hMMMMMMMMm`/MMMMMMMMMMMMMMMMMMMMMd-    :dMMMMMMMMMMMMMMMMMm:.``.oMMMMMMMM+.``./NMMM]],
[[    MMMMMMM.-MMMMMMMMMM/ NMMMMMMMMMMMMMMMMMMMMMNs  sNMMMMMMMMMMMMMMMMMM+      dMMMMMMh      oMMM]],
[[    MMMMMMM+`dMMMMMMMMN.-MMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMd-`  `/NMMMMMMN:`  `-mMMM]],
[[    MMMMMMMN/.smNMMNmy--mMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMNdyhdMMms++ymMMdhydNMMMM]],
[[    MMMMMMMMMh/:////:/yNMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMd.    .dMMMMMMMMMM]],
[[    MMMMMMMMMMMNmddmNMMMMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMy      yMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMMs-..-sMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNNMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMNyoyMMMMMMMMMMMMNMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMNMMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMM+   +MMMMMMMMMMM:oMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMo:MMMMMMMMMMho:--:ohMMMMMMMMMM]],
[[    MMMMMMMMMMMM/   /MMMMMMMMMMM: .hMMMMMMMMMMMMM..MMMMMMMMMMMMMd- :MMMMMMMMs.:ymNNmy:.yMMMMMMMM]],
[[    MMMMMMMddddd-   -ddddmMMMMMM:   /NMMMMMMMMMMM..MMMMMMMMMMMN+   :MMMMMMMo hMMMMMMMMy sMMMMMMM]],
[[    MMMMMN.`             `oMMMMM:    `yMMMMMMMMMM..MMMMMMMMMMy.    :MMMMMMM`:MMMMMMMMMM-`MMMMMMM]],
[[    MMMMMN/.````     ````-hMMMMM:      :dMMMMMMMM..MMMMMMMMm:      :MMMMMMM-.NMMMMMMMMN.-MMMMMMM]],
[[    MMMMMMMNNNNN:   /NNNNNMMMMMM:       `oNMMMMMM..MMMMMMNo`       :MMMMMMMd.:dMMMMMMd:.mMMMMMMM]],
[[    MMMMMMMMMMMM/   /MMMMMMMMMMM:         -hMMMMM..MMMMMh-         :MMMMMMMMNo:-/oo/-:sNMMMMMMMM]],
[[    MMMMMMMMMMMMy.`.hMMMMMMMMMMM:          `+mMMM..MMMm+`          :MMMMMMMMMMNmdyydmNMMMMMMMMMM]],
[[    MMMMMMMMMMMMMNmNMMMMMMMMMMMM:            .yMM..MMy.            :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMM:              :d..d:              :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMM:               `  `               :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    NMMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  :MMMMMMMMMMMMMMMMMMMMMMMMMMMN]],
[[    oMMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  :MMMMMMMMMMMMMMMMMMMMMMMMMMMo]],
[[     yMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  -MMMMMMMMMMMMMMMMMMMMMMMMMMy ]],
[[      oNMMMMMMMMMMMMMMMMMMMMMMMM.                                  `NMMMMMMMMMMMMMMMMMMMMMMMNo  ]],
[[       .yNMMMMMMMMMMMMMMMMMMMMN+                                    /NMMMMMMMMMMMMMMMMMMMMNy.   ]],
[[         `/yNMMMMMMMMMMMMMMMNy-                                      .yNMMMMMMMMMMMMMMMNy/`     ]]
,"\n\n"}) do MsgC(Color(255, 255, 255), v .. "\n") end

moat.spacer()
moat.print "|"
moat.print "| Welcome to Moat TTT! (づ｡◕‿‿◕｡)づ"
moat.print "|"
moat.print "| We're changing the way people play and experience TTT together. We'd love your help."
moat.print "|"
moat.spacer()
moat.print "| Moat TTT's God Squad Development Team (¬‿¬)" 
moat.print "|"
moat.print "| Meepen > https://steamcommunity.com/profiles/76561198154133184"
moat.print "| Motato > https://steamcommunity.com/profiles/76561198053381832"
moat.print "| Velkon > https://steamcommunity.com/profiles/76561198154133184"
moat.spacer()
moat.print "| Need to report a bug? We'd love to talk with you! <3<3<3"
moat.print [[| The best way to contact us is on our partnered Discord server. \ (•◡•) /]]
moat.print "|"
for i = 1, 3 do moat.print "| > https://discord.gg/moatgaming" end
moat.spacer()