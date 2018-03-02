ITEM.ID = 7010 --models/jaanus/santa.mdl
ITEM.Name = "Cat Woman Model"
ITEM.Description = "I'm a catist, not a feminist"
ITEM.Model = "models/player/bobert/accatwoman.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Holiday Collection"

function ITEM:OnPlayerSpawn(ply)
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end