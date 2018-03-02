CAC.Resources = {}
CAC.Resources.Resources = {}
CAC.Resources.ResourceRequests = {}
CAC.Resources.UncommittedResources = {}

function CAC.Resources.RegisterFile (namespace, id, localPath)
end

function CAC.Resources.Get (namespace, id, callback)
	local resourceId = namespace .. "/" .. id
	
	if CAC.Resources.Resources [resourceId] then
		callback (true, CAC.Resources.Resources [resourceId])
	end
	
	CAC.Resources.ResourceRequests [resourceId] = CAC.Resources.ResourceRequests [resourceId] or {}
	CAC.Resources.ResourceRequests [resourceId] [#CAC.Resources.ResourceRequests [resourceId] + 1] = callback
end

function CAC.Resources.Append (namespace, id, data)
	local resourceId = namespace .. "/" .. id
	
	local resourceChunks = CAC.Resources.UncommittedResources [resourceId]
	if not resourceChunks then
		CAC.Resources.UncommittedResources [resourceId] = {}
		resourceChunks = CAC.Resources.UncommittedResources [resourceId]
		
		local resourceChunks = CAC.Resources.UncommittedResources [resourceId]
		if CAC.Resources.Resources [resourceId] then
			resourceChunks [#resourceChunks + 1] = CAC.Resources.Resources [resourceId]
		end
	end
	
	resourceChunks [#resourceChunks + 1] = data
end

function CAC.Resources.Commit (namespace, id)
	local resourceId = namespace .. "/" .. id
	
	if not CAC.Resources.UncommittedResources [resourceId] then
		CAC.Error ("CAC.Resources.Commit : No data to commit for " .. resourceId .. "!")
		return
	end
	
	CAC.Resources.Resources [resourceId] = table.concat (CAC.Resources.UncommittedResources [resourceId])
	CAC.Resources.UncommittedResources [resourceId] = nil
	
	if CAC.Resources.ResourceRequests [resourceId] then
		for _, callback in ipairs (CAC.Resources.ResourceRequests [resourceId]) do
			callback (true, CAC.Resources.Resources [resourceId])
		end
		
		CAC.Resources.ResourceRequests [resourceId] = nil
	end
end