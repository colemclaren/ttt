-- Generated from: glib/lua/glib/glue.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/glue.lua
-- Timestamp:      2016-02-22 19:22:23
function CAC.BindCustomProperty (destinationObject, setterName, sourceObject, getterName, eventName, eventId)
	destinationObject [setterName] (destinationObject, sourceObject [getterName] (sourceObject))
	
	if not eventName then return end
	eventId = eventId or tostring (destinationObject)
	
	if not sourceObject.AddEventListener then return end
	
	sourceObject:AddEventListener (eventName, eventId,
		function ()
			destinationObject [setterName] (destinationObject, sourceObject [getterName] (sourceObject))
		end
	)
end

function CAC.BindProperty (destinationObject, sourceObject, propertyName, eventId)
	local setterName = "Set" .. propertyName
	local getterName = "Get" .. propertyName
	if not sourceObject [getterName] then
		getterName = "Is" .. propertyName
	end
	local eventName = propertyName .. "Changed"
	
	CAC.BindCustomProperty (destinationObject, setterName, sourceObject, getterName, eventName, eventId)
end

function CAC.UnbindCustomProperty (destinationObject, setterName, sourceObject, getterName, eventName, eventId)
	if not eventName then return end
	eventId = eventId or tostring (destinationObject)
	
	if not sourceObject.RemoveEventListener then return end
	
	sourceObject:RemoveEventListener (eventName, eventId)
end

function CAC.UnbindProperty (destinationObject, sourceObject, propertyName, eventId)
	local setterName = "Set" .. propertyName
	local getterName = "Get" .. propertyName
	if not sourceObject [getterName] then
		getterName = "Is" .. propertyName
	end
	local eventName = propertyName .. "Changed"
	
	CAC.UnbindCustomProperty (destinationObject, setterName, sourceObject, getterName, eventName, eventId)
end