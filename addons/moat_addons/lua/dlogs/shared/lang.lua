dlogsLang = dlogsLang or {}

local f = dlogs.Folder .. "/shared/lang/english.lua"
if SERVER then
	AddCSLuaFile(f)
end
include(f)

function TTTLogTranslate(GetDMGLogLang, phrase, nomissing)
	return dlogsLang["english"][phrase] or not nomissing and "Missing: "..tostring(phrase)
end