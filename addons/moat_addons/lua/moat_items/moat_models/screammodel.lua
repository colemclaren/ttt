ITEM.ID = 5135
ITEM.Name = "Scream Model"
ITEM.Description = "Please do not scream as loud as you can when wearing this model"
ITEM.Model = "models/player/screamplayermodel/scream/scream.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"

function ITEM:OnPlayerSpawn( ply )
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end