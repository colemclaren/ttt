include('shared.lua')

AccessorFunc(SWEP,"m_bDrawn","Drawn",FORCE_BOOL)
local posStringBase = Vector(-14.039,5.068,0) *0.6
function SWEP:BuildBonePositions(numBones,numPhysBones)
	local boneID = self:LookupBone("stringbone")
	local owner = self:GetOwner()
	local pos,ang
	if(!self:GetDrawn()) then
		local attID = owner:LookupAttachment("shield")
		local att = owner:GetAttachment(attID)
		pos = att.Pos
		ang = att.Ang
		pos = pos +ang:Forward() *posStringBase.x +ang:Right() *posStringBase.y
		self:SetBonePosition(boneID,pos,ang)
	else
		local attID = owner:LookupAttachment("bow_string")
		local att = owner:GetAttachment(attID)
		pos = att.Pos
		ang = att.Ang
		self:SetBonePosition(boneID,pos,ang)
	end
end

net.Receive("sky_bow_draw",function(len)
	local ent = net.ReadEntity()
	if(!ent:IsValid()) then return end
	ent:SetDrawn(net.ReadUInt(1) == 1)
end)