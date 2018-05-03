local ORM = include "sql_mysqloo.lua"

function MOAT_INV:SQLQuery(str, ...)
    local args = {n = select("#", ...), ...}
    local succ, err = isfunction(args[args.n]), isfunction(args[args.n - 1])
	if (succ) then
		succ, err = err and args[args.n - 1] or args[args.n], err and args[args.n] or nil
		args.n = args.n - (err and 2 or 1)
	end

    self.SQL:Query(self.SQL:CreateQuery(str, unpack(args, 1, args.n)), succ, err or function(er)
		MOAT_INV.Print("Query Error: " .. er .. " | With Query: " .. str, true)
    end)
end

hook.Add("SQLConnected", "MOAT_INV.SQL", function(db)
    MOAT_INV.SQL = ORM(db)
    hook.Run "InventoryPrepare"
end)