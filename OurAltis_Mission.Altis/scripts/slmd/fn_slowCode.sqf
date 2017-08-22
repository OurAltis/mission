#include "macros.hpp"
/*
* SL_Markierungsdienst - fn_slowCode
* 
* Author: PhilipJFry
* 
* Description:
* Get relevant Units and weather factor
* 
* Parameter(s):
* 0: None <ANY>
* 
* Return Value:
* None <ANY>
*/

if (side (group player) != GVAR(side)) then {
	[player] call FUNC(getSide);
};

GVAR(relevantUnits) = [];

{
	if ((side _x) isEqualTo GVAR(side)) then {
		GVAR(relevantUnits) append (units _x);
	};
	
	nil
} count allGroups;	

GVAR(kRain) = ((0.7 - 1) * rain) + 1;
GVAR(kFog) = ((0.08 - 1) * fog) + 1;
GVAR(kDayKnight) = ((1 - 0.25) * sunOrMoon) + 0.25;	

nil
