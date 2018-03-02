
ITEM.ID = 171

ITEM.Name = "Citizen Male 5"

ITEM.Description = "Just your average male citizen"

ITEM.Model = "models/player/Group01/male_05.mdl"

ITEM.Rarity = 1

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end