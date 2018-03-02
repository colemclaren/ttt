ITEM.ID = 862
ITEM.Name = "Eastertrooper Model"
ITEM.Description = "You sure this is where we're supposed to wait? - Yes"
ITEM.Model = "models/burd/player/eastertrooper/eastertrooper.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Easter Collection"

function ITEM:OnPlayerSpawn(ply)
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end