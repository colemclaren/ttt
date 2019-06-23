
ITEM.ID = 543

ITEM.Name = "Spider-Man Model"

ITEM.Description = "My spider senses are starting to tingle!"

ITEM.Model = "models/otv/scarletspider.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end