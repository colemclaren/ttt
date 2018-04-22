require("a_star_pathfinding")
file.CreateDir("aigraph")
local map = game.GetMap()
local _R = debug.getregistry()
local nodegraph = _R.Nodegraph.Read()
local nodegraph_default,links = nodegraph:GetNodes(),nodegraph:GetLinks()
local bNoNodegraph
if(!nodegraph_default) then
	nodegraph_default = {}
	links = {}
	bNoNodegraph = true
	MsgN("WARNING: No aigraph found!")
end
local nodes = {}
local nodeBlocks = {}
local nodesDefault = {}
local tblNodePositions = {}
for k, v in pairs(nodegraph_default) do
	if table.HasValue(tblNodePositions, v.pos) then
		nodegraph_default[k] = nil
	else
		tblNodePositions[k] = v.pos
	end
end
local nodesGround
local nodesAir
local nodesClimb
local nodesWater

if(CLIENT) then
	HULL_HUMAN = 0
	HULL_SMALL_CENTERED = 1
	HULL_WIDE_HUMAN = 2
	HULL_TINY = 3
	HULL_WIDE_SHORT = 4
	HULL_MEDIUM = 5
	HULL_TINY_CENTERED = 6
	HULL_LARGE = 7
	HULL_LARGE_CENTERED = 8
	HULL_MEDIUM_TALL = 9
end

local HULL_HUMAN = HULL_HUMAN
local HULL_SMALL_CENTERED = HULL_SMALL_CENTERED
local HULL_WIDE_HUMAN = HULL_WIDE_HUMAN
local HULL_TINY = HULL_TINY
local HULL_WIDE_SHORT = HULL_WIDE_SHORT
local HULL_MEDIUM = HULL_MEDIUM
local HULL_TINY_CENTERED = HULL_TINY_CENTERED
local HULL_LARGE = HULL_LARGE
local HULL_LARGE_CENTERED = HULL_LARGE_CENTERED
local HULL_MEDIUM_TALL = HULL_MEDIUM_TALL

HULL_MOVE_HUMAN = 1
HULL_MOVE_SMALL_CENTERED = 2
HULL_MOVE_WIDE_HUMAN = 4
HULL_MOVE_TINY = 8
HULL_MOVE_WIDE_SHORT = 16
HULL_MOVE_MEDIUM = 32
HULL_MOVE_TINY_CENTERED = 64
HULL_MOVE_LARGE = 128
HULL_MOVE_LARGE_CENTERED = 256
HULL_MOVE_MEDIUM_TALL = 512
local tbHulls = {
	[HULL_HUMAN] = HULL_MOVE_HUMAN,
	[HULL_SMALL_CENTERED] = HULL_MOVE_SMALL_CENTERED,
	[HULL_WIDE_HUMAN] = HULL_MOVE_WIDE_HUMAN,
	[HULL_TINY] = HULL_MOVE_TINY,
	[HULL_WIDE_SHORT] = HULL_MOVE_WIDE_SHORT,
	[HULL_MEDIUM] = HULL_MOVE_MEDIUM,
	[HULL_TINY_CENTERED] = HULL_MOVE_TINY_CENTERED,
	[HULL_LARGE] = HULL_MOVE_LARGE,
	[HULL_LARGE_CENTERED] = HULL_MOVE_LARGE_CENTERED,
	[HULL_MEDIUM_TALL] = HULL_MOVE_MEDIUM_TALL
}

function util.GetMoveHull(hull) return tbHulls[hull] || 0 end

local bEdited = false
local numBlocksAxis = 10
local function InitNodeSystem()
	local szMax = 2 ^14 // 16384
	local szMin = -szMax
	local szBounds = szMax *2
	local min = Vector(szMin,szMin,szMin)
	local max = Vector(szMax,szMax,szMax)
	local bounds = Vector(szBounds,szBounds,szBounds)
	local block = szBounds /numBlocksAxis
	local vecBlock = Vector(block,block,block)
	nodeBlocks = {}
	for x = 1,numBlocksAxis do
		nodeBlocks[x] = {}
		for y = 1,numBlocksAxis do
			nodeBlocks[x][y] = {}
			local mins = min +Vector(vecBlock.x *(x -1),vecBlock.y *(y -1),min.z)
			local maxs = mins +vecBlock
			maxs.z = max.z
			nodeBlocks[x][y] = {
				mins = mins,
				maxs = maxs,
				nodes = {},
				numNodes = 0
			}
		end
	end
	nodesGround = {}
	nodesAir = {}
	nodesClimb = {}
	nodesWater = {}
	local content = file.Read("aigraph/" .. game.GetMap() .. ".txt")
	bEdited = true
	if(content) then
		//bEdited = true
		local bSuccess,data = pcall(glon.decode,content)
		if(!bSuccess) then
			MsgN("Unable to load nodegraph: '" .. data .. "'.")
			nodes = table.Copy(nodesDefault)
			return
		end
		if(!data.flags || bit.band(data.flags,1) != 1) then
			nodes = table.Copy(nodesDefault)
		else MsgN("Nodegraph has flag 'Ignore Default Nodegraph' set. Default nodegraph will not be loaded.") end
		for ID,node in pairs(data.nodes) do
			node.ID = ID
			node.links = {}
		end
		for _,link in ipairs(data.links) do
			local ID = link[1]
			local dest = link[2]
			local move = link[3]
			local type = link[4]
			local flags = link[5]
			
			local node = data.nodes[ID]
			local tbLinkSrc = {
				dest = dest,
				move = move,
				type = type,
				flags = flags
			}
			table.insert(node.links,tbLinkSrc)
			local tbLinkTgt = table.Copy(tbLinkSrc)
			tbLinkTgt.dest = ID
			if(!nodes[dest]) then	-- If not a vanilla node
				table.insert(data.nodes[dest].links,tbLinkTgt)
			else
				table.insert(nodes[dest].links,tbLinkTgt)
			end
		end
		table.Merge(nodes,data.nodes)
	else
		MsgN("No custom nodegraph found!")
		nodes = table.Copy(nodesDefault)
	end
	for ID, node in pairs(nodes) do
		if(node.type == 2) then nodesGround[ID] = node
		elseif(node.type == 3) then nodesAir[ID] = node
		elseif(node.type == 4) then nodesClimb[ID] = node
		elseif(node.type == 5) then nodesWater[ID] = node end
		local pos = node.pos
		local bFound
		for x = 1,numBlocksAxis do
			for y = 1,numBlocksAxis do
				local data = nodeBlocks[x][y]
				local mins = data.mins
				local maxs = data.maxs
				if(pos.x >= mins.x && pos.y >= mins.y
					&& pos.x < maxs.x && pos.y < maxs.y) then
					table.insert(data.nodes,node)
					bFound = true
					break
				end
			end
			if(bFound) then break end
		end
	end
	for x = 1,numBlocksAxis do
		for y = 1,numBlocksAxis do
			nodeBlocks[x][y].numNodes = #nodeBlocks[x][y].nodes
		end
	end
end
debug.sethook()
for ID, node in pairs(nodegraph_default) do
	nodesDefault[ID] = {ID = ID, persistent = true}
	for key,info in pairs(node) do
		if(key == "link") then
			nodesDefault[ID].links = {}
			local links = {}
			for IDDest,link in pairs(info) do
				local nodeDest
				if(link.dest.pos != node.pos) then nodeDest = link.dest
				elseif(link.src.pos != node.pos) then nodeDest = link.src end
				if(nodeDest) then
					local IDDest
					for ID,pos in pairs(tblNodePositions) do
						if(pos == nodeDest.pos) then IDDest = ID; break end
					end
					if(IDDest && !links[IDDest]) then
						local move = 0
						for hull,mv in pairs(link.move) do
							if(mv > 0) then move = move +util.GetMoveHull(hull -1) end
						end
						table.insert(nodesDefault[ID].links,{
							dest = IDDest,
							type = 0,
							move = move
						})
						links[IDDest] = true
					end
				end
			end
		/*elseif(key == "offset") then
			local iHull = 0
			local iHullCur = 1
			local i = 1
			while iHullCur <= 512 do
				if v[i] > 0 then iHull = iHull +iHullCur end
				i = i +1
				iHullCur = iHullCur *2
			end
			nodesDefault[ID]["move"] = iHull*/
		elseif(key == "pos" || key == "info" || key == "yaw" || key == "zone" || key == "type") then
			nodesDefault[ID][key] = info
		end
	end
end
InitNodeSystem()

local ipairs = ipairs
local pairs = pairs
local table = table
local math = math
local util = util
local Vector = Vector
local astar = astar
local file = file
local game = game
local tostring = tostring
local timer = timer
local debug = debug
local glon = glon
local pcall = pcall
local MsgN = MsgN
local MsgPrint = MsgPrint
local bit = bit

module("nodegraph")

function GetNodeBlocks()
	return nodeBlocks
end

function GetNodes(iType)
	return !iType && nodes || iType == 2 && nodesGround || iType == 3 && nodesAir || iType == 4 && nodesClimb || iType == 5 && nodesWater
end

function GetByID(ID) return nodes[ID] end

function Reload()
	InitNodeSystem()
end

function GetGroundNodes()
	return nodesGround
end

function GetAirNodes()
	return nodesAir
end

function GetClimbNodes()
	return nodesClimb
end

function GetWaterNodes()
	return nodesWater
end

function IsEdited()
	return bEdited
end

function FindNodesInSphere(pos, dist, iType,move,nodes)
	local tbNodes = {}
	for _, node in pairs(nodes || GetNodes(iType)) do
		local bValid
		if(!move) then bValid = true
		else
			for _,link in pairs(node.links) do
				if(link.move && bit.band(link.move,move) == move) then
					bValid = true
					break
				end
			end
		end
		if(bValid && node.pos:Distance(pos) <= dist) then table.insert(tbNodes, node) end
	end
	return tbNodes
end

function GetNodeLinks(node, iType)
	if !node then return links || {} end
	iType = iType || 2
	for k, v in pairs(GetNodes(iType)) do
		if v.pos == node.pos then
			return v.link
		end
	end
	return {}
end

local function FindSecondClosestBlock(pos)
	local blocks = GetNodeBlocks()
	local distClosest = math.huge
	local blockClosest
	local blockClosestSecond
	for x = 1,numBlocksAxis do
		for y = 1,numBlocksAxis do
			local data = blocks[x][y]
			if(data.numNodes > 0) then // Ignore empty blocks
				local mins = data.mins
				local maxs = data.maxs
				local dist = 0
				if(pos.x < mins.x) then dist = dist +(mins.x -pos.x)
				elseif(pos.x > maxs.x) then dist = dist +(pos.x -maxs.x) end
				if(pos.y < mins.y) then dist = dist +(mins.y -pos.y)
				elseif(pos.y > maxs.y) then dist = dist +(pos.y -maxs.y) end
				if(dist < distClosest) then
					blockClosestSecond = blockClosest
					distClosest = dist
					blockClosest = data
				end
			end
		end
	end
	return blockClosestSecond
end

local function _FindClosestNode(pos,type,move,nodes) // Obsolete; Still used by function below
	type = type || 2
	local distClosest = math.huge
	local nodeClosest
	for _, node in pairs(nodes || GetNodes(type)) do
		local dist = (node.pos -pos):LengthSqr()
		if(dist < distClosest) then
			local bValid
			if(!move) then bValid = true
			else
				for _,link in pairs(node.links) do
					if(link.move && bit.band(link.move,move) == move) then
						bValid = true
						break
					end
				end
			end
			if(bValid) then
				distClosest = dist
				nodeClosest = node
			end
		end
	end
	return nodeClosest,distClosest
end
function FindClosestNode(pos,type,move) // Checks individual blocks first, so we don't have to check every single node
	type = type || 2
	local blocks = GetNodeBlocks()
	for x = 1,numBlocksAxis do
		for y = 1,numBlocksAxis do
			local data = blocks[x][y]
			local mins = data.mins
			local maxs = data.maxs
			if(pos.x >= mins.x && pos.y >= mins.y &&
				pos.x < maxs.x && pos.y < maxs.y) then
				if(data.numNodes == 0) then -- Don't bother; Check next closest block instead
					local block = FindSecondClosestBlock(pos)
					if(!block || block.numNodes == 0) then -- This was a waste of resources; Just check all nodes
						return _FindClosestNode(pos,type,move)
					else return _FindClosestNode(pos,type,move,block.nodes) end
				else return _FindClosestNode(pos,type,move,data.nodes) end
			end
		end
	end
	return _FindClosestNode(pos,type,move)
end
GetClosestNode = FindClosestNode -- Backwards compatibility

function FindClosestVisibleNode(pos,type,move,nodes) -- More expensive than FindClosestNode; Only use when neccessary
	type = type || 2
	local blocks = GetNodeBlocks()
	if(!nodes) then
		for x = 1,numBlocksAxis do
			for y = 1,numBlocksAxis do
				local data = blocks[x][y]
				local mins = data.mins
				local maxs = data.maxs
				if(pos.x >= mins.x && pos.y >= mins.y &&
					pos.x < maxs.x && pos.y < maxs.y) then
					if(data.numNodes == 0) then -- Don't bother; Check next closest block instead
						local block = FindSecondClosestBlock(pos)
						if(!block || block.numNodes == 0) then -- This was a waste of resources; Just check all nodes
							return FindClosestVisibleNode(pos,type,move,GetNodes(type))
						else return FindClosestVisibleNode(pos,type,move,block.nodes) end
					else return FindClosestVisibleNode(pos,type,move,data.nodes) end
				end
			end
		end
	end
	local nodesClose = FindNodesInSphere(pos,100,type,move,nodes)	-- Only checking nodes in a close proximity
	local nodeClosest
	local distClosest = math.huge
	local offset = Vector(0,0,3)
	pos = pos +offset
	for _,node in ipairs(nodesClose) do
		local dist = pos:Distance(node.pos)
		if(dist < distClosest) then
			local tr = util.TraceLine({
				start = pos,
				endpos = node.pos +offset,
				mask = MASK_SOLID_BRUSHONLY
			})
			if(!tr.HitWorld) then
				dist = distClosest
				nodeClosest = node
			end
		end
	end
	return nodeClosest || _FindClosestNode(pos,type,move,nodes)
end

function GetLink(nodeA,nodeB)
	for _,link in pairs(nodeA.links) do
		if(link.dest == nodeB.ID) then return link end
	end
	return false
end

function Exists()
	return table.Count(nodes) > 0 || false
end

local function HullCanUsePath(iMove, iHull)
	local hullID = util.GetMoveHull(iHull)
	return bit.band(iMove,hullID) == hullID
end

function GeneratePath(posStart, posEnd, iType, iHull, fcLinkFilter)
	if !Exists() || table.IsEmpty(GetNodes(iType)) then return {} end
	local nodeStart = FindClosestVisibleNode(posStart,iType,util.GetMoveHull(iHull))
	local nodeEnd = FindClosestVisibleNode(posEnd,iType,util.GetMoveHull(iHull))
	local b, _path, nStatus = astar.CalculatePath(nodeStart, nodeEnd, function(node)
		local tblNeigh = {}
		for k, v in pairs(node.links) do
			table.insert(tblNeigh, nodes[v.dest])
		end
		return pairs(tblNeigh)
	end, function(nodeCur, nodeNeigh, nodeStart, nodeTarget, heuristic, ...)
		for k, v in pairs(nodeCur.links) do
			if nodes[v.dest].pos == nodeNeigh.pos then
				if (v.type == 2 && nodeCur.pos.z < nodeNeigh.pos.z) || (iHull && !HullCanUsePath(v.move, iHull)) then
					return false
				end
			end
		end
		return !fcLinkFilter || fcLinkFilter(nodeCur, nodeNeigh)
	end, function(nodeA, nodeB)
		return nodeA.pos:Distance(nodeB.pos)
	end, function(nodeCur, nodeNeigh, nodeStart, nodeTarget, heuristic, ...)
		return 1
	end)
	local path = {}
	for i = #_path, 1, -1 do
		path[(#_path +1) -i] = _path[i]
	end
	return path, nodeStart, nodeEnd
end

function CreateAstarObject(posStart, posEnd, iType, iHull, fcLinkFilter,heuristic)
	if !Exists() || table.IsEmpty(GetNodes(iType)) then return nil end
	local nodeStart = FindClosestVisibleNode(posStart, iType,util.GetMoveHull(iHull))
	local nodeEnd = FindClosestVisibleNode(posEnd, iType,util.GetMoveHull(iHull))
	local objAstar = astar.Create(nodeStart, nodeEnd, function(node)
		local tblNeigh = {}
		for k, v in pairs(node.links) do
			table.insert(tblNeigh, nodes[v.dest])
		end
		return pairs(tblNeigh)
	end, function(nodeCur, nodeNeigh, nodeStart, nodeTarget, heuristic, ...)
		for k, v in pairs(nodeCur.links) do
			if nodes[v.dest].pos == nodeNeigh.pos then
				if (v.type == 2 && nodeCur.pos.z < nodeNeigh.pos.z) || (iHull && !HullCanUsePath(v.move, iHull)) then
					return false
				elseif(fcLinkFilter) then return fcLinkFilter(nodeCur,nodeNeigh,v) end
				break
			end
		end
		return !fcLinkFilter || fcLinkFilter(nodeCur, nodeNeigh)
	end, function(nodeA, nodeB)
		--local cost = (nodeB.pos.x -nodeA.pos.x)^2 +(nodeB.pos.y -nodeA.pos.y)^2 +(nodeB.pos.z -nodeA.pos.z)^2
		--return heuristic && heuristic(nodeA.pos,nodeB.pos,cost) || cost
		local cost = nodeA.pos:Distance(nodeB.pos)
		return heuristic && heuristic(nodeA.pos,nodeB.pos,cost) || cost
	end, function(nodeCur, nodeNeigh, nodeStart, nodeTarget, heuristic, ...)
		return 1
	end)
	return objAstar
end

local function HullAccessable(posStart, posEnd, hull)
	local tblTraces = {}
	local tblTrPos = {
		{start = Vector(0,0,(hull.max.z +hull.min.z) *0.5), endpos = Vector(0,0,(hull.max.z +hull.min.z) *0.5)},
		{start = Vector(0,0,hull.max.z), endpos = Vector(0,0,hull.max.z)},
		{start = Vector(0,0,hull.min.z), endpos = Vector(0,0,hull.min.z)},
		{start = Vector(hull.max.x,hull.max.y,(hull.max.z +hull.min.z) *0.5), endpos = Vector(hull.max.x,hull.max.y,(hull.max.z +hull.min.z) *0.5)},
		{start = Vector(hull.min.x,hull.min.y,(hull.max.z +hull.min.z) *0.5), endpos = Vector(hull.min.x,hull.min.y,(hull.max.z +hull.min.z) *0.5)},
		{start = Vector(hull.min.x,hull.min.y,hull.max.z), endpos = Vector(hull.max.x,hull.max.y,hull.max.z)},
		{start = Vector(hull.max.x,hull.max.y,hull.max.z), endpos = Vector(hull.min.x,hull.min.y,hull.max.z)},
		{start = Vector(hull.min.x,hull.min.y,hull.min.z), endpos = Vector(hull.max.x,hull.max.y,hull.min.z)},
		{start = Vector(hull.max.x,hull.max.y,hull.min.z), endpos = Vector(hull.min.x,hull.min.y,hull.min.z)},
		{start = Vector(hull.min.x,hull.min.y,hull.max.z), endpos = Vector(hull.min.x,hull.min.y,hull.min.z)},
		{start = Vector(hull.min.x,hull.min.y,hull.min.z), endpos = Vector(hull.min.x,hull.min.y,hull.max.z)},
		{start = Vector(hull.max.x,hull.max.y,hull.max.z), endpos = Vector(hull.max.x,hull.max.y,hull.min.z)},
		{start = Vector(hull.max.x,hull.max.y,hull.min.z), endpos = Vector(hull.max.x,hull.max.y,hull.max.z)}
	}

	for k, v in pairs(tblTrPos) do
		table.insert(tblTraces, util.TraceLine({start = posStart +v.start, endpos = posEnd +v.endpos, mask = MASK_NPCWORLDSTATIC}))
	end

	local tblTrPos = {hull.max, hull.min, Vector(hull.max.x, hull.max.y, hull.min.z), Vector(hull.min.x, hull.min.y, hull.max.z)}
	for k, v in pairs(tblTrPos) do
		table.insert(tblTraces, util.TraceLine({start = posStart +v, endpos = posEnd +v, mask = MASK_NPCWORLDSTATIC}))
		if k == 1 || k == 3 then
			table.insert(tblTraces, util.TraceLine({start = posStart +v, endpos = posEnd +tblTrPos[k +1], mask = MASK_NPCWORLDSTATIC}))
		else
			table.insert(tblTraces, util.TraceLine({start = posStart +v, endpos = posEnd +tblTrPos[k -1], mask = MASK_NPCWORLDSTATIC}))
		end
	end

	for k, v in pairs(tblTraces) do
		if v.Hit then return false end
	end
	return true
end

function AddLink(nodeIDStart,nodeIDEnd,iType,iForceHulls,flags,hullsIgnore)
	if(flags == 0) then flags = nil end
	local tblHulls = {
		HULL_HUMAN = {max = Vector(13, 13, 72), min = Vector(-13, -13, 0)},
		HULL_SMALL_CENTERED = {max = Vector(20, 20, 40), min = Vector(-20, -20, 0)},
		HULL_WIDE_HUMAN = {max = Vector(15, 15, 72), min = Vector(-15, -15, 0)},
		HULL_TINY = {max = Vector(12, 12, 24), min = Vector(-12, -12, 0)},
		HULL_WIDE_SHORT = {max = Vector(35, 35, 32), min = Vector(-35, -35, 0)},
		HULL_MEDIUM = {max = Vector(16, 16, 64), min = Vector(-16, -16, 0)},
		HULL_TINY_CENTERED = {max = Vector(8, 8, 8), min = Vector(-8, -8, 0)},
		HULL_LARGE = {max = Vector(40, 40, 100), min = Vector(-40, -40, 0)},
		HULL_LARGE_CENTERED = {max = Vector(38, 38, 76), min = Vector(-38, -38, 0)},
		HULL_MEDIUM_TALL = {max = Vector(18, 18, 100), min = Vector(-18, -18, 0)}
	}
	
	local nodeType = nodes[nodeIDStart].type
	if nodeType == 3 then
		for k, v in pairs(tblHulls) do
			v.max.z = v.max.z *0.5
			v.min.z = -v.max.z
		end
	end
	
	local tblHullIDs = {
		HULL_HUMAN = 1,
		HULL_SMALL_CENTERED = 2,
		HULL_WIDE_HUMAN = 4,
		HULL_TINY = 8,
		HULL_WIDE_SHORT = 16,
		HULL_MEDIUM = 32,
		HULL_TINY_CENTERED = 64,
		HULL_LARGE = 128,
		HULL_LARGE_CENTERED = 256,
		HULL_MEDIUM_TALL = 512
	}
	
	local nodeEnd = GetNodes(nodeType)[nodeIDEnd]
	local posEnd = nodeEnd.pos +Vector(0,0,3)
	local posStart = nodeEnd.pos +Vector(0,0,3)
	local iHullsAccessable = 0
	local forceHulls = iForceHulls || 0
	for k, v in pairs(tblHulls) do
		if((!hullsIgnore || bit.band(hullsIgnore,tblHullIDs[k]) == 0) && (bit.band(forceHulls,tblHullIDs[k]) == tblHullIDs[k] || HullAccessable(posStart, posEnd, v))) then
			iHullsAccessable = iHullsAccessable +tblHullIDs[k]
		end
	end
	local tbl = nodeType == 2 && nodesGround || nodeType == 3 && nodesAir || nodeType == 4 && nodesClimb || nodesWater
	table.insert(tbl[nodeIDStart].links, {dest = nodeIDEnd, move = iHullsAccessable, type = iType,flags = flags})
	table.insert(tbl[nodeIDEnd].links, {dest = nodeIDStart, move = iHullsAccessable, type = iType,flags = flags})
end

function MakeEditable()
	for ID,node in pairs(GetNodes()) do
		if(node.persistent) then
			node.persistent = nil
			node.zone = nil
		end
	end
	Save(1)
end

function AddNode(pos, iType, iForceHulls)
	local iNodeID = 0
	for k, v in pairs(nodes) do
		if k > iNodeID then iNodeID = k end
	end
	iNodeID = iNodeID +1
	local links = {}
	
	local tblHulls = {
		HULL_HUMAN = {max = Vector(13, 13, 72), min = Vector(-13, -13, 0)},
		HULL_SMALL_CENTERED = {max = Vector(20, 20, 40), min = Vector(-20, -20, 0)},
		HULL_WIDE_HUMAN = {max = Vector(15, 15, 72), min = Vector(-15, -15, 0)},
		HULL_TINY = {max = Vector(12, 12, 24), min = Vector(-12, -12, 0)},
		HULL_WIDE_SHORT = {max = Vector(35, 35, 32), min = Vector(-35, -35, 0)},
		HULL_MEDIUM = {max = Vector(16, 16, 64), min = Vector(-16, -16, 0)},
		HULL_TINY_CENTERED = {max = Vector(8, 8, 8), min = Vector(-8, -8, 0)},
		HULL_LARGE = {max = Vector(40, 40, 100), min = Vector(-40, -40, 0)},
		HULL_LARGE_CENTERED = {max = Vector(38, 38, 76), min = Vector(-38, -38, 0)},
		HULL_MEDIUM_TALL = {max = Vector(18, 18, 100), min = Vector(-18, -18, 0)}
	}
	
	if iType == 3 then
		for k, v in pairs(tblHulls) do
			v.max.z = v.max.z *0.5
			v.min.z = -v.max.z
		end
	end
	
	local tblHullIDs = {
		HULL_HUMAN = 1,
		HULL_SMALL_CENTERED = 2,
		HULL_WIDE_HUMAN = 4,
		HULL_TINY = 8,
		HULL_WIDE_SHORT = 16,
		HULL_MEDIUM = 32,
		HULL_TINY_CENTERED = 64,
		HULL_LARGE = 128,
		HULL_LARGE_CENTERED = 256,
		HULL_MEDIUM_TALL = 512
	}
	
	local forceHulls = iForceHulls || 0
	for k, v in pairs(GetNodes(iType)) do
		if v.pos != pos && v.pos:Distance(pos) <= 320 then
			local tr = util.TraceLine({start = v.pos +Vector(0,0,3), endpos = pos +Vector(0,0,3), mask = MASK_NPCWORLDSTATIC})
			if !tr.Hit then
				local posStart = pos +Vector(0,0,3)
				local posEnd = v.pos +Vector(0,0,3)
				local iHullsAccessable = 0
				for k, v in pairs(tblHulls) do
					if bit.band(iForceHulls,tblHullIDs[k]) == tblHullIDs[k] || HullAccessable(posStart, posEnd, v) then
						iHullsAccessable = iHullsAccessable +tblHullIDs[k]
					end
				end
				table.insert(links, {dest = k, move = iHullsAccessable, type = 0})
				table.insert(v.links, {dest = iNodeID, move = iHullsAccessable, type = 0})
			end
		end
	end
	local node = {pos = pos, type = iType, zone = 0, yaw = 0, info = 0, links = links}
	if iType == 2 then nodesGround[iNodeID] = node
	elseif iType == 3 then nodesAir[iNodeID] = node
	elseif iType == 4 then nodesClimb[iNodeID] = node
	elseif iType == 5 then nodesWater[iNodeID] = node end
	nodes[iNodeID] = node
	return iNodeID
end

function RemoveNode(iNodeID)
	local iType = nodes[iNodeID].type
	nodes[iNodeID] = nil
	for k, v in pairs(nodes) do
		for _, link in pairs(v.links) do
			if link.dest == iNodeID then
				nodes[k].links[_] = nil
			end
		end
	end
	local tbl = iType == 2 && nodesGround || iType == 3 && nodesAir || iType == 4 && nodesClimb || nodesWater
	tbl[iNodeID] = nil
	for k, v in pairs(tbl) do
		for _, link in pairs(v.links) do
			if link.dest == iNodeID then
				tbl[k].links[_] = nil
			end
		end
	end
end

function RemoveLink(iNodeIDStart, iNodeIDEnd, iHullOnly)
	local iType = nodes[iNodeIDStart].type
	if !iHullOnly then
		if !iNodeIDEnd || iNodeIDStart == iNodeIDEnd then
			for k, v in pairs(nodes[iNodeIDStart].links) do
				for k, link in pairs(nodes[v.dest].links) do
					if link.dest == iNodeIDStart then
						table.remove(nodes[v.dest].links, k)
					end
				end
			end
			nodes[iNodeIDStart].links = {}
			return
		end
		for k, v in pairs(nodes[iNodeIDStart].links) do
			if v.dest == iNodeIDEnd then
				table.remove(nodes[iNodeIDStart].links, k)
				break
			end
		end
		for k, v in pairs(nodes[iNodeIDEnd].links) do
			if v.dest == iNodeIDStart then
				table.remove(nodes[iNodeIDEnd].links, k)
				break
			end
		end
		return
	end
	
	if !iNodeIDEnd || iNodeIDStart == iNodeIDEnd then
		for k, v in pairs(nodes[iNodeIDStart].links) do
			for k, link in pairs(nodes[v.dest].links) do
				if link.dest == iNodeIDStart then
					if bit.band(v.move,iHullOnly) == iHullOnly then
						nodes[v.dest].links[k].move = v.move -iHullOnly
					end
				end
			end
		end
		for k, v in pairs(nodes[iNodeIDStart].links) do
			if table.HasValue(math.SplitByPowerOfTwo(v.move), iHullOnly) then
				nodes[iNodeIDStart].links[k].move = v.move -iHullOnly
			end
		end
		return
	end
	for k, v in pairs(nodes[iNodeIDStart].links) do
		if v.dest == iNodeIDEnd then
			if bit.band(v.move,iHullOnly) == iHullOnly then
				nodes[iNodeIDStart].links[k].move = v.move -iHullOnly
			end
			break
		end
	end
	for k, v in pairs(nodes[iNodeIDEnd].links) do
		if v.dest == iNodeIDStart then
			if bit.band(v.move,iHullOnly) == iHullOnly then
				nodes[iNodeIDEnd].links[k].move = v.move -iHullOnly
			end
			break
		end
	end
end

function Save(flags)
	local nodegraph = {nodes = {},links = {},flags = flags}
	debug.sethook()
	for ID,node in pairs(nodes) do
		if(!node.persistent) then
			nodegraph.nodes[ID] = {
				pos = node.pos,
				type = node.type,
				yaw = node.yaw,
				info = node.info
			}
			for _, link in pairs(node.links) do
				local bExists
				for _,linkB in ipairs(nodegraph.links) do
					if((linkB[1] == ID && linkB[2] == link.dest) || (linkB[1] == link.dest && linkB[2] == ID)) then
						bExists = true
						break
					end
				end
				if(!bExists) then table.insert(nodegraph.links,{ID,link.dest,link.move,link.type,link.flags}) end
			end
		end
	end
	local bSuccess,data = pcall(glon.encode,nodegraph)
	if(!bSuccess) then
		MsgN("Unable to save nodegraph: '" .. data .. "'.")
		return
	end
	MsgN("Nodegraph saved successfully!")
	file.Write("aigraph/" .. game.GetMap() .. ".txt",data)
end