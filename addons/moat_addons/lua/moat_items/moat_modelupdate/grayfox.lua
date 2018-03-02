
ITEM.ID = 538

ITEM.Name = "Gray Fox Model"

ITEM.Description = "How nice. There's even a target to aim for right between the eyes"

ITEM.Model = "models/player/lordvipes/metal_gear_rising/gray_fox_playermodel_cvp.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end