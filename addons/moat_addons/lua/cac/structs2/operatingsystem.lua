CAC.OperatingSystem = CAC.Enum (
	{
		Indeterminate = 0,
		Windows       = 1,
		Macintosh     = 2,
		Linux         = 3,
		Other         = 4
	}
)

function CAC.OperatingSystem.FromLocalEnvironment ()
	if system.IsWindows () then
		return CAC.OperatingSystem.Windows
	elseif system.IsOSX () then
		return CAC.OperatingSystem.Macintosh
	elseif system.IsLinux () then
		return CAC.OperatingSystem.Linux
	end
	
	return CAC.OperatingSystem.Indeterminate
end

-- Returns jit.os
function CAC.OperatingSystem.ToString (operatingSystem)
	if operatingSystem == CAC.OperatingSystem.Indeterminate then
		return "Other"
	elseif operatingSystem == CAC.OperatingSystem.Windows then
		return "Windows"
	elseif operatingSystem == CAC.OperatingSystem.Macintosh then
		return "OSX"
	elseif operatingSystem == CAC.OperatingSystem.Linux then
		return "Linux"
	elseif operatingSystem == CAC.OperatingSystem.Other then
		return "Other"
	end
	
	return "Other"
end