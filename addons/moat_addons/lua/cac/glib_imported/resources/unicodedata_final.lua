-- This file is computer-generated.
CAC.Resources.Commit ("UnicodeData", "UnicodeData_compressed")

CAC.Resources.Get ("UnicodeData", "UnicodeData_compressed",
	function (success, data)
		CAC.Resources.Append ("UnicodeData", "UnicodeData", util.Decompress (data))
		CAC.Resources.Commit ("UnicodeData", "UnicodeData")
	end
)