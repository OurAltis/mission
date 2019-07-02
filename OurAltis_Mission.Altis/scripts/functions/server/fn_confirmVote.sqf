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
	["_vote", false, [true]],
	["_playerUID", "", [""]]
];

CHECK_TRUE(isServer, Function can only be executed on the server!, {})
CHECK_TRUE(_success, Invalid parameter!, {})

if !(PGVAR(PREPARATION_FINISHED) select 0) then {
	if (_vote) then {
		GVAR(playerVote) pushBack _playerUID;
	} else {
		private _index = GVAR(playerVote) find _playerUID;
		
		if (_index isEqualTo -1) then {
			diag_log "ERROR: fn_doVote, player not in array";
		} else {
			GVAR(playerVote) deleteAt _index;
		};
	};

	if (count playableUnits isEqualTo count GVAR(playerVote)) then {		
		PGVAR(PREPARATION_FINISHED) = [true, CBA_missionTime + 10];
		publicVariable QPGVAR(PREPARATION_FINISHED);	
	};
};
nil
