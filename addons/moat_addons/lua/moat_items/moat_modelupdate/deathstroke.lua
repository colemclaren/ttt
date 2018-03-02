
ITEM.ID = 532

ITEM.Name = "Deathstroke Model"

ITEM.Description = "The result of Two-Face and Deadpool having a Baby"

ITEM.Model = "models/norpo/arkhamorigins/assassins/deathstroke_valvebiped.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end