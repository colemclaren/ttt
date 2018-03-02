local Module = Prometheus.DB.Module

Module.Name = "tmysql"
Module.Version = "4"


function Module.Connect(Callback)
	Module.DB, Err = tmysql.initialize(Prometheus.Mysql.Host, Prometheus.Mysql.Username, Prometheus.Mysql.Password, Prometheus.Mysql.DBName, tonumber(Prometheus.Mysql.Port), nil, CLIENT_MULTI_STATEMENTS)

	Callback(Err)
end

function Module.Escape(String)
	return Module.DB:Escape(String)
end


function Module.Query(QueryS, Callback)
	local function LCallback(Results)
		for n, j in pairs(Results) do
			if !j.data then
				Prometheus.DB.Error(j.error, QueryS or "Unknown query")
			else
				if j.data[1] != nil then
					Callback(j.data)
					return
				end
			end
		end
		Callback(P_DB_NO_DATA)
	end

	Module.DB:Query(QueryS, LCallback)
end