#include "macros.hpp"
/**
 * OurAltis_Mission - fn_confirmVote
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Manage vote from player
 * 
 * Parameter(s):
 * 0: Client ID <SCALAR>
 * 1: Vote <BOOLN>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_clientID", -1, [0]],
	["_vote", false, [true]]
];

CHECK_TRUE(isServer, Function can only be executed on the server!, {})
CHECK_TRUE(_success, Invalid parameter!, {})

if !(PGVAR(votingFinish)) then {
	if (_vote) then {
		GVAR(playerVote) pushBack _clientID;
	} else {
		private _index = GVAR(playerVote) find _clientID;
		
		if (_index isEqualTo -1) then {
			diag_log "ERROR: fn_doVote, player not in array";
		} else {
			GVAR(playerVote) deleteAt _index;
		};
	};

	if (count playableUnits isEqualTo count GVAR(playerVote)) then {		
		PGVAR(votingFinish) = true;
		publicVariable QPGVAR(votingFinish);		
	};
};
nil
