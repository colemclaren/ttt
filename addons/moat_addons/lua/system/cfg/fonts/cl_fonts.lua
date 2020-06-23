if (not _SCF) then _SCF = surface.CreateFont end

THEME_DEFAULT = Color(185, 187, 190, 255)
THEME_WHITE   = Color(246, 246, 246, 255)
THEME_BUTTON  = Color(246, 246, 247, 76.5)
THEME_DESC    = Color(220, 221, 222, 255)
THEME_GRAY    = Color(114, 118, 125, 255)

local f = {}
f.default = "Tahoma"
if (system.IsOSX()) then
	f.default = system.IsLinux() and "DejaVu Sans" or "Helvetica"
end

f.custom = system.IsWindows()
f.base = {
	[0] = {font = f.custom and "Lato Light" or f.default, weight = 300, antialias = true},
	[1] = {font = f.custom and "Lato" or f.default, weight = 500, antialias = true},
	[2] = {font = f.custom and "Lato" or f.default, weight = 700, antialias = true},
	[3] = {font = f.custom and "Lato Black" or f.default, weight = 900, antialias = true},
	italic = {
		[0] = {font = f.custom and "Lato Italic" or f.default, weight = 300, italic = not f.custom, antialias = true},
		[1] = {font = f.custom and "Lato Italic" or f.default, weight = 400, italic = not f.custom, antialias = true},
		[2] = {font = f.custom and "Lato Italic" or f.default, weight = 700, italic = not f.custom, antialias = true},
		[3] = {font = f.custom and "Lato Italic" or f.default, weight = 900, italic = not f.custom, antialias = true}
	}
}

local function lato(kind, new_size, italic)
	local font = f.base[kind]
	if (italic) then
		font = f.base.italic[kind]
	end

	font.size = new_size or 14
	return font
end

local ff, df = system.IsLinux() and 'DejaVu Sans' or 'Tahoma', 'Lato'
_SCF('acrashscreen_small', {font = 'Arial',size = 28,weight = 900})
_SCF('acrashscreen_medium', {font = 'Arial',size = 32,weight = 900})
_SCF('acrashscreen_big', {font = 'Arial',size = 36,weight = 900})
_SCF('DermaLargeSmall', {font = df,weight = 500,size = 18})
_SCF('DermaLargeSmall2', {font = df,weight = 500,size = 16})
_SCF('DermaLargeSmall3', {font = df,weight = 500,size = 12})
_SCF('DermaLargeSmall_', {font = df,size = 18,weight = 800})
_SCF('DermaLargeSmall2_', {font = df,size = 16,weight = 800})
_SCF('DermaLargeSmall3_', {font = df,size = 12,weight = 700})
_SCF('M_DL_ChatCategory', {font = df,size = 17,weight = 700})
_SCF('M_DL_ChatFont', {font = df,size = 17})
_SCF('M_DL_ChatPlayer', {font = df,size = 16,weight = 600})
_SCF('RDM_Manager_Player', {font = df,weight = 500,size = 17})
_SCF('M_DL_Highlight', {font = 'Verdana',size = 13})
_SCF('M_DL_OldLogsFont', {font = df,weight = 500,size = 20})
_SCF('M_DL_RDM_Manager', {font = df,weight = 500,size = 20})
_SCF('M_DL_Conclusion', {font = df,size = 18,weight = 600})
_SCF('M_DL_ConclusionText', {font = df,weight = 500,size = 18})
_SCF('M_DL_ResponseDisabled', {font = df,weight = 500,size = 16})
_SCF('RAM_VoteFont', {font = 'Trebuchet MS',size = 19,weight = 700})
_SCF('RAM_VoteFontCountdown', {font = df,size = 32,weight = 700})
_SCF('RAM_VoteSysButton', {font = 'Marlett',size = 13,weight = 0,symbol = true})
_SCF('moat_Feedback', {font = 'Roboto',size = 20,weight = 500})
_SCF('moat_mVotes', {font = df,size = 30,weight = 800})
_SCF('moat_mFeed', {font = df,size = 22,weight = 1000})
_SCF('moat_mTitle', {font = df,size = 22,weight = 800})
_SCF('moat_BossWarning', {font = df,size = 52,weight = 800,italic = true})
_SCF('moat_BossInfo', {font = df,size = 28,weight = 800,italic = true})
_SCF('moat_BossInfo2', {font = df,size = 18,weight = 800,italic = true})

for i = 1, 25 do
	_SCF('moat_TDMLead' .. i, {font = df,size = 20 + i,weight = 800,italic = true})
end

_SCF('moat_GunGameMedium', {font = df,size = 28,weight = 800,italic = true})
_SCF('moat_GunGameSmall', {font = df,size = 18,weight = 800})
_SCF('moat_GunGameLarge', {font = df,size = 52,weight = 800,italic = true})

for i = 1, 50 do
	_SCF('moat_FFALead' .. i, {font = df,size = 20 + i,weight = 800,italic = true})
end

for i = 1, 50 do
	_SCF('MOAT_LAVALead' .. i, {font = df,size = 20 + i,weight = 800,italic = true})
end

for i = 1, 50 do
	_SCF('MOAT_TNTLead' .. i, {font = df,size = 20 + i,weight = 800,italic = true})
end

_SCF('TNT.Big', {font = 'Coolvetica',size = 50,weight = 800,blursize = 0})
_SCF('TNT.Small', {font = 'Coolvetica',size = 30,weight = 800,blursize = 0})

for i = 1, 50 do
	_SCF('MOAT_PHLead' .. i, {font = df,size = 20 + i,weight = 800,italic = true})
end

_SCF('PH.Big', {font = 'Coolvetica',size = 50,weight = 800,blursize = 0})
_SCF('PH.Small', {font = 'Coolvetica',size = 30,weight = 800,blursize = 0})

_SCF('moat_NotifyTest2', {font = df,size = 32,weight = 800})
_SCF('moat_NotifyTestBonus', {font = df,size = 26,weight = 800})

for i = 1, 10 do
	_SCF('moat_Derma' .. i, lato(2, 16 + i))
end

_SCF('moat_LabelFont', lato(3, 16))
_SCF('moat_HitNumberFont', lato(3, 200))
_SCF('moat_Medium11', {font = df,size = 28,weight = 800})
_SCF('moat_Trebuchet', lato(2, 24))
_SCF('moat_Medium9', {font = df,size = 13,weight = 800})
_SCF('moat_Medium10', {font = df,size = 15,weight = 800})
_SCF('moat_Medium4', {font = df,size = 18,weight = 800})
_SCF('moat_Medium4s', {font = df,size = 18,weight = 800, blursize = 3})

_SCF('moat_Medium5', {font = df,size = 20,weight = 800})
_SCF('moat_Medium3', {font = df,size = 16,weight = 700})
_SCF('moat_ItemDesc', lato(2, 15))
_SCF('moat_TradeDesc', {font = df,size = 12,weight = 800})
_SCF('moat_ItemDescLarge3', lato(3, 28))
_SCF('moat_MOTDHead', {font = df,size = 40,weight = 700})
_SCF('moat_ItemDescSmall2', lato(2, 10))
_SCF('moat_Medium2', {font = df,size = 12,weight = 500,italic = true})
_SCF('moat_Medium52', {font = df,size = 20,weight = 800,antialias = false})
_SCF('moat_ExtremeLarge', {font = df,size = 200,weight = 800})
_SCF('moat_Extreme1Large', {font = df,size = 100,weight = 800})
_SCF('MinnLottery', {font = df,size = 25,weight = 400})
_SCF('moat_GambleTitle', {font = df,size = 22,weight = 800})
_SCF('moat_CardFont', {font = df,size = 14,weight = 800})
_SCF('moat_CardFont2', {font = df,size = 14,weight = 1200})
_SCF('moat_DiceWin', {font = df,size = 48,weight = 600})
_SCF('moat_RouletteAmount', {font = df,size = 30,weight = 800})
_SCF('moat_RoulettTime', {font = df,size = 50,weight = 800})
_SCF('moat_RoulettRoll', {font = df,size = 26,weight = 1200})
_SCF('moat_RoulettBet', {font = df,size = 17,weight = 800})
_SCF('moat_crashRoll', {font = df,size = 50,weight = 800})
_SCF('moat_crash', {font = df,size = 40,weight = 800})
_SCF('moat_crashTime', {font = df,size = 20,weight = 800})
_SCF('moat_JackBig', {font = df,size = 50,weight = 800})
_SCF('moat_JackMed', {font = df,size = 40,weight = 800})
_SCF('moat_JackVerySmall', {font = df,size = 15,weight = 800})
_SCF('moat_VersusTitle', {font = df,size = 28,weight = 800})
_SCF('moat_VersusWinner', {font = df,size = 22,weight = 800})
_SCF('moat_ChatFont2', {font = df,size = 20,weight = 1200})
_SCF('moat_raffleHUDFont', {font = df,size = 26,weight = 800})
_SCF('moat_wdl', {font = df,size = 22,weight = 700})
_SCF('moat_wdls', {font = df,size = 22,weight = 700,blursize = 3})
_SCF('moat_wdl2', {font = df,size = 20,weight = 600})
_SCF('moat_wdl2s', {font = df,size = 20,weight = 600,blursize = 3})
_SCF('moat_ItemDescShadow3', {font = df,size = 14,weight = 800,blursize = 2})
_SCF('moat_wdlb3', {font = df,size = 41,weight = 200})
_SCF('moat_wdlb3s', {font = df,size = 41,weight = 500,blursize = 5})
_SCF('WackyTitle', {size = 28,weight = 600})
_SCF('profile.name', {font = df,weight = 500,size = 40,italic = true})
_SCF('profile.steamid', {font = df,weight = 500,size = 20})

_SCF('Snapper Title', {font = 'Roboto Regular',size = 22.1})
_SCF('Roboto 24', {font = 'Roboto Regular',size = 24})
_SCF('Roboto Big', {font = 'Roboto Regular',size = 77.35})
_SCF('Info Text', {font = 'Roboto Medium',size = 17.68})
_SCF('Info Header', {font = 'Roboto Bold',size = 22.1})
_SCF('Info Title', {font = 'Roboto Medium',size = 44.2})
_SCF('Info Tiny', {font = 'Roboto Medium',size = 13.8125})

_SCF('moat_ChatFont', lato(2, 18))
_SCF('moat_ChatFontSmall', lato(2, 12))
_SCF('moat_MenuFont', {font = 'Lato Bold',size = 15,weight = 800})

_SCF('TabLarge', {font = 'Lato',size = 13,weight = 900})
_SCF('treb_small', lato(2, 16))

_SCF('moat_Trebuchet24', lato(3, 23))
_SCF('Trebuchet24', lato(3, 23))
_SCF('DefaultBold', {font = df,size = 13,weight = 1000})
_SCF('Trebuchet22', lato(2, 22))
_SCF('TargetIDSmall2', {font = df,size = 16,weight = 1000})
_SCF('cool_small', {font = 'coolvetica',size = 20,weight = 400})
_SCF('cool_large', {font = 'coolvetica',size = 24,weight = 400})
_SCF('TraitorState', {font = df,size = 28,weight = 1000})
_SCF('TimeLeft', lato(3, 24))
_SCF('TimeLeftS', {font = df,size = 24,weight = 900, blursize = 3})
_SCF('HealthAmmo', {font = df,size = 24,weight = 750})
_SCF('TimeLeftSmall', {font = df,size = 20,weight = 800})
_SCF('WinHuge', {font = df,size = 72,weight = 1000})
_SCF('C4ModelTimer', {font = df,size = 30,weight = 0})
_SCF('C4ModelTimer', {font = df,size = 13,weight = 0})
_SCF('C4Timer', {font = df,size = 30,weight = 750})
_SCF('C4ModelTimer', {font = df,size = 13,weight = 0})
_SCF('C4Timer', {font = df,size = 30,weight = 750})
_SCF("ttc_tutorial_id", {font = 'Arial',size = 40})
_SCF("ttc_tutorial_lbl", {font = 'Arial',size = 15,weight = 1000})

_SCF("ttc_tutorial_lbl", {font = 'Arial',size = 15,weight = 1000})