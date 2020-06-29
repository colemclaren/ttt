MOAT_OMEGAS = MOAT_OMEGAS or {}

function MOAT_OMEGAS.Material(id, mat)
	local mat_key = (mat or "") .. "Material"

	MOAT_OMEGAS[id][mat_key .. "Set"] = false
	MOAT_OMEGAS[id][mat_key] = CreateMaterial("omega_" .. mat:lower() .. "_" .. MOAT_OMEGAS[id].Name:lower(), "VertexLitGeneric", {
		["$model"] = 1,
        ["$alphatest"] = 1,
        ["$vertexcolor"] = 1,
        ["$basetexture"] = "error"
    })

	if (MOAT_OMEGAS[id].URL:match "vtf$") then
		local function set(m)
			MOAT_OMEGAS[id][mat_key]:SetTexture("$basetexture", m)
			MOAT_OMEGAS[id][mat_key .. "Set"] = true
		end

		local m = cdn.Texture(MOAT_OMEGAS[id].URL, set)
		if (m) then
			set(m)
		end
	else
		local function set(m)
			MOAT_OMEGAS[id][mat_key]:SetTexture("$basetexture", m:GetTexture("$basetexture"))
			MOAT_OMEGAS[id][mat_key .. "Set"] = true
		end

		local m = cdn.Image(MOAT_OMEGAS[id].URL, set)
		if (m) then
			set(m)
		end
	end

	return MOAT_OMEGAS[id][mat_key]
end


function MOAT_OMEGAS.Add(id, name, desc, image, ball_rarity, mask_rarity, skin_rarity, collection, name_color)
	image = image or ("https://static.moat.gg/f/" .. name:lower() .. ".png")

	local omega = {
		ID = id,
		Name = name,
		Description = desc or name,
		URL = image,
		Image = image,
		Rarity = math.max(ball_rarity, mask_rarity, skin_rarity)
	}

	/*
	if (skin_rarity and skin_rarity > 0) then
		MOAT_PAINT.Skins = MOAT_PAINT.Skins or {}
		MOAT_PAINT.Skins[6400 + omega.ID] = {omega.Name .. " Skin", skin_url or omega.Image, skin_rarity, skin_url or omega.Image, "Omega Collection"}

		local tbl = {Collection = "Omega Collection"}
        tbl.Name = omega.Name .. " Skin"
        tbl.ID = 6400 + omega.ID
        tbl.Description = "Right click this skin to use it on a weapon"
        tbl.Rarity = omega.Rarity
		tbl.Texture = skin_url or omega.Image
        tbl.Image = skin_icon or omega.Image
		tbl.ItemCheck = 12
		tbl.PaintVer = 2

        function tbl:ItemUsed(pl, slot, item)
            m_TextureItem(pl, slot, item, self.ID)
        end

		if (SERVER) then
			m_AddDroppableItem(tbl, "Usable")
		end
	end
	*/

	if (ball_rarity and ball_rarity > 0) then
		weapons.Register({
            Base = "weapon_ttt_bouncy_omega",
            PrintName = omega.Name .. " Bouncy Ball",
			CreateBall = function(s)
                local ent = ents.Create "sent_omegaball"
				if (IsValid(ent)) then
					ent:SetBallMaterial(omega.ID)
				end

                return ent
            end
		}, "weapon_ttt_bouncy_" .. omega.Name:lower())

		local tbl = {Collection = collection or "Omega Collection"}
		if (name_color) then tbl.NameColor = name_color end
        tbl.Name = omega.Name .. " Bouncy Ball"
        tbl.ID = 7400 + omega.ID
        tbl.Description = omega.Description
        tbl.Rarity = omega.Rarity
        tbl.Image = omega.Image
		tbl.WeaponClass = "weapon_ttt_bouncy_" .. omega.Name:lower()

        -- if (SERVER) then
			m_AddDroppableItem(tbl, "Special")
		-- end
	end

	if (mask_rarity and mask_rarity > 0) then
		local tbl = {Collection = collection or "Omega Collection"}
		if (name_color) then tbl.NameColor = name_color end
        tbl.Name = omega.Name .. " Mask"
        tbl.ID = 8400 + omega.ID
        tbl.Description = omega.Description
        tbl.Rarity = omega.Rarity
        tbl.Image = omega.Image
		tbl.Attachment = "eyes"
		tbl.Model = "models/moat/mg_meme_mask4.mdl"
		tbl.WeaponClass = "weapon_ttt_bouncy_" .. omega.Name:lower()

		function tbl:ModifyClientsideModel(pl, model, pos, ang)
			pos = pos + (ang:Forward() * 3) + (ang:Up() * -0.4) + m_IsTerroristModel(pl:GetModel())
			
			if (MOAT_OMEGAS[omega.ID]["MaskMaterialSet"] == nil) then
				MOAT_OMEGAS.Material(omega.ID, "Mask")
				model:SetModelScale(0)
			end

			if (MOAT_OMEGAS[omega.ID]["MaskMaterialSet"] and not model.SetOmega) then
				model:SetSubMaterial(0, "!" .. MOAT_OMEGAS[omega.ID]["MaskMaterial"]:GetName())
				model:SetModelScale(1)
				model.SetOmega = true
			end

			return model, pos, ang
		end

		m_AddDroppableItem(tbl, "Mask")
		if (CLIENT) then
			m_AddCosmeticItem(tbl, "Mask")
		end
	end

	MOAT_OMEGAS[id] = omega
end

function MOAT_OMEGAS.InitializeItems()
	if (CLIENT and not m_AddCosmeticItem) or (SERVER and not m_AddDroppableItem) then
		return
	end

	MOAT_OMEGAS.Add(1, "Pog", nil, nil, 7, 7, 7)
	MOAT_OMEGAS.Add(2, "OMEGALUL", nil, nil, 6, 6, 6)
	MOAT_OMEGAS.Add(3, "HeartPepe", nil, nil, 4, 4, 4)
	MOAT_OMEGAS.Add(4, "PepeHands", nil, nil, 2, 2, 2)
	MOAT_OMEGAS.Add(5, "Poggers", nil, nil, 5, 5, 5)
	MOAT_OMEGAS.Add(6, "WaitWhat", nil, nil, 7, 7, 7)
	MOAT_OMEGAS.Add(7, "DontBully", nil, nil, 3, 3, 3)
	MOAT_OMEGAS.Add(8, "MonkaS", nil, nil, 6, 6, 6)
	MOAT_OMEGAS.Add(9, "PagChomp", nil, nil, 7, 7, 7)
	MOAT_OMEGAS.Add(10, "FeelsBadMan", nil, nil, 6, 6, 6)
	MOAT_OMEGAS.Add(11, "MonkaMega", nil, nil, 5, 5, 5)
	MOAT_OMEGAS.Add(12, "LULW", nil, nil, 2, 2, 2)
	MOAT_OMEGAS.Add(13, "MonkaOMEGA", nil, nil, 6, 6, 6)
	MOAT_OMEGAS.Add(14, "PepoThink", nil, nil, 3, 3, 3)
	MOAT_OMEGAS.Add(15, "Klappa", nil, nil, 5, 5, 5)
	MOAT_OMEGAS.Add(16, "MonkaGun", nil, nil, 4, 4, 4)
	MOAT_OMEGAS.Add(17, "SuchMeme", nil, nil, 4, 4, 4)
	MOAT_OMEGAS.Add(18, "ForsenCD", nil, nil, 7, 7, 7)
	MOAT_OMEGAS.Add(19, "PeepoHappy", nil, nil, 6, 6, 6)
	MOAT_OMEGAS.Add(20, "Thankong", nil, nil, 3, 3, 3)
	MOAT_OMEGAS.Add(21, "RNGplz", nil, nil, 4, 4, 4)
	MOAT_OMEGAS.Add(22, "HyperPoggers", nil, nil, 6, 6, 6)
	MOAT_OMEGAS.Add(23, "FeelsSpecialMan", nil, nil, 7, 7, 7)
	MOAT_OMEGAS.Add(24, "Kappa", nil, nil, 4, 4, 4)
	MOAT_OMEGAS.Add(25, "4Head", nil, nil, 5, 5, 5)
	MOAT_OMEGAS.Add(26, "PogChamp", nil, nil, 7, 7, 7)
	MOAT_OMEGAS.Add(27, "KKona", nil, nil, 3, 3, 3)
	MOAT_OMEGAS.Add(28, "TriHard", nil, nil, 6, 6, 6)
	MOAT_OMEGAS.Add(29, "Box", nil, nil, 5, 5, 5)
	MOAT_OMEGAS.Add(30, "HeartPepe", nil, nil, 3, 2, 2, "Valentine Collection", Color(255, 0, 255))
end


hook("Initialize", MOAT_OMEGAS.InitializeItems)
MOAT_OMEGAS.InitializeItems()