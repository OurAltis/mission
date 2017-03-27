#include "macros.hpp"
/**
 * OurAltis_Mission - fn_endMission
 * 
 * Author: Raven
 * 
 * Description:
 * Ends the mission on the server and all clients
 * 
 * Parameter(s):
 * 0: The side of the winner <Side>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_winnerSide", sideUnknown, [sideUnknown]]
];

CHECK_TRUE(_success, Invalid winner side!, {})

[
	MISSION_ENDED,
	[_winnerSide],
	true
] call FUNC(fireGlobalClientEvent);

// end mission on Server
["serverEnd", false, false, false] call BIS_fnc_endMission;

nil;
