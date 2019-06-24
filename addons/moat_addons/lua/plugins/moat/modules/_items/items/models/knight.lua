
ITEM.ID = 545

ITEM.Name = "Crimson Lance Model"

ITEM.Description = "Give me your keys."

ITEM.Model = "models/player/lordvipes/bl_clance/crimsonlanceplayer.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end