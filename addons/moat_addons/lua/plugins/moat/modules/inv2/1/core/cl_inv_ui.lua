m_CosmeticSlots = {}
m_CosmeticSlots["Hat"] = ""
m_CosmeticSlots["Mask"] = ""
m_CosmeticSlots["Body"] = ""
m_CosmeticSlots["Effect"] = ""

function m_GetCosmeticFromEnum(item_enum)

    return table.Copy(COSMETIC_ITEMS[item_enum]) or {}
end

function m_SendCosmeticPositions(itemtbl, slot)
    if (slot ~= 6 and slot ~= 7 and slot ~= 8) then return end
    if (not itemtbl.u) then return end
    
    local cosmetic_pos = {}

    for i = 1, 6 do
        local num = cookie.GetNumber("moatbeta_pos" .. itemtbl.u .. i)
        if (num) then
            cosmetic_pos[i] = num
        else
            cosmetic_pos[i] = 0
            if (i == 3) then
                cosmetic_pos[i] = 1
            end
        end
    end

    net.Start("MOAT_UPDATE_MODEL_POS")
    net.WriteUInt(itemtbl.u, 16)
    net.WriteDouble(cosmetic_pos[1])
    net.WriteDouble(cosmetic_pos[2])
    net.WriteDouble(cosmetic_pos[3])
    net.WriteDouble(cosmetic_pos[4])
    net.WriteDouble(cosmetic_pos[5])
    net.WriteDouble(cosmetic_pos[6])
    net.SendToServer()
end


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

    --[[self.Platform = ClientsideModel("models/props_phx/construct/glass/glass_angle360.mdl", RENDERGROUP_BOTH)
	
	self.Platform:SetNoDraw(true)

	self.Platform:SetPos(center + Vector(0, 0, 2))

	self.Platform:SetAngles(Angle(0, 0, 0))

	self.Platform:SetModelScale(0.4, 0)]]
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
        strModel = GetGlobalString("ttt_default_playermodel")
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

    if (MOAT_PAINT and item_tbl and (item_tbl.p or item_tbl.p2)) then
        if (item_tbl.p2) then
            tbl.ModelEnt:SetMaterial("models/debug/debugwhite")
            local col = MOAT_PAINT.Colors[item_tbl.p2 - #MOAT_PAINT.Colors - 6000]
            if (not col) then return end
            tbl.Colors = {col[2][1]/255, col[2][2]/255, col[2][3]/255}
        else
            local col = MOAT_PAINT.Colors[item_tbl.p - 6000]
            if (not col) then return end
            tbl.Colors = {col[2][1]/255, col[2][2]/255, col[2][3]/255}
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
        if (v.Colors) then
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
	if (particles:GetInt() ~= 1) then return end
	
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

vgui.Register("MOAT_PlayerPreview", PANEL, "DButton")



local PANEL = {}

AccessorFunc( PANEL, "m_strModelName",  "ModelName" )
AccessorFunc( PANEL, "m_iSkin",         "SkinID" )
AccessorFunc( PANEL, "m_strBodyGroups", "BodyGroup" )
AccessorFunc( PANEL, "m_strIconName",   "IconName" )

function PANEL:Init()

    self:SetDoubleClickingEnabled( false )
    self:SetText( "" )

    self.Icon = vgui.Create( "ModelImage", self )
    self.Icon:SetMouseInputEnabled( false )
    self.Icon:SetKeyboardInputEnabled( false )

    self:SetSize( 64, 64 )

    self.m_strBodyGroups = "000000000"

end

function PANEL:DoRightClick()

    local pCanvas = self:GetSelectionCanvas()
    if ( IsValid( pCanvas ) && pCanvas:NumSelectedChildren() > 0 ) then
        return hook.Run( "SpawnlistOpenGenericMenu", pCanvas )
    end

    self:OpenMenu()
end

function PANEL:DoClick()
    self:RebuildSpawnIcon()
end

function PANEL:OpenMenu()
end

function PANEL:Paint( w, h )

    

end


function PANEL:PerformLayout()
	self.Icon:StretchToParent(0, 0, 0, 0)
end

function PANEL:SetSpawnIcon(name)
    self.m_strIconName = name
    self.Icon:SetSpawnIcon(name)
end

function PANEL:SetBodyGroup( k, v )

    if ( k < 0 ) then return end
    if ( k > 9 ) then return end
    if ( v < 0 ) then return end
    if ( v > 9 ) then return end

    self.m_strBodyGroups = self.m_strBodyGroups:SetChar( k + 1, v )

end

function PANEL:CreateIcon(n)
	if (IsValid(self.Icon)) then self.Icon:Remove() end -- Why are we being called anyways?

	self.Icon = vgui.Create("ModelImage", self)
    self.Icon:SetMouseInputEnabled(false)
    self.Icon:SetKeyboardInputEnabled(false)
	self.Icon:StretchToParent(0, 0, 0, 0)

	local mdl = self:GetModelName()
	local skn = self:GetSkinID()

	if (not mdl and not n) then return end
	mdl = tostring(mdl)

	self:SetModel(mdl, skn)
end

function PANEL:SetModel(mdl, iSkin, BodyGroups)
	if ( !mdl ) then debug.Trace() return end
	if (not mdl:EndsWith(".mdl")) then
		if (self.ModelPanel) then self.ModelPanel:Remove() end
		return
	end

    self:SetModelName( mdl )
    self:SetSkinID( iSkin )

    if ( tostring( BodyGroups ):len() != 9 ) then
        BodyGroups = "000000000"
    end

    self.m_strBodyGroups = BodyGroups

	if (not IsValid(self.Icon)) then self:CreateIcon(true) end
    self.Icon:SetModel(mdl, iSkin, BodyGroups)

    local mdls = tostring(mdl)

    if (self.ModelPanel) then self.ModelPanel:Remove() end
    if (MOAT_MODEL_POS[mdls]) then
        self.Icon:SetVisible(false)

        self.ModelPanel = vgui.Create("DModelPanel", self)
        self.ModelPanel:SetPos(0, 0)
        self.ModelPanel:SetSize(64, 64)
        self.ModelPanel:SetModel(mdl)

        if (iSkin) then self.ModelPanel.Entity:SetSkin(iSkin) end
        
        local PrevMins, PrevMaxs = self.ModelPanel.Entity:GetRenderBounds()
        self.ModelPanel:SetCamPos(PrevMins:Distance(PrevMaxs) * Vector(0.5, 0.5, 0.5))
        self.ModelPanel:SetLookAt((PrevMaxs + PrevMins) / 2)
        self.ModelPanel.Entity:SetModelScale(MOAT_MODEL_POS[mdls][1])
        self.ModelPanel.Entity:SetAngles(MOAT_MODEL_POS[mdls][2])
        self.ModelPanel.Entity:SetPos(MOAT_MODEL_POS[mdls][3])
        
        function self.ModelPanel:LayoutEntity(ent)
            ent:SetModelScale(MOAT_MODEL_POS[mdls][1])
            ent:SetAngles(MOAT_MODEL_POS[mdls][2])
            ent:SetPos(MOAT_MODEL_POS[mdls][3])
            --ent:SetAngles(Angle(0, 45, 0))
            --ent:SetPos(Vector(0, 0, 35))
        end
    else
        self.Icon:SetVisible(true)
    end

end

function PANEL:RebuildSpawnIcon()
	if (not IsValid(self.Icon)) then self:CreateIcon() end
    self.Icon:RebuildSpawnIcon()
end

function PANEL:RebuildSpawnIconEx(t)
    self.Icon:RebuildSpawnIconEx(t)
end

function PANEL:ToTable( bigtable )

    local tab = {}

    tab.type = "model"
    tab.model = self:GetModelName()

    if ( self:GetSkinID() != 0 ) then
        tab.skin = self:GetSkinID()
    end

    if ( self:GetBodyGroup() != "000000000" ) then
        tab.body = "B" .. self:GetBodyGroup()
    end

    if ( self:GetWide() != 64 ) then
        tab.wide = self:GetWide()
    end

    if ( self:GetTall() != 64 ) then
        tab.tall = self:GetTall()
    end

    table.insert( bigtable, tab )

end

-- Icon has been editied, they changed the skin
-- what should we do?
function PANEL:SkinChanged( i )

    -- Change the skin, and change the model
    -- this way we can edit the spawnmenu....
    self:SetSkinID( i )
    self:SetModel( self:GetModelName(), self:GetSkinID(), self:GetBodyGroup() )

end

function PANEL:BodyGroupChanged( k, v )

    self:SetBodyGroup( k, v )
    self:SetModel( self:GetModelName(), self:GetSkinID(), self:GetBodyGroup() )

end

vgui.Register( "MoatModelIcon", PANEL, "DButton" )


