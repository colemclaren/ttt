local self = {}
CAC.AdminUIBootstrapperFileList = CAC.MakeConstructor (self)

function self:ctor ()
	self.Files   = {}
	self.FileSet = {}
end

function self:Add (path)
	if self.FileSet [path] then return end
	
	self.Files [#self.Files + 1] = path
	self.FileSet [path] = true
end

function self:AddRange (enumerator, exclusionSet)
	for path in enumerator do
		if not exclusionSet or not exclusionSet [path] then
			self:Add (path)
		end
	end
end

function self:GetEnumerator ()
	return CAC.ArrayEnumerator (self.Files)
end