ITEM.ID = 1108
ITEM.Name = "Guerilla Model"
ITEM.Description = "Go hide in the jungle"
ITEM.Model = "models/player/guerilla.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"

function ITEM:OnPlayerSpawn( ply )
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end