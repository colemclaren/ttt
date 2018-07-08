ITEM.ID = 1116
ITEM.Name = "Super Soldier Model"
ITEM.Description = "Don't stand out too much from the terrorists"
ITEM.Model = "models/player/combine_super_soldier.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Titan Collection"

function ITEM:OnPlayerSpawn( ply )
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end