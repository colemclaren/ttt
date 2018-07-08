
ITEM.ID = 165

ITEM.Name = "Citizen Female 5"

ITEM.Description = "Just your average female citizen"

ITEM.Model = "models/player/Group01/female_05.mdl"

ITEM.Rarity = 1

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end