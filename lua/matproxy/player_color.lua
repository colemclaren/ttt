
--[[---------------------------------------------------------
	PlayerColor Material Proxy
		Sets the clothing colour of custom made models to
		ent.GetPlayerColor, a normalized vector colour.
-----------------------------------------------------------]]
local CSModel = {["class C_BaseFlex"] = true}

matproxy.Add( {
	name = "PlayerColor",

	init = function( self, mat, values )
		-- Store the name of the variable we want to set
		self.ResultTo = values.resultvar
	end,

	bind = function( self, mat, ent )
		if ( !IsValid( ent ) ) then return end

		-- If entity is a ragdoll try to convert it into the player
		-- ( this applies to their corpses )
		if ( ent:IsRagdoll() ) then
			local owner = ent:GetRagdollOwner()
			if ( IsValid( owner ) ) then ent = owner end
		end

		-- If the target ent has a function called GetPlayerColor then use that
		-- The function SHOULD return a Vector with the chosen player's colour.
		if ( ent.GetPlayerColor ) then
			local col = ent:GetPlayerColor()
			if ( isvector( col ) ) then
				mat:SetVector( self.ResultTo, col )
			end
		else
			mat:SetVector( self.ResultTo, Vector( 1, 1, 1 ) )
		end

		if (CSModel[ent:GetClass()] and MOAT_PAINT and m_Loadout and m_Loadout[10] and m_Loadout[10].p2 and m_Loadout[10].item and m_Loadout[10].item.Model == ent:GetModel() and MOAT_PAINT.Paints[m_Loadout[10].p2] and MOAT_PAINT.Paints[m_Loadout[10].p2][2]) then
			local col = MOAT_PAINT.Paints[m_Loadout[10].p2][2]
			if (MOAT_PAINT.Paints[m_Loadout[10].p2].Dream) then
				col = {rarity_names[9][2].r, rarity_names[9][2].g, rarity_names[9][2].b}
			end

			mat:SetVector(self.ResultTo, Vector(col[1]/255, col[2]/255, col[3]/255))
		end
	end
} )
