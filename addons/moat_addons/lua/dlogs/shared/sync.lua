-- I heard using an entity to sync variables with all players is good
-- this is what sandbox does (edit_sky, edit_sun, ..)
local ENT = {
	Type = "anim",
	base = "base_anim",
	SetupDataTables = function(self)
		self:NetworkVar("Int", 0, "PlayedRounds")
		self:NetworkVar("Bool", 0, "LastRoundMapExists")
		self:NetworkVar("Int", 1, "PendingReports")
	end,
	UpdateTransmitState = function() return TRANSMIT_ALWAYS end,
	Draw = function() end,
	Initialize = function(self)
		self:DrawShadow(false)
	end
}

scripted_ents.Register(ENT, "dmglog_sync_ent")

-- Getting the entity serverside or clientside
-- Then all we'll have to do is using Get* and Set* functions we create using NetworkVar()
function dlogs:GetSyncEnt()
	if SERVER then
		return self.sync_ent
	else
		return ents.FindByClass("dmglog_sync_ent")[1]
	end
end

-- TTT cleans up all entities
-- fuck it
local CleanUpMap = game.CleanUpMap

function game.CleanUpMap(send_to_clients, filters)
	filters = filters or {}
	table.insert(filters, "dmglog_sync_ent")
	local res = CleanUpMap(send_to_clients, filters)
	return res
end

if SERVER then
	-- Creating the entity on InitPostEntity

	hook.Add("InitPostEntity", "InitPostEntity_dlogs", function()
		dlogs.sync_ent = ents.Create("dmglog_sync_ent")
		dlogs.sync_ent:Spawn()
		dlogs.sync_ent:Activate()
		dlogs.sync_ent:SetLastRoundMapExists(dlogs.last_round_map and true or false)

		for k,v in pairs(dlogs.Reports.Current) do
			if v.status != RDM_MANAGER_FINISHED then
				dlogs.sync_ent:SetPendingReports(dlogs.sync_ent:GetPendingReports() + 1)
			end
		end

		for k,v in pairs(dlogs.Reports.Previous) do
			if v.status != RDM_MANAGER_FINISHED then
				dlogs.sync_ent:SetPendingReports(dlogs.sync_ent:GetPendingReports() + 1)
			end
		end
	end)
end