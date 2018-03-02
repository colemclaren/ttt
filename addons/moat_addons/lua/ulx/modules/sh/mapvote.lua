local CATEGORY_NAME = "MapVote"
------------------------------ VoteMap ------------------------------
function AMB_mapvote( calling_ply, votetime, should_cancel )
	if not should_cancel then
		MapVote.Start(votetime, nil, nil, nil)
		ulx.fancyLogAdmin( calling_ply, "#A called a votemap!" )
	else
		MapVote.Cancel()
		ulx.fancyLogAdmin( calling_ply, "#A canceled the votemap" )
	end
end

local mapvotecmd = ulx.command( CATEGORY_NAME, "mapvote", AMB_mapvote, "!mapvote" )
mapvotecmd:addParam{ type=ULib.cmds.NumArg, min=15, default=25, hint="time", ULib.cmds.optional, ULib.cmds.round }
mapvotecmd:addParam{ type=ULib.cmds.BoolArg, invisible=true }
mapvotecmd:defaultAccess( ULib.ACCESS_ADMIN )
mapvotecmd:help( "Invokes the map vote logic" )
mapvotecmd:setOpposite( "unmapvote", {_, _, true}, "!unmapvote" )