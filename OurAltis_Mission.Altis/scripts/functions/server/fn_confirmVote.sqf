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
 * 0: Vote <BOOLN>
 * 1: Client ID <STRING>
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
			NOTIFICATION_FORMAT_LOG(Player not in GVAR(playerVote): %1, GVAR(playerVote))
		} else {
			GVAR(playerVote) deleteAt _index;
		};
	};
	
	[
		SEND_READYPLAYER,
		[count GVAR(playerVote)],
		false
	] call FUNC(fireGlobalClientEvent);
	
	if (count playableUnits isEqualTo count GVAR(playerVote)) then {
		private _time = CBA_missionTime + 10;
		
		PGVAR(PREPARATION_FINISHED) = [true, _time];
		publicVariable QPGVAR(PREPARATION_FINISHED);
		
		[
			FUNC(timeLimitExceeded),
			[],
			_time + (GVAR(timeLimit) * 60)
		] call CBA_fnc_waitAndExecute;
		
		[
			{
				{
					_x lock false;
					nil
				} count GVAR(vehicleListAll);
			},
			[],
			_time - CBA_missionTime
		] call CBA_fnc_waitAndExecute;		
	};
};

nil
