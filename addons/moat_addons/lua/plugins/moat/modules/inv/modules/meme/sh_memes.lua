MOAT_MEMES = MOAT_MEMES or {}

function MOAT_MEMES.Material(id, mat)
	local mat_key = (mat or "") .. "Material"

	MOAT_MEMES[id][mat_key .. "Set"] = false
	MOAT_MEMES[id][mat_key] = CreateMaterial("meme_" .. mat:lower() .. "_" .. MOAT_MEMES[id].Name:lower(), "VertexLitGeneric", {
		["$model"] = 1,
        ["$alphatest"] = 1,
        ["$vertexcolor"] = 1,
        ["$basetexture"] = "error"
    })

	if (MOAT_MEMES[id].URL:match "vtf$") then
		local function set(m)
			MOAT_MEMES[id][mat_key]:SetTexture("$basetexture", m)
			MOAT_MEMES[id][mat_key .. "Set"] = true
		end

		local m = cdn.Texture(MOAT_MEMES[id].URL, set)
		if (m) then
			set(m)
		end
	else
		local function set(m)
			MOAT_MEMES[id][mat_key]:SetTexture("$basetexture", m:GetTexture("$basetexture"))
			MOAT_MEMES[id][mat_key .. "Set"] = true
		end

		local m = cdn.Image(MOAT_MEMES[id].URL, set)
		if (m) then
			set(m)
		end
	end

	return MOAT_MEMES[id][mat_key]
end


function MOAT_MEMES.Add(id, name, desc, image, ball_rarity, mask_rarity, skin_rarity, skin_url, skin_icon)
	image = image or ("https://cdn.moat.gg/f/" .. name:lower() .. ".png")

	local meme = {
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
		MOAT_PAINT.Skins[6400 + meme.ID] = {meme.Name .. " Skin", skin_url or meme.Image, skin_rarity, skin_url or meme.Image, "Meme Collection"}

		local tbl = {Collection = "Meme Collection"}
        tbl.Name = meme.Name .. " Skin"
        tbl.ID = 6400 + meme.ID
        tbl.Description = "Right click this skin to use it on a weapon"
        tbl.Rarity = meme.Rarity
		tbl.Texture = skin_url or meme.Image
        tbl.Image = skin_icon or meme.Image
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
            Base = "weapon_ttt_bouncy_meme",
            PrintName = meme.Name .. " Bouncy Ball",
			CreateBall = function(s)
                local ent = ents.Create "sent_memeball"
				if (IsValid(ent)) then
					ent:SetBallMaterial(meme.ID)
				end

                return ent
            end
		}, "weapon_ttt_bouncy_" .. meme.Name:lower())

		local tbl = {Collection = "Meme Collection"}
        tbl.Name = meme.Name .. " Bouncy Ball"
        tbl.ID = 7400 + meme.ID
        tbl.Description = meme.Description
        tbl.Rarity = meme.Rarity
        tbl.Image = meme.Image
		tbl.WeaponClass = "weapon_ttt_bouncy_" .. meme.Name:lower()

        if (SERVER) then
			m_AddDroppableItem(tbl, "Other")
		end
	end

	if (mask_rarity and mask_rarity > 0) then
		local tbl = {Collection = "Meme Collection"}
        tbl.Name = meme.Name .. " Mask"
        tbl.ID = 8400 + meme.ID
        tbl.Description = meme.Description
        tbl.Rarity = meme.Rarity
        tbl.Image = meme.Image
		tbl.Attachment = "eyes"
		tbl.Model = "models/moat/mg_meme_mask4.mdl"
		tbl.WeaponClass = "weapon_ttt_bouncy_" .. meme.Name:lower()

		function tbl:ModifyClientsideModel(pl, model, pos, ang)
			pos = pos + (ang:Forward() * 3) + (ang:Up() * -0.4) + m_IsTerroristModel(pl:GetModel())
			
			if (MOAT_MEMES[meme.ID]["MaskMaterialSet"] == nil) then
				MOAT_MEMES.Material(meme.ID, "Mask")
				model:SetModelScale(0)
			end

			if (MOAT_MEMES[meme.ID]["MaskMaterialSet"] and not model.SetMeme) then
				model:SetSubMaterial(0, "!" .. MOAT_MEMES[meme.ID]["MaskMaterial"]:GetName())
				model:SetModelScale(1)
				model.SetMeme = true
			end

			return model, pos, ang
		end

		if (SERVER) then
			m_AddDroppableItem(tbl, "Mask")
		else
			m_AddCosmeticItem(tbl, "Mask")
		end
	end

	MOAT_MEMES[id] = meme
end

function MOAT_MEMES.InitializeItems()
	if (CLIENT and not m_AddCosmeticItem) or (SERVER and not m_AddDroppableItem) then
		return
	end

	MOAT_MEMES.Add(1, "Pog", nil, nil, 7, 7, 7)
	MOAT_MEMES.Add(2, "OMEGALUL", nil, nil, 6, 6, 6)
	MOAT_MEMES.Add(3, "HeartPepe", nil, nil, 4, 4, 4)
	MOAT_MEMES.Add(4, "PepeHands", nil, nil, 2, 2, 2)
	MOAT_MEMES.Add(5, "Poggers", nil, nil, 5, 5, 5)
	MOAT_MEMES.Add(6, "WaitWhat", nil, nil, 7, 7, 7)
	MOAT_MEMES.Add(7, "DontBully", nil, nil, 3, 3, 3)
	MOAT_MEMES.Add(8, "MonkaS", nil, nil, 6, 6, 6)
	MOAT_MEMES.Add(9, "PagChomp", nil, nil, 7, 7, 7)
	MOAT_MEMES.Add(10, "FeelsBadMan", nil, nil, 6, 6, 6)
	MOAT_MEMES.Add(11, "MonkaMega", nil, nil, 5, 5, 5)
	MOAT_MEMES.Add(12, "LULW", nil, nil, 2, 2, 2)
	MOAT_MEMES.Add(13, "MonkaOMEGA", nil, nil, 6, 6, 6)
	MOAT_MEMES.Add(14, "PepoThink", nil, nil, 3, 3, 3)
	MOAT_MEMES.Add(15, "Klappa", nil, nil, 5, 5, 5)
	MOAT_MEMES.Add(16, "MonkaGun", nil, nil, 4, 4, 4)
	MOAT_MEMES.Add(17, "SuchMeme", nil, nil, 4, 4, 4)
	MOAT_MEMES.Add(18, "ForsenCD", nil, nil, 7, 7, 7)
	MOAT_MEMES.Add(19, "PeepoHappy", nil, nil, 6, 6, 6)
	MOAT_MEMES.Add(20, "Thankong", nil, nil, 3, 3, 3)
	MOAT_MEMES.Add(21, "RNGplz", nil, nil, 4, 4, 4)
	MOAT_MEMES.Add(22, "HyperPoggers", nil, nil, 6, 6, 6)
	MOAT_MEMES.Add(23, "FeelsSpecialMan", nil, nil, 7, 7, 7)
	MOAT_MEMES.Add(24, "Kappa", nil, nil, 4, 4, 4)
	MOAT_MEMES.Add(25, "4Head", nil, nil, 5, 5, 5)
	MOAT_MEMES.Add(26, "PogChamp", nil, nil, 7, 7, 7)
	MOAT_MEMES.Add(27, "KKona", nil, nil, 3, 3, 3)
	MOAT_MEMES.Add(28, "TriHard", nil, nil, 6, 6, 6)
	MOAT_MEMES.Add(29, "Box", nil, nil, 5, 5, 5)
end


hook("Initialize", MOAT_MEMES.InitializeItems)
MOAT_MEMES.InitializeItems()