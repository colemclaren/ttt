
ITEM.ID = 543

ITEM.Name = "Jack Sparrow Model"

ITEM.Description = "This is the Tale of Captain Jack Sparrow, Pirate so Brave on the Seven Seas. A Mystical Quest to the Isle of Tortuga, Raven Locks sway on the Ocean's Breeze"

ITEM.Model = "models/player/jack_sparrow.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end