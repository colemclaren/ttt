local self = {}
CAC.ContinuousRealFunction = CAC.MakeConstructor (self)

function self:ctor ()
end

function self:Evaluate (x)
	CAC.Error ("ContinuousRealFunction:Evaluate : Not implemented.")
end

function self:EvaluateBulk (array, out)
	CAC.Error ("ContinuousRealFunction:EvaluateBulk : Not implemented.")
end