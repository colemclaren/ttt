if (true) then return end
-- this was just a test to see if we could edit the string table
-- to determine if a client should download & mount the addons on
-- the loading screen rather than in-game
-- (we can)
-- no we are not putting this code or that module on live (so plz dont)


require "stringtable"

local ids = {
	"785934793",
	"847230994",
	"863940132",
	"863942563",
	"889902236",
	"938750501",
	"1186879315",
	"1239007209",
	"1343169881"
}

local cnt = #ids
local function AddWorkshopItems()
	for i = 1, cnt do
		resource.AddWorkshop(ids[i])
	end
end

local function RemoveWorkshopItems()
	FindMetaTable("stringtable").DeleteAllStrings(stringtable.Get(0))
end

sql.Query [[CREATE TABLE IF NOT EXISTS use_workshop (steamid BIGINT NOT NULL PRIMARY KEY);]]
-- sql.Query "INSERT INTO use_workshop (steamid) VALUES (76561198053381832)"
-- sql.Query "DELETE FROM use_workshop WHERE steamid = 76561198053381832"
-- sql.Query "SELECT steamid FROM use_workshop WHERE steamid = 76561198053381832"

hook.Add("CheckPassword", "Workshop Check", function(id)
	local str = sql.Query("SELECT steamid FROM use_workshop WHERE steamid = " .. id .. ";")
	if (str) then
		last_ws_id = id
		AddWorkshopItems()
		timer.Simple(0.04, function()
			if (last_ws_id == id) then RemoveWorkshopItems() end
		end)
	end
end)