ANIMATION_FLAG_LOOP = 1

local _R = debug.getregistry()
local meta = {}
_R.Frame = meta
local methods = {}
meta.__index = methods
function meta:__tostring()
	return "Frame"
end
methods.MetaName = "Frame"
function _R.Frame.Create()
	local t = {}
	setmetatable(t,meta)
	t.m_bones = {}
	return t
end

function methods:GetBonePositions() return self.m_bones end

function methods:GetBonePosition(ID)
	if (!ID) then return end
	local bone = self:GetBonePositions()[ID]
	if(!bone) then return end
	return bone.pos,bone.ang
end

function methods:Scale(scale)
	local bones = self:GetBonePositions()
	for ID,bone in pairs(bones) do
		bone.pos = bone.pos *scale
	end
end

function methods:SetBonePosition(ID,pos,ang)
	local bones = self:GetBonePositions()
	bones[ID] = {
		pos = pos,
		ang = ang
	}
end

local VERSION = 2
local meta = {}
_R.Animation = meta
local methods = {}
meta.__index = methods
function meta:__tostring()
	return "Animation [" .. tostring(self:GetFrameCount()) .. "]"
end
methods.MetaName = "Animation"
function _R.Animation.Create()
	local t = {}
	setmetatable(t,meta)
	t.m_bones = {}
	t.m_bonesRoot = {}
	t.m_boneIDs = {}
	t.m_frames = {}
	t.m_events = {}
	t.m_numFrames = 0
	t.m_fps = 30
	t.m_flags = 0
	return t
end

function methods:AddFlags(flags) self.m_flags = bit.bor(self.m_flags,flags) end
function methods:RemoveFlags(flags) self.m_flags = self.m_flags -(bit.band(self.m_flags,flags)) end
function methods:GetFlags() return self.m_flags end
function methods:HasFlag(flag) return bit.band(self.m_flags,flag) == flag end
function methods:SetFlags(flags) self.m_flags = flags end
function methods:SetFPS(fps) self.m_fps = fps end
function methods:GetFPS() return self.m_fps end

function methods:Reverse()
	local frames = self:GetFrames()
	self.m_frames = {}
	for i = #frames,1,-1 do
		self:AddFrame(frames[i])
	end
end

function methods:Scale(scale)
	local frames = self:GetFrames()
	for i = 1,self:GetFrameCount() do
		local frame = frames[i]
		frame:Scale(scale)
	end
end

function methods:GetBoneName(ID)
	local bones = self:GetBones()
	if(!bones[ID]) then return end
	return bones[ID].name
end

function methods:GetBoneParent(ID)
	local bones = self:GetBones()
	if(!bones[ID]) then return end
	return bones[ID].parent
end

function methods:GetBoneID(name) return self.m_boneIDs[name] end

function methods:GetBones() return self.m_bones end
function methods:GetBone(ID) return self:GetBones()[ID] end
function methods:GetFrameCount() return self.m_numFrames end
function methods:GetFrames() return self.m_frames end

function methods:SetRootBone(bone)
	local ID = self:GetBoneID(bone)
	local data = self:GetBone(ID)
	if(!data) then MsgN("WARNING: Unable to set root bone '" .. bone .. "' for animation " .. tostring(self) .. ": Bone doesn't exist."); return end
	data.root = true
	table.insert(self.m_bonesRoot,ID)
end

function methods:GetRootBones() return self.m_bonesRoot end

function methods:IsRootBone(ID)
	local bone = self:GetBone(ID)
	if(!bone) then return false end
	return bone.root || false
end

function methods:AddBone(ID,parent,name)
	local bones = self:GetBones()
	bones[ID] = {
		name = name,
		parent = parent
	}
	self.m_boneIDs[name] = ID
end

function methods:AddFrame(frame)
	self.m_numFrames = table.insert(self.m_frames,frame)
	--print(self.m_numFrames) // Don't ask why this is here. For some reason m_numFrames becomes nil unless I print it to the console..............
end

function methods:AddEvent(frame,event)
	self.m_events[frame] = self.m_events[frame] || {}
	table.insert(self.m_events[frame],event)
end

function methods:GetEvents(frame)
	if(!frame) then return self.m_events end
	return self.m_events[frame]
end

function methods:ClearEvents() self.m_events = {} end

local function writeBytesUShort(f,num)
	f:WriteByte(bit.band(num,0xFF))
	f:WriteByte(bit.rshift(num,bit.band(8,0xFF)))
end

function methods:Save(name)
	local bones = self:GetBones()
	local numBones = #bones
	local f = file.Open(name,"wb","DATA")
	writeBytesUShort(f,VERSION)
	writeBytesUShort(f,numBones)
	for i = 0,numBones do
		local bone = bones[i]
		f:WriteShort(bone.parent)
		writeBytesUShort(f,#bone.name)
		f:Write(bone.name)
	end
	local bonesRoot = self:GetRootBones()
	local numRoot = #bonesRoot
	writeBytesUShort(f,numRoot)
	for i = 1,numRoot do
		local ID = bonesRoot[i]
		writeBytesUShort(f,ID)
	end
	writeBytesUShort(f,self:GetFlags())
	writeBytesUShort(f,self:GetFPS())
	local frames = self:GetFrames()
	local numFrames = self:GetFrameCount()
	writeBytesUShort(f,numFrames)
	for i = 1,numFrames do
		local frame = frames[i]
		local bones = frame:GetBonePositions()
		for j = 0,numBones do
			local bone = bones[j]
			local pos = bone.pos
			local ang = bone.ang
			f:WriteFloat(pos.x)
			f:WriteFloat(pos.y)
			f:WriteFloat(pos.z)
			f:WriteFloat(ang.p)
			f:WriteFloat(ang.y)
			f:WriteFloat(ang.r)
		end
		local events = self:GetEvents(i) || {}
		local numEvents = #events
		writeBytesUShort(f,numEvents)
		for j = 1,numEvents do
			local ev = events[j]
			writeBytesUShort(f,#ev)
			f:Write(ev)
		end
	end
	f:Close()
end

local SIZEOF_SHORT = 2
local function toUShort(b)
	local i = {string.byte(b,1,SIZEOF_SHORT)}
	return i[1] +i[2] *256
end
local function ReadUShort(f) return toUShort(f:Read(SIZEOF_SHORT)) end

function _R.Animation.Parse(fName)
	local anim = _R.Animation.Create()
	local f = file.Open(fName,"rb","GAME")
	if(!f) then return anim end
	local version = ReadUShort(f)
	local numBones = ReadUShort(f)
	local bones = {}
	for i = 0,numBones do
		local parent = f:ReadShort()
		local l = ReadUShort(f)
		local name = f:Read(l)
		anim:AddBone(i,parent,name)
		bones[i] = name
	end
	local numRoot = ReadUShort(f)
	for i = 1,numRoot do
		local bone = ReadUShort(f)
		local name = bones[bone]
		anim:SetRootBone(name)
	end
	local flags = ReadUShort(f)
	anim:SetFlags(flags)
	local fps = ReadUShort(f)
	anim:SetFPS(fps)
	local numframes = ReadUShort(f)
	for i = 1,numframes do
		local frame = _R.Frame.Create()
		for j = 0,numBones do
			frame:SetBonePosition(j,Vector(f:ReadFloat(),f:ReadFloat(),f:ReadFloat()),Angle(f:ReadFloat(),f:ReadFloat(),f:ReadFloat()))
		end
		anim:AddFrame(frame)
		local numEvents = ReadUShort(f)
		for j = 1,numEvents do
			local l = ReadUShort(f)
			local ev = f:Read(l)
			anim:AddEvent(i,ev)
		end
	end
	return anim
end