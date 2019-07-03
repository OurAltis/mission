#include "macros.hpp"
/**
 * OurAltis_Mission - fn_timelimitExceeded
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Ends the mission if timelimit exceeded
 * 
 * Parameter(s):
 * None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _succcess = params [
	["_args", [], [[]]]
];

CHECK_TRUE(_succcess, Invalid parameters!, {})

[GVAR(defenderSide)] call FUNC(endMission);

nil
