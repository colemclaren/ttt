local self = {}
CAC.ImageLoader = CAC.MakeConstructor (self)

function self:ctor ()
	self.Cache         = {}
	
	self.Queue         = {}
	self.UrlQueueItems = {}
	
	self.CurrentQueueItem = nil
	self.ProcessingQueue  = false
	self.State = "idle"
end

function self:dtor ()
	self:StopProcessingQueue ()
	
	self:DestroyBrowserControl ()
end

function self:LoadImage (url, callback)
	-- Check for cache hit
	if self.Cache [url] then
		callback (self.Cache [url].Texture, self.Cache [url].Width, self.Cache [url].Height)
		return
	end
	
	-- Merge with existing queue item
	if self.UrlQueueItems [url] then
		self.UrlQueueItems [url].Callbacks [#self.UrlQueueItems [url].Callbacks + 1] = callback
		return
	end
	
	local queueItem =
	{
		Url       = url,
		Callbacks = { callback }
	}
	
	self.Queue [#self.Queue + 1] = queueItem
	self.UrlQueueItems [url] = queueItem
	
	self:StartProcessingQueue ()
end

-- Internal, do not call
function self:StartProcessingQueue ()
	if self.ProcessingQueue then return end
	
	self.ProcessingQueue = true
	
	timer.Create ("CAC.ImageLoader", 0.2, 0,
		function ()
			self:Think ()
		end
	)
end

function self:StopProcessingQueue ()
	if not self.ProcessingQueue then return end
	
	timer.Destroy ("CAC.ImageLoader")
	
	self.ProcessingQueue = false
end

function self:DestroyBrowserControl ()
	if not self.BrowserControl then return end
	
	if self.BrowserControl:IsValid () then
		self.BrowserControl:Remove ()
	end
	
	self.BrowserControl = nil
end

function self:Think ()
	if self.State == "idle" then
		-- Time for next queue item
		if #self.Queue == 0 then
			self:StopProcessingQueue ()
			return
		end
		
		local queueItem = self.Queue [1]
		
		self.CurrentQueueItem = queueItem
		self.State = "waiting"
		
		self:DestroyBrowserControl ()
		self.BrowserControl = vgui.Create ("DHTML")
		self.BrowserControl:SetVisible (false)
		
		self.BrowserControl:NewObjectCallback ("imageLoader", "debugMessage")
		self.BrowserControl:NewObjectCallback ("imageLoader", "error")
		self.BrowserControl:NewObjectCallback ("imageLoader", "finished")
		self.BrowserControl.OnCallback = function (_, objectName, methodName, args)
			if objectName == "imageLoader" then
				if methodName == "debugMessage" then
					error ("CAC.ImageLoader: " .. tostring (args [1]))
					
					self.BrowserControl:Remove ()
					self.BrowserControl = nil
				elseif methodName == "finished" then
					local width  = tonumber (args [1])
					local height = tonumber (args [2])
					
					self.CurrentQueueItem.Width  = width
					self.CurrentQueueItem.Height = height
					
					self.BrowserControl:SetSize (width, height)
					
					self.State = "resizing"
				elseif methodName == "error" then
					table.remove (self.Queue, 1)
					self.UrlQueueItems [self.CurrentQueueItem.Url] = nil
					
					self.CurrentQueueItem = nil
					self.State = "idle"
					
					self.BrowserControl:Remove ()
					self.BrowserControl = nil
				end
			end
		end
		
		self.BrowserControl:SetHTML (
			[[
			<html>
				<head>
				</head>
				<body style="padding: 0px; margin: 0px; overflow: hidden">
					<script type="text/javascript">
						var loaded = false;
						function debugMessage (message)
						{
							if (loaded)
							{
								console.log (message);
								if (window.imageLoader)
								{
									imageLoader.debugMessage (message)
								}
							}
							else
							{
								setTimeout (
									function ()
									{
										debugMessage (message);
									},
									20
								);
							}
						}
						
						function imageError ()
						{
							imageLoader.error ();
						}
						
						function imageLoaded ()
						{
							var image = document.getElementById ("image");
							imageLoader.finished (image.width, image.height);
						}
						
						window.onerror = function (message, file, lineNumber)
						{
							debugMessage (file + ":" + lineNumber + ": " + message);
						};
						
						function onLuaApiLoaded ()
						{
							loaded = true;
						};
					</script>
					<img id="image" src="]] .. queueItem.Url .. [[" onerror="imageError ()" onload="imageLoaded ()" />
				</body>
			</html>
			]]
		)
		
		if self.BrowserControl then
			self.BrowserControl:QueueJavascript ("onLuaApiLoaded ()")
		end
	elseif self.State == "resizing" then
		self.BrowserControl:UpdateHTMLTexture ()
		
		local texture = self.BrowserControl:GetHTMLMaterial ():GetTexture ("$basetexture")
		texture:Download ()
		
		self.Cache [self.CurrentQueueItem.Url] =
		{
			Texture = texture,
			Width   = self.CurrentQueueItem.Width,
			Height  = self.CurrentQueueItem.Height,
		}
		
		for _, callback in ipairs (self.CurrentQueueItem.Callbacks) do
			callback (self.Cache [self.CurrentQueueItem.Url].Texture, self.Cache [self.CurrentQueueItem.Url].Width, self.Cache [self.CurrentQueueItem.Url].Height)
		end
		
		self.BrowserControl:Remove ()
		self.BrowserControl = nil
		
		table.remove (self.Queue, 1)
		self.UrlQueueItems [self.CurrentQueueItem.Url] = nil
		
		self.CurrentQueueItem = nil
		self.State = "idle"
	end
end

CAC.ImageLoader = CAC.ImageLoader ()

CAC:AddEventListener ("Unloaded",
	function ()
		CAC.ImageLoader:dtor ()
	end
)