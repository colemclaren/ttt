
include('shared.lua')

/*---------------------------------------------------------
   Name: Draw
   Desc: Draw it!
---------------------------------------------------------*/
function ENT:Draw()
	self.Entity:DrawModel()
end


/*---------------------------------------------------------
   Name: IsTranslucent
   Desc: Return whether object is translucent or opaque
---------------------------------------------------------*/
function ENT:IsTranslucent()
	return true
end

// the flash effect sticks when theres ANY amount of lag, so fuck that shit.