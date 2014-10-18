local CATEGORY_NAME = "Fretta" -- If you want these commands to show up in a different category you can simply change the name of this to something else.

------------------------------ Add Time ------------------------------
function ulx.addtime( calling_ply, time )
	local time = tonumber(time)
	
	if not time then
		ULib.tsayError( calling_ply, "No time specified!", true )
		return
	end
	if not GAMEMODE:InRound() then
		ULib.tsayError( calling_ply, "Can't add time while not in round!" )
		return
	end	
	GAMEMODE:AddRoundTime( time )
	ulx.fancyLogAdmin( calling_ply, "#A has extended round time by #i", time ) 
end
local addtime = ulx.command( CATEGORY_NAME, "ulx addtime", ulx.addtime, "!addtime" )
addtime:addParam{ type=ULib.cmds.NumArg, min=1, default=1, hint="time", ULib.cmds.round }
addtime:defaultAccess( ULib.ACCESS_SUPERADMIN )
addtime:help( "Add time onto the current round." )

------------------------------ Force Vote ------------------------------
function ulx.forcevote( calling_ply )
	if GAMEMODE.m_bVotingStarted then
		ULib.tsayError( calling_ply, "Vote already in-progress!" )
		return
	end	
	GAMEMODE:StartGamemodeVote()
	ulx.fancyLogAdmin( calling_ply, "#A force started a vote!" )
end
local forcevote = ulx.command( CATEGORY_NAME, "ulx forcevote", ulx.forcevote, "!forcevote" )
forcevote:defaultAccess( ULib.ACCESS_SUPERADMIN )
forcevote:help( "Forces the Fretta vote on-screen." )

------------------------------ Round Restart ------------------------------
function ulx.roundrestart( calling_ply )
	if not GAMEMODE:InRound() then
		ULib.tsayError( calling_ply, "Must be in round to restart it!" )
		return
	end	
	GAMEMODE:PreRoundStart( GetGlobalInt( "RoundNumber" ) )
	ulx.fancyLogAdmin( calling_ply, "#A restarted the current round!" )
end
local roundrestart = ulx.command( CATEGORY_NAME, "ulx restartround", ulx.roundrestart, "!restartround" )
roundrestart:defaultAccess( ULib.ACCESS_SUPERADMIN )
roundrestart:help( "Forces the round to restart." )

------------------------------ Round Left ------------------------------
function ulx.roundsleft( calling_ply )
	local limit = GAMEMODE:GetRoundLimit()
	local current = GetGlobalInt("RoundNumber")
	local rounds = (limit - current)
	
	if not IsValid(calling_ply) then
		if current != limit then
			Msg("There are "..rounds.." rounds until map change.")
		else
			Msg("This is the last round!")
		end
		return
	end
	
	if current != limit then
		calling_ply:ChatPrint(""..calling_ply:Nick()..", there are "..rounds.." rounds until map change.")
	else
		calling_ply:ChatPrint(""..calling_ply:Nick()..", this is the last round!")
	end
end
local roundsleft = ulx.command( CATEGORY_NAME, "ulx roundsleft", ulx.roundsleft, "!roundsleft" )
roundsleft:defaultAccess( ULib.ACCESS_ALL )
roundsleft:help( "Prints the rounds that are left." )
