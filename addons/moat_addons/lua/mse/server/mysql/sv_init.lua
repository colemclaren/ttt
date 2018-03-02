MSE.MySQL = MSE.MySQL or {}

function MSE.MySQL.CheckTable()
	MSE.MySQL.Query([[
		CREATE TABLE IF NOT EXISTS mse_players (
		id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
		steamid VARCHAR(30) NOT NULL,
		rank TEXT NOT NULL, 
		cooldown INTEGER NOT NULL, 
		amount INTEGER NOT NULL)
	]])
	MSE.MySQL.Query([[
		CREATE TABLE IF NOT EXISTS mse_logs (
		id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
		steamid VARCHAR(30) NOT NULL,
		cmd TEXT NOT NULL, 
		time INTEGER NOT NULL)
	]])
end

if (system.IsWindows() and file.Exists("lua/bin/gmsv_tmysql4_win32.dll", "MOD")) or (system.IsLinux() and file.Exists("lua/bin/gmsv_tmysql4_linux.dll", "MOD")) then
	MSE.IncludeSV "sv_tmysql.lua"
	MSE.Print "Using tmysql"
elseif (system.IsWindows() and file.Exists("lua/bin/gmsv_mysqloo_win32.dll", "MOD")) or (system.IsLinux() and file.Exists("lua/bin/gmsv_mysqloo_linux.dll", "MOD")) then
	MSE.IncludeSV "sv_mysqloo.lua"
	MSE.Print "Using mysqloo"
else
	error "MSE: No mysql module found! Please install tmysql or mysqloo."
end