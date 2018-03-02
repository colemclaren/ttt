local NilSerializer      = function (outBuffer, argument) end
local NilDeserializer    = function (inBuffer) return nil end

local function SerializeArgumentArray (outBuffer, customSerializers, parameters, arguments)
	for i = 1, #parameters do
		local typeName = parameters [i]
		local serializer = customSerializers [typeName]
		serializer = serializer or outBuffer [typeName]
		if not serializer and typeName == "Nil" then serializer = NilSerializer end
		serializer (outBuffer, arguments [i])
	end
end

local function SerializeArguments (outBuffer, customSerializers, parameters, ...)
	return SerializeArgumentArray (outBuffer, customSerializers, parameters, {...})
end

local function DeserializeArgumentArray (inBuffer, customDeserializers, parameters)
	local arguments = {}
	
	for i = 1, #parameters do
		local typeName = parameters [i]
		local deserializer = customDeserializers [typeName]
		deserializer = deserializer or inBuffer [typeName]
		if not deserializer and typeName == "Nil" then deserializer = NilDeserializer end
		arguments [i] = deserializer (inBuffer)
	end
	
	return arguments
end

local function DeserializeArguments (inBuffer, customDeserializers, parameters)
	return unpack (DeserializeArgumentArray (inBuffer, customDeserializers, parameters), 1, #parameters)
end

local defaultParameterArray = {}

function CAC.CreateObjectNetworkerFactory (outboundMessages, inboundMessages, inboundPredicate, customSerializers, customDeserializers)
	local self = {}
	
	if inboundMessages then
		for messageName, messageInfo in pairs (inboundMessages) do
			local handlerName = "Handle" .. messageName
			local parameters  = messageInfo.Parameters or defaultParameterArray
			
			self [handlerName] = function (self, inBuffer, object)
				object = object or self:GetObject ()
				
				if not inboundPredicate (self, object, messageName) then return end
				
				local arguments = nil
				if messageInfo.ArgumentDeserializer then
					arguments = { messageInfo.ArgumentDeserializer (self, inBuffer) }
				else
					arguments = DeserializeArgumentArray (inBuffer, customDeserializers, parameters)
				end
				if isstring (messageInfo.Handler) then
					object [messageInfo.Handler] (object, unpack (arguments, 1, #parameters))
				elseif isfunction (messageInfo.Handler) then
					messageInfo.Handler (self, object, unpack (arguments, 1, #parameters))
				end
				if isstring (messageInfo.PostHandler) then
					object [messageInfo.PostHandler] (object, unpack (arguments, 1, #parameters))
				elseif isfunction (messageInfo.PostHandler) then
					messageInfo.PostHandler (self, object, unpack (arguments, 1, #parameters))
				end
			end
		end
	end
	
	if outboundMessages then
		for messageName, messageInfo in pairs (outboundMessages) do
			local networked = messageInfo.Networked
			if networked == nil then networked = true end
			
			if networked then
				local dispatcherName = "Dispatch" .. messageName
				local parameters     = messageInfo.Parameters or defaultParameterArray
				
				self [dispatcherName] = function (self, ...)
					local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
					outBuffer:StringN8  (messageName)
					
					local arguments = nil
					if messageInfo.ArgumentTransformer then
						arguments = { messageInfo.ArgumentTransformer (self, ...) }
					else
						arguments = {...}
					end
					if messageInfo.ArgumentSerializer then
						messageInfo.ArgumentSerializer (self, outBuffer, unpack (arguments, 1, table.maxn (arguments)))
					else
						SerializeArgumentArray (outBuffer, customSerializers, parameters, arguments)
					end
					self:DispatchEvent  ("DispatchPacket", outBuffer)
				end
			end
		end
		
		function self:HookObject (object)
			if not object then return end
			
			for messageName, messageInfo in pairs (outboundMessages) do
				local networked = messageInfo.Networked
				if networked == nil then networked = true end
				
				object:AddEventListener (messageName, "CAC.ObjectNetworker." .. self:GetHashCode (),
					function (_, ...)
						if isstring (messageInfo.PreHandler) then
							object [messageInfo.PreHandler] (object, ...)
						elseif isfunction (messageInfo.PreHandler) then
							messageInfo.PreHandler (self, object, ...)
						end
						if networked then
							self ["Dispatch" .. messageName] (self, ...)
						end
					end
				)
			end
			
			self:DispatchEvent ("HookObject", object)
		end
		
		function self:UnhookObject (object)
			if not object then return end
			
			for messageName, _ in pairs (outboundMessages) do
				object:RemoveEventListener (messageName, "CAC.ObjectNetworker." .. self:GetHashCode ())
			end
			
			self:DispatchEvent ("UnhookObject", object)
		end
	end
	
	return self
end

local CustomSerializers   = {}
local CustomDeserializers = {}

function CAC.CreateObjectReceiverFactory (type)
	local inboundPredicate = nil
	inboundPredicate = inboundPredicate or function () return true end
	
	local customSerializers   = type.Networking.Serializers   or CustomSerializers
	local customDeserializers = type.Networking.Deserializers or CustomDeserializers
	
	local self = CAC.CreateObjectNetworkerFactory (type.Networking.Commands, type.Networking.Events, inboundPredicate, customSerializers, customDeserializers)
	
	if type.Networking.ObjectChangedHandler then
		self.OnObjectChanged = type.Networking.ObjectChangedHandler
	end
	if type.Networking.FullUpdateDeserializer then
		self.DeserializeFullUpdate = type.Networking.FullUpdateDeserializer
	end
	if type.Networking.FullUpdateHandler then
		self.OnFullUpdateReceived = type.Networking.FullUpdateHandler
	end
	
	-- Requests
	if type.Networking.Requests then
		for requestName, requestInfo in pairs (type.Networking.Requests) do
			local messageName    = requestName .. "Request"
			local dispatcherName = "Dispatch" .. messageName
			local parameters     = requestInfo.Parameters or defaultParameterArray
			
			self [dispatcherName] = function (self, ...)
				local arguments = {...}
				local callback  = arguments [#parameters + 1]
				arguments [#parameters + 1] = nil
				
				local replyId = self:CreateReplyHandler (callback)
				
				local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
				outBuffer:StringN8  (messageName)
				outBuffer:UInt32    (replyId)
				SerializeArgumentArray (outBuffer, customSerializers, parameters, arguments)
				self:DispatchEvent  ("DispatchPacket", outBuffer)
			end
		end
		
		local oldHookObject   = self.HookObject
		local oldUnhookObject = self.UnhookObject
		
		function self:HookObject (object)
			if not object then return end
			
			oldHookObject (self, object)
			
			for requestName, requestInfo in pairs (type.Networking.Requests) do
				object:AddEventListener ("Request" .. requestName, "CAC.ObjectReceiver." .. self:GetHashCode (),
					function (_, ...)
						self ["Dispatch" .. requestName .. "Request"] (self, ...)
					end
				)
			end
		end
		
		function self:UnhookObject (object)
			if not object then return end
			
			oldUnhookObject (self, object)
			
			for requestName, requestInfo in pairs (type.Networking.Requests) do
				object:RemoveEventListener ("Request" .. requestName, "CAC.ObjectReceiver." .. self:GetHashCode ())
			end
		end
	end
	
	return CAC.MakeConstructor (self, CAC.ObjectReceiver)
end

function CAC.CreateObjectSenderFactory (type)
	local inboundPredicate = nil
	inboundPredicate = type.Networking.CommandPermissionPredicate
	inboundPredicate = inboundPredicate or function () return true end
	
	local requestPredicate = nil
	requestPredicate = type.Networking.RequestPermissionPredicate
	requestPredicate = requestPredicate or function () return true end
	
	local customSerializers   = type.Networking.Serializers   or CustomSerializers
	local customDeserializers = type.Networking.Deserializers or CustomDeserializers
	
	local self = CAC.CreateObjectNetworkerFactory (type.Networking.Events, type.Networking.Commands, inboundPredicate, customSerializers, customDeserializers)
	
	if type.Networking.ObjectChangedHandler then
		self.OnObjectChanged = type.Networking.ObjectChangedHandler
	end
	if type.Networking.FullUpdateSerializer then
		self.SerializeFullUpdate = type.Networking.FullUpdateSerializer
	end
	
	-- Requests
	if type.Networking.Requests then
		for requestName, requestInfo in pairs (type.Networking.Requests) do
			local handlerName = "Handle" .. requestName .. "Request"
			local parameters  = requestInfo.Parameters or defaultParameterArray
			
			self [handlerName] = function (self, inBuffer, object)
				object = object or self:GetObject ()
				
				local replyId = inBuffer:UInt32 ()
				
				if not requestPredicate (self, object, requestName) then return end
				
				local arguments = DeserializeArgumentArray (inBuffer, customDeserializers, parameters)
				requestInfo.Handler (self, object, replyId, unpack (arguments, 1, #parameters))
			end
		end
	end
	
	return CAC.MakeConstructor (self, CAC.ObjectSender)
end