-- Generated from: gooey/lua/gooey/ui/render.lua
-- Original:       https://github.com/notcake/gooey/blob/master/lua/gooey/ui/render.lua
-- Timestamp:      2016-04-28 19:58:52
CAC.RenderHooks = {}

hook.Add ("PostRenderVGUI", "CAC.PostRenderVGUI",
	function ()
		if CAC.RenderHooks [CAC.RenderType.DragDropPreview] then
			for _, renderFunction in pairs (CAC.RenderHooks [CAC.RenderType.DragDropPreview]) do
				xpcall (renderFunction, CAC.Error)
			end
		end
		if CAC.RenderHooks [CAC.RenderType.ToolTip] then
			for _, renderFunction in pairs (CAC.RenderHooks [CAC.RenderType.ToolTip]) do
				xpcall (renderFunction, CAC.Error)
			end
		end
	end
)

CAC:AddEventListener ("Unloaded",
	function ()
		hook.Remove ("PostRenderVGUI", "CAC.PostRenderVGUI")
	end
)

function CAC.AddRenderHook (renderType, name, renderFunction)
	if not renderFunction then return end
	name = tostring (name)
	
	CAC.RenderHooks [renderType] = CAC.RenderHooks [renderType] or {}
	CAC.RenderHooks [renderType] [name] = renderFunction
end

function CAC.RemoveRenderHook (renderType, name)
	name = tostring (name)
	
	if not CAC.RenderHooks [renderType] then return end
	CAC.RenderHooks [renderType] [name] = nil
	if not next (CAC.RenderHooks [renderType]) then
		CAC.RenderHooks [renderType] = nil
	end
end