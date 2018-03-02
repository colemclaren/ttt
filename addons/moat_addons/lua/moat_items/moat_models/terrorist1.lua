ITEM.ID = 1107
ITEM.Name = "Arctic Model"
ITEM.Description = "Chilli now isn't it.."
ITEM.Model = "models/player/arctic.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"

function ITEM:OnPlayerSpawn( ply )
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end