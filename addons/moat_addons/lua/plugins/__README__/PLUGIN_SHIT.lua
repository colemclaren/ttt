/*

	- just look at the other plugins for examples
	- important notes:
		- file name realms will override folder realm
		- unset file or folder realms will default to shared
	- include rules:
		- starts with "_" will never include anything past the folder
		- starts with "sv_" or "server" will include in server realm
		- starts with "cl_" or "client" will include in client realm
		- folders have the same include rules as files but only if the file realm is not set
		- files that do not have a set realm rely on the folder's realm by default or default to shared
		- files that do not end with .lua will be never be included
		- ./init.lua will be included shared before any other folder or file inside
		- ./init/ will be included shared before any other folder inside (if init.lua is in same dir, it will be called before the folder)
		- ./utils.lua > ./utils/ will be included shared after any init file or folders
		- starts with "dev_" will only include if SERVER_ISDEV is true (it's automatically set if you aren't on a master server - no convar needed)
			- if a plugin root folder starts with dev_ you do not have to set folder/filenames to dev_
			- you can still set the realm after dev_ if you want, examples:
				- dev_cl_example.lua -- only included clientside
				- dev_sv_example.lua -- only included serverside
				- dev_example.lua    -- checks folder realm, defaults shared

*/