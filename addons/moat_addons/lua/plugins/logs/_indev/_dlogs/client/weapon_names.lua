dlogs.NamesTable = dlogs.NamesTable or {}

function dlogs:GetWeaponName(class)
    return self.NamesTable[class] or TTTLogTranslate(GetDMGLogLang, class, true) or class
end

local function UpdateWeaponNames()
	dlogs.NamesTabl = {}
	local e = {scripted_ents.GetList(), weapons.GetList()}
	for i = 1, 2 do
		if (not e[i]) then continue end
		for k, v in pairs(e[i]) do
			if (not v.ClassName or not v.PrintName) then continue end

        	dlogs.NamesTable[v.ClassName] = LANG.TryTranslation(v.PrintName) or LANG.TryTranslation(v.ClassName) or v.PrintName
    	end
	end
end
hook.Add("TTTLanguageChanged", "dlogs.WeaponNames", UpdateWeaponNames)

hook.Add("Initialize", "dlogs.WeaponNames", function()
	if (LANG.TryTranslation) then
		UpdateWeaponNames()
		return
	end

    local LangInit = LANG.Init
    function LANG.Init(...)
        local res = LangInit(...)
        UpdateWeaponNames()
        return res
    end
end)