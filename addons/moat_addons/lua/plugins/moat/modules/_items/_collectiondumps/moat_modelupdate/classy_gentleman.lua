
ITEM.ID = 530

ITEM.Name = "Classy Gentleman Model"

ITEM.Description = "Only for the Most Dapper of Tea-Sipping Gentelmen"

ITEM.Model = "models/player/macdguy.mdl"

ITEM.Rarity = 8

ITEM.Collection = "George Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end