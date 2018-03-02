local Module = Prometheus.DB.Module

Module.Name = "MySQLoo"
Module.Version = mysqloo.VERSION

function Module.Connect(Callback)
	Module.DB = mysqloo.connect(Prometheus.Mysql.Host, Prometheus.Mysql.Username, Prometheus.Mysql.Password, Prometheus.Mysql.DBName, tonumber(Prometheus.Mysql.Port) )

	function Module.DB:onConnectionFailed(Err)
		Callback(Err)
	end

	function Module.DB:onConnected()
		Callback()
		if timer.Exists("prometheus_mysqloo_dbtimeout") then return end
		timer.Create("prometheus_mysqloo_dbtimeout", 180, 0, function()
			if #player.GetAll() <= 0 then
				Module.DB:status()
				return
			end
		end)
	end

	Module.DB:connect()
end

function Module.Escape(String)
	return Module.DB:escape(String)
end

function Module.Query(QueryS, Callback)

	local Query = Module.DB:query(QueryS)

	Query.onError = function(Data, Err, QueryS)
		Prometheus.DB.Error(Err, QueryS)
	end

	Query.onSuccess = function(Q, Results)
		if Results[1] != nil then
			Callback(Results)
		else
			Callback(P_DB_NO_DATA)
		end
	end

	Query:start()
end