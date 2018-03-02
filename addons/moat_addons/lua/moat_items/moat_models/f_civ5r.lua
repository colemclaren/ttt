
ITEM.ID = 189

ITEM.Name = "Rebel Female 5"

ITEM.Description = "Just your average rebel female citizen"

ITEM.Model = "models/player/Group03/female_05.mdl"

ITEM.Rarity = 2

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end