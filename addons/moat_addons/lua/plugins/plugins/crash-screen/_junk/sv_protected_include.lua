local _this = aCrashScreen
_this.include = _this.include or {}
local _this = _this.include

util.AddNetworkString( 'acrashscreen_alt' )

-- Store all compressed files
_this.files = _this.files or {}

--[[=====================================
		File send.
=======================================]]

function _this.send( ply )
	
	net.Start( 'acrashscreen_alt' )
		
		-- So we know how many compressed files we have
		net.WriteUInt( table.Count( _this.files ), 10 )
		
		for path, _file in SortedPairsByMemberValue( _this.files, 'n', false ) do
			net.WriteUInt( _file[ 'l' ], 32 )
			net.WriteData( _file[ 'c' ], _file[ 'l' ] )
			net.WriteString( path )
		end
		
	net.Send( ply )
	
end

hook.Add( 'PlayerInitialSpawn', 'acrashscreen_alt', function( ply )
	_this.send( ply )
end)

--[[=====================================
		File include
=======================================]]

-- Include a server file
function _this.includeServerFile( path )
	include( path )
end

-- Include a client file
function _this.includeClientFile( path, notMinfy )
	local _string = file.Read( path, "LUA" )
	local minified = not notMinfy and _this.minifyLuaString( _string, path ) or _string
	local compressed = util.Compress( minified )
	_this.files[ path ] = {
		n = _this.files[ path ] and _this.files[ path ].n or table.Count( _this.files ),
		c = compressed,
		l = compressed:len()
	}
end

-- Include a single file
function _this.includeFile( path, notMinfy )
	
	path = string.TrimRight( path, "/" )
	local _file = string.GetFileFromFilename( path )
	
	if not string.EndsWith( _file, ".lua" ) then
		Error( "Attempted to include a non lua file." )
	end
	
	-- Include all files that do not start with cl_ stands for not include
	if not string.StartWith( _file, "cl_" ) then
		_this.includeServerFile( path )
	end
	
	if ( string.StartWith( _file, "cl_" ) or string.StartWith( _file, "sh_" ) ) then
		_this.includeClientFile( path, notMinfy )
	end

end

--[[=====================================
		File minify
=======================================]]

local string = string

local tokens = {
	'+', '-', '*', '/', '%', '^', '#',
	'==', '~=', '!=', '<=', '>=', '<', '>', '=',
	'(', ')', '{', '}', '[', ']',
	';', ':', ',', '.', '..', '...'
}

function _this.minifyLuaString( str, path )
	
	path = path or "..."
	
	-- Can't get it to work with regex...
	
	local _t = string.ToTable( str ) -- All characters in the string.
	local _nt, _ct = {}, nil -- New table, Current table.
	
	local inString1, inString2 = false, false -- ", '
	local inStringBlock1 = false -- [[
	local inCommentLine1, inCommentLine2 = false, false -- --, //
	local inCommentBlock1, inCommentBlock2 = false, false -- --[[, /*
	
	local i = 0
	local size = #_t
	while i < size do
		
		i = i+1
		
		local v = _t[ i ]
		
		-- Do nothing if in string.
		-- If it's a new line, the code will give an error.
		if inString1 then
			if v == '"' or v == '\n' then
				inString1 = false
				if v == '\n' then -- This wont be a string anymore, and will give an error.
					_ct.type = "errorcode"
					ErrorNoHalt( "[ALT][WARNING] " .. path .. ": Unfinished string at character `" .. i .. "`\n" )
				end
			end
			_ct.string = _ct.string .. v
			continue
		end
		
		-- Do nothing if in string.
		-- If it's a new line, the code will give an error.
		if inString2 then
			if v == "'" or v == '\n' then
				inString2 = false
				if v == '\n' then -- This wont be a string anymore, and will give an error.
					_ct.type = "errorcode"
					ErrorNoHalt( "[ALT][WARNING] " .. path .. ": Unfinished string at character `" .. i .. "`\n" )
				end
			end
			_ct.string = _ct.string .. v
			continue
		end
		
		-- Do nothing if in string block.
		-- We do want to keep new lines in here.
		if inStringBlock1 then
			if v .. _t[ i+1 ] == "]]" then
				inStringBlock1 = false
				_ct.string = _ct.string .. ']]'
				i = i+1 -- Skip next char.
			else
				_ct.string = _ct.string .. v
			end
			continue
		end
		
		-- Stop comment when there's a new line.
		if inCommentLine1 then
			if v == '\n' then inCommentLine1 = false end
			_ct.string = _ct.string .. string.gsub( v, '\n', '' ) -- We don't want new lines.
			continue
		end
		
		-- Stop comment when there's a new line.
		if inCommentLine2 then
			if v == '\n' then inCommentLine2 = false end
			_ct.string = _ct.string .. string.gsub( v, '\n', '' ) -- We don't want new lines.
			continue
		end
		
		-- Stop comment when the comment block ends.
		if inCommentBlock1 then
			if _t[ i+1 ] != nil and v .. _t[ i+1 ] == ']]' then
				inCommentBlock1 = false
				_ct.string = _ct.string .. ']]'
				i = i+1 -- Skip next char.
			else
				_ct.string = _ct.string .. string.gsub( v, '\n', ' ' ) -- No need for new lines in commented blocks.
			end
			continue
		end
		
		-- Stop comment when the comment block ends.
		-- Otherwise remove the character.
		if inCommentBlock2 then
			if _t[ i+1 ] != nil and v .. _t[ i+1 ] == '*/' then
				inCommentBlock2 = false
				_ct.string = _ct.string .. '*/'
				i = i+1 -- Skip next char.
			else
				_ct.string = _ct.string .. string.gsub( v, '\n', ' ' ) -- No need for new lines in commented blocks.
			end
			continue
		end
		
		-- Start a new current table.
		
		local _nct = { type = "notset", string = "" } -- Create new current table.
		
		if v == '"' then
			inString1 = true
			_nct.string = _nct.string .. v -- Add to string.
			_nct.type = 'string1'
		elseif v == '\'' then
			inString2 = true
			_nct.string = _nct.string .. v -- Add to string.
			_nct.type = 'string2'
		elseif _t[ i+1 ] != nil
			and v .. _t[ i+1 ] == '[[' then
			inStringBlock1 = true
			_nct.string = _nct.string .. v .. _t[ i+1 ] -- Add to string.
			_nct.type = 'stringblock1'
			i = i + 1 -- Skip next char.
		elseif _t[ i+3 ] != nil
			and v .. _t[ i+1 ] .. _t[ i+2 ] .. _t[ i+3 ] == '--[[' then
			inCommentBlock1 = true
			_nct.string = _nct.string .. v .. _t[ i+1 ] .. _t[ i+2 ] .. _t[ i+3 ] -- Add to string.
			_nct.type = 'commentblock1'
			i = i + 3 -- Skip next 3 chars.
		elseif _t[ i+1 ] != nil
			and v .. _t[ i+1 ] == '/*' then
			inCommentBlock2 = true
			_nct.string = _nct.string .. v .. _t[ i+1 ] -- Add to string.
			_nct.type = 'commentblock2'
			i = i + 1 -- Skip next char.
		elseif _t[ i+1 ] != nil
			and v .. _t[ i+1 ] == '--' then
			inCommentLine1 = true
			_nct.string = _nct.string .. v .. _t[ i+1 ] -- Add to string.
			_nct.type = 'commentline1'
			i = i + 1 -- Skip next char.
		elseif _t[ i+1 ] != nil
			and v .. _t[ i+1 ] == '//' then
			inCommentLine2 = true
			_nct.string = _nct.string .. v .. _t[ i+1 ] -- Add to string.
			_nct.type = 'commentline2'
			i = i + 1 -- Skip next char.
		else
			
			if _ct != nil and _ct.type == 'code' then
				_ct.string = _ct.string .. string.gsub( v, '\n', ' ' ) -- Add to string, we don't want new lines.
				continue -- No need for a new current table.
			else
				_nct.string = _nct.string .. string.gsub( v, '\n', ' ' ) -- Add to string, we don't want new lines.
				_nct.type = 'code'
			end
			
		end
		
		_ct = _nct
		table.insert( _nt, _ct ) -- Insert table into the new table.
		
	end
	
	local str = ""
	for n, _t in pairs( _nt ) do
		
		local _string = _t.string
		local _type = _t.type
		
		if _type == 'commentline1' or _type == 'commentline2'
			or _type == 'commentblock1' or _type == 'commentblock2' then
			continue
		end
		
		if _type == 'code' then
			
			-- Replace these with a space.
			_string = string.gsub( _string, "%c", " " )
			_string = string.Replace( _string, "	", "" )
			
			-- Remove all double spaces.
			local l = 0
			repeat
				l = _string:len()
				_string = string.Replace( _string, "  ", " " )
			until ( l == _string:len() )
			
			-- Replace these, no spaces needed.
			for k, v in pairs( tokens ) do
				_string = string.Replace( _string, " " .. v, v )
				_string = string.Replace( _string, v .. " ", v )
			end
			
		end
		
		
		str = str .. _string
		
	end
	
	str = str:Trim( " " )
	
	return str
end