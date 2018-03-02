
ITEM.ID = 554

ITEM.Name = "Scorpion Model"

ITEM.Description = "(From Mortal Kombat) Just incase you thought it was the insect and you had a Giant Stinger"

ITEM.Model = "models/player/scorpion.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end