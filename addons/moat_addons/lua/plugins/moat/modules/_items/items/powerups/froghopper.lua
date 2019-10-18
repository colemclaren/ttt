
ITEM.ID = 11

ITEM.Name = "Froghopper"

ITEM.NameEffect = "bounce"

ITEM.NameColor = Color( 255, 0, 0 )

ITEM.Description = "Froghoppers can jump 70 times their body height. Too bad this only allows you to jump +%s_ higher"

ITEM.Image = "https://cdn.moat.gg/f/efbb38256abb921e7cc3425819f80949.png" 

ITEM.Rarity = 2

ITEM.Collection = "Alpha Collection"

ITEM.Stats = {

	{ min = 15, max = 50 }

}

function ITEM:OnPlayerSpawn( ply, powerup_mods )

	local new_jump_power = ply.JumpHeight * ( 1 + ( ( self.Stats[1].min + ( ( self.Stats[1].max - self.Stats[1].min ) * powerup_mods[1] ) ) / 100 ) )
	if (GetGlobal("MOAT_MINIGAME_ACTIVE")) then return end
	ply:SetJumpPower( new_jump_power )

end