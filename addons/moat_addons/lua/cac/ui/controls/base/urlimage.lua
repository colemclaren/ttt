local self = {}

local material = CreateMaterial ("CAC.UrlImage", "UnlitGeneric",
	{
		["$vertexcolor"] = 1,
		["$vertexalpha"] = 1,
		["$translucent"] = 1
	}
)

function self:Init ()
	self.Url               = nil
	
	self.WaitingForTexture = false
	self.Texture           = nil
	self.ImageWidth        = 0
	self.ImageHeight       = 0
end

function self:Paint (w, h)
	if not self.Texture then
		if self.Url and
		   not self.WaitingForTexture then
			self.WaitingForTexture = true
			
			local url = self.Url
			CAC.ImageLoader:LoadImage (url,
				function (texture, width, height)
					if not self            then return end
					if not self:IsValid () then return end
					
					if self.Url ~= url     then return end
					
					self.Texture     = texture
					self.ImageWidth  = width
					self.ImageHeight = height
				end
			)
		end
		
		return
	end
	
	material:SetTexture ("$basetexture", self.Texture)
	
	render.PushFilterMag (TEXFILTER.ANISOTROPIC)
	render.PushFilterMin (TEXFILTER.ANISOTROPIC)
	surface.SetMaterial (material)
	surface.SetDrawColor (CAC.Colors.White)
	surface.DrawTexturedRect (0, 0, self.Texture:Width () * self:GetWidth () / self.ImageWidth, self.Texture:Height () * self:GetHeight () / self.ImageHeight)
	render.PopFilterMag ()
	render.PopFilterMin ()
end

function self:GetUrl ()
	return self.Url
end

function self:SetUrl (url)
	if self.Url == url then return self end
	
	self.Url               = url
	self.WaitingForTexture = false
	self.Texture           = nil
	
	return self
end

CAC.Register ("CACUrlImage", self, "CACPanel")