
ITEM.ID = 566

ITEM.Name = "Walter White Model"

ITEM.Description = [["Say my name". "I am the one who knocks". "You're Goddamn Right". I could go on all day, but there's only do much room in this box]]

ITEM.Model = "models/agent_47/agent_47.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end