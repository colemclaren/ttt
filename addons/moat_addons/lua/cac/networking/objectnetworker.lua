local self = {}
CAC.ObjectNetworker = CAC.MakeConstructor (self)

--[[
	Events:
		CreateOutBuffer ()
			Fired when an OutBuffer instance is needed.
		DispatchPacket (OutBuffer packet)
			Fired when a packet needs to be dispatched.
]]

function self:ctor ()
	self.Object             = nil
	
	self.ReplyHandlers      = nil
	self.NextReplyHandlerId = 0
	
	self.ChildNetworkers    = nil
	self.ChildIds           = nil
	
	CAC.EventProvider (self)
end

function self:dtor ()
	self:SetObject (nil)
	
	self:ClearChildren ()
end

function self:GetObject ()
	return self.Object
end

function self:SetObject (object)
	if self.Object == object then return self end
	
	self:UnhookObject (self.Object)
	
	local lastObject = self.Object
	self.Object = object
	
	self:HookObject (self.Object)
	
	self:DispatchEvent ("ObjectChanged", lastObject, self.Object)
	self:OnObjectChanged (lastObject, self.Object)
	
	return self
end

function self:IsReceiver ()
	return false
end

function self:IsSender ()
	return false
end

function self:HandlePacket (inBuffer, object)
	object = object or self:GetObject ()
	
	local eventName = inBuffer:StringN8 ()
	local handlerMethodName = "Handle" .. eventName
	
	if handlerMethodName == "HandlePacket" then return end
	
	if not self [handlerMethodName] then
		CAC.Error ("CAC.ObjectNetworker:HandlePacket : Unhandled command " .. CAC.String.EscapeNonprintable (eventName))
		return
	end
	
	return self [handlerMethodName] (self, inBuffer, object)
end

self ["Handle."] = function (self, inBuffer, object)
	local childId = inBuffer:StringN8 ()
	local childNetworker = self.ChildNetworkers [childId]
	if not childNetworker then
		CAC.Error ("CAC.ObjectNetworker:Handle. : Child " .. CAC.String.EscapeNonprintable (childId) .. " not found!")
		return
	end
	
	childNetworker:HandlePacket (inBuffer)
end

function self:HandleReply (inBuffer, object)
	local replyId = inBuffer:UInt32 ()
	local replyHandler = self:GetReplyHandler (replyId)
	
	if not replyHandler then
		CAC.Error ("CAC.ObjectNetworker:HandleReply : Unhandled reply ID " .. string.format ("0x%08x", replyId))
		return
	end
	
	local subInBuffer = CAC.StringInBuffer (inBuffer:StringN32 ())
	local moreData = replyHandler (self, object, subInBuffer)
	if not moreData then
		self:DestroyReplyHandler (replyId)
	end
end

-- Replies
function self:CreateReplyHandler (callback)
	local replyHandlerId = self.NextReplyHandlerId
	self.ReplyHandlers = self.ReplyHandlers or {}
	self.ReplyHandlers [replyHandlerId] = callback
	
	self.NextReplyHandlerId = self.NextReplyHandlerId + 1
	if self.NextReplyHandlerId >= 65536 then
		self.NextReplyHandlerId = 1
	end
	
	return replyHandlerId
end

function self:DestroyReplyHandler (replyId)
	if not self.ReplyHandlers then return nil end
	
	self.ReplyHandlers [replyId] = nil
end

function self:DispatchReply (replyId, str)
	local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
	outBuffer:StringN8  ("Reply")
	outBuffer:UInt32    (replyId)
	outBuffer:StringN32 (str)
	self:DispatchEvent  ("DispatchPacket", outBuffer)
end

function self:GetReplyHandler (replyId)
	if not self.ReplyHandlers then return nil end
	
	return self.ReplyHandlers [replyId]
end

-- Children
function self:AddChild (object, id, objectNetworkerFactory)
	if not object then
		self:RemoveChildById (id)
		return
	end
	
	self.ChildNetworkers = self.ChildNetworkers or {}
	self.ChildIds        = self.ChildIds        or {}
	
	if self.ChildIds [object] then
		if self.ChildIds [object] ~= id then
			CAC.Error ("ObjectNetworker:AddChild : Child object already exists under a different ID (" .. id .. ", existing ID is " .. self.ChildIds [object] .. ")")
		end
		return
	end
	
	local objectNetworker = self:CreateChildObjectNetworker (objectNetworkerFactory)
	
	self.ChildIds [object] = id
	self.ChildNetworkers [id] = objectNetworker
	
	objectNetworker:SetObject (object)
	
	objectNetworker:AddEventListener ("CreateOutBuffer", "CAC.ObjectNetworker." .. self:GetHashCode (),
		function (_)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			
			outBuffer:StringN8 (".")
			outBuffer:StringN8 (id)
			
			return outBuffer
		end
	)
	
	objectNetworker:AddEventListener ("DispatchPacket", "CAC.ObjectNetworker." .. self:GetHashCode (),
		function (_, outBuffer)
			self:DispatchEvent ("DispatchPacket", outBuffer)
		end
	)
end

function self:ClearChildren ()
	if not self.ChildIds then return end
	
	for object, _ in pairs (self.ChildIds) do
		self:RemoveChild (object)
	end
end

function self:CreateChildObjectNetworker (objectNetworkerFactory)
	return objectNetworkerFactory ()
end

function self:GetChildNetworker (object)
	return self.ChildNetworkers [self.ChildIds [object]]
end

function self:GetChildNetworkerById (id)
	return self.ChildNetworkers [id]
end

function self:GetChildNetworkerEnumerator ()
	if not self.ChildNetworkers then
		return CAC.NullEnumerator ()
	end
	
	return CAC.KeyValueEnumerator (self.ChildNetworkers)
end

function self:RemoveChild (object)
	if not self.ChildIds          then return end
	if not self.ChildIds [object] then return end
	
	self:RemoveChildById (self.ChildIds [object])
end

function self:RemoveChildById (id)
	if not self.ChildNetworkers      then return end
	if not self.ChildNetworkers [id] then return end
	
	self.ChildIds [self.ChildNetworkers [id]:GetObject ()] = nil
	
	self.ChildNetworkers [id]:RemoveEventListener ("CreateOutBuffer", "CAC.ObjectNetworker." .. self:GetHashCode ())
	self.ChildNetworkers [id]:RemoveEventListener ("DispatchPacket",  "CAC.ObjectNetworker." .. self:GetHashCode ())
	self.ChildNetworkers [id]:dtor ()
	self.ChildNetworkers [id] = nil
end

-- Internal, do not call
function self:HookObject (object)
	if not object then return end
	
	self:DispatchEvent ("HookObject", object)
end

function self:UnhookObject (object)
	if not object then return end
	
	self:DispatchEvent ("UnhookObject", object)
end

function self:OnObjectChanged (lastObject, object)
end

function self:__call (...)
	return self.__ictor (...)
end