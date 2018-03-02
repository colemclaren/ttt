if SERVER then
	AddCSLuaFile()
	AddCSLuaFile('cl_modernrewards.lua')
	AddCSLuaFile('sh_rewardsconfig.lua')
	AddCSLuaFile('cl_rewardfonts.lua')
	
	--Add panel files
	AddCSLuaFile('sgrpanels/cl_menubutton.lua')
	
	--Add server files
	include('sv_modernrewards.lua')
	
	--Add resources
	local function AddResourceDir(dir)
		local files, dirs = file.Find(dir.."/*", "GAME")

		for _, fdir in pairs(dirs) do
			if fdir != ".svn" then
				AddResourceDir(dir.."/"..fdir)
			end
		end

		for k,v in pairs(files) do
			//print(dir.."/"..v)
			resource.AddSingleFile(dir.."/"..v)
		end
	end

	AddResourceDir("materials/modernrewards")
	AddResourceDir("sound/modernrewards")
	resource.AddFile("resource/fonts/BebasNeue.ttf")
	//resource.AddFile("resource/fonts/OpenSansC.ttf")
end

if CLIENT then
	include('cl_modernrewards.lua')
end