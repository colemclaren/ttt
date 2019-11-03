local function GetFakedDeathGroup(ply)

	if ply:GetNW2Bool("FakedDeath", false) and ply:GetNW2Bool("body_found", false) then

        return GROUP_FOUND

    end

end

hook.Add( "TTTScoreGroup", "Puts Player in right gruop", GetFakedDeathGroup )



-- Hacking around a bit to get the right Avatar Icon

local function ModifySearch(processed, raw)

	local plys = player.GetAll()

	local ply

	for i = 1, # plys do

		if plys[i]:Name() == raw.nick then

			ply = plys[i]

		end

	end



	raw.owner = ply

end

hook.Add( "TTTBodySearchPopulate", "Modifies the Search", ModifySearch )







-- Add the Tab for configuring

local function AddTab(dtabs)

	if not CLIENT then return end



	if LocalPlayer():HasWeapon("weapon_ttt_bodyspawn") then

		local ddfmenu = DEATHFAKER.OpenDFConfig(dtabs)

		dtabs:AddSheet("Death Faker", ddfmenu, "icon16/user_gray.png", false,false, "Deathfaker control control")

	end

end

hook.Add( "TTTEquipmentTabs", "Adds the right tab", AddTab )