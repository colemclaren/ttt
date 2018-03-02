
ITEM.ID = 531

ITEM.Name = "Inferno Armor Model"

ITEM.Description = "Now you can survive a wild volcano attack"

ITEM.Model = "models/mass effect 2/player/inferno_armour.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end