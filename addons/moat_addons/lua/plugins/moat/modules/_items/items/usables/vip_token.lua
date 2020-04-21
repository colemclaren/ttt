ITEM.ID = 17
ITEM.Name = "VIP Token"
ITEM.Description = "Using this will grant VIP benefits permanently! Benefits of joining the VIP are in the 'Donate' tab"
ITEM.Rarity = 8
ITEM.Collection = "Meta Collection"
ITEM.Image = "https://cdn.moat.gg/ttt/vip_token.png"
ITEM.Active = false

-- Will only be able to be bought with SC, not done yet. Just pushing votekick meme

//Buying VIP for your friends or trading it for IC is about to be way easier! People that already own VIP will be able to purchase VIP tokens that are able to be traded!
ITEM.ItemUsed = function(pl, slot, item)
	moat_makevip(pl:SteamID64())
	m_AddCreditsToSteamID(pl:SteamID(), 17000)
end