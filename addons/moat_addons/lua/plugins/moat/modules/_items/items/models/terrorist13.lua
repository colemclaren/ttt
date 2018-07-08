ITEM.ID = 1111
ITEM.Name = "Hobo Model"
ITEM.Description = "Now you can collect IC and beg properly"
ITEM.Model = "models/player/corpse1.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"

function ITEM:OnPlayerSpawn( ply )
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end