
ITEM.ID = 529

ITEM.Name = "Chris Redfield Model"

ITEM.Description = "Just your typical Hunky, Sexy Military Man. All Homo"

ITEM.Model = "models/player/chris.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end