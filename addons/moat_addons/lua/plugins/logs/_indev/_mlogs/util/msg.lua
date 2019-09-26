mlogs.Colors = mlogs.Colors or {}
mlogs.Colors.White 		= Color(255, 255, 255, 255)
mlogs.Colors.Green 		= Color(0, 255, 0, 255)
mlogs.Colors.Blue 		= Color(51, 153, 255, 255)
mlogs.Colors.Cyan 		= Color(0, 200, 255, 255)
mlogs.Colors.Pink 		= Color(255, 0, 255, 255)
mlogs.Colors.Red 		= Color(255, 0, 0, 255)
mlogs.Colors.Black 		= Color(0, 0, 0, 255)
mlogs.Colors.LightRed 	= Color(255, 100, 100, 255)

mlogs.Colors.moat_white = Color(255, 255, 255, 255)
mlogs.Colors.moat_green = Color(0, 255, 0, 255)
mlogs.Colors.moat_blue = Color(51, 153, 255, 255)
mlogs.Colors.moat_teal = Color(0, 200, 255, 255)
mlogs.Colors.moat_pink = Color(255, 0, 255, 255)
mlogs.Colors.moat_red = Color(255, 0, 0, 255)

function mlogs:Print(msg, stopnl)
	MsgC(self.Colors.Red, "mLogs", self.Colors.Green, " | ", msg)
	if (stopnl) then return end
	MsgC "\n"
end


local border = "=================================="
function mlogs:PrintH(msg)
	self:Print(border)
	self:Print(msg)
	self:Print(border)
end