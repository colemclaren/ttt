local PANEL = {}

function PANEL:Init()
    self.EntAngle = 0
    self.SnapToCenter = CurTime()
    self.Scrolled = false
    self.ScrollDelta = 105
    self.CursorSnapX, self.CursorSnapY = 0, 0
    self.PlayerModel = ClientsideModel("models/error.mdl", RENDERGROUP_BOTH)
    self.PlayerModel:SetNoDraw(true)
    local min, max = self.PlayerModel:GetRenderBounds()
    local center = (min + max) * -0.5
    self.PlayerModel:SetPos(center + Vector(0, 0, 2))
    self.PlayerModel:SetAngles(Angle(0, 0, 0))
    self.m_intLastPaint = 0
    self.AdditionalX = 0
    self.AdditionalZ = 0
    self.ChangingAdditionalXY = false
    self.AdditionalXSave = 0
    self.AdditionalZSave = 0
    self.AdditionalXSaveCache = 0
    self.AdditionalZSaveCache = 0
    self.ClientsideModels = {}
    self.ActualAdditionalX = 0
    self.ActualAdditionalZ = 0
	self.AlphaValue = 0
	self:CreateParticles(center)
end

function PANEL:OnRemove()
	if (IsValid(self.PlayerModel)) then
		self.PlayerModel:Remove()
	end

	for k, v in pairs(self.ClientsideModels) do
		if (IsValid(v.ModelEnt)) then
			v.ModelEnt:Remove()
		end
	end
end

local ActIndex = {
	[ "pistol" ]        = ACT_HL2MP_IDLE_PISTOL,
    [ "smg" ]           = ACT_HL2MP_IDLE_SMG1,
    [ "grenade" ]       = ACT_HL2MP_IDLE_GRENADE,
    [ "ar2" ]           = ACT_HL2MP_IDLE_AR2,
    [ "shotgun" ]       = ACT_HL2MP_IDLE_SHOTGUN,
    [ "rpg" ]           = ACT_HL2MP_IDLE_RPG,
    [ "physgun" ]       = ACT_HL2MP_IDLE_PHYSGUN,
    [ "crossbow" ]      = ACT_HL2MP_IDLE_CROSSBOW,
    [ "melee" ]         = ACT_HL2MP_IDLE_MELEE,
    [ "slam" ]          = ACT_HL2MP_IDLE_SLAM,
    [ "normal" ]        = ACT_HL2MP_IDLE,
    [ "fist" ]          = ACT_HL2MP_IDLE_FIST,
    [ "melee2" ]        = ACT_HL2MP_IDLE_MELEE2,
    [ "passive" ]       = ACT_HL2MP_IDLE_PASSIVE,
    [ "knife" ]         = ACT_HL2MP_IDLE_KNIFE,
    [ "duel" ]          = ACT_HL2MP_IDLE_DUEL,
    [ "camera" ]        = ACT_HL2MP_IDLE_CAMERA,
    [ "magic" ]         = ACT_HL2MP_IDLE_MAGIC,
    [ "revolver" ]      = ACT_HL2MP_IDLE_REVOLVER
}

function PANEL:SetModel(strModel)
    if (not strModel) then
        strModel = GetGlobalString "ttt_default_playermodel"
    end

    if (isnumber(strModel)) then
        strModel = m_GetCosmeticFromEnum(strModel).Model
    end

    self.PlayerModel:SetModel(strModel)
    self.PlayerModel:ResetSequence(self.PlayerModel:LookupSequence("pose_standing_02"))

    --self.PlayerModel:ResetSequence(self.PlayerModel:SelectWeightedSequence(ACT_GMOD_TAUNT_ROBOT))
    /*
    self.PlayerModel:ResetSequence(self.PlayerModel:SelectWeightedSequence(ACT_HL2MP_IDLE_PASSIVE))
    if (self.HoldWeapon) then
        self.HoldWeapon:Remove()
    end

    self.HoldWeapon = ClientsideModel(Model("models/weapons/w_rif_ak47.mdl"))
    self.HoldWeapon:SetNoDraw(true)
    self.HoldWeapon:SetParent(self.PlayerModel, self.PlayerModel:LookupAttachment("anim_attachment_RH"))
    self.HoldWeapon:AddEffects(EF_BONEMERGE)*/
end

function PANEL:AddModel(item_enum, item_tbl)
    local tbl = m_GetCosmeticFromEnum(item_enum)
    tbl.ModelEnt = ClientsideModel(tbl.Model, RENDERGROUP_OPAQUE)
    tbl.ModelEnt:SetNoDraw(true)

	if (tbl.Skin) then
		tbl.ModelEnt:SetSkin(tbl.Skin)
	end

    if (MOAT_PAINT and item_tbl and (item_tbl.p or item_tbl.p2)) then
        if (item_tbl.p2) then
            tbl.ModelEnt:SetMaterial("models/debug/debugwhite")
            local col = MOAT_PAINT.Paints[item_tbl.p2]
            if (not col) then return end
            tbl.Colors = {col[2][1]/255, col[2][2]/255, col[2][3]/255}
			if (col.Dream) then
				tbl.Dream = true
			end
        else
            local col = MOAT_PAINT.Tints[item_tbl.p]
            if (not col) then return end
            tbl.Colors = {col[2][1]/255, col[2][2]/255, col[2][3]/255}
			if (col.Dream) then
				tbl.Dream = true
			end
        end
    end

    if (not MOAT_MODEL_POS_EDITS[item_enum]) then
        MOAT_MODEL_POS_EDITS[item_enum] = {}
        for i = 1, 6 do
            local num = cookie.GetNumber("moatbeta_pos" .. item_enum .. i)
            if (num) then
                MOAT_MODEL_POS_EDITS[item_enum][i] = num
            end
        end
    end
    self.ClientsideModels[item_enum] = tbl
end

function PANEL:AddWeapon(class)

end

function PANEL:RemoveModel(item_enum)
    if (self.ClientsideModels[item_enum] and self.ClientsideModels[item_enum].ModelEnt) then
        self.ClientsideModels[item_enum].ModelEnt:Remove()
        self.ClientsideModels[item_enum] = nil
    end
end

function PANEL:DrawModel()
    local curparent = self
    local rightx = self:GetWide()
    local leftx = 0
    local topy = 0
    local bottomy = self:GetTall()
    local previous = curparent

    while curparent:GetParent() ~= nil do
        curparent = curparent:GetParent()
        local x, y = previous:GetPos()
        topy = math.Max(y, topy + y)
        leftx = math.Max(x, leftx + x)
        bottomy = math.Min(y + previous:GetTall(), bottomy + y)
        rightx = math.Min(x + previous:GetWide(), rightx + x)
        previous = curparent
    end

    render.SetScissorRect(leftx, topy, rightx, bottomy, true)
    self.PlayerModel:DrawModel()
    --self.HoldWeapon:DrawModel()
    --local anim = ActIndex[wep.HoldType]
    --self.Entity:SetSequence(anim)

    --self.Platform:DrawModel()
    self:DrawClientsideModels()
    render.SetScissorRect(0, 0, 0, 0, false)
end

function PANEL:DrawClientsideModels()
    if (not self.ClientsideModels or table.Count(self.ClientsideModels) <= 0) then return end

    for k, v in pairs(self.ClientsideModels) do
        local pos = Vector()
        local ang = Angle()

        if (v.Attachment) then
            local attach_id = self.PlayerModel:LookupAttachment(v.Attachment)
            if (not attach_id) then return end
            local attach = self.PlayerModel:GetAttachment(attach_id)
            if (not attach) then return end
            pos = attach.Pos
            ang = attach.Ang
        else
            local bone_id = self.PlayerModel:LookupBone(v.Bone)
            if (not bone_id) then return end
            pos, ang = self.PlayerModel:GetBonePosition(bone_id)
        end

        v.ModelEnt, pos, ang = v:ModifyClientsideModel(self.PlayerModel, v.ModelEnt, pos, ang)
        -- cache the size so it's not called every frame
        -- not sure if this actually increases performance lol
        if (not v.SizeCache) then
            v.SizeCache = v.ModelEnt:GetModelScale()
        end

        if (MOAT_MODEL_POS_EDITS[k]) then
            if (MOAT_MODEL_POS_EDITS[k][3]) then
                v.ModelEnt:SetModelScale(v.SizeCache * MOAT_MODEL_POS_EDITS[k][3], 0)
            end
            if (MOAT_MODEL_POS_EDITS[k][4]) then
                pos = pos + (ang:Forward() * MOAT_MODEL_POS_EDITS[k][4])
            end
            if (MOAT_MODEL_POS_EDITS[k][5]) then
                pos = pos + (ang:Right() * -MOAT_MODEL_POS_EDITS[k][5])
            end
            if (MOAT_MODEL_POS_EDITS[k][6]) then
                pos = pos + (ang:Up() * MOAT_MODEL_POS_EDITS[k][6])
            end
            if (MOAT_MODEL_POS_EDITS[k][1]) then
                ang:RotateAroundAxis(ang:Right(), -MOAT_MODEL_POS_EDITS[k][1])
            end
            if (MOAT_MODEL_POS_EDITS[k][2]) then
                ang:RotateAroundAxis(ang:Up(), MOAT_MODEL_POS_EDITS[k][2])
            end
        else
            v.ModelEnt:SetModelScale(v.SizeCache, 0)
        end
        v.ModelEnt:SetPos(pos)
        v.ModelEnt:SetAngles(ang)
		if (v.Dream) then
			render.SetColorModulation(rarity_names[9][2].r/255, rarity_names[9][2].g/255, rarity_names[9][2].b/255)
		elseif (v.Colors) then
            render.SetColorModulation(v.Colors[1], v.Colors[2], v.Colors[3])
        end
        v.ModelEnt:DrawModel()
        render.SetColorModulation(1, 1, 1)
    end
end

local smokeparticles = {
    Model("particle/particle_smokegrenade"),
    Model("particle/particle_noisesphere"),
}

function PANEL:CreateParticle(s, n)
	if (not s) then return end

	local p = s:Add("particle/smokesprites_0001", self.ParticlePos + Vector(-60, -15.5, 80 * n))//Vector(-60, -15.5, -4))
	if (not p) then return end
	local col = HSVToColor((CurTime() - (14.5 * n)) * 5 % 360, 1, 1)
    p:SetColor(col.r, col.g, col.b)

	if (self.AlphaValue and self.AlphaValue < 0.999) then 
		p:SetNextThink(CurTime())
		p:SetThinkFunction(function(pa)
			local l = pa:GetLifeTime()
			if (self.AlphaValue and self.AlphaValue < 0.999) then
				pa:SetStartAlpha(self.AlphaValue * 200)
			end

			--local na = math.max(0, l - 6)/9
			--local col = HSVToColor((1 - na) * 365, 1, 1)
			--pa:SetColor(col.r, col.g, col.b)

			if (l < pa:GetDieTime()) then
				pa:SetNextThink(CurTime())
			end
		end)
	end

    p:SetStartAlpha(200)
    p:SetEndAlpha(0)
    p:SetLifeTime(15 * n)

    p:SetDieTime(15)

    p:SetStartSize(20)
    p:SetEndSize(20)
	p:SetGravity(Vector(0, 0, 65))
    p:SetAirResistance(600)
	p:SetAngles(Angle(0, 0, math.random(180)))
    p:SetCollide(true)
    p:SetBounce(0.4)
    p:SetLighting(false)
end


/*function PANEL:CreateParticle(s, n)
	for i = 1, 7 do
	local p = s:Add("particle/smokesprites_0001", self.ParticlePos + Vector(-60, -90 + (20 * i), 0))//Vector(-60, -15.5, -4))
	if (not p) then return end
	local col = HSVToColor((CurTime() - (14.5 * n)) * 5 % 360, 1, 1)
    p:SetColor(col.r, col.g, col.b)

    p:SetStartAlpha(30)
    p:SetEndAlpha(0)
    p:SetLifeTime(0)

    p:SetDieTime(5)

    p:SetStartSize(30)
    p:SetEndSize(40)
	p:SetGravity(Vector(0, 65, 65))
    p:SetAirResistance(600)
	p:SetAngles(Angle(0, 0, math.random(180)))
    p:SetCollide(true)
    p:SetBounce(0.4)
    p:SetLighting(false)
	end
end*/

function PANEL:FakeCreateParticles()
	for i = 1, 58 do
		self:CreateParticle(self.SmokeEffect, 1 - (i/58), amt)
	end
end

local particles = CreateConVar("moat_model_smoke", "0", FCVAR_ARCHIVE)
function PANEL:CreateParticles(pos)
	if (true) then return end --if (particles:GetInt() ~= 1) then return end
	
	self.SmokeEffect = ParticleEmitter(pos, true)
	self.SmokeEffect:SetNoDraw(true)

	local prpos = Vector(0, -5, -20)
	self.ParticlePos = pos + prpos

	self:FakeCreateParticles()
end

function PANEL:CustomThink()
	if (particles:GetInt() ~= 1) then return end
	if (not self.NextSmoke) then 
		self.NextSmoke = CurTime() + 0.25
	end

	if (self.NextSmoke <= CurTime()) then

		self:CreateParticle(self.SmokeEffect, 0)
		self.NextSmoke = CurTime() + 0.25
	end
end

function PANEL:DrawParticles()
	if (self.SmokeEffect and self.SmokeEffect:IsValid()) then
		self.SmokeEffect:SetPos(self.PlayerModel:GetPos())
		self.SmokeEffect:Draw()
	end
end

local light = CreateConVar("moat_inventory_lighting", "0", FCVAR_ARCHIVE)

function PANEL:HandleParticles(x, y, ang)
	local x2, y2 = MOAT_INV_BG:GetPos()
	local pcf = {["x"] = x - 33, ["y"] = y - 44 - 26, ["w"] = MOAT_INV_BG_W, ["h"] = MOAT_INV_BG_H}
	
	if (self.ParticleInventory) then
		pcf["x"], pcf["y"] = MOAT_INV_BG:LocalToScreen()
	end

    cam.Start3D(ang:Forward() * 103, (ang:Forward() * -1):Angle(), 33, pcf["x"], pcf["y"], pcf["w"], pcf["h"], 5)
	render.SetScissorRect(x2, y2, x2 + pcf["w"], y2 + pcf["h"], true)
	render.SuppressEngineLighting(true)
    render.SetLightingMode(1)
    render.SetLightingOrigin(self.PlayerModel:GetPos())
    render.ResetModelLighting(1, 1, 1)
    render.SetColorModulation(1, 1, 1)
    render.SetBlend(1)
    self:DrawParticles()
    render.SetLightingMode(0)
	render.SuppressEngineLighting(false)
	render.SetScissorRect(0, 0, 0, 0, false)
    cam.End3D()
end

function PANEL:Paint(intW, intH)
    if not IsValid(self.PlayerModel) then return end

    local x, y = self:LocalToScreen()
    local ang = Angle(0, 0, 0)

	if (particles:GetInt() == 1 and self.ShowParticles and IsValid(MOAT_INV_BG)) then
		if (MOAT_INV_BG:GetAlpha() == 255) then
			self.AlphaValue = Lerp(FrameTime() * 1, self.AlphaValue, 1)
		end

		self:HandleParticles(x, y, ang)
	else
		self.AlphaValue = 1
	end

    cam.Start3D(ang:Forward() * self.ScrollDelta + Vector(0, self.ActualAdditionalX, self.ActualAdditionalZ), (ang:Forward() * -1):Angle(), 33, x, y, intW, intH, 5)
    render.SuppressEngineLighting(light:GetInt() == 0 and true or false)
    render.SetLightingMode(1)
    render.SetLightingOrigin(self.PlayerModel:GetPos())
    render.ResetModelLighting(1, 1, 1)
    render.SetColorModulation(1, 1, 1)
	render.SetBlend(1)
	self:DrawModel()
    render.SetLightingMode(0)
    render.SuppressEngineLighting(false)
    cam.End3D()

    self.PlayerModel:FrameAdvance((RealTime() - self.m_intLastPaint) * 1)
    self.m_intLastPaint = RealTime()
end

function PANEL:ResetZoom()
    self.ScrollDelta = 105
    self.AdditionalX = 0
    self.AdditionalZ = 0
    self.ChangingAdditionalXY = false
    self.AdditionalXSave = 0
    self.AdditionalZSave = 0
    self.AdditionalXSaveCache = 0
    self.AdditionalZSaveCache = 0
    self.ActualAdditionalX = 0
    self.ActualAdditionalZ = 0
    self.EntAngle = 0
    self.PlayerModel:SetAngles(Angle(0, 0, 0))
end

function PANEL:Think()
    if (self.ActualAdditionalX ~= self.AdditionalX) then
        self.ActualAdditionalX = Lerp(FrameTime() * 10, self.ActualAdditionalX, self.AdditionalX)
    end

    if (self.ActualAdditionalZ ~= self.AdditionalZ) then
        self.ActualAdditionalZ = Lerp(FrameTime() * 10, self.ActualAdditionalZ, self.AdditionalZ)
    end

    if (input.IsMouseDown(MOUSE_LEFT) and self.Scrolled) then
        local x, y = input.GetCursorPos()

        if (self.SnapToCenter <= CurTime()) then
            input.SetCursorPos(self.CursorSnapX, self.CursorSnapY)
            self.SnapToCenter = CurTime() + 0.01
            self.dx, self.dy = input.GetCursorPos()
        end

        self.EntAngle = self.EntAngle + (x - self.dx) / 2
        self.PlayerModel:SetAngles(Angle(0, self.EntAngle, 0))

        return
    end

    local mouse_right = input.IsMouseDown(MOUSE_RIGHT) and self:IsHovered()

    if (mouse_right and not self.ChangingAdditionalXY) then
        local dax, day = input.GetCursorPos()

        self.AdditionalXSave = dax
        self.AdditionalZSave = day

        self.ChangingAdditionalXY = true
    elseif (mouse_right and self.ChangingAdditionalXY) then
        local dax, day = input.GetCursorPos()

        if (self.SnapToCenter <= CurTime()) then
            input.SetCursorPos(self.CursorSnapX, self.CursorSnapY)
            self.SnapToCenter = CurTime() + 0.01
            self.dx, self.dy = input.GetCursorPos()
        end

        local additionalx, additionalz = (dax - self.dx) / 5, (day - self.dy) / 5

        if (self.AdditionalXSaveCache ~= additionalx) then
            self.AdditionalX = self.AdditionalX - additionalx
            self.AdditionalXSaveCache = additionalx
        elseif (self.AdditionalZSaveCache ~= additionalz) then
            self.AdditionalZ = self.AdditionalZ + additionalz
            self.AdditionalZSaveCache = additionalz
        end
    elseif (not mouse_right and self.ChangingAdditionalXY) then
        self.ChangingAdditionalXY = false
    end

    if (GetConVar("moat_autorotate_model"):GetInt() == 1) then
        self.EntAngle = (CurTime() % 360) * 20
        self.PlayerModel:SetAngles(Angle(0, self.EntAngle, 0))
    end

    self:CustomThink()
end

function PANEL:OnMouseWheeled(scrl)
    if (not self:IsHovered()) then return end

    self.ScrollDelta = self.ScrollDelta - (scrl * 5)
end

function PANEL:OnMousePressed(key)
    if (key == MOUSE_LEFT) then
        self.CursorSnapX, self.CursorSnapY = input.GetCursorPos()
        self.Scrolled = true
    elseif (key == MOUSE_RIGHT) then
        self.CursorSnapX, self.CursorSnapY = input.GetCursorPos()
    end
end

function PANEL:OnMouseReleased(key)
    if (key == MOUSE_LEFT) then
        self.Scrolled = false
    end
end

vgui.Register("MOAT_PlayerPreview2", PANEL, "DButton")