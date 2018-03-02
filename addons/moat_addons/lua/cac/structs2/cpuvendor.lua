CAC.CpuVendor = CAC.Enum (
	{
		Indeterminate = 0,
		Intel         = 1,
		AMD           = 2,
		Other         = 3
	}
)

function CAC.CpuVendor.FromLocalEnvironment ()
	local jitStatusFlags = { jit.status () }
	for _, flag in ipairs (jitStatusFlags) do
		if flag == "AMD" then
			return CAC.CpuVendor.AMD
		end
	end
	
	return CAC.CpuVendor.Intel
end