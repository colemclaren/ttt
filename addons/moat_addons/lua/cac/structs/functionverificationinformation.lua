-- This file is computer-generated.
local self = {}
CAC.FunctionVerificationInformation = CAC.MakeConstructor (self, CAC.Serialization.ISerializable)

function self:ctor ()
	self.Native              = nil
	self.Address             = nil
	self.Path                = nil
	self.DefinitionStartLine = nil
	self.DefinitionEndLine   = nil
	self.BytecodeHash        = nil
end

-- ISerializable
function self:Serialize (outBuffer)
	outBuffer:Boolean   (self.Native             )
	outBuffer:UInt32    (self.Address            )
	outBuffer:StringN32 (self.Path               )
	outBuffer:Int32     (self.DefinitionStartLine)
	outBuffer:Int32     (self.DefinitionEndLine  )
	outBuffer:UInt32    (self.BytecodeHash       )
	
	return outBuffer
end

function self:Deserialize (inBuffer)
	self.Native              = inBuffer:Boolean   ()
	self.Address             = inBuffer:UInt32    ()
	self.Path                = inBuffer:StringN32 ()
	self.DefinitionStartLine = inBuffer:Int32     ()
	self.DefinitionEndLine   = inBuffer:Int32     ()
	self.BytecodeHash        = inBuffer:UInt32    ()
	
	return self
end

-- FunctionVerificationInformation
function self:GetNative ()
	return self.Native
end

function self:GetAddress ()
	return self.Address
end

function self:GetPath ()
	return self.Path
end

function self:GetDefinitionStartLine ()
	return self.DefinitionStartLine
end

function self:GetDefinitionEndLine ()
	return self.DefinitionEndLine
end

function self:GetBytecodeHash ()
	return self.BytecodeHash
end

function self:SetNative (native)
	self.Native = native
	return self
end

function self:SetAddress (address)
	self.Address = address
	return self
end

function self:SetPath (path)
	self.Path = path
	return self
end

function self:SetDefinitionStartLine (definitionStartLine)
	self.DefinitionStartLine = definitionStartLine
	return self
end

function self:SetDefinitionEndLine (definitionEndLine)
	self.DefinitionEndLine = definitionEndLine
	return self
end

function self:SetBytecodeHash (bytecodeHash)
	self.BytecodeHash = bytecodeHash
	return self
end

