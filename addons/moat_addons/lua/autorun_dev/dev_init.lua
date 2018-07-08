-- only moat_init.lua and init/sh_servers.lua is called before this file
-- use this to block includes or custom load stuff for dev servers only
moat.dontinclude "loaders/example.lua"

DEBUG = false
DEBUG_LOAD = false
