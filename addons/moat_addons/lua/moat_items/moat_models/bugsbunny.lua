ITEM.ID = 861
ITEM.Name = "Bunny Model"
ITEM.Description = "Eh... What's up doc? Hehe.."
ITEM.Model = "models/player/bugsb/bugsb.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"

function ITEM:OnPlayerSpawn(ply)
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end