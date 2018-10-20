
  -- BEM Settings in F1 menu
hook.Add("TTTSettingsTabs", "BEM_TTTSettingsTab", function(dtabs)
    local padding = dtabs:GetPadding()
    padding = padding * 2

    local dsettings = vgui.Create("DPanelList", dtabs)
    dsettings:StretchToParent(0,0,padding,0)
    dsettings:EnableVerticalScrollbar(true)
    dsettings:SetPadding(10)
    dsettings:SetSpacing(10)

    -- info text
    local dlabel = vgui.Create("DLabel", dsettings)
    dlabel:SetText("All changes made here are clientside and will only apply to your own menu!")
    dsettings:AddItem(dlabel)

    -- layout section
    local dlayout = vgui.Create("DForm", dsettings)
    dlayout:SetName("Item List Layout")

    if true then
      --dlayout:Help("All changes made here are clientside and will only apply to your own menu.")
      dlayout:NumSlider("Number of columns (def. 4)", "ttt_moat_bem_cols", 1, 20, 0)
      dlayout:NumSlider("Number of rows (def. 5)", "ttt_moat_bem_rows", 1, 20, 0)
      dlayout:NumSlider("Icon size (def. 64)", "ttt_moat_bem_size", 32, 128, 0)
    else
      dlayout:Help("Individual changes to the Traitor/Detective menus layout are not allowed on this server. Please contact a server admin for details.")
    end

    dsettings:AddItem(dlayout)

    -- marker section
    local dmarker = vgui.Create("DForm", dsettings)
    dmarker:SetName("Item Marker Settings")

    dmarker:CheckBox("Show slot marker", "ttt_moat_bem_marker_slot")
    dmarker:CheckBox("Show custom item marker", "ttt_moat_bem_marker_custom")
    dmarker:CheckBox("Show favourite item marker", "ttt_moat_bem_marker_fav")

    dsettings:AddItem(dmarker)

    dtabs:AddSheet("Equipment Settings", dsettings, "icon16/cog.png", false, false, "Equipment Menu Settings")
end)

BetterEQ = BetterEQ or {}

function BetterEQ.CreateFavTable()
	if !(sql.TableExists("ttt_bem_fav")) then
    query = "CREATE TABLE ttt_bem_fav (guid TEXT, role TEXT, weapon_id TEXT)"
		result = sql.Query(query)
	end
end

function BetterEQ.AddFavorite(guid, role, weapon_id)
  query = "INSERT INTO ttt_bem_fav VALUES('" .. guid .. "','" .. role .. "','" .. weapon_id .. "')"
  result = sql.Query(query)
end

function BetterEQ.RemoveFavorite(guid, role, weapon_id)
  query = "DELETE FROM ttt_bem_fav WHERE guid = '" .. guid .. "' AND role = '" .. role .. "' AND weapon_id = '" .. weapon_id .. "'"
  result = sql.Query(query)
end

function BetterEQ.GetFavorites(guid, role)
  query = "SELECT weapon_id, _rowid_ FROM ttt_bem_fav WHERE guid = '" .. guid .. "' AND role = '" .. role .. "' ORDER BY `_rowid_`"
  result = sql.Query(query)
  return result
end

-- looks for weapon id in favorites table (result of GetFavorites)
function BetterEQ.IsFavorite(favorites, weapon_id)
  if (not favorites) then
    return false
  end
	for _, value in pairs(favorites) do
		local dbid = value["weapon_id"]
  	if (dbid == tostring(weapon_id)) then
    	return true
    end
  end
  return false
end
