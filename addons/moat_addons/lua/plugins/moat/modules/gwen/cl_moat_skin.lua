if (SERVER) then
	AddCSLuaFile "plugins/moat/init/cl_util.lua"
	return
end
include "plugins/moat/init/cl_util.lua"

local MenuColors = {
	Text = Color(154, 156, 160, 255),
	Disabled = Color(128, 128, 128, 255),
	Border = Color(42, 43, 46, 255),
	Menu = Color(24, 25, 28, 255),
	Hover = Color(4, 4, 5, 255),
	TextHover = Color(246, 246, 246, 255)
}

local function look_how_long_this_function_is(dtype, mat)


local surface = surface
local Color = Color

SKIN = {}

SKIN.PrintName		= "Moat Skin"
SKIN.Author		= "Garry Newman"
SKIN.DermaVersion	= 1
SKIN.GwenTexture	= mat

SKIN.bg_color					= Color( 101, 100, 105, 255 )
SKIN.bg_color_sleep				= Color( 70, 70, 70, 255 )
SKIN.bg_color_dark				= Color( 55, 57, 61, 255 )
SKIN.bg_color_bright			= Color( 220, 220, 220, 255 )
SKIN.frame_border				= Color( 50, 50, 50, 255 )

SKIN.fontFrame					= "DermaDefault"

SKIN.control_color				= Color( 120, 120, 120, 255 )
SKIN.control_color_highlight	= Color( 150, 150, 150, 255 )
SKIN.control_color_active		= Color( 110, 150, 250, 255 )
SKIN.control_color_bright		= Color( 255, 200, 100, 255 )
SKIN.control_color_dark			= Color( 100, 100, 100, 255 )

SKIN.bg_alt1					= Color( 50, 50, 50, 255 )
SKIN.bg_alt2					= Color( 55, 55, 55, 255 )

SKIN.listview_hover				= Color( 70, 70, 70, 255 )
SKIN.listview_selected			= Color( 100, 170, 220, 255 )

SKIN.text_bright				= Color( 255, 255, 255, 255 )
SKIN.text_normal				= Color( 180, 180, 180, 255 )
SKIN.text_dark					= Color( 20, 20, 20, 255 )
SKIN.text_highlight				= Color( 255, 20, 20, 255 )

SKIN.texGradientUp				= Material( "gui/gradient_up" )
SKIN.texGradientDown			= Material( "gui/gradient_down" )

SKIN.combobox_selected			= SKIN.listview_selected

SKIN.panel_transback			= Color( 255, 255, 255, 50 )
SKIN.tooltip					= Color( 255, 255, 255, 255 )

SKIN.colPropertySheet			= Color( 170, 170, 170, 255 )
SKIN.colTab						= SKIN.colPropertySheet
SKIN.colTabInactive				= Color( 140, 140, 140, 255 )
SKIN.colTabShadow				= Color( 0, 0, 0, 170 )
SKIN.colTabText					= Color( 255, 255, 255, 255 )
SKIN.colTabTextInactive			= Color( 0, 0, 0, 200 )
SKIN.fontTab					= "DermaDefault"

SKIN.colCollapsibleCategory		= Color( 255, 255, 255, 20 )

SKIN.colCategoryText			= Color( 255, 255, 255, 255 )
SKIN.colCategoryTextInactive	= Color( 200, 200, 200, 255 )
SKIN.fontCategoryHeader			= "TabLarge"

SKIN.colNumberWangBG			= Color( 255, 240, 150, 255 )
SKIN.colTextEntryBG				= Color( 240, 240, 240, 255 )
SKIN.colTextEntryBorder			= Color( 255, 255, 255, 255 )
SKIN.colTextEntryText			= Color( 255, 255, 255, 255 )
SKIN.colTextEntryTextHighlight	= Color( 20, 200, 250, 255 )
SKIN.colTextEntryTextCursor		= Color( 255, 255, 255, 255 )
SKIN.colTextEntryTextPlaceholder= Color( 128, 128, 128, 255 )

SKIN.colMenuBG					= Color( 255, 255, 255, 200 )
SKIN.colMenuBorder				= Color( 0, 0, 0, 200 )

SKIN.colButtonText				= Color( 255, 255, 255, 255 )
SKIN.colButtonTextDisabled		= Color( 255, 255, 255, 100 )
SKIN.colButtonBorder			= Color( 20, 20, 20, 255 )
SKIN.colButtonBorderHighlight	= Color( 255, 255, 255, 50 )
SKIN.colButtonBorderShadow		= Color( 0, 0, 0, 100 )

SKIN.tex = {}

SKIN.tex.Selection					= GWEN.CreateTextureBorder( 384, 32, 31, 31, 4, 4, 4, 4 )

SKIN.tex.Panels = {}
SKIN.tex.Panels.Normal				= GWEN.CreateTextureBorder( 256,	0, 63, 63, 16, 16, 16, 16 )
SKIN.tex.Panels.Bright				= GWEN.CreateTextureBorder( 256+64, 0, 63, 63, 16, 16, 16, 16 )
SKIN.tex.Panels.Dark				= GWEN.CreateTextureBorder( 256,	64, 63, 63, 16, 16, 16, 16 )
SKIN.tex.Panels.Highlight			= GWEN.CreateTextureBorder( 256+64, 64, 63, 63, 16, 16, 16, 16 )

SKIN.tex.Button						= GWEN.CreateTextureBorder( 480, 0, 31, 30, 8, 8, 8, 8 )
SKIN.tex.Button_Hovered				= GWEN.CreateTextureBorder( 480, 32, 31, 30, 8, 8, 8, 8 )
SKIN.tex.Button_Dead				= GWEN.CreateTextureBorder( 480, 64, 31, 30, 8, 8, 8, 8 )
SKIN.tex.Button_Down				= GWEN.CreateTextureBorder( 480, 97, 31, 30, 8, 8, 8, 8 )

SKIN.tex.Button_DownGreen			= GWEN.CreateTextureBorder( 481, 482, 31, 30, 8, 8, 8, 8 )
SKIN.tex.Button_DownRed			    = GWEN.CreateTextureBorder( 449, 482, 31, 30, 8, 8, 8, 8 )
SKIN.tex.Button_DownYellow			= GWEN.CreateTextureBorder( 417, 482, 31, 30, 8, 8, 8, 8 )
SKIN.tex.Button_DownOrange			= GWEN.CreateTextureBorder( 385, 482, 31, 30, 8, 8, 8, 8 )


SKIN.tex.Shadow						= GWEN.CreateTextureBorder( 448, 0, 31, 31, 8, 8, 8, 8 )

SKIN.tex.Tree						= GWEN.CreateTextureBorder( 256, 128, 127, 127, 16, 16, 16, 16 )
SKIN.tex.Checkbox_Checked			= GWEN.CreateTextureNormal( 448, 32, 15, 15 )
SKIN.tex.Checkbox					= GWEN.CreateTextureNormal( 464, 32, 15, 15 )
SKIN.tex.CheckboxD_Checked			= GWEN.CreateTextureNormal( 448, 48, 15, 15 )
SKIN.tex.CheckboxD					= GWEN.CreateTextureNormal( 464, 48, 15, 15 )
SKIN.tex.RadioButton_Checked		= GWEN.CreateTextureNormal( 448, 64, 15, 15 )
SKIN.tex.RadioButton				= GWEN.CreateTextureNormal( 464, 64, 15, 15 )
SKIN.tex.RadioButtonD_Checked		= GWEN.CreateTextureNormal( 448, 80, 15, 15 )
SKIN.tex.RadioButtonD				= GWEN.CreateTextureNormal( 464, 80, 15, 15 )
SKIN.tex.TreePlus					= GWEN.CreateTextureNormal( 448, 96, 15, 15 )
SKIN.tex.TreeMinus					= GWEN.CreateTextureNormal( 464, 96, 15, 15 )
SKIN.tex.TextBox					= GWEN.CreateTextureBorder( 0, 150, 127, 21, 4, 4, 4, 4 )
SKIN.tex.TextBox_Focus				= GWEN.CreateTextureBorder( 0, 172, 127, 21, 4, 4, 4, 4 )
SKIN.tex.TextBox_Disabled			= GWEN.CreateTextureBorder( 0, 194, 127, 21, 4, 4, 4, 4 )
SKIN.tex.MenuBG_Column				= GWEN.CreateTextureBorder( 128, 128, 127, 63, 24, 8, 8, 8 )
SKIN.tex.MenuBG						= GWEN.CreateTextureBorder( 128, 192, 127, 63, 8, 8, 8, 8 )
SKIN.tex.MenuBG_Hover				= GWEN.CreateTextureBorder( 128, 256, 127, 31, 8, 8, 8, 8 )
SKIN.tex.MenuBG_Spacer				= GWEN.CreateTextureNormal( 128, 288, 127, 3 )
SKIN.tex.Menu_Strip					= GWEN.CreateTextureBorder( 0, 128, 127, 21, 8, 8, 8, 8 )
SKIN.tex.Menu_Check					= GWEN.CreateTextureNormal( 448, 112, 15, 15 )
SKIN.tex.Tab_Control				= GWEN.CreateTextureBorder( 0, 256, 127, 127, 8, 8, 8, 8 )
SKIN.tex.TabB_Active				= GWEN.CreateTextureBorder( 0,		416, 63, 31, 8, 8, 8, 8 )
SKIN.tex.TabB_Inactive				= GWEN.CreateTextureBorder( 128,	416, 63, 31, 8, 8, 8, 8 )
SKIN.tex.TabT_Active				= GWEN.CreateTextureBorder( 0,		384, 63, 31, 8, 8, 8, 8 )
SKIN.tex.TabT_Inactive				= GWEN.CreateTextureBorder( 128,	384, 63, 31, 8, 8, 8, 8 )
SKIN.tex.TabL_Active				= GWEN.CreateTextureBorder( 64,		384, 31, 63, 8, 8, 8, 8 )
SKIN.tex.TabL_Inactive				= GWEN.CreateTextureBorder( 64+128, 384, 31, 63, 8, 8, 8, 8 )
SKIN.tex.TabR_Active				= GWEN.CreateTextureBorder( 96,		384, 31, 63, 8, 8, 8, 8 )
SKIN.tex.TabR_Inactive				= GWEN.CreateTextureBorder( 96+128, 384, 31, 63, 8, 8, 8, 8 )
SKIN.tex.Tab_Bar					= GWEN.CreateTextureBorder( 128, 352, 127, 31, 4, 4, 4, 4 )

SKIN.tex.Window = {}

SKIN.tex.Window.Normal			= GWEN.CreateTextureBorder( 0, 0, 127, 127, 8, 24, 8, 8 )
SKIN.tex.Window.Inactive		= GWEN.CreateTextureBorder( 128, 0, 127, 127, 8, 24, 8, 8 )

SKIN.tex.Window.Close			= GWEN.CreateTextureNormal( 32, 452, 30, 16 )
SKIN.tex.Window.Close_Hover		= GWEN.CreateTextureNormal( 64, 452, 30, 16 )
SKIN.tex.Window.Close_Down		= GWEN.CreateTextureNormal( 96, 452, 30, 16 )

SKIN.tex.Window.Maxi			= GWEN.CreateTextureNormal( 32 + 96 * 2, 448, 31, 24 )
SKIN.tex.Window.Maxi_Hover		= GWEN.CreateTextureNormal( 64 + 96 * 2, 448, 31, 24 )
SKIN.tex.Window.Maxi_Down		= GWEN.CreateTextureNormal( 96 + 96 * 2, 448, 31, 24 )

SKIN.tex.Window.Restore			= GWEN.CreateTextureNormal( 32 + 96 * 2, 448 + 32, 31, 24 )
SKIN.tex.Window.Restore_Hover	= GWEN.CreateTextureNormal( 64 + 96 * 2, 448 + 32, 31, 24 )
SKIN.tex.Window.Restore_Down	= GWEN.CreateTextureNormal( 96 + 96 * 2, 448 + 32, 31, 24 )

SKIN.tex.Window.Mini			= GWEN.CreateTextureNormal( 32 + 96, 448, 31, 24 )
SKIN.tex.Window.Mini_Hover		= GWEN.CreateTextureNormal( 64 + 96, 448, 31, 24 )
SKIN.tex.Window.Mini_Down		= GWEN.CreateTextureNormal( 96 + 96, 448, 31, 24 )

SKIN.tex.Scroller = {}
SKIN.tex.Scroller.TrackV				= GWEN.CreateTextureBorder( 384,		208, 15, 127, 4, 4, 4, 4 )
SKIN.tex.Scroller.ButtonV_Normal		= GWEN.CreateTextureBorder( 384 + 16,	208, 15, 127, 4, 4, 4, 4 )
SKIN.tex.Scroller.ButtonV_Hover			= GWEN.CreateTextureBorder( 384 + 32,	208, 15, 127, 4, 4, 4, 4 )
SKIN.tex.Scroller.ButtonV_Down			= GWEN.CreateTextureBorder( 384 + 48,	208, 15, 127, 4, 4, 4, 4 )
SKIN.tex.Scroller.ButtonV_Disabled		= GWEN.CreateTextureBorder( 384 + 64,	208, 15, 127, 4, 4, 4, 4 )

SKIN.tex.Scroller.TrackH				= GWEN.CreateTextureBorder( 384, 128,		127, 15, 4, 4, 4, 4 )
SKIN.tex.Scroller.ButtonH_Normal		= GWEN.CreateTextureBorder( 384, 128 + 16,	127, 15, 4, 4, 4, 4 )
SKIN.tex.Scroller.ButtonH_Hover			= GWEN.CreateTextureBorder( 384, 128 + 32,	127, 15, 4, 4, 4, 4 )
SKIN.tex.Scroller.ButtonH_Down			= GWEN.CreateTextureBorder( 384, 128 + 48,	127, 15, 4, 4, 4, 4 )
SKIN.tex.Scroller.ButtonH_Disabled		= GWEN.CreateTextureBorder( 384, 128 + 64,	127, 15, 4, 4, 4, 4 )

SKIN.tex.Scroller.LeftButton_Normal		= GWEN.CreateTextureBorder( 464,		208, 15, 15, 2, 2, 2, 2 )
SKIN.tex.Scroller.LeftButton_Hover		= GWEN.CreateTextureBorder( 480,		208, 15, 15, 2, 2, 2, 2 )
SKIN.tex.Scroller.LeftButton_Down		= GWEN.CreateTextureBorder( 464,		272, 15, 15, 2, 2, 2, 2 )
SKIN.tex.Scroller.LeftButton_Disabled	= GWEN.CreateTextureBorder( 480 + 48,	272, 15, 15, 2, 2, 2, 2 )

SKIN.tex.Scroller.UpButton_Normal		= GWEN.CreateTextureBorder( 464,		208 + 16, 15, 15, 2, 2, 2, 2 )
SKIN.tex.Scroller.UpButton_Hover		= GWEN.CreateTextureBorder( 480,		208 + 16, 15, 15, 2, 2, 2, 2 )
SKIN.tex.Scroller.UpButton_Down			= GWEN.CreateTextureBorder( 464,		272 + 16, 15, 15, 2, 2, 2, 2 )
SKIN.tex.Scroller.UpButton_Disabled		= GWEN.CreateTextureBorder( 480 + 48,	272 + 16, 15, 15, 2, 2, 2, 2 )

SKIN.tex.Scroller.RightButton_Normal	= GWEN.CreateTextureBorder( 464,		208 + 32, 15, 15, 2, 2, 2, 2 )
SKIN.tex.Scroller.RightButton_Hover		= GWEN.CreateTextureBorder( 480,		208 + 32, 15, 15, 2, 2, 2, 2 )
SKIN.tex.Scroller.RightButton_Down		= GWEN.CreateTextureBorder( 464,		272 + 32, 15, 15, 2, 2, 2, 2 )
SKIN.tex.Scroller.RightButton_Disabled	= GWEN.CreateTextureBorder( 480 + 48,	272 + 32, 15, 15, 2, 2, 2, 2 )

SKIN.tex.Scroller.DownButton_Normal		= GWEN.CreateTextureBorder( 464,		208 + 48, 15, 15, 2, 2, 2, 2 )
SKIN.tex.Scroller.DownButton_Hover		= GWEN.CreateTextureBorder( 480,		208 + 48, 15, 15, 2, 2, 2, 2 )
SKIN.tex.Scroller.DownButton_Down		= GWEN.CreateTextureBorder( 464,		272 + 48, 15, 15, 2, 2, 2, 2 )
SKIN.tex.Scroller.DownButton_Disabled	= GWEN.CreateTextureBorder( 480 + 48,	272 + 48, 15, 15, 2, 2, 2, 2 )

SKIN.tex.Menu = {}
SKIN.tex.Menu.RightArrow = GWEN.CreateTextureNormal( 468, 113, 12, 12 )

SKIN.tex.Input = {}

SKIN.tex.Input.ComboBox = {}
SKIN.tex.Input.ComboBox.Normal		= GWEN.CreateTextureBorder( 384, 336,	127, 31, 8, 8, 32, 8 )
SKIN.tex.Input.ComboBox.Hover		= GWEN.CreateTextureBorder( 384, 336+32, 127, 31, 8, 8, 32, 8 )
SKIN.tex.Input.ComboBox.Down		= GWEN.CreateTextureBorder( 384, 336+64, 127, 31, 8, 8, 32, 8 )
SKIN.tex.Input.ComboBox.Disabled	= GWEN.CreateTextureBorder( 384, 336+96, 127, 31, 8, 8, 32, 8 )

SKIN.tex.Input.ComboBox.Button = {}
SKIN.tex.Input.ComboBox.Button.Normal	= GWEN.CreateTextureNormal( 496, 272, 15, 15 )
SKIN.tex.Input.ComboBox.Button.Hover	= GWEN.CreateTextureNormal( 496, 272+16, 15, 15 )
SKIN.tex.Input.ComboBox.Button.Down		= GWEN.CreateTextureNormal( 496, 272+32, 15, 15 )
SKIN.tex.Input.ComboBox.Button.Disabled	= GWEN.CreateTextureNormal( 496, 272+48, 15, 15 )

SKIN.tex.Input.UpDown = {}
SKIN.tex.Input.UpDown.Up = {}
SKIN.tex.Input.UpDown.Up.Normal		= GWEN.CreateTextureCentered( 384,		112, 7, 7 )
SKIN.tex.Input.UpDown.Up.Hover		= GWEN.CreateTextureCentered( 384+8,	112, 7, 7 )
SKIN.tex.Input.UpDown.Up.Down		= GWEN.CreateTextureCentered( 384+16,	112, 7, 7 )
SKIN.tex.Input.UpDown.Up.Disabled	= GWEN.CreateTextureCentered( 384+24,	112, 7, 7 )

SKIN.tex.Input.UpDown.Down = {}
SKIN.tex.Input.UpDown.Down.Normal	= GWEN.CreateTextureCentered( 384,		120, 7, 7 )
SKIN.tex.Input.UpDown.Down.Hover	= GWEN.CreateTextureCentered( 384+8,	120, 7, 7 )
SKIN.tex.Input.UpDown.Down.Down		= GWEN.CreateTextureCentered( 384+16,	120, 7, 7 )
SKIN.tex.Input.UpDown.Down.Disabled	= GWEN.CreateTextureCentered( 384+24,	120, 7, 7 )

SKIN.tex.Input.Slider = {}
SKIN.tex.Input.Slider.H = {}
SKIN.tex.Input.Slider.H.Normal		= GWEN.CreateTextureNormal( 416, 32,	15, 15 )
SKIN.tex.Input.Slider.H.Hover		= GWEN.CreateTextureNormal( 416, 32+16, 15, 15 )
SKIN.tex.Input.Slider.H.Down		= GWEN.CreateTextureNormal( 416, 32+32, 15, 15 )
SKIN.tex.Input.Slider.H.Disabled	= GWEN.CreateTextureNormal( 416, 32+48, 15, 15 )

SKIN.tex.Input.Slider.V = {}
SKIN.tex.Input.Slider.V.Normal		= GWEN.CreateTextureNormal( 416+16, 32, 15, 15 )
SKIN.tex.Input.Slider.V.Hover		= GWEN.CreateTextureNormal( 416+16, 32+16, 15, 15 )
SKIN.tex.Input.Slider.V.Down		= GWEN.CreateTextureNormal( 416+16, 32+32, 15, 15 )
SKIN.tex.Input.Slider.V.Disabled	= GWEN.CreateTextureNormal( 416+16, 32+48, 15, 15 )

SKIN.tex.Input.ListBox = {}
SKIN.tex.Input.ListBox.Background		= GWEN.CreateTextureBorder( 256, 256, 63, 127, 8, 8, 8, 8 )
SKIN.tex.Input.ListBox.Hovered			= GWEN.CreateTextureBorder( 320, 320, 31, 31, 8, 8, 8, 8 )
SKIN.tex.Input.ListBox.EvenLine			= GWEN.CreateTextureBorder( 352, 256, 31, 31, 8, 8, 8, 8 )
SKIN.tex.Input.ListBox.OddLine			= GWEN.CreateTextureBorder( 352, 288, 31, 31, 8, 8, 8, 8 )
SKIN.tex.Input.ListBox.EvenLineSelected	= GWEN.CreateTextureBorder( 320, 256, 31, 31, 8, 8, 8, 8 )
SKIN.tex.Input.ListBox.OddLineSelected	= GWEN.CreateTextureBorder( 320, 288, 31, 31, 8, 8, 8, 8 )

SKIN.tex.ProgressBar = {}
SKIN.tex.ProgressBar.Back	= GWEN.CreateTextureBorder( 384,	0, 31, 31, 8, 8, 8, 8 )
SKIN.tex.ProgressBar.Front	= GWEN.CreateTextureBorder( 384+32, 0, 31, 31, 8, 8, 8, 8 )

SKIN.tex.CategoryList = {}
SKIN.tex.CategoryList.Outer		= GWEN.CreateTextureBorder( 256, 384, 63, 63, 8, 8, 8, 8 )
SKIN.tex.CategoryList.Inner		= GWEN.CreateTextureBorder( 320, 384, 63, 63, 8, 21, 8, 8 )
SKIN.tex.CategoryList.Header	= GWEN.CreateTextureBorder( 320, 352, 63, 31, 8, 8, 8, 8 )

SKIN.tex.Tooltip = GWEN.CreateTextureBorder( 384, 64, 31, 31, 8, 8, 8, 8 )

SKIN.Colours = {}

SKIN.Colours.Window = {}
SKIN.Colours.Window.TitleActive		= GWEN.TextureColor( 4 + 8 * 0, 508 )
SKIN.Colours.Window.TitleInactive	= GWEN.TextureColor( 4 + 8 * 1, 508 )

SKIN.Colours.Button = {}
SKIN.Colours.Button.Normal			= GWEN.TextureColor( 4 + 8 * 2, 508 )
SKIN.Colours.Button.Hover			= GWEN.TextureColor( 4 + 8 * 3, 508 )
SKIN.Colours.Button.Down			= GWEN.TextureColor( 4 + 8 * 2, 500 )
SKIN.Colours.Button.Disabled		= GWEN.TextureColor( 4 + 8 * 3, 500 )

SKIN.Colours.Tab = {}
SKIN.Colours.Tab.Active = {}
SKIN.Colours.Tab.Active.Normal		= GWEN.TextureColor( 4 + 8 * 4, 508 )
SKIN.Colours.Tab.Active.Hover		= GWEN.TextureColor( 4 + 8 * 5, 508 )
SKIN.Colours.Tab.Active.Down		= GWEN.TextureColor( 4 + 8 * 4, 500 )
SKIN.Colours.Tab.Active.Disabled	= GWEN.TextureColor( 4 + 8 * 5, 500 )

SKIN.Colours.Tab.Inactive = {}
SKIN.Colours.Tab.Inactive.Normal	= GWEN.TextureColor( 4 + 8 * 6, 508 )
SKIN.Colours.Tab.Inactive.Hover		= GWEN.TextureColor( 4 + 8 * 7, 508 )
SKIN.Colours.Tab.Inactive.Down		= GWEN.TextureColor( 4 + 8 * 6, 500 )
SKIN.Colours.Tab.Inactive.Disabled	= GWEN.TextureColor( 4 + 8 * 7, 500 )

SKIN.Colours.Label = {}
SKIN.Colours.Label.Default			= GWEN.TextureColor( 4 + 8 * 8, 508 )
SKIN.Colours.Label.Bright			= GWEN.TextureColor( 4 + 8 * 9, 508 )
SKIN.Colours.Label.Dark				= GWEN.TextureColor( 4 + 8 * 8, 500 )
SKIN.Colours.Label.Highlight		= GWEN.TextureColor( 4 + 8 * 9, 500 )

SKIN.Colours.Tree = {}
SKIN.Colours.Tree.Lines				= GWEN.TextureColor( 4 + 8 * 10, 508 ) ---- !!!
SKIN.Colours.Tree.Normal			= GWEN.TextureColor( 4 + 8 * 11, 508 )
SKIN.Colours.Tree.Hover				= GWEN.TextureColor( 4 + 8 * 10, 500 )
SKIN.Colours.Tree.Selected			= GWEN.TextureColor( 4 + 8 * 11, 500 )

SKIN.Colours.Properties = {}
SKIN.Colours.Properties.Line_Normal			= GWEN.TextureColor( 4 + 8 * 12, 508 )
SKIN.Colours.Properties.Line_Selected		= GWEN.TextureColor( 4 + 8 * 13, 508 )
SKIN.Colours.Properties.Line_Hover			= GWEN.TextureColor( 4 + 8 * 12, 500 )
SKIN.Colours.Properties.Title				= GWEN.TextureColor( 4 + 8 * 13, 500 )
SKIN.Colours.Properties.Column_Normal		= GWEN.TextureColor( 4 + 8 * 14, 508 )
SKIN.Colours.Properties.Column_Selected		= GWEN.TextureColor( 4 + 8 * 15, 508 )
SKIN.Colours.Properties.Column_Hover		= GWEN.TextureColor( 4 + 8 * 14, 500 )
SKIN.Colours.Properties.Border				= GWEN.TextureColor( 4 + 8 * 15, 500 )
SKIN.Colours.Properties.Label_Normal		= GWEN.TextureColor( 4 + 8 * 16, 508 )
SKIN.Colours.Properties.Label_Selected		= GWEN.TextureColor( 4 + 8 * 17, 508 )
SKIN.Colours.Properties.Label_Hover			= GWEN.TextureColor( 4 + 8 * 16, 500 )

SKIN.Colours.Category = {}
SKIN.Colours.Category.Header				= GWEN.TextureColor( 4 + 8 * 18, 500 )
SKIN.Colours.Category.Header_Closed			= GWEN.TextureColor( 4 + 8 * 19, 500 )
SKIN.Colours.Category.Line = {}
SKIN.Colours.Category.Line.Text				= GWEN.TextureColor( 4 + 8 * 20, 508 )
SKIN.Colours.Category.Line.Text_Hover		= GWEN.TextureColor( 4 + 8 * 21, 508 )
SKIN.Colours.Category.Line.Text_Selected	= GWEN.TextureColor( 4 + 8 * 20, 500 )
SKIN.Colours.Category.Line.Button			= GWEN.TextureColor( 4 + 8 * 21, 500 )
SKIN.Colours.Category.Line.Button_Hover		= GWEN.TextureColor( 4 + 8 * 22, 508 )
SKIN.Colours.Category.Line.Button_Selected	= GWEN.TextureColor( 4 + 8 * 23, 508 )
SKIN.Colours.Category.LineAlt = {}
SKIN.Colours.Category.LineAlt.Text				= GWEN.TextureColor( 4 + 8 * 22, 500 )
SKIN.Colours.Category.LineAlt.Text_Hover		= GWEN.TextureColor( 4 + 8 * 23, 500 )
SKIN.Colours.Category.LineAlt.Text_Selected		= GWEN.TextureColor( 4 + 8 * 24, 508 )
SKIN.Colours.Category.LineAlt.Button			= GWEN.TextureColor( 4 + 8 * 25, 508 )
SKIN.Colours.Category.LineAlt.Button_Hover		= GWEN.TextureColor( 4 + 8 * 24, 500 )
SKIN.Colours.Category.LineAlt.Button_Selected	= GWEN.TextureColor( 4 + 8 * 25, 500 )

SKIN.Colours.TooltipText = GWEN.TextureColor( 4 + 8 * 26, 500 )

--[[---------------------------------------------------------
	Panel
-----------------------------------------------------------]]
function SKIN:PaintPanel( panel, w, h )

	if ( !panel.m_bBackground ) then return end
	self.tex.Panels.Normal( 0, 0, w, h, panel.m_bgColor )

end

--[[---------------------------------------------------------
	Panel
-----------------------------------------------------------]]
function SKIN:PaintShadow( panel, w, h )

	SKIN.tex.Shadow( 0, 0, w, h )

end

--[[---------------------------------------------------------
	Frame
-----------------------------------------------------------]]
function SKIN:PaintFrame( panel, w, h )

	if ( panel.m_bPaintShadow ) then

		DisableClipping( true )
		SKIN.tex.Shadow( -4, -4, w+10, h+10 )	
		DisableClipping( false )

	end

	self.tex.Window.Normal( 0, 0, w, h )

end

--[[---------------------------------------------------------
	Button
-----------------------------------------------------------]]
function SKIN:PaintButton( panel, w, h )

	if ( !panel.m_bBackground ) then return end

	if ( panel.Depressed || panel:IsSelected() || panel:GetToggle() ) then
		if (panel.Red) then return self.tex.Button_DownRed(0, 0, w, h) end
		if (panel.Green) then return self.tex.Button_DownGreen(0, 0, w, h) end
		if (panel.Gold) then return self.tex.Button_DownGold(0, 0, w, h) end
		if (panel.Orange) then return self.tex.Button_DownOrange(0, 0, w, h) end

		return self.tex.Button_Down( 0, 0, w, h )
	end

	if ( panel:GetDisabled() ) then
		return self.tex.Button_Dead( 0, 0, w, h )
	end

	if ( panel.Hovered ) then
		return self.tex.Button_Hovered( 0, 0, w, h )
	end

	self.tex.Button( 0, 0, w, h )

end

--[[---------------------------------------------------------
	Tree
-----------------------------------------------------------]]
function SKIN:PaintTree( panel, w, h )

	if ( !panel.m_bBackground ) then return end

	self.tex.Tree( 0, 0, w, h, panel.m_bgColor )

end

--[[---------------------------------------------------------
	CheckBox
-----------------------------------------------------------]]
function SKIN:PaintCheckBox( panel, w, h )

	if ( panel:GetChecked() ) then

		if ( panel:GetDisabled() ) then
			self.tex.CheckboxD_Checked( 0, 0, w, h )
		else
			self.tex.Checkbox_Checked( 0, 0, w, h )
		end

	else

		if ( panel:GetDisabled() ) then
			self.tex.CheckboxD( 0, 0, w, h )
		else
			self.tex.Checkbox( 0, 0, w, h )
		end

	end

end

--[[---------------------------------------------------------
	ExpandButton
-----------------------------------------------------------]]
function SKIN:PaintExpandButton( panel, w, h )

	if ( !panel:GetExpanded() ) then
		self.tex.TreePlus( 0, 0, w, h )
	else
		self.tex.TreeMinus( 0, 0, w, h )
	end

end

--[[---------------------------------------------------------
	TextEntry
-----------------------------------------------------------]]
function SKIN:PaintTextEntry( panel, w, h )

	if ( panel.m_bBackground ) then

		if ( panel:GetDisabled() ) then
			self.tex.TextBox_Disabled( 0, 0, w, h )
		elseif ( panel:HasFocus() ) then
			self.tex.TextBox_Focus( 0, 0, w, h )
		else
			self.tex.TextBox( 0, 0, w, h )
		end

	end

	-- Hack on a hack, but this produces the most close appearance to what it will actually look if text was actually there
	if ( panel.GetPlaceholderText && panel.GetPlaceholderColor && panel:GetPlaceholderText() && panel:GetPlaceholderText():Trim() != "" && panel:GetPlaceholderColor() && ( !panel:GetText() || panel:GetText() == "" ) ) then

		local oldText = panel:GetText()

		local str = panel:GetPlaceholderText()
		if ( str:StartWith( "#" ) ) then str = str:sub( 2 ) end
		str = language.GetPhrase( str )

		panel:SetText( str )
		panel:DrawTextEntryText( panel:GetPlaceholderColor(), panel:GetHighlightColor(), panel:GetCursorColor() )
		panel:SetText( oldText )

		return
	end

	panel:DrawTextEntryText( panel:GetTextColor(), panel:GetHighlightColor(), panel:GetCursorColor() )

end

--[[---------------------------------------------------------
	Menu
-----------------------------------------------------------]]
function SKIN:PaintMenu( panel, w, h )

	if ( panel:GetDrawColumn() ) then
		self.tex.MenuBG_Column( 0, 0, w, h )
	else
		self.tex.MenuBG( 0, 0, w, h )
	end

end

--[[---------------------------------------------------------
	Menu
-----------------------------------------------------------]]
function SKIN:PaintMenuSpacer( panel, w, h )

	surface.SetDrawColor( MenuColors.Border )
	surface.DrawRect( 0, 0, w, h )

end

--[[---------------------------------------------------------
	MenuOption
-----------------------------------------------------------]]
function SKIN:PaintMenuOption( panel, w, h )

	if ( panel.m_bBackground && (panel.Hovered || panel.Highlight) ) then
		self.tex.MenuBG_Hover( -1, 0, w + 2, h )
	end

	if ( panel:GetChecked() ) then
		self.tex.Menu_Check( 5, h/2-7, 15, 15 )
	end

end

--[[---------------------------------------------------------
	MenuRightArrow
-----------------------------------------------------------]]
function SKIN:PaintMenuRightArrow( panel, w, h )

	self.tex.Menu.RightArrow( 0, 0, w, h )

end

--[[---------------------------------------------------------
	PropertySheet
-----------------------------------------------------------]]
function SKIN:PaintPropertySheet( panel, w, h )

	-- TODO: Tabs at bottom, left, right

	local ActiveTab = panel:GetActiveTab()
	local Offset = 0
	if ( ActiveTab ) then Offset = ActiveTab:GetTall() - 8 end

	self.tex.Tab_Control( 0, Offset, w, h-Offset )

end

--[[---------------------------------------------------------
	Tab
-----------------------------------------------------------]]
function SKIN:PaintTab( panel, w, h )

	if ( panel:IsActive() ) then
		return self:PaintActiveTab( panel, w, h )
	end

	self.tex.TabT_Inactive( 0, 0, w, h )

end

function SKIN:PaintActiveTab( panel, w, h )

	self.tex.TabT_Active( 0, 0, w, h )

end

--[[---------------------------------------------------------
	Button
-----------------------------------------------------------]]
function SKIN:PaintWindowCloseButton( panel, w, h )

	if ( !panel.m_bBackground ) then return end

	if ( panel:GetDisabled() ) then
		return self.tex.Window.Close( 1, 4, 30, 16, Color( 255, 255, 255, 50 ) )
	end

	if ( panel.Depressed || panel:IsSelected() ) then
		return self.tex.Window.Close_Down( 1, 4, 30, 16 )
	end

	if ( panel.Hovered ) then
		return self.tex.Window.Close_Hover( 1, 4, 30, 16 )
	end

	self.tex.Window.Close( 1, 4, 30, 16 )

end

function SKIN:PaintWindowMinimizeButton( panel, w, h )

	if ( !panel.m_bBackground ) then return end

	if ( panel:GetDisabled() ) then
		return self.tex.Window.Mini( 0, 0, w, h, Color( 255, 255, 255, 50 ) )
	end

	if ( panel.Depressed || panel:IsSelected() ) then
		return self.tex.Window.Mini_Down( 0, 0, w, h )
	end

	if ( panel.Hovered ) then
		return self.tex.Window.Mini_Hover( 0, 0, w, h )
	end

	self.tex.Window.Mini( 0, 0, w, h )

end

function SKIN:PaintWindowMaximizeButton( panel, w, h )

	if ( !panel.m_bBackground ) then return end

	if ( panel:GetDisabled() ) then
		return self.tex.Window.Maxi( 0, 0, w, h, Color( 255, 255, 255, 50 ) )
	end

	if ( panel.Depressed || panel:IsSelected() ) then
		return self.tex.Window.Maxi_Down( 0, 0, w, h )
	end

	if ( panel.Hovered ) then
		return self.tex.Window.Maxi_Hover( 0, 0, w, h )
	end

	self.tex.Window.Maxi( 0, 0, w, h )

end

--[[---------------------------------------------------------
	VScrollBar
-----------------------------------------------------------]]
function SKIN:PaintVScrollBar( panel, w, h )

	self.tex.Scroller.TrackV( 0, 0, w, h )

end

--[[---------------------------------------------------------
	ScrollBarGrip
-----------------------------------------------------------]]
function SKIN:PaintScrollBarGrip( panel, w, h )

	if ( panel:GetDisabled() ) then
		return self.tex.Scroller.ButtonV_Disabled( 0, 0, w, h )
	end

	if ( panel.Depressed ) then
		return self.tex.Scroller.ButtonV_Down( 0, 0, w, h )
	end

	if ( panel:IsHovered() ) then
		return self.tex.Scroller.ButtonV_Hover( 0, 0, w, h )
	end

	return self.tex.Scroller.ButtonV_Normal( 0, 0, w, h )

end

--[[---------------------------------------------------------
	ButtonDown
-----------------------------------------------------------]]
function SKIN:PaintButtonDown( panel, w, h )

	if ( !panel.m_bBackground ) then return end

	if ( panel.Depressed || panel:IsSelected() ) then
		return self.tex.Scroller.DownButton_Down( 0, 0, w, h )
	end

	if ( panel:GetDisabled() ) then
		return self.tex.Scroller.DownButton_Dead( 0, 0, w, h )
	end

	if ( panel.Hovered ) then
		return self.tex.Scroller.DownButton_Hover( 0, 0, w, h )
	end

	self.tex.Scroller.DownButton_Normal( 0, 0, w, h )

end

--[[---------------------------------------------------------
	ButtonUp
-----------------------------------------------------------]]
function SKIN:PaintButtonUp( panel, w, h )

	if ( !panel.m_bBackground ) then return end

	if ( panel.Depressed || panel:IsSelected() ) then
		return self.tex.Scroller.UpButton_Down( 0, 0, w, h )
	end

	if ( panel:GetDisabled() ) then
		return self.tex.Scroller.UpButton_Dead( 0, 0, w, h )
	end

	if ( panel.Hovered ) then
		return self.tex.Scroller.UpButton_Hover( 0, 0, w, h )
	end

	self.tex.Scroller.UpButton_Normal( 0, 0, w, h )

end

--[[---------------------------------------------------------
	ButtonLeft
-----------------------------------------------------------]]
function SKIN:PaintButtonLeft( panel, w, h )

	if ( !panel.m_bBackground ) then return end

	if ( panel.Depressed || panel:IsSelected() ) then
		return self.tex.Scroller.LeftButton_Down( 0, 0, w, h )
	end

	if ( panel:GetDisabled() ) then
		return self.tex.Scroller.LeftButton_Dead( 0, 0, w, h )
	end

	if ( panel.Hovered ) then
		return self.tex.Scroller.LeftButton_Hover( 0, 0, w, h )
	end

	self.tex.Scroller.LeftButton_Normal( 0, 0, w, h )

end

--[[---------------------------------------------------------
	ButtonRight
-----------------------------------------------------------]]
function SKIN:PaintButtonRight( panel, w, h )

	if ( !panel.m_bBackground ) then return end

	if ( panel.Depressed || panel:IsSelected() ) then
		return self.tex.Scroller.RightButton_Down( 0, 0, w, h )
	end

	if ( panel:GetDisabled() ) then
		return self.tex.Scroller.RightButton_Dead( 0, 0, w, h )
	end

	if ( panel.Hovered ) then
		return self.tex.Scroller.RightButton_Hover( 0, 0, w, h )
	end

	self.tex.Scroller.RightButton_Normal( 0, 0, w, h )

end

--[[---------------------------------------------------------
	ComboDownArrow
-----------------------------------------------------------]]
function SKIN:PaintComboDownArrow( panel, w, h )

	if ( panel.ComboBox:GetDisabled() ) then
		return self.tex.Input.ComboBox.Button.Disabled( 0, 0, w, h )
	end

	if ( panel.ComboBox.Depressed || panel.ComboBox:IsMenuOpen() ) then
		return self.tex.Input.ComboBox.Button.Down( 0, 0, w, h )
	end

	if ( panel.ComboBox.Hovered ) then
		return self.tex.Input.ComboBox.Button.Hover( 0, 0, w, h )
	end

	self.tex.Input.ComboBox.Button.Normal( 0, 0, w, h )

end

--[[---------------------------------------------------------
	ComboBox
-----------------------------------------------------------]]
function SKIN:PaintComboBox( panel, w, h )

	if ( panel:GetDisabled() ) then
		return self.tex.Input.ComboBox.Disabled( 0, 0, w, h )
	end

	if ( panel.Depressed || panel:IsMenuOpen() ) then
		return self.tex.Input.ComboBox.Down( 0, 0, w, h )
	end

	if ( panel.Hovered ) then
		return self.tex.Input.ComboBox.Hover( 0, 0, w, h )
	end

	self.tex.Input.ComboBox.Normal( 0, 0, w, h )

end

--[[---------------------------------------------------------
	ComboBox
-----------------------------------------------------------]]
function SKIN:PaintListBox( panel, w, h )

	self.tex.Input.ListBox.Background( 0, 0, w, h )

end

--[[---------------------------------------------------------
	NumberUp
-----------------------------------------------------------]]
function SKIN:PaintNumberUp( panel, w, h )

	if ( panel:GetDisabled() ) then
		return self.tex.Input.UpDown.Up.Disabled( 0, 0, w, h )
	end

	if ( panel.Depressed ) then
		return self.tex.Input.UpDown.Up.Down( 0, 0, w, h )
	end

	if ( panel.Hovered ) then
		return self.tex.Input.UpDown.Up.Hover( 0, 0, w, h )
	end

	self.tex.Input.UpDown.Up.Normal( 0, 0, w, h )

end

--[[---------------------------------------------------------
	NumberDown
-----------------------------------------------------------]]
function SKIN:PaintNumberDown( panel, w, h )

	if ( panel:GetDisabled() ) then
		return self.tex.Input.UpDown.Down.Disabled( 0, 0, w, h )
	end

	if ( panel.Depressed ) then
		return self.tex.Input.UpDown.Down.Down( 0, 0, w, h )
	end

	if ( panel.Hovered ) then
		return self.tex.Input.UpDown.Down.Hover( 0, 0, w, h )
	end

	self.tex.Input.UpDown.Down.Normal( 0, 0, w, h )

end

function SKIN:PaintTreeNode( panel, w, h )

	if ( !panel.m_bDrawLines ) then return end

	surface.SetDrawColor( self.Colours.Tree.Lines )

	if ( panel.m_bLastChild ) then

		surface.DrawRect( 9, 0, 1, 7 )
		surface.DrawRect( 9, 7, 9, 1 )

	else
		surface.DrawRect( 9, 0, 1, h )
		surface.DrawRect( 9, 7, 9, 1 )
	end

end

function SKIN:PaintTreeNodeButton( panel, w, h )

	if ( !panel.m_bSelected ) then return end

	-- Don't worry this isn't working out the size every render
	-- it just gets the cached value from inside the Label
	local w, _ = panel:GetTextSize()

	self.tex.Selection( 38, 0, w + 6, h )

end

function SKIN:PaintSelection( panel, w, h )

	self.tex.Selection( 0, 0, w, h )

end

function SKIN:PaintSliderKnob( panel, w, h )

	if ( panel:GetDisabled() ) then	return self.tex.Input.Slider.H.Disabled( 0, 0, w, h ) end

	if ( panel.Depressed ) then
		return self.tex.Input.Slider.H.Down( 0, 0, w, h )
	end

	if ( panel.Hovered ) then
		return self.tex.Input.Slider.H.Hover( 0, 0, w, h )
	end

	self.tex.Input.Slider.H.Normal( 0, 0, w, h )

end

local function PaintNotches( x, y, w, h, num )

	if ( !num ) then return end

	local space = w / num

	for i=0, num do

		surface.DrawRect( x + i * space, y + 4, 1, 5 )

	end

end

function SKIN:PaintNumSlider( panel, w, h )

	surface.SetDrawColor( Color( 114, 118, 125, 255 ) )
	surface.DrawRect( 8, h / 2 - 1, w - 15, 1 )

	PaintNotches( 8, h / 2 - 1, w - 16, 1, panel.m_iNotches )

end

function SKIN:PaintProgress( panel, w, h )

	self.tex.ProgressBar.Back( 0, 0, w, h )
	self.tex.ProgressBar.Front( 0, 0, w * panel:GetFraction(), h )

end

function SKIN:PaintCollapsibleCategory( panel, w, h )

	if ( h < 21 ) then
		return self.tex.CategoryList.Header( 0, 0, w, h )
	end

	self.tex.CategoryList.Inner( 0, 0, w, 63 )

end

function SKIN:PaintCategoryList( panel, w, h )

	self.tex.CategoryList.Outer( 0, 0, w, h )

end

function SKIN:PaintCategoryButton( panel, w, h )

	if ( panel.AltLine ) then

		if ( panel.Depressed || panel.m_bSelected ) then surface.SetDrawColor( self.Colours.Category.LineAlt.Button_Selected )
		elseif ( panel.Hovered ) then surface.SetDrawColor( self.Colours.Category.LineAlt.Button_Hover )
		else surface.SetDrawColor( self.Colours.Category.LineAlt.Button ) end

	else

		if ( panel.Depressed || panel.m_bSelected ) then surface.SetDrawColor( self.Colours.Category.Line.Button_Selected )
		elseif ( panel.Hovered ) then surface.SetDrawColor( self.Colours.Category.Line.Button_Hover )
		else surface.SetDrawColor( self.Colours.Category.Line.Button ) end

	end

	surface.DrawRect( 0, 0, w, h )

end

function SKIN:PaintListViewLine( panel, w, h )

	if ( panel:IsSelected() ) then

		self.tex.Input.ListBox.EvenLineSelected( 0, 0, w, h )

	elseif ( panel.Hovered ) then

		self.tex.Input.ListBox.Hovered( 0, 0, w, h )

	elseif ( panel.m_bAlt ) then

		self.tex.Input.ListBox.EvenLine( 0, 0, w, h )

	end

end

function SKIN:PaintListView( panel, w, h )

	if ( !panel.m_bBackground ) then return end

	self.tex.Input.ListBox.Background( 0, 0, w, h )

end

function SKIN:PaintTooltip( panel, w, h )

	self.tex.Tooltip( 0, 0, w, h )

end

function SKIN:PaintMenuBar( panel, w, h )

	self.tex.Menu_Strip( 0, 0, w, h )

end

derma.DefineSkin( dtype, "Made to look like regular VGUI", SKIN )


--[[-------------------------------------------------------------------------
DMenu Overwrite
---------------------------------------------------------------------------]]


local PANEL = {}
AccessorFunc(PANEL, "m_bBorder", "DrawBorder")
AccessorFunc(PANEL, "m_bDeleteSelf", "DeleteSelf")
AccessorFunc(PANEL, "m_iMinimumWidth", "MinimumWidth")
AccessorFunc(PANEL, "m_bDrawColumn", "DrawColumn")
AccessorFunc(PANEL, "m_iMaxHeight", "MaxHeight")
AccessorFunc(PANEL, "m_pOpenSubMenu", "OpenSubMenu")

function PANEL:Init()
    self:SetIsMenu(true)
    self:SetDrawBorder(true)
    self:SetPaintBackground(true)
    self:SetMinimumWidth(170)
    self:SetDrawOnTop(true)
    self:SetMaxHeight(ScrH() * 0.9)
    self:SetDeleteSelf(true)
    self:SetPadding(0)
    -- Automatically remove this panel when menus are to be closed
    RegisterDermaMenuForClose(self)
end

function PANEL:AddPanel(pnl)
    self:AddItem(pnl)
    pnl.ParentMenu = self
end

function PANEL:AddOption(strText, funcFunction)
    local pnl = vgui.Create("DMenuOption", self)
    pnl:SetMenu(self)
    pnl:SetText(strText)

    if (funcFunction) then
        pnl.DoClick = funcFunction
    end

    self:AddPanel(pnl)

    return pnl
end

function PANEL:AddCVar(strText, convar, on, off, funcFunction)
    local pnl = vgui.Create("DMenuOptionCVar", self)
    pnl:SetMenu(self)
    pnl:SetText(strText)

    if (funcFunction) then
        pnl.DoClick = funcFunction
    end

    pnl:SetConVar(convar)
    pnl:SetValueOn(on)
    pnl:SetValueOff(off)
    self:AddPanel(pnl)

    return pnl
end

function PANEL:AddSpacer(strText, funcFunction)
    local pnl = vgui.Create("DPanel", self)

    pnl.Paint = function(p, w, h)
        derma.SkinHook("Paint", "MenuSpacer", p, w, h)
    end

    pnl:SetTall(1)
    self:AddPanel(pnl)

    return pnl
end

function PANEL:AddSubMenu(strText, funcFunction)
    local pnl = vgui.Create("DMenuOption", self)
    local SubMenu = pnl:AddSubMenu(strText, funcFunction)
    pnl:SetText(strText)

    if (funcFunction) then
        pnl.DoClick = funcFunction
    end

    self:AddPanel(pnl)

    return SubMenu, pnl
end

function PANEL:Hide()
    local openmenu = self:GetOpenSubMenu()

    if (openmenu) then
        openmenu:Hide()
    end

    self:SetVisible(false)
    self:SetOpenSubMenu(nil)
end

function PANEL:OpenSubMenu(item, menu)
    -- Do we already have a menu open?
    local openmenu = self:GetOpenSubMenu()

    if (IsValid(openmenu) and openmenu:IsVisible()) then
        -- Don't open it again!
        if (menu and openmenu == menu) then return end
        -- Close it!
        self:CloseSubMenu(openmenu)
    end

    if (not IsValid(menu)) then return end
    local x, y = item:LocalToScreen(self:GetWide(), 0)
    menu:Open(x - 3, y, false, item)
    self:SetOpenSubMenu(menu)
end

function PANEL:CloseSubMenu(menu)
    menu:Hide()
    self:SetOpenSubMenu(nil)
end

function PANEL:Paint(w, h)
    if (not self:GetPaintBackground()) then return end
    derma.SkinHook("Paint", "Menu", self, w, h)

    return true
end

function PANEL:ChildCount()
    return #self:GetCanvas():GetChildren()
end

function PANEL:GetChild(num)
    return self:GetCanvas():GetChildren()[num]
end

function PANEL:PerformLayout()
    local w = self:GetMinimumWidth()

    -- Find the widest one
    for k, pnl in pairs(self:GetCanvas():GetChildren()) do
        pnl:PerformLayout()
        w = math.max(w, pnl:GetWide())
    end

    self:SetWide(w)
    local y = 0 -- for padding

    for k, pnl in pairs(self:GetCanvas():GetChildren()) do
        pnl:SetWide(w)
        pnl:SetPos(0, y)
        pnl:InvalidateLayout(true)
        y = y + pnl:GetTall()
    end

    y = math.min(y, self:GetMaxHeight())
    self:SetTall(y)
    derma.SkinHook("Layout", "Menu", self)
    DScrollPanel.PerformLayout(self)
end

--[[---------------------------------------------------------
	Open - Opens the menu.
	x and y are optional, if they're not provided the menu
		will appear at the cursor.
-----------------------------------------------------------]]
function PANEL:Open(x, y, skipanimation, ownerpanel)
    RegisterDermaMenuForClose(self)
    local maunal = x and y
    x = x or gui.MouseX()
    y = y or gui.MouseY()
    local OwnerHeight = 0
    local OwnerWidth = 0

    if (ownerpanel) then
        OwnerWidth, OwnerHeight = ownerpanel:GetSize()
    end

    self:PerformLayout()
    local w = self:GetWide()
    local h = self:GetTall()
    self:SetSize(w, h)

    if (y + h > ScrH()) then
        y = ((maunal and ScrH()) or (y + OwnerHeight)) - h
    end

    if (x + w > ScrW()) then
        x = ((maunal and ScrW()) or x) - w
    end

    if (y < 1) then
        y = 1
    end

    if (x < 1) then
        x = 1
    end

    self:SetPos(x, y)
    -- Popup!
    self:MakePopup()
    -- Make sure it's visible!
    self:SetVisible(true)
    -- Keep the mouse active while the menu is visible.
    self:SetKeyboardInputEnabled(false)
end

--
-- Called by DMenuOption
--
function PANEL:OptionSelectedInternal(option)
    self:OptionSelected(option, option:GetText())
end

function PANEL:OptionSelected(option, text)
    -- For override
end

function PANEL:ClearHighlights()
    for k, pnl in pairs(self:GetCanvas():GetChildren()) do
        pnl.Highlight = nil
    end
end

function PANEL:HighlightItem(item)
    for k, pnl in pairs(self:GetCanvas():GetChildren()) do
        if (pnl == item) then
            pnl.Highlight = true
        end
    end
end

function PANEL:GenerateExample(ClassName, PropertySheet, Width, Height)
    local MenuItemSelected = function()
        Derma_Message("Choosing a menu item worked!")
    end

    local ctrl = vgui.Create("Button")
    ctrl:SetText("Test Me!")

    ctrl.DoClick = function()
        local menu = DermaMenu()
        menu:AddOption("Option One", MenuItemSelected)
        menu:AddOption("Option 2", MenuItemSelected)
        local submenu = menu:AddSubMenu("Option Free")
        submenu:AddOption("Submenu 1", MenuItemSelected)
        submenu:AddOption("Submenu 2", MenuItemSelected)
        menu:AddOption("Option For", MenuItemSelected)
        menu:Open()
    end

    PropertySheet:AddSheet(ClassName, ctrl, nil, true, true)
end

derma.DefineControl("DMenu", "A Menu", PANEL, "DScrollPanel")


--[[-------------------------------------------------------------------------
DMenuOption Overwrite
---------------------------------------------------------------------------]]


local PANEL = {}

AccessorFunc( PANEL, "m_pMenu", "Menu" )
AccessorFunc( PANEL, "m_bChecked", "Checked" )
AccessorFunc( PANEL, "m_bCheckable", "IsCheckable" )

function PANEL:Init()

	self:SetContentAlignment( 4 )
	self:SetTextInset( 30, 0 )
	self:SetTextColor(MenuColors.Text)
	self:SetChecked( false )
	self:SetFont("moat_MenuFont")

end

function PANEL:SetSubMenu( menu )

	self.SubMenu = menu

	if ( !self.SubMenuArrow ) then

		self.SubMenuArrow = vgui.Create( "DPanel", self )
		self.SubMenuArrow.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "MenuRightArrow", panel, w, h ) end

	end

end

function PANEL:AddSubMenu()

	local SubMenu = DermaMenu( self )
	SubMenu:SetVisible( false )
	SubMenu:SetParent( self )

	self:SetSubMenu( SubMenu )

	return SubMenu

end

function PANEL:OnCursorEntered()
	if (GetConVar "moat_ui_sounds" and GetConVar "moat_ui_sounds":GetInt() and GetConVar "moat_ui_sounds":GetInt() > 0) then
		LocalPlayer():EmitSound "moatsounds/pop1.wav"
	end

	self:SetTextColor(MenuColors.TextHover)

	if ( IsValid( self.ParentMenu ) ) then
		self.ParentMenu:OpenSubMenu( self, self.SubMenu )
		return
	end

	local p = self:GetParent()
	if (IsValid(p) and p.OpenSubMenu) then
		p:OpenSubMenu(self, self.SubMenu)
	end
end

function PANEL:OnCursorExited()
	self:SetTextColor(MenuColors.Text)
end

function PANEL:Paint( w, h )

	derma.SkinHook( "Paint", "MenuOption", self, w, h )

	--
	-- Draw the button text
	--
	return false

end

function PANEL:OnMousePressed( mousecode )

	self.m_MenuClicking = true

	DButton.OnMousePressed( self, mousecode )

	if (GetConVar "moat_ui_sounds" and GetConVar "moat_ui_sounds":GetInt() and GetConVar "moat_ui_sounds":GetInt() > 0) then
		LocalPlayer():EmitSound "moatsounds/pop2.wav"
	end
end

function PANEL:OnMouseReleased( mousecode )

	DButton.OnMouseReleased( self, mousecode )

	if ( self.m_MenuClicking && mousecode == MOUSE_LEFT ) then

		self.m_MenuClicking = false
		CloseDermaMenus()

	end

end

function PANEL:DoRightClick()

	if ( self:GetIsCheckable() ) then
		self:ToggleCheck()
	end

	if (cdn and cdn.PlayURL and GetConVar "moat_ui_sounds" and GetConVar "moat_ui_sounds":GetInt() and GetConVar "moat_ui_sounds":GetInt() > 0) then
		cdn.PlayURL "https://static.moat.gg/ttt/appear-online.ogg"
	end

end

function PANEL:DoClickInternal()

	if ( self:GetIsCheckable() ) then
		self:ToggleCheck()
	end

	if ( self.m_pMenu ) then

		self.m_pMenu:OptionSelectedInternal( self )

	end

end

function PANEL:ToggleCheck()

	self:SetChecked( !self:GetChecked() )
	self:OnChecked( self:GetChecked() )

end

function PANEL:OnChecked( b )
end

function PANEL:PerformLayout()

	self:SizeToContents()
	self:SetWide( self:GetWide() + 32 )

	local w = math.max( self:GetParent():GetWide(), self:GetWide() )

	self:SetSize( w, 32 )

	if ( self.SubMenuArrow ) then

		self.SubMenuArrow:SetSize( 12, 12 )
		self.SubMenuArrow:CenterVertical()
		self.SubMenuArrow:AlignRight( 4 )

	end

	DButton.PerformLayout( self )

	if (self.m_Image) then
		self.m_Image:SetPos(8, 8)
	end
end

function PANEL:GenerateExample()

	-- Do nothing!

end

derma.DefineControl( "DMenuOption", "Menu Option Line", PANEL, "DButton" )

--[[-------------------------------------------------------------------------
DComboBox Overwrite
---------------------------------------------------------------------------]]


local PANEL = {}

Derma_Hook( PANEL, "Paint", "Paint", "ComboBox" )

Derma_Install_Convar_Functions( PANEL )

AccessorFunc( PANEL, "m_bDoSort", "SortItems", FORCE_BOOL )

function PANEL:Init()

	self.DropButton = vgui.Create( "DPanel", self )
	self.DropButton.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "ComboDownArrow", panel, w, h ) end
	self.DropButton:SetMouseInputEnabled( false )
	self.DropButton.ComboBox = self

	self:SetTall( 22 )
	self:Clear()

	self:SetContentAlignment( 4 )
	self:SetTextInset( 8, 0 )
	self:SetIsMenu( true )
	self:SetSortItems( true )
	self:SetTextColor(Color(255, 255, 255, 255))

end

function PANEL:Clear()

	self:SetText( "" )
	self.Choices = {}
	self.Data = {}
	self.selected = nil

	if ( self.Menu ) then
		self.Menu:Remove()
		self.Menu = nil
	end

end

function PANEL:GetOptionText( id )

	return self.Choices[ id ]

end

function PANEL:GetOptionData( id )

	return self.Data[ id ]

end

function PANEL:GetOptionTextByData( data )

	for id, dat in pairs( self.Data ) do
		if ( dat == data ) then
			return self:GetOptionText( id )
		end
	end

	-- Try interpreting it as a number
	for id, dat in pairs( self.Data ) do
		if ( dat == tonumber( data ) ) then
			return self:GetOptionText( id )
		end
	end

	-- In case we fail
	return data

end

function PANEL:PerformLayout()

	self.DropButton:SetSize( 15, 15 )
	self.DropButton:AlignRight( 4 )
	self.DropButton:CenterVertical()

end

function PANEL:ChooseOption( value, index )

	if ( self.Menu ) then
		self.Menu:Remove()
		self.Menu = nil
	end

	self:SetText( value )

	-- This should really be the here, but it is too late now and convar changes are handled differently by different child elements
	--self:ConVarChanged( self.Data[ index ] )

	self.selected = index
	self:OnSelect( index, value, self.Data[ index ] )

end

function PANEL:ChooseOptionID( index )

	local value = self:GetOptionText( index )
	self:ChooseOption( value, index )

end

function PANEL:GetSelectedID()

	return self.selected

end

function PANEL:GetSelected()

	if ( !self.selected ) then return end

	return self:GetOptionText( self.selected ), self:GetOptionData( self.selected )

end

function PANEL:OnSelect( index, value, data )

	-- For override

end

function PANEL:AddChoice( value, data, select )

	local i = table.insert( self.Choices, value )

	if ( data ) then
		self.Data[ i ] = data
	end

	if ( select ) then

		self:ChooseOption( value, i )

	end

	return i

end

function PANEL:IsMenuOpen()

	return IsValid( self.Menu ) && self.Menu:IsVisible()

end

function PANEL:OpenMenu( pControlOpener )

	if ( pControlOpener && pControlOpener == self.TextEntry ) then
		return
	end

	-- Don't do anything if there aren't any options..
	if ( #self.Choices == 0 ) then return end

	-- If the menu still exists and hasn't been deleted
	-- then just close it and don't open a new one.
	if ( IsValid( self.Menu ) ) then
		self.Menu:Remove()
		self.Menu = nil
	end

	self.Menu = DermaMenu( false, self )

	if ( self:GetSortItems() ) then
		local sorted = {}
		for k, v in pairs( self.Choices ) do
			local val = tostring( v ) --tonumber( v ) || v -- This would make nicer number sorting, but SortedPairsByMemberValue doesn't seem to like number-string mixing
			if ( string.len( val ) > 1 && !tonumber( val ) && val:StartWith( "#" ) ) then val = language.GetPhrase( val:sub( 2 ) ) end
			table.insert( sorted, { id = k, data = v, label = val } )
		end
		for k, v in SortedPairsByMemberValue( sorted, "label" ) do
			self.Menu:AddOption( v.data, function() self:ChooseOption( v.data, v.id ) end )
		end
	else
		for k, v in pairs( self.Choices ) do
			self.Menu:AddOption( v, function() self:ChooseOption( v, k ) end )
		end
	end

	local x, y = self:LocalToScreen( 0, self:GetTall() )

	self.Menu:SetMinimumWidth( self:GetWide() )
	self.Menu:Open( x, y, false, self )

end

function PANEL:CloseMenu()

	if ( IsValid( self.Menu ) ) then
		self.Menu:Remove()
	end

end

-- This really should use a convar change hook
function PANEL:CheckConVarChanges()

	if ( !self.m_strConVar ) then return end

	local strValue = GetConVarString( self.m_strConVar )
	if ( self.m_strConVarValue == strValue ) then return end

	self.m_strConVarValue = strValue

	self:SetValue( self:GetOptionTextByData( self.m_strConVarValue ) )

end

function PANEL:Think()

	self:CheckConVarChanges()

end

function PANEL:SetValue( strValue )

	self:SetText( strValue )

end

function PANEL:DoClick()

	if ( self:IsMenuOpen() ) then
		return self:CloseMenu()
	end

	self:OpenMenu()

	if (GetConVar "moat_ui_sounds" and GetConVar "moat_ui_sounds":GetInt() and GetConVar "moat_ui_sounds":GetInt() > 0) then
		LocalPlayer():EmitSound "moatsounds/pop2.wav"
	end
end

function PANEL:OnCursorEntered(s)
	if (GetConVar "moat_ui_sounds" and GetConVar "moat_ui_sounds":GetInt() and GetConVar "moat_ui_sounds":GetInt() > 0) then
		LocalPlayer():EmitSound "moatsounds/pop1.wav"
	end
end

function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
	ctrl:AddChoice( "Some Choice" )
	ctrl:AddChoice( "Another Choice" )
	ctrl:SetWide( 150 )

	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "DComboBox", "", PANEL, "DButton" )


--[[-------------------------------------------------------------------------
DPanelList Overwrite
---------------------------------------------------------------------------]]


local PANEL = {}

AccessorFunc( PANEL, "m_bSizeToContents",		"AutoSize" )
AccessorFunc( PANEL, "m_bStretchHorizontally",	"StretchHorizontally" )
AccessorFunc( PANEL, "m_bNoSizing",				"NoSizing" )
AccessorFunc( PANEL, "m_bSortable",				"Sortable" )
AccessorFunc( PANEL, "m_fAnimTime",				"AnimTime" )
AccessorFunc( PANEL, "m_fAnimEase",				"AnimEase" )
AccessorFunc( PANEL, "m_strDraggableName",		"DraggableName" )

AccessorFunc( PANEL, "Spacing", "Spacing" )
AccessorFunc( PANEL, "Padding", "Padding" )

function PANEL:Init()

	self:SetDraggableName( "GlobalDPanel" )

	self.pnlCanvas = vgui.Create( "DPanel", self )
	self.pnlCanvas:SetPaintBackground( false )
	self.pnlCanvas.OnMousePressed = function( self, code ) self:GetParent():OnMousePressed( code ) end
	self.pnlCanvas.OnChildRemoved = function() self:OnChildRemoved() end
	self.pnlCanvas:SetMouseInputEnabled( true )
	self.pnlCanvas.InvalidateLayout = function() self:InvalidateLayout() end

	self.Items = {}
	self.YOffset = 0
	self.m_fAnimTime = 0
	self.m_fAnimEase = -1 -- means ease in out
	self.m_iBuilds = 0

	self:SetSpacing( 0 )
	self:SetPadding( 0 )
	self:EnableHorizontal( false )
	self:SetAutoSize( false )
	self:SetPaintBackground( true )
	self:SetNoSizing( false )

	self:SetMouseInputEnabled( true )

	-- This turns off the engine drawing
	self:SetPaintBackgroundEnabled( false )
	self:SetPaintBorderEnabled( false )

end

function PANEL:OnModified()

	-- Override me

end

function PANEL:SizeToContents()

	self:SetSize( self.pnlCanvas:GetSize() )

end

function PANEL:GetItems()

	-- Should we return a copy of this to stop
	-- people messing with it?
	return self.Items

end

function PANEL:EnableHorizontal( bHoriz )

	self.Horizontal = bHoriz

end

function PANEL:EnableVerticalScrollbar()

	if ( self.VBar ) then return end

	self.VBar = vgui.Create( "DVScrollBar", self )

end

function PANEL:GetCanvas()

	return self.pnlCanvas

end

function PANEL:Clear( bDelete )

	for k, panel in pairs( self.Items ) do

		if ( !IsValid( panel ) ) then continue end

		panel:SetVisible( false )

		if ( bDelete ) then
			panel:Remove()
		end

	end

	self.Items = {}

end

function PANEL:AddItem( item, strLineState )

	if ( !IsValid( item ) ) then return end

	item:SetVisible( true )
	item:SetParent( self:GetCanvas() )
	item.m_strLineState = strLineState || item.m_strLineState
	table.insert( self.Items, item )

	--[[if ( self.m_bSortable ) then

		local DragSlot = item:MakeDraggable( self:GetDraggableName(), self )
		DragSlot.OnDrop = self.DropAction

	end]]

	item:SetSelectable( self.m_bSelectionCanvas )

	self:InvalidateLayout()

end

function PANEL:InsertBefore( before, insert, strLineState )

	table.RemoveByValue( self.Items, insert )

	self:AddItem( insert, strLineState )

	local key = table.KeyFromValue( self.Items, before )

	if ( key ) then
		table.RemoveByValue( self.Items, insert )
		table.insert( self.Items, key, insert )
	end

end

function PANEL:InsertAfter( before, insert, strLineState )

	table.RemoveByValue( self.Items, insert )
	self:AddItem( insert, strLineState )

	local key = table.KeyFromValue( self.Items, before )

	if ( key ) then
		table.RemoveByValue( self.Items, insert )
		table.insert( self.Items, key + 1, insert )
	end

end

function PANEL:InsertAtTop( insert, strLineState )

	table.RemoveByValue( self.Items, insert )
	self:AddItem( insert, strLineState )

	local key = 1
	if ( key ) then
		table.RemoveByValue( self.Items, insert )
		table.insert( self.Items, key, insert )
	end

end

function PANEL.DropAction( Slot, RcvSlot )

	local PanelToMove = Slot.Panel
	if ( dragndrop.m_MenuData == "copy" ) then

		if ( PanelToMove.Copy ) then

			PanelToMove = Slot.Panel:Copy()

			PanelToMove.m_strLineState = Slot.Panel.m_strLineState
		else
			return
		end

	end

	PanelToMove:SetPos( RcvSlot.Data.pnlCanvas:ScreenToLocal( gui.MouseX() - dragndrop.m_MouseLocalX, gui.MouseY() - dragndrop.m_MouseLocalY ) )

	if ( dragndrop.DropPos == 4 || dragndrop.DropPos == 8 ) then
		RcvSlot.Data:InsertBefore( RcvSlot.Panel, PanelToMove )
	else
		RcvSlot.Data:InsertAfter( RcvSlot.Panel, PanelToMove )
	end

end

function PANEL:RemoveItem( item, bDontDelete )

	for k, panel in pairs( self.Items ) do

		if ( panel == item ) then

			self.Items[ k ] = nil

			if ( !bDontDelete ) then
				panel:Remove()
			end

			self:InvalidateLayout()

		end

	end

end

function PANEL:CleanList()

	for k, panel in pairs( self.Items ) do

		if ( !IsValid( panel ) || panel:GetParent() != self.pnlCanvas ) then
			self.Items[k] = nil
		end

	end

end

function PANEL:Rebuild()

	local Offset = 0
	self.m_iBuilds = self.m_iBuilds + 1

	self:CleanList()

	if ( self.Horizontal ) then

		local x, y = self.Padding, self.Padding
		for k, panel in pairs( self.Items ) do

			if ( panel:IsVisible() ) then

				local OwnLine = ( panel.m_strLineState && panel.m_strLineState == "ownline" )

				local w = panel:GetWide()
				local h = panel:GetTall()

				if ( x > self.Padding && ( x + w > self:GetWide() || OwnLine ) ) then

					x = self.Padding
					y = y + h + self.Spacing

				end

				if ( self.m_fAnimTime > 0 && self.m_iBuilds > 1 ) then
					panel:MoveTo( x, y, self.m_fAnimTime, 0, self.m_fAnimEase )
				else
					panel:SetPos( x, y )
				end

				x = x + w + self.Spacing
				Offset = y + h + self.Spacing

				if ( OwnLine ) then

					x = self.Padding
					y = y + h + self.Spacing

				end

			end

		end

	else

		for k, panel in pairs( self.Items ) do

			if ( panel:IsVisible() ) then

				if ( self.m_bNoSizing ) then
					panel:SizeToContents()
					if ( self.m_fAnimTime > 0 && self.m_iBuilds > 1 ) then
						panel:MoveTo( ( self:GetCanvas():GetWide() - panel:GetWide() ) * 0.5, self.Padding + Offset, self.m_fAnimTime, 0, self.m_fAnimEase )
					else
						panel:SetPos( ( self:GetCanvas():GetWide() - panel:GetWide() ) * 0.5, self.Padding + Offset )
					end
				else
					panel:SetSize( self:GetCanvas():GetWide() - self.Padding * 2, panel:GetTall() )
					if ( self.m_fAnimTime > 0 && self.m_iBuilds > 1 ) then
						panel:MoveTo( self.Padding, self.Padding + Offset, self.m_fAnimTime, self.m_fAnimEase )
					else
						panel:SetPos( self.Padding, self.Padding + Offset )
					end
				end

				-- Changing the width might ultimately change the height
				-- So give the panel a chance to change its height now,
				-- so when we call GetTall below the height will be correct.
				-- True means layout now.
				panel:InvalidateLayout( true )

				Offset = Offset + panel:GetTall() + self.Spacing

			end

		end

		Offset = Offset + self.Padding

	end

	self:GetCanvas():SetTall( Offset + self.Padding - self.Spacing )

	-- Although this behaviour isn't exactly implied, center vertically too
	if ( self.m_bNoSizing && self:GetCanvas():GetTall() < self:GetTall() ) then

		self:GetCanvas():SetPos( 0, ( self:GetTall() - self:GetCanvas():GetTall() ) * 0.5 )

	end

end

function PANEL:OnMouseWheeled( dlta )

	if ( self.VBar ) then
		return self.VBar:OnMouseWheeled( dlta )
	end

end

function PANEL:Paint( w, h )

	derma.SkinHook( "Paint", "PanelList", self, w, h )
	return true

end

function PANEL:OnVScroll( iOffset )

	self.pnlCanvas:SetPos( 0, iOffset )

end

function PANEL:PerformLayout()

	local Wide = self:GetWide()
	local Tall = self.pnlCanvas:GetTall()
	local YPos = 0

	if ( !self.Rebuild ) then
		debug.Trace()
	end

	self:Rebuild()

	if ( self.VBar ) then

		self.VBar:SetPos( self:GetWide() - 15, 0 )
		self.VBar:SetSize( 15, self:GetTall() )
		self.VBar:SetUp( self:GetTall(), self.pnlCanvas:GetTall() ) -- Disables scrollbar if nothing to scroll
		YPos = self.VBar:GetOffset()

		if ( self.VBar.Enabled ) then Wide = Wide - 15 end

	end

	self.pnlCanvas:SetPos( 0, YPos )
	self.pnlCanvas:SetWide( Wide )

	self:Rebuild()

	if ( self:GetAutoSize() ) then

		self:SetTall( self.pnlCanvas:GetTall() )
		self.pnlCanvas:SetPos( 0, 0 )

	end

	if ( self.VBar && !self:GetAutoSize() && Tall != self.pnlCanvas:GetTall() ) then
		self.VBar:SetScroll( self.VBar:GetScroll() ) -- Make sure we are not too far down!
	end

end

function PANEL:OnChildRemoved()

	self:CleanList()
	self:InvalidateLayout()

end

function PANEL:ScrollToChild( panel )

	local x, y = self.pnlCanvas:GetChildPosition( panel )
	local w, h = panel:GetSize()

	y = y + h * 0.5
	y = y - self:GetTall() * 0.5

	self.VBar:AnimateTo( y, 0.5, 0, 0.5 )

end

function PANEL:SortByMember( key, desc )

	desc = desc || true

	table.sort( self.Items, function( a, b )

		if ( desc ) then

			local ta = a
			local tb = b

			a = tb
			b = ta

		end

		if ( a[ key ] == nil ) then return false end
		if ( b[ key ] == nil ) then return true end

		return a[ key ] > b[ key ]

	end )

end

derma.DefineControl( "DPanelList", "A Panel that neatly organises other panels", PANEL, "DPanel" )



--
-- The delay before a tooltip appears
--
local tooltip_delay = CreateClientConVar( "tooltip_delay", "0.5", true, false )

local PANEL = {}

function PANEL:Init()

	self:SetDrawOnTop( true )
	self.DeleteContentsOnClose = false
	self:SetText( "" )
	self:SetFont( "Default" )

end

function PANEL:UpdateColours( skin )

	return self:SetTextStyleColor( skin.Colours.TooltipText )

end

function PANEL:SetContents( panel, bDelete )

	panel:SetParent( self )

	self.Contents = panel
	self.DeleteContentsOnClose = bDelete or false
	self.Contents:SizeToContents()
	self:InvalidateLayout( true )

	self.Contents:SetVisible( false )

end

function PANEL:PerformLayout()

	if ( IsValid( self.Contents ) ) then

		self:SetWide( self.Contents:GetWide() + 8 )
		self:SetTall( self.Contents:GetTall() + 8 )
		self.Contents:SetPos( 4, 4 )
		self.Contents:SetVisible( true )

	else

		local w, h = self:GetContentSize()
		self:SetSize( w + 8, h + 6 )
		self:SetContentAlignment( 5 )

	end

end

local Mat = Material( "vgui/arrow" )

function PANEL:DrawArrow( x, y )

	self.Contents:SetVisible( true )

	surface.SetMaterial( Mat )
	surface.DrawTexturedRect( self.ArrowPosX + x, self.ArrowPosY + y, self.ArrowWide, self.ArrowTall )

end

function PANEL:PositionTooltip()

	if ( !IsValid( self.TargetPanel ) ) then
		self:Remove()
		return
	end

	self:PerformLayout()

	local x, y = input.GetCursorPos()
	local w, h = self:GetSize()

	local lx, ly = self.TargetPanel:LocalToScreen( 0, 0 )

	y = y

	y = math.min( y, ly - h * 1.5 )
	if ( y < 2 ) then y = 2 end

	-- Fixes being able to be drawn off screen
	self:SetPos( math.Clamp( x - w * 0.5, 0, ScrW() - self:GetWide() ), math.Clamp( y, 0, ScrH() - self:GetTall() ) )

end

local tri_w, tri_h = 20, 10

function PANEL:Paint( w, h )

	derma.SkinHook( "Paint", "Tooltip", self, w, h )

	DisableClipping(true)
	surface.SetDrawColor(0, 0, 0, 255)
	draw.NoTexture()
	surface.DrawPoly({
		{x = (w/2) - (tri_w/2), y = h},
		{x = (w/2) + (tri_w/2), y = h},
		{x = (w/2), y = h + tri_h}
	})
	DisableClipping(false)
end

function PANEL:OpenForPanel( panel )

	self.TargetPanel = panel
	self:PositionTooltip()

	if ( tooltip_delay:GetFloat() > 0 ) then

		self:SetVisible( false )
		timer.Simple( 0.2, function()

			if ( !IsValid( self ) ) then return end
			if ( !IsValid( panel ) ) then return end

			self:PositionTooltip()
			self:SetVisible( true )

		end )
	end

end

function PANEL:Close()

	if ( !self.DeleteContentsOnClose && IsValid( self.Contents ) ) then

		self.Contents:SetVisible( false )
		self.Contents:SetParent( nil )

	end

	self:Remove()

end

function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( "DButton" )
	ctrl:SetText( "Hover me" )
	ctrl:SetWide( 200 )
	ctrl:SetTooltip( "This is a tooltip" )

	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "DTooltip", "", PANEL, "DLabel" )


--[[-------------------------------------------------------------------------
DListView Line Overwrite
---------------------------------------------------------------------------]]


local PANEL = {}

function PANEL:Init()

	self:SetTextInset( 5, 0 )

end

local b = Color(255, 255, 255, 255)
local d = Color(20, 20, 20, 255)

function PANEL:UpdateColours( skin )

	if ( self:GetParent():IsLineSelected() ) then return self:SetTextStyleColor(b) end

	return self:SetTextStyleColor(d)

end

function PANEL:GenerateExample()

	-- Do nothing!

end

derma.DefineControl( "DListViewLabel", "", PANEL, "DLabel" )

--[[---------------------------------------------------------
	DListView_Line
-----------------------------------------------------------]]

local PANEL = {}

Derma_Hook( PANEL, "Paint", "Paint", "ListViewLine" )
Derma_Hook( PANEL, "ApplySchemeSettings", "Scheme", "ListViewLine" )
Derma_Hook( PANEL, "PerformLayout", "Layout", "ListViewLine" )

AccessorFunc( PANEL, "m_iID", "ID" )
AccessorFunc( PANEL, "m_pListView", "ListView" )
AccessorFunc( PANEL, "m_bAlt", "AltLine" )

function PANEL:Init()

	self:SetSelectable( true )
	self:SetMouseInputEnabled( true )

	self.Columns = {}
	self.Data = {}

end

function PANEL:OnSelect()

	-- For override

end

function PANEL:OnRightClick()

	-- For override

end

function PANEL:OnMousePressed( mcode )

	if ( mcode == MOUSE_RIGHT ) then

		-- This is probably the expected behaviour..
		if ( !self:IsLineSelected() ) then

			self:GetListView():OnClickLine( self, true )
			self:OnSelect()

		end

		self:GetListView():OnRowRightClick( self:GetID(), self )
		self:OnRightClick()

		return

	end

	self:GetListView():OnClickLine( self, true )
	self:OnSelect()

end

function PANEL:OnCursorMoved()

	if ( input.IsMouseDown( MOUSE_LEFT ) ) then
		self:GetListView():OnClickLine( self )
	end

end

function PANEL:SetSelected( b )

	self.m_bSelected = b

	-- Update colors of the lines
	for id, column in pairs( self.Columns ) do
		column:ApplySchemeSettings()
	end

end

function PANEL:IsLineSelected()

	return self.m_bSelected

end

function PANEL:SetColumnText( i, strText )

	if ( type( strText ) == "Panel" ) then

		if ( IsValid( self.Columns[ i ] ) ) then self.Columns[ i ]:Remove() end

		strText:SetParent( self )
		self.Columns[ i ] = strText
		self.Columns[ i ].Value = strText
		return

	end

	if ( !IsValid( self.Columns[ i ] ) ) then

		self.Columns[ i ] = vgui.Create( "DListViewLabel", self )
		self.Columns[ i ]:SetMouseInputEnabled( false )

	end

	self.Columns[ i ]:SetText( tostring( strText ) )
	self.Columns[ i ].Value = strText
	return self.Columns[ i ]

end
PANEL.SetValue = PANEL.SetColumnText

function PANEL:GetColumnText( i )

	if ( !self.Columns[ i ] ) then return "" end

	return self.Columns[ i ].Value

end

PANEL.GetValue = PANEL.GetColumnText

--[[---------------------------------------------------------
	Allows you to store data per column

	Used in the SortByColumn function for incase you want to
	sort with something else than the text
-----------------------------------------------------------]]
function PANEL:SetSortValue( i, data )

	self.Data[ i ] = data

end

function PANEL:GetSortValue( i )

	return self.Data[ i ]

end

function PANEL:DataLayout( ListView )

	self:ApplySchemeSettings()

	local height = self:GetTall()

	local x = 0
	for k, Column in pairs( self.Columns ) do

		local w = ListView:ColumnWidth( k )
		Column:SetPos( x, 0 )
		Column:SetSize( w, height )
		x = x + w

	end

end

derma.DefineControl( "DListViewLine", "A line from the List View", PANEL, "Panel" )
derma.DefineControl( "DListView_Line", "A line from the List View", PANEL, "Panel" )


--[[-------------------------------------------------------------------------
Scrollbar
---------------------------------------------------------------------------]]
local PANEL = {}

AccessorFunc( PANEL, "m_HideButtons", "HideButtons" )

function PANEL:Init()

    self.Offset = 0
    self.Scroll = 0
    self.CanvasSize = 1
    self.BarSize = 1
	self.LerpTarget = 0
	self.moving = false

    self.btnUp = vgui.Create( "DButton", self )
    self.btnUp:SetText( "" )
    self.btnUp.DoClick = function( self ) self:GetParent():AddScroll( -1 ) end
    self.btnUp.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "ButtonUp", panel, w, h ) end

    self.btnDown = vgui.Create( "DButton", self )
    self.btnDown:SetText( "" )
    self.btnDown.DoClick = function( self ) self:GetParent():AddScroll( 1 ) end
    self.btnDown.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "ButtonDown", panel, w, h ) end

    self.btnGrip = vgui.Create( "DScrollBarGrip", self )

    self:SetSize( 15, 15 )
    self:SetHideButtons( false )

end

function PANEL:SetEnabled( b )

    if ( !b ) then

        self.Offset = 0
        self:SetScroll( 0 )
        self.HasChanged = true

    end

    self:SetMouseInputEnabled( b )
    self:SetVisible( b )

    -- We're probably changing the width of something in our parent
    -- by appearing or hiding, so tell them to re-do their layout.
    if ( self.Enabled != b ) then

        self:GetParent():InvalidateLayout()

        if ( self:GetParent().OnScrollbarAppear ) then
            self:GetParent():OnScrollbarAppear()
        end

    end

    self.Enabled = b

end

function PANEL:Value()

    return self.Pos

end

function PANEL:BarScale()

    if ( self.BarSize == 0 ) then return 1 end

    return self.BarSize / ( self.CanvasSize + self.BarSize )

end

function PANEL:SetUp( _barsize_, _canvassize_ )

    self.BarSize = _barsize_
    self.CanvasSize = math.max( _canvassize_ - _barsize_, 1 )

    self:SetEnabled( _canvassize_ > _barsize_ )

    self:InvalidateLayout()

end

function PANEL:OnMouseWheeled( dlta )

    if ( !self:IsVisible() ) then return false end

    -- We return true if the scrollbar changed.
    -- If it didn't, we feed the mousehweeling to the parent panel

    return self:AddScroll( dlta * -2 )

end

local smooth_scrolling = GetConVar("moat_continue_scrolling"):GetInt()

function PANEL:AddScroll(dlta)
        local OldScroll = self.LerpTarget or self:GetScroll()

        if (smooth_scrolling > 0) then
            dlta = dlta * 75
        else
            dlta = dlta * 50
        end

        self.LerpTarget = math.Clamp(self.LerpTarget + dlta, -self.btnGrip:GetTall(), self.CanvasSize + self.btnGrip:GetTall())
        return OldScroll != self:GetScroll()
end

function PANEL:SetScroll( scrll )

    if ( !self.Enabled ) then self.Scroll = 0 return end

    self.Scroll = math.Clamp( scrll, 0, self.CanvasSize )

    self:InvalidateLayout()

    -- If our parent has a OnVScroll function use that, if
    -- not then invalidate layout (which can be pretty slow)

    local func = self:GetParent().OnVScroll
    if ( func ) then

        func( self:GetParent(), self:GetOffset() )

    else

        self:GetParent():InvalidateLayout()

    end

end

function PANEL:AnimateTo( scrll, length, delay, ease )
	
	self.LerpTarget = scrll

end

function PANEL:GetScroll()

    if ( !self.Enabled ) then self.Scroll = 0 end
    return self.Scroll

end

function PANEL:GetOffset()

    if ( !self.Enabled ) then return 0 end
    return self.Scroll * -1

end

function PANEL:Think()
	if (self.ScrollOnExtend) then
		if (self.StoredCanvas and self.StoredCanvas < self.CanvasSize and self.LerpTarget == self.StoredCanvas) then
			self:SetScroll(self.CanvasSize)
			self.LerpTarget = self.CanvasSize
		end

		self.StoredCanvas = self.CanvasSize
	end

    if (input.IsMouseDown(MOUSE_LEFT) and not M_INV_DRAG) then
        self.LerpTarget = self:GetScroll()
    end
        
    local frac = FrameTime() * 5

    if (smooth_scrolling > 0) then
        if (math.abs(self.LerpTarget - self:GetScroll()) <= (self.CanvasSize/10)) then frac = FrameTime() * 2 end
    else
        frac = FrameTime() * 10
    end
        
    local newpos = Lerp(frac, self:GetScroll(), self.LerpTarget)
    newpos = math.Clamp(newpos, 0, self.CanvasSize)

    self:SetScroll(newpos)

    if (self.LerpTarget < 0 and self:GetScroll() == 0) then
        self.LerpTarget = 0
    end

    if (self.LerpTarget > self.CanvasSize and self:GetScroll() == self.CanvasSize) then
        self.LerpTarget = self.CanvasSize
    end
end

function PANEL:Paint( w, h )

    derma.SkinHook( "Paint", "VScrollBar", self, w, h )
    return true

end

function PANEL:OnMousePressed()

    local x, y = self:CursorPos()

    local PageSize = self.BarSize

    if ( y > self.btnGrip.y ) then
        self:SetScroll( self:GetScroll() + PageSize )
    else
        self:SetScroll( self:GetScroll() - PageSize )
    end

end

function PANEL:OnMouseReleased()

    self.Dragging = false
    self.DraggingCanvas = nil
    self:MouseCapture( false )

    self.btnGrip.Depressed = false

end

function PANEL:OnCursorMoved( x, y )

    if ( !self.Enabled ) then return end
    if ( !self.Dragging ) then return end

    local x, y = self:ScreenToLocal( 0, gui.MouseY() )

    -- Uck.
    y = y - self.btnUp:GetTall()
    y = y - self.HoldPos

    local BtnHeight = self:GetWide()
    if ( self:GetHideButtons() ) then BtnHeight = 4 end

    local TrackSize = self:GetTall() - BtnHeight * 2 - self.btnGrip:GetTall()

    y = y / TrackSize

    self:SetScroll( y * self.CanvasSize )

end

function PANEL:Grip()

    if ( !self.Enabled ) then return end
    if ( self.BarSize == 0 ) then return end

    self:MouseCapture( true )
    self.Dragging = true

    local x, y = self.btnGrip:ScreenToLocal( 0, gui.MouseY() )
    self.HoldPos = y

    self.btnGrip.Depressed = true

end

function PANEL:PerformLayout()

    local Wide = self:GetWide()
    local BtnHeight = Wide
    if ( self:GetHideButtons() ) then BtnHeight = 4 end
    local Scroll = self:GetScroll() / self.CanvasSize
    local BarSize = math.max( self:BarScale() * ( self:GetTall() - ( BtnHeight * 2 ) ), 10 )
    local Track = self:GetTall() - ( BtnHeight * 2 ) - BarSize
    Track = Track + 1

    Scroll = Scroll * Track

    self.btnGrip:SetPos( 0, BtnHeight + Scroll )
    self.btnGrip:SetSize( Wide, BarSize )

    if ( BtnHeight > 4 ) then
        self.btnUp:SetPos( 0, 0, Wide, Wide )
        self.btnUp:SetSize( Wide, BtnHeight )

        self.btnDown:SetPos( 0, self:GetTall() - BtnHeight )
        self.btnDown:SetSize( Wide, BtnHeight )
        
        self.btnUp:SetVisible( true )
        self.btnDown:SetVisible( true )
    else
        self.btnUp:SetVisible( false )
        self.btnDown:SetVisible( false )
        self.btnDown:SetSize( Wide, BtnHeight )
        self.btnUp:SetSize( Wide, BtnHeight )
    end

end

derma.DefineControl( "DVScrollBar", "A Scrollbar", PANEL, "Panel" )


	if (not old_vgui_create) then old_vgui_create = vgui.Create end

	function vgui.Create(c, p, n)
		if (moat_already_skin) then
			vgui.Create = old_vgui_create
			return old_vgui_create(c, p, n)
		end

		local dagui = old_vgui_create(c, p, n)
		dagui:SetSkin("moat")
		moat_already_skin = true

		return dagui
	end
end

function check_derma_skin()
	if (file.Exists("ui2.png", "DATA")) then
		timer.Remove "moat.load.derma"

		local m = Material("data/ui2.png", "noclamp")

		look_how_long_this_function_is("Default", m)
		look_how_long_this_function_is("moat", m)

		return
	end

	http.Fetch("https://static.moat.gg/ttt/garrysmod/data/ui2.png", function(b)
		file.Write("ui2.png", b)
	end)
end

hook.Add("InitPostEntity", "moat.load.derma", function()
	check_derma_skin()

	timer.Create("moat.load.derma", 3, 0, check_derma_skin)
end)