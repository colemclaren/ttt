
function moat_DropIndependence(ply, amt)
	for i = 1, amt do
        if (not IsValid(ply)) then return end
        ply:m_DropInventoryItem("Independence Crate", "hide_chat_obtained", false, true)
    end
end