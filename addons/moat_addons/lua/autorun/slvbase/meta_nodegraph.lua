NODE_TYPE_GROUND = 2
NODE_TYPE_AIR = 3
NODE_TYPE_CLIMB = 4
NODE_TYPE_WATER = 5

local AINET_VERSION_NUMBER = 37
local NUM_HULLS = 10
local MAX_NODES = 1500

local SIZEOF_INT = 4
local SIZEOF_SHORT = 2
local function toUShort(b)
	local i = {string.byte(b,1,SIZEOF_SHORT)}
	return i[1] +i[2] *256
end
local function toInt(b)
	local i = {string.byte(b,1,SIZEOF_INT)}
	i = i[1] +i[2] *256 +i[3] *65536 +i[4] *16777216
	if(i > 2147483647) then return i -4294967296 end
	return i
end
local function ReadInt(f) return toInt(f:Read(SIZEOF_INT)) end
local function ReadUShort(f) return toUShort(f:Read(SIZEOF_SHORT)) end


local _R = debug.getregistry()
local meta = {}
_R.Nodegraph = meta
local methods = {}
meta.__index = methods
function meta:__tostring()
	local str = "Nodegraph [" .. table.Count(self:GetNodes()) .. " Nodes] [" .. table.Count(self:GetLinks()) .. " Links] [AINET " .. self:GetAINetVersion() .. "] [MAP " .. self:GetMapVersion() .. "]"
	return str
end
methods.MetaName = "Nodegraph"
function _R.Nodegraph.Create(f)
	local t = {}
	setmetatable(t,meta)
	if(f) then if(!t:ParseFile(f)) then t:Clear() end
	else t:Clear() end
	return t
end

function _R.Nodegraph.Read(f)
	if(!f) then f = "maps/graphs/" .. game.GetMap() .. ".ain" end
	return _R.Nodegraph.Create(f)
end

function methods:Clear()
	self.m_nodegraph = {
		ainet_version = AINET_VERSION_NUMBER,
		map_version = 1196,
		nodes = {},
		links = {},
		lookup = {}
	}
end

function methods:GetAINetVersion() return self:GetData().ainet_version end

function methods:GetMapVersion() return self:GetData().map_version end

function methods:ParseFile(f)
	f = file.Open(f,"rb","GAME")
		if(!f) then return end
		local ainet_ver = ReadInt(f)
		local map_ver = ReadInt(f)
		local nodegraph = {
			ainet_version = ainet_ver,
			map_version = map_ver
		}
		if(ainet_ver != AINET_VERSION_NUMBER) then
			MsgN("Unknown graph file")
			return
		end
		local numNodes = ReadInt(f)
		if(numNodes > MAX_NODES || numNodes < 0) then
			MsgN("Graph file has an unexpected amount of nodes")
			return
		end
		local nodes = {}
		for i = 1,numNodes do
			local v = Vector(f:ReadFloat(),f:ReadFloat(),f:ReadFloat())
			local yaw = f:ReadFloat()
			local flOffsets = {}
			for i = 1,NUM_HULLS do
				flOffsets[i] = f:ReadFloat()
			end
			local nodetype = f:ReadByte()
			local nodeinfo = ReadUShort(f)
			local zone = f:ReadShort()
			
			local node = {
				pos = v,
				yaw = yaw,
				offset = flOffsets,
				type = nodetype,
				info = nodeinfo,
				zone = zone,
				neighbor = {},
				numneighbors = 0,
				link = {},
				numlinks = 0
			}
			table.insert(nodes,node)
		end
		local numLinks = ReadInt(f)
		local links = {}
		for i = 1,numLinks do
			local link = {}
			local srcID = f:ReadShort()
			local destID = f:ReadShort()
			local nodesrc = nodes[srcID +1]
			local nodedest = nodes[destID +1]
			if(nodesrc && nodedest) then
				table.insert(nodesrc.neighbor,nodedest)
				nodesrc.numneighbors = nodesrc.numneighbors +1
				
				table.insert(nodesrc.link,link)
				nodesrc.numlinks = nodesrc.numlinks +1
				link.src = nodesrc
				link.srcID = srcID +1
				
				table.insert(nodedest.neighbor,nodesrc)
				nodedest.numneighbors = nodedest.numneighbors +1
				
				table.insert(nodedest.link,link)
				nodedest.numlinks = nodedest.numlinks +1
				link.dest = nodedest
				link.destID = destID +1
			else MsgN("Unknown link source or destination " .. srcID .. " " .. destID) end
			local moves = {}
			for i = 1,NUM_HULLS do
				moves[i] = f:ReadByte()
			end
			link.move = moves
			table.insert(links,link)
		end
		local lookup = {}
		for i = 1,numNodes do
			table.insert(lookup,ReadInt(f))
		end
	f:Close()
	nodegraph.nodes = nodes
	nodegraph.links = links
	nodegraph.lookup = lookup
	self.m_nodegraph = nodegraph
	return nodegraph
end

function methods:GetData() return self.m_nodegraph end

function methods:GetNodes() return self:GetData().nodes end
function methods:GetLinks() return self:GetData().links end
function methods:GetLookupTable() return self:GetData().lookup end

function methods:GetNode(nodeID) return self:GetNodes()[nodeID] end

function methods:AddNode(pos,type,yaw,info)
	type = type || NODE_TYPE_GROUND
	local nodes = self:GetNodes()
	local numNodes = table.Count(nodes)
	if(numNodes == MAX_NODES) then return false end
	local offset = {}
	for i = 1,NUM_HULLS do offset[i] = 0 end
	local node = {
		pos = pos,
		yaw = yaw || 0,
		offset = offset,
		type = type,
		info = info || 0,
		zone = 0,
		neighbor = {},
		numneighbors = 0,
		link = {},
		numlinks = 0
	}
	local nodeID = table.insert(nodes,node)
	local lookup = self:GetLookupTable()
	lookup[nodeID] = -1
	return nodeID
end

function methods:RemoveLinks(nodeID)
	local nodes = self:GetNodes()
	local node = nodes[nodeID]
	if(!node) then return end
	local links = self:GetLinks()
	for _,link in pairs(links) do
		if(link.dest == node) then
			links[_] = nil
			if(link.src) then
				for _,linkSrc in pairs(link.src.link) do
					if(linkSrc.dest == node || linkSrc.src == node) then
						link.src.link[_] = nil
					end
				end
			end
		elseif(link.src == node) then
			links[_] = nil
			if(link.dest) then
				for _,linkSrc in pairs(link.dest.link) do
					if(linkSrc.dest == node || linkSrc.src == node) then
						link.dest.link[_] = nil
					end
				end
			end
		end
	end
	node.link = {}
end

function methods:RemoveNode(nodeID)
	local nodes = self:GetNodes()
	if(!nodes[nodeID]) then return end
	self:RemoveLinks(nodeID)
	nodes[nodeID] = nil
	local lookup = self:GetLookupTable()
	lookup[nodeID] = nil
end

function methods:RemoveLink(src,dest)
	local nodes = self:GetNodes()
	local nodeSrc = nodes[src]
	local nodeDest = nodes[dest]
	if(!nodeSrc || !nodeDest) then return end
	local links = self:GetLinks()
	for _,link in pairs(links) do
		if((link.src == nodeSrc && link.dest == nodeDest) || (link.src == nodeDest && link.dest == nodeSrc)) then
			links[_] = nil
		end
	end
	for _,linkSrc in pairs(nodeSrc.link) do
		if((linkSrc.src == nodeSrc && linkSrc.dest == nodeDest) || (linkSrc.src == nodeDest && linkSrc.dest == nodeSrc)) then
			nodeSrc.link[_] = nil
		end
	end
	for _,linkDest in pairs(nodeDest.link) do
		if((linkDest.src == nodeSrc && linkDest.dest == nodeDest) || (linkDest.src == nodeDest && linkDest.dest == nodeSrc)) then
			nodeDest.link[_] = nil
		end
	end
end

function methods:AddLink(src,dest,move)
	if(src == dest) then return end
	local nodes = self:GetNodes()
	local nodeSrc = nodes[src]
	local nodeDest = nodes[dest]
	if(!nodeSrc || !nodeDest) then return end
	if(!move) then
		move = {}
		for i = 1,NUM_HULLS do move[i] = 1 end
	end
	local link = {
		src = nodeSrc,
		dest = nodeDest,
		srcID = src,
		destID = dest,
		move = move
	}
	table.insert(nodeSrc.link,link)
	table.insert(self:GetLinks(),link)
end

function methods:GetLink(src,dest)
	local nodes = self:GetNodes()
	local nodeSrc = nodes[src]
	local nodeDest = nodes[dest]
	if(!nodeSrc || !nodeDest) then return end
	for _,link in pairs(nodeSrc.link) do
		if(link.src == nodeDest || link.dest == nodeDest) then return link end
	end
	for _,link in pairs(nodeDest.link) do
		if(link.src == nodeSrc || link.dest == nodeSrc) then return link end
	end
end

function methods:HasLink(src,dest)
	return self:GetLink(src,dest) != nil
end

local function writeBytesInt(f,num)
	f:WriteByte(bit.band(num,0xFF))
	f:WriteByte(bit.rshift(num,bit.band(8,0xFF)))
	f:WriteByte(bit.rshift(num,bit.band(16,0xFF)))
	f:WriteByte(bit.rshift(num,bit.band(24,0xFF)))
end
local function writeBytesUShort(f,num)
	f:WriteByte(bit.band(num,0xFF))
	f:WriteByte(bit.rshift(num,bit.band(8,0xFF)))
end

function methods:Save(f)
	if(!f) then
		file.CreateDir("nodegraph")
		f = "nodegraph/" .. game.GetMap() .. ".txt"
	end
	local data = self:GetData()
	local nodes = data.nodes
	local nodeID = 1
	local nodeIDs = {}
	for _,node in pairs(nodes) do // Put everything in a sequential order
		nodes[_] = nil
		nodes[nodeID] = node
		nodeIDs[_] = nodeID
		nodeID = nodeID +1
	end
	local links = data.links
	local linkID = 1
	for _,link in pairs(links) do // Update the node IDs in the links and put everything in a sequential order
		links[_] = nil
		links[linkID] = link
		link.destID = nodeIDs[link.destID]
		link.srcID = nodeIDs[link.srcID]
		link.dest = nodes[link.destID]
		link.src = nodes[link.srcID]
		linkID = linkID +1
	end
	local lookup = table.Copy(data.lookup)
	data.lookup = {}
	for nodeID,_ in pairs(lookup) do // Update the lookup table
		data.lookup[nodeIDs[nodeID]] = _
	end
	lookup = data.lookup
	local f = file.Open(f,"wb","DATA")
		writeBytesInt(f,data.ainet_version)
		writeBytesInt(f,data.map_version)
		local numNodes = #nodes
		writeBytesInt(f,numNodes)
		for i = 1,numNodes do
			local node = nodes[i]
			for i = 1,3 do f:WriteFloat(node.pos[i]) end
			f:WriteFloat(node.yaw)
			for i = 1,NUM_HULLS do
				f:WriteFloat(node.offset[i])
			end
			f:WriteByte(node.type)
			writeBytesUShort(f,node.info)
			f:WriteShort(node.zone)
		end
		local numLinks = #links
		writeBytesInt(f,numLinks)
		for i = 1,numLinks do
			local link = links[i]
			f:WriteShort(link.srcID -1)
			f:WriteShort(link.destID -1)
			for i = 1,NUM_HULLS do
				f:WriteByte(link.move[i])
			end
		end
		for i = 1,numNodes do
			writeBytesInt(f,lookup[i])
		end
	f:Close()
end