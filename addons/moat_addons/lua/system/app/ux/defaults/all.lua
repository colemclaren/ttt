return function(p)
	function p:Size(w, h)
		self:SetSize(w or 0, h or w or 0)
		return self
	end

	function p:Pos(x, y)
		self:SetPos(x or 0, y or x or 0)
		return self
	end

	function p:Setup(x, y, w, h)
		self:Pos(x, y)
		self:Size(w, h)

		return self
	end

	function p:BounceIn(dir, bounce, toX, toY, bounceX, bounceY)
		local curX, curY = self:GetPos()
		local curW, curH = self:GetSize()
		
		bounce = bounce or 30
		if (dir == TOP) then
			toX, toY = toX or curX, toY or ux.CenterY(curH)
			bounceX, bounceY = bounceX or curX, bounceY or ux.CenterY(curH) - bounce
		elseif (dir == RIGHT) then
			toX, toY = toX or ux.CenterX(curW), toY or curY
			bounceX, bounceY = bounceX or ux.CenterX(curW) - bounce, bounceY or curY
		elseif (dir == LEFT) then
			toX, toY = toX or ux.CenterX(curW), toY or curY
			bounceX, bounceY = bounceX or ux.CenterX(curW) + bounce, bounceY or curY
		else
			toX, toY = toX or curX, toY or ux.CenterY(curH)
			bounceX, bounceY = bounceX or curX, bounceY or ux.CenterY(curH) + bounce
		end

		self:MoveTo(bounceX, bounceY, .2, 0, -1, function()
			if (not IsValid(self)) then return end
			self:MoveTo(toX, toY, .1, 0, -1)
		end)
	end

	function p:BounceOut(dir, bounce, toX, toY, bounceX, bounceY)
		local curX, curY = self:GetPos()
		local curW, curH = self:GetSize()
		
		bounce = bounce or 30
		if (dir == TOP) then
			toX, toY = toX or curX, toY or -curH
			bounceX, bounceY = bounceX or curX, bounceY or curY + bounce
		elseif (dir == RIGHT) then
			toX, toY = toX or ScrW(), toY or curY
			bounceX, bounceY = bounceX or curX - bounce, bounceY or curY
		elseif (dir == LEFT) then
			toX, toY = toX or -curW, toY or curY
			bounceX, bounceY = bounceX or curX + bounce, bounceY or curY
		else
			toX, toY = toX or curX, toY or ScrH()
			bounceX, bounceY = bounceX or curX, bounceY or curY - bounce
		end

		self:MoveTo(bounceX, bounceY, .2, 0, -1, function()
			if (not IsValid(self)) then return end
			self:MoveTo(toX, toY, .1, 0, -1, function()
				if (IsValid(self)) then self:Remove() end
			end)
		end)
	end

	function p:FadeIn(toX, toY, offset)
		offset = offset or 30

		self:SetPos(toX, toY - offset)
		self:SetAlpha(0)

		self:MoveTo(toX, toY, .2)
		self:AlphaTo(255, .2, 0)
	end

	function p:FadeOut(cb, offset, toX, toY)
		local curX, curY = self:GetPos()

		offset = offset or 30
		toX = toX or curX
		toY = toY or curY

		self:MoveTo(toX, toY - offset, .2)
		self:AlphaTo(0, .2, 0, function()
			if (cb) then cb(self) end
		end)
	end
end