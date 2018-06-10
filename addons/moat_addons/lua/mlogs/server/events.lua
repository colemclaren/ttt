mlogs.Print "parsing event files"
Files, Folders = file.Find(mlogs.Folder .. "/server/events/*.lua", "LUA")
for k, v in ipairs(Files) do
	mlogs.Print(" | " .. v)
	mlogs.IncludeSV(mlogs.Folder .. "/server/events/" .. v)
end