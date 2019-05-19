-- autorun/client/cl_vapeswep.lua
-- Defines clientside globals for Vape SWEP

-- Vape SWEP by Swamp Onions - http://steamcommunity.com/id/swamponions/

if not VapeParticleEmitter then VapeParticleEmitter = ParticleEmitter(Vector(0,0,0)) end

net.Receive("Vape",function()
	local ply = net.ReadEntity()
	local amt = net.ReadInt(8)
	local fx = net.ReadInt(8)
	if !IsValid(ply) then return end

	if amt>=50 then
		ply:EmitSound("vapecough1.wav",90)

		for i=1,200 do
			local d=i+10
			if i>140 then d=d+150 end
			timer.Simple((d-1)*0.003,function() vape_do_pulse(ply, 1, 100, fx) end)
		end

		return
	elseif amt>=35 then
		ply:EmitSound("vapebreath2.wav",75,100,0.7)
	elseif amt>=10 then
		ply:EmitSound("vapebreath1.wav",70,130-math.min(100,amt*2),0.4+(amt*0.005))
	end

	for i=1,amt*2 do
		timer.Simple((i-1)*0.02,function() vape_do_pulse(ply,math.floor(((amt*2)-i)/10), fx==2 and 100 or 0, fx) end)
	end
end)

net.Receive("VapeArm",function()
	local ply = net.ReadEntity()
	local z = net.ReadBool()
	if !IsValid(ply) then return end
	if ply.vapeArm != z then
		if z then
			timer.Simple(0.3, function() 
				if !IsValid(ply) then return end 
				if ply.vapeArm then ply:EmitSound("vape_inhale") end
			end)
		else
			ply:StopSound("vape_inhale")
		end
		ply.vapeArm = z
		ply.vapeArmTime = os.clock()
		local m = 0
		if z then m = 1 end

		for i=0,19 do
			timer.Simple(i/60,function() 
				vape_interpolate_arm(ply, math.abs(m-((19-i)/20)),z and 0 or 0.2) 
			end)
		end
	end
end)

net.Receive("VapeTalking",function()
	local ply = net.ReadEntity()
	if IsValid(ply) then ply.vapeTalkingEndtime = net.ReadFloat() end
end)

function vape_interpolate_arm(ply, mult, mouth_delay)
	if !IsValid(ply) then return end

	ply.vapeArmUpAmt = mult
	
	if mouth_delay>0 then 
		timer.Simple(mouth_delay,function() if IsValid(ply) then ply.vapeMouthOpenAmt = mult end end)
	else 
		ply.vapeMouthOpenAmt = mult
	end

	local b1 = ply:LookupBone("ValveBiped.Bip01_R_Upperarm")
	local b2 = ply:LookupBone("ValveBiped.Bip01_R_Forearm")
	if (not b1) or (not b2) then return end
	ply:ManipulateBoneAngles(b1,Angle(20*mult,-62*mult,10*mult))
	ply:ManipulateBoneAngles(b2,Angle(-5*mult,-10*mult,0))
	if mult==1 then ply.vapeArmFullyUp=true else ply.vapeArmFullyUp=false end
end

--this makes the mouth opening work without clobbering other addons
hook.Add("InitPostEntity", "VapeMouthMoveSetup", function()
	timer.Simple(1, function()
		if Vape_OriginalMouthMove ~= nil then return end

		Vape_OriginalMouthMove = GAMEMODE.MouthMoveAnimation
	 
		function GAMEMODE:MouthMoveAnimation(ply)
			--run the base MouthMoveAnimation if player isn't vaping/vapetalking
			if ((ply.vapeMouthOpenAmt or 0) == 0) and ((ply.vapeTalkingEndtime or 0) < CurTime()) then
				return Vape_OriginalMouthMove(GAMEMODE, ply)
			end

			local FlexNum = ply:GetFlexNum() - 1
			if ( FlexNum <= 0 ) then return end
			for i = 0, FlexNum - 1 do
				local Name = ply:GetFlexName(i)
				if ( Name == "jaw_drop" || Name == "right_part" || Name == "left_part" || Name == "right_mouth_drop" || Name == "left_mouth_drop" ) then
					ply:SetFlexWeight(i, math.max(((ply.vapeMouthOpenAmt or 0)*0.5), math.Clamp(((ply.vapeTalkingEndtime or 0)-CurTime())*3.0, 0, 1)*math.Rand(0.1,0.8) ))
				end
			end
		end
	end)
end)

function vape_do_pulse(ply, amt, spreadadd, fx)
	if !IsValid(ply) then return end

	if ply:WaterLevel()==3 then return end

	if not spreadadd then spreadadd=0 end

	local attachid = ply:LookupAttachment("eyes")
	VapeParticleEmitter:SetPos(LocalPlayer():GetPos())
	
	local angpos = ply:GetAttachment(attachid) or {Ang=Angle(0,0,0), Pos=Vector(0,0,0)}
	local fwd
	local pos
	
	if (ply != LocalPlayer()) then
		fwd = (angpos.Ang:Forward()-angpos.Ang:Up()):GetNormalized()
		pos = angpos.Pos + (fwd*3.5)
	else
		fwd = ply:GetAimVector():GetNormalized()
		pos = ply:GetShootPos() + fwd*1.5 + gui.ScreenToVector( ScrW()/2, ScrH() )*5
	end

	fwd = ply:GetAimVector():GetNormalized()

	for i = 1,amt do
		if !IsValid(ply) then return end
		local particle
		if fx == 6 then
			particle = VapeParticleEmitter:Add(string.format("effects/fire_cloud1"), pos)
			if ply==LocalPlayer() then table.insert(MyDragonVapeParticles, particle) end
		else
			particle = VapeParticleEmitter:Add(string.format("particle/smokesprites_00%02d",math.random(7,16)), pos)
		end
		if particle then
			local dir = VectorRand():GetNormalized() * ((amt+5)/10)
			vape_do_particle(particle, (ply:GetVelocity()*0.25)+(((fwd*9)+dir):GetNormalized() * math.Rand(50,80) * (amt + 1) * 0.2), fx)
		end
	end
end

function vape_do_particle(particle, vel, fx)
	particle:SetColor(255,255,255,255)
	if fx == 3 then particle:SetColor(220,255,230,255) end
	if fx == 4 then particle:SetColor(220,230,255,255) end
	if fx == 7 then particle:SetColor(vape_red_white_blue_chooser(math.random(0,2)/3)) end
	if fx >= 20 then 
		local c = JuicyVapeJuices[fx-19].color
		if c == nil then c = HSVToColor(math.random(0,359),1,1) end
		particle:SetColor(c.r, c.g, c.b, 255)
	end

	local mega = 1
	if fx == 2 then mega = 4 end
	
	particle:SetVelocity( vel * mega * (fx==6 and 2 or 1))
	particle:SetGravity( Vector(0,0,fx == 4 and 15 or 1.5) )
	particle:SetLifeTime(0)
	particle:SetDieTime(math.Rand(80,100)*0.11*mega)
	if fx==6 then particle:SetDieTime(math.Rand(80,100)*0.03) end
	particle:SetStartSize(2*mega)
	if fx==6 then particle:SetStartSize(3) end
	particle:SetEndSize(40*mega*mega)
	if fx==6 then particle:SetEndSize(20) end
	particle:SetStartAlpha(fx == 4 and 20 or 150)
	particle:SetEndAlpha(0)
	particle:SetCollide(true)
	particle:SetBounce(0.25)
	particle:SetRoll(math.Rand(0,360))
	particle:SetRollDelta(0.01*math.Rand(-40,40))
	particle:SetAirResistance(50)
	if fx==6 then particle:SetAirResistance(20) end
end

MyDragonVapeParticles = {}

function vape_red_white_blue_chooser(lerp)
	lerp = 3*lerp

	local v = nil

	local r = Vector(255,0,0)
	local w = Vector(255,255,255)
	local b = Vector(0,0,255)

	if lerp >= 2 then
		v = LerpVector(lerp-2,b,r)
	elseif lerp >= 1 then
		v = LerpVector(lerp-1,w,b)
	else
		v = LerpVector(lerp,r,w)
	end

	--particle:SetColor takes seperate parameters per channel
	return v.x,v.y,v.z,255
end

matproxy.Add({
	name = "VapeTankColor",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,
	bind = function( self, mat, ent )
		if ( !IsValid( ent ) ) then return end
		if ent:GetClass()=="viewmodel" then 
			ent=ent:GetOwner()
			if ( !IsValid( ent ) or !ent:IsPlayer() ) then return end
			ent=ent:GetActiveWeapon()
			if ( !IsValid( ent ) ) then return end
		end
		local v = ent.VapeTankColor or Vector(0.3,0.3,0.3)
		if v==Vector(-1,-1,-1) then
			local c = HSVToColor((CurTime()*60)%360,0.9,0.9)
			v = Vector(c.r,c.g,c.b)/255.0
		end
		if v==Vector(-2,-2,-2) then
			local c = Color(vape_red_white_blue_chooser((CurTime()*0.2)%1))
			v = Vector(c.r,c.g,c.b)/255.0
		end
		mat:SetVector(self.ResultTo, v)
	end
})

matproxy.Add({
	name = "VapeAccentColor",
	init = function( self, mat, values )
		self.ResultTo = values.resultvar
	end,
	bind = function( self, mat, ent )
		if ( !IsValid( ent ) ) then return end
		local o = ent:GetOwner()
		if ent:GetClass()=="viewmodel" then 
			if (!IsValid(o)) or (!o:IsPlayer()) then return end
			ent=o:GetActiveWeapon()
			if ( !IsValid( ent ) ) then return end
		end
		local col = ent.VapeAccentColor or Vector(1,1,1)
		if col==Vector(-1,-1,-1) then
			col=Vector(1,1,1)
			if IsValid(o) then col=o.CustomVapeColor or col end
		end
		mat:SetVector(self.ResultTo, col)
	end
})