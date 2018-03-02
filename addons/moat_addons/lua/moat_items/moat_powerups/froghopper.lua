
ITEM.ID = 11

ITEM.Name = "Froghopper"

ITEM.NameEffect = "bounce"

ITEM.NameColor = Color( 255, 0, 0 )

ITEM.Description = "Froghoppers can jump 70 times their body height. Too bad this only allows you to jump +%s_ higher"

ITEM.Image = "moat_inv/jumpboost64.png" 

ITEM.Rarity = 2

ITEM.Collection = "Alpha Collection"

ITEM.Stats = {

	{ min = 15, max = 50 }

}

function ITEM:OnPlayerSpawn( ply, powerup_mods )

	local new_jump_power = ply.JumpHeight * ( 1 + ( ( self.Stats[1].min + ( ( self.Stats[1].max - self.Stats[1].min ) * powerup_mods[1] ) ) / 100 ) )

	ply:SetJumpPower( new_jump_power )

end