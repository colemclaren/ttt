
ITEM.ID = 168

ITEM.Name = "Citizen Male 2"

ITEM.Description = "Just your average male citizen"

ITEM.Model = "models/player/Group01/male_02.mdl"

ITEM.Rarity = 1

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end