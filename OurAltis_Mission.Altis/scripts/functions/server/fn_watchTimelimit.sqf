#include "macros.hpp"
/**
 * OurAltis_Mission - fn_watchTimelimit
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Sets up a checking framework that repeatedly if the timelimit is reached.
 * 
 * Parameter(s):
 * None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _succcess = params [
	["_args", [], [[]]],
	["_handlerID", -1, [0]]
];

CHECK_TRUE(_succcess, Invalid parameters!, {})
 
if (servertime > (GVAR(timelimit) * 60)) then {
	[GVAR(defenderSide)] call FUNC(endMission);
	[_handlerID] call CBA_fnc_removePerFrameHandler;
};

nil;
