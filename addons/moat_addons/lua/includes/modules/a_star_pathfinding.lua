local ipairs = ipairs
local pairs = pairs
local table = table
local math = math
local print = print
local unpack = unpack
function table.call(t, ...)
	if type(t) == "function" then return t(...) end
	for k,v in pairs(t) do
		if not v(...) then
			return false
		end
	end
	return true
end
function table.multiplier_call(t, num, ...)
	if type(t) == "function" then return t(...) end
	for k,v in pairs(t) do
		num = num * v(num, ...)
		if num < 0 or num >= math.huge then break end
	end
	return math.max(num, 0)
end
local object_meta = {}
module("astar")
function Create(starting_node, target_node, neighbour_iterator, walkable_checks, heuristic, conditionals, ...)
	return {
		node_status = {
			[starting_node] = { -- 1) Add the starting node to the open list
				list = false, -- true = on the closed list, false = on the open list
				parent = nil,
				f = 0, -- g+h
				g = 0, -- length of path from starting node to current node (current.g = parent.g + heuristic(parent, curent))
				h = heuristic(starting_node, target_node, ...), -- estimated distance to target node
				c = 1,
			}
		},
		starting_node = starting_node,
		target_node = target_node,
		neighbour_iterator = neighbour_iterator,
		walkable_checks = walkable_checks,
		heuristic = heuristic,
		conditionals = conditionals or {},
		args = {...}
	}
end
function Step(object) -- 2) Repeat the following:
	local lowest_f_score, current_node, current_status = math.huge, nil, nil
	for open_node, status in pairs(object.node_status) do -- a) Look for the lowest F cost node on the open list...
		if not status.list and status.f < lowest_f_score then
			current_node = open_node -- ... We refer to this as the current node.
			lowest_f_score = status.f
			current_status = status
		end
	end
	if current_node then
		if current_node == object.target_node then -- (If this node is the target node, stop and loop backwards from the target node via parent links to the source node...
			local path, pathi, pathn = {current_node}, 1, current_node
			while path[pathi] do
				pathi = pathi + 1
				pathn = object.node_status[pathn].parent
				path[pathi] = pathn
			end
			return true, true, path, node_status -- ...This is your path! :D )
		end
		current_status.list = true -- b) Switch it to the closed list
		local neighbour_status
		for _, neighbour_node in object.neighbour_iterator(current_node, current_status) do -- c) For each of the nodes linked to this node:
			neighbour_status = object.node_status[neighbour_node]
			if not neighbour_status then -- () If it isn't on the open list,...
				if table.call(object.walkable_checks, current_node, neighbour_node, object.startinging_node, object.target_node, object.heuristic, unpack(object.args)) then -- ...and it's walkable...
					neighbour_status = {
						list = false, -- ...add it to the open list...
						parent = current_node, -- ...Make the current node the parent of this node...
						-- ...Record the..
						g = current_status.g + object.heuristic(current_node, neighbour_node, unpack(object.args)) -- ...G cost...
								* table.multiplier_call(object.conditionals, 1, current_node, neighbour_node, object.starting_node, object.target_node, object.heuristic, unpack(object.args)), -- ...additional costs...
						h = object.heuristic(current_node, object.target_node, unpack(object.args)), -- ...H cost...
					}
					neighbour_status.f = neighbour_status.g + neighbour_status.h  -- ...and the F cost.
					object.node_status[neighbour_node] = neighbour_status
				end
			elseif not neighbour_status.list -- () If it is on the open list already,...
			 and table.call(object.walkable_checks, current_node, neighbour_node, object.startinging_node, object.target_node, object.heuristic, unpack(object.args)) -- ...and it's walkable...
			 and object.node_status[neighbour_status.parent].g > current_status.g -- ...check to see if this path to that node is better from the current node, using G cost as the measure...
			then
				-- ..A lower G cost means that this is a better path. If so...
				neighbour_status.parent = current_node -- ...change the parent of the node to the current node...
				neighbour_status.g = current_status.g + object.heuristic(current_node, neighbour_node, unpack(object.args)) -- ...G cost...
					* table.multiplier_call(object.conditionals, 1, current_node, neighbour_node, starting_node, target_node, heuristic, unpack(object.args)) -- ...additional costs...
				neighbour_status.f = neighbour_status.g + neighbour_status.h -- ... and the F cost.
			end
		end
	else -- (If the openlist is empty, and you haven't found the target node...
		return true, false, {start_node}, node_status -- ...there is no path! D: )
	end
	return false
end
function CalculatePath(starting_node, target_node, neighbour_iterator, walkable_checks, heuristic, conditionals, ...)
	local object = Create(starting_node, target_node, neighbour_iterator, walkable_checks, heuristic, conditionals, ...)
	local finished, found, path, statuses
	while not finished do
		finished, found, path, statuses = Step(object)
	end
	return found, path, statuses
end
