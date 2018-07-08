ITEM.ID = 7006 --models/gonzo/crimboclonesv2/elf/elf.mdl
ITEM.Name = "Batman Model"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/superheroes/batman.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Holiday Collection"

function ITEM:OnPlayerSpawn(ply)
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end