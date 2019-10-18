
ITEM.ID = 600

ITEM.Name = "Credit Hoarder"

ITEM.NameColor = Color( 255, 255, 0 )

ITEM.Description = "Start with %s extra credits as a detective/traitor when using this powerup"

ITEM.Image = "https://cdn.moat.gg/f/78738ccf67e834f86317059b2dd06caf.png"

ITEM.Rarity = 4

ITEM.Collection = "Crimson Collection"

ITEM.Stats = {

	{ min = 1, max = 5 }

}

function ITEM:OnBeginRound(ply, powerup_mods)
	timer.Simple(2, function()
		if (not IsValid(ply)) then return end
		if (ply:GetRole() and ply:GetRole() == ROLE_TRAITOR or ply:GetRole() == ROLE_DETECTIVE) then
			local new_credits = GetConVarNumber("ttt_credits_starting") + math.Round( self.Stats[1].min + ( ( self.Stats[1].max - self.Stats[1].min ) * powerup_mods[1] ) )
			ply:SetCredits(new_credits)
		end
	end)
end