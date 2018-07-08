ITEM.ID = 1119
ITEM.Name = "Police Model"
ITEM.Description = "Wow the police are here"
ITEM.Model = "models/player/police.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Titan Collection"

function ITEM:OnPlayerSpawn( ply )
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end