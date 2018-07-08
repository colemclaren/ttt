local minstd = {}
minstd.__index = minstd

local floor = math.floor
local time = os.time
local sqrt = math.sqrt
local log = math.log

--module( "minstd" )

-- MINSTD parameters
local NTAB = 32

local IA = 16807
local IM = 2147483647
local IQ = 127773
local IR = 2836
local NDIV = floor(1+(IM-1)/NTAB)
local MAX_RANDOM_RANGE = 0x7FFFFFFF

local AM = 1/IM
local EPS = 1.2e-7
local RNMX = 1-EPS

function minstd:SetSeed( iSeed )
	self.m_bTimeSeeded = false
	self.m_idum = iSeed < 0 and iSeed or -iSeed
	self.m_iy = 0
end

function minstd:SetTimeSeed( iSeed )
	self.m_bTimeSeeded = true
	
	if ( iSeed == 0 ) then
		idum = time()
	else
		idum = iSeed > 1000 and -iSeed or iSeed > -1000 and iSeed - 22261048 or iSeed
	end
end

-- Modified Lehmer random number generator
-- Returns integer [1, 2147483647)
function minstd:RandomNumber()
	local j = 0
	local k = 0
	
	if (self.m_idum <= 0 or self.m_iy == 0) then
		if (-self.m_idum < 1) then
			self.m_idum = 1
		else
			self.m_idum = -self.m_idum
		end
			
		for j=NTAB+8, 1, -1 do
			k = floor(self.m_idum/IQ)
			self.m_idum = IA*(self.m_idum-k*IQ)-IR*k
			if (self.m_idum < 0) then
				self.m_idum = self.m_idum+IM
			end
			if (j <= NTAB) then
				self.m_iv[j] = self.m_idum
			end
		end
		self.m_iy = self.m_iv[1]
	end
	k = floor(self.m_idum/IQ)
	self.m_idum = IA*(self.m_idum-k*IQ)-IR*k
	if (self.m_idum < 0) then
		self.m_idum = self.m_idum+IM
	end
	j = floor(self.m_iy/NDIV)
	self.m_iy = self.m_iv[j+1]
	self.m_iv[j+1] = self.m_idum

	return self.m_iy
end

-- Returns float [flLow, flHigh)
function minstd:RandomFloat( flLow --[[= 0]], flHigh --[[= 1]] )
	if ( self.m_bTimeSeeded and self.m_idum == 0 ) then
		self:SetTimeSeed(0)
	end
	
	if ( not flLow ) then
		flLow = 0
	end
	
	-- float in [0,1)
	local fl = AM * self:RandomNumber()
	
	-- Obey Source float limits
	if (fl > RNMX) then
		fl = RNMX
	elseif (fl < EPS) then
		fl = 0
	end
	
	return fl * ((flHigh or 1) - flLow) + flLow
end

-- Returns float [flLow, flHigh)
function minstd:RandomFloatExp( flLow --[[= 0]], flHigh --[[= 1]], flExponent --[[= 1]] )
	if ( self.m_bTimeSeeded and self.m_idum == 0 ) then
		self:SetTimeSeed(0)
	end
	
	if ( not flLow ) then
		flLow = 0
	end
	
	local fl = AM * self:RandomNumber()
	
	if (fl > RNMX) then
		fl = RNMX
	elseif (fl < EPS) then
		fl = 0
	end
	
	return fl ^ (flExponent or 1) * ((flHigh or 1) - flLow) + flLow
end

-- Returns double [flLow, flHigh)
function minstd:RandomDouble( flLow --[[= 0]], flHigh --[[= 1]] )
	if ( self.m_bTimeSeeded and self.m_idum == 0 ) then
		self:SetTimeSeed(0)
	end
	
	if ( not flLow ) then
		flLow = 0
	end
	
	-- double in [1/IM, 1)
	-- MINSTD is not widely distributed enough to go past double limits
	-- So we have to set the min value to 0
	local fl = AM * self:RandomNumber()
	
	if (fl == AM) then
		fl = 0
	end
	
	return fl * ((flHigh or 1) - flLow) + flLow -- float in [low,high)
end

-- Returns double [flLow, flHigh)
function minstd:RandomDoubleExp( flLow --[[= 0]], flHigh --[[= 1]], flExponent --[[= 1]] )
	if ( self.m_bTimeSeeded and self.m_idum == 0 ) then
		self:SetTimeSeed(0)
	end
	
	if ( not flLow ) then
		flLow = 0
	end
	
	local fl = AM * self:RandomNumber()
	
	if (fl == AM) then
		fl = 0
	end
	
	return fl ^ (flExponent or 1) * ((flHigh or 1) - flLow) + flLow
end

-- Returns integer [iLow, iHigh]
function minstd:RandomInt( iLow --[[= 0]], iHigh --[[= 1]] )
	if ( self.m_bTimeSeeded and self.m_idum == 0 ) then
		self:SetTimeSeed(0)
	end
	
	--assert(lLow <= lHigh)
	if ( not flLow ) then
		flLow = 0
	end
	
	local x = (iHigh or 1) - iLow + 1
	
	if (x <= 1 or MAX_RANDOM_RANGE < x-1) then
		return iLow
	end

	-- The following maps a uniform distribution on the interval [0,MAX_RANDOM_RANGE]
	-- to a smaller, client-specified range of [0,x-1] in a way that doesn't bias
	-- the uniform distribution unfavorably. Even for a worst case x, the loop is
	-- guaranteed to be taken no more than half the time, so for that worst case x,
	-- the average number of times through the loop is 2. For cases where x is
	-- much smaller than MAX_RANDOM_RANGE, the average number of times through the
	-- loop is very close to 1.
	local iMaxAcceptable = MAX_RANDOM_RANGE - (MAX_RANDOM_RANGE+1) % x 
	local n
	
	repeat
		n = self:RandomNumber()
	until (n <= iMaxAcceptable)

	return iLow + n % x
end


-------------------------------------------------------------------------------
--
-- Implementation of the gaussian random number stream
-- We're gonna use the Box-Muller method (which actually generates 2
-- gaussian-distributed numbers at once)
--
-------------------------------------------------------------------------------
function minstd:RandomGaussianFloat( flMean --[[= 0]], flStdDev --[[= 1]] )
	if (self.m_bHaveValue) then
		self.m_bHaveValue = false
		
		return (flStdDev or 1) * self.m_flRandomValue + (flMean or 0)
	end
	
	if ( self.m_bTimeSeeded and self.m_idum == 0 ) then
		SetTimeSeed(0)
	end
	
	-- Pick 2 random #s from -1 to 1
	-- Make sure they lie inside the unit circle. If they don't, try again
	local v1
	local v2
	local rsq
	
	repeat
		v1 = 2 * self:RandomFloat() - 1
		v2 = 2 * self:RandomFloat() - 1
		rsq = v1*v1 + v2*v2
	until (rsq <= 1 and rsq ~= 0)
	
	-- The box-muller transformation to get the two gaussian numbers
	local fac = sqrt( -2 * log(rsq) / rsq )
	
	-- Store off one value for later use
	self.m_flRandomValue = v1 * fac
	self.m_bHaveValue = true
	
	return (flStdDev or 1) * (v2 * fac) + (flMean or 0)
end

return setmetatable({
	m_idum = 0,
	m_iy = 0,
	m_iv = {},
	m_bTimeSeeded = false,
	m_bHaveValue = false,
	m_flRandomValue = 0
}, minstd )