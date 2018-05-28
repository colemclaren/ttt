
ITEM.ID = 23

ITEM.Name = "Ammo Hoarder"

ITEM.NameColor = Color( 255, 102, 0 )

ITEM.Description = "Spawn with +%s_ more ammo in your reserves"

ITEM.Image = "https://moat.gg/assets/img/smithammoicon.png" 

ITEM.Rarity = 4

ITEM.Collection = "Alpha Collection"

ITEM.Stats = {

	{ min = 45, max = 125 }

}

function ITEM:OnPlayerSpawn( ply, powerup_mods )

	timer.Simple( 1, function()

		if ( ply:IsValid() ) then

			for k, v in pairs( ply:GetWeapons() ) do

				local ammo_type = v:GetPrimaryAmmoType()

				local max_clip = v:GetMaxClip1()

				local ammo_to_give = math.Clamp( ( ( self.Stats[1].min + ( ( self.Stats[1].max - self.Stats[1].min ) * powerup_mods[1] ) ) / 100 ) * (max_clip*2), 0, max_clip * 2 )

				ply:GiveAmmo( ammo_to_give, ammo_type, true )

			end

		end

	end )

end