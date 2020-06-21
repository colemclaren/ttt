local moat_CurAdvert = 1

local moat_Adverts = {
	{ Color( 255, 255, 0 ), "Visit our forums @ https://moat.gg/" },
	{ Color( 255, 255, 0 ), "VIP's receive 50% more IC when deconstructing, 17000 IC, and a fancy scoreboard tag!" },
	{ Color( 255, 255, 0 ), "Almost everything is customizable inside the inventory settings, make sure to check them out!" },
	{ Color( 255, 255, 0 ), "If you would like to support the server through your steam name, please add moat.gg to it to receive 25% more IC when deconstructing!" },
	{ Color( 255, 255, 0 ), "We do a lot of work. Check out https://moat.gg/changes to stay up to date with our latest changes! We love hearing your feedback. <3" },
	{ Color( 255, 255, 0 ), "Don't like the custom HUD? You can press F6 while alive to use the menu bar and the top left of elements to move them around!" },
	{ Color( 255, 255, 0 ), "Want some free credits? Type !rewards in the chat to open the rewards menu!" },
	{ Color( 255, 255, 0 ), "Someone causing problems with no staff online? Make a player complaint on our forums." },
	{ Color( 255, 255, 0 ), "Have a suggestion for the server? Make a post on the forums!" },
	{ Color( 255, 255, 0 ), "Join our discord (!discord) for access to exclusive announcements and updates." },
}


timer.Create("moat_ChatAdverts", 360, 0, function()
	if (moat_CurAdvert > #moat_Adverts) then moat_CurAdvert = 1 end
	local chosen_advert = moat_Adverts[moat_CurAdvert]
	moat_CurAdvert = moat_CurAdvert + 1
	for k, v in pairs( player.GetAll() ) do
		v:SendLua( [[chat.AddText( Material( "icon16/information.png" ), Color( 255, 255, 0 ), "]] .. chosen_advert[2] .. [[" )]] )
	end
end)