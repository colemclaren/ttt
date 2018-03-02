D3A.MySQL = D3A.MySQL or {}

if (system.IsWindows() and file.Exists("lua/bin/gmsv_tmysql4_win32.dll", "MOD")) or (system.IsLinux() and file.Exists("lua/bin/gmsv_tmysql4_linux.dll", "MOD")) then
	D3A.IncludeSV "sv_tmysql.lua"
	D3A.Print "Using tmysql"
elseif (system.IsWindows() and file.Exists("lua/bin/gmsv_mysqloo_win32.dll", "MOD")) or (system.IsLinux() and file.Exists("lua/bin/gmsv_mysqloo_linux.dll", "MOD")) then
	D3A.IncludeSV "sv_mysqloo.lua"
	D3A.Print "Using mysqloo"
else
	error "D3A: No mysql module found! Please install tmysql or mysqloo"
end