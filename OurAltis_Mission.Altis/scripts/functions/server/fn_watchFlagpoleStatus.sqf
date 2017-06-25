#include "macros.hpp"
/**
 * OurAltis_Mission - fn_watchFlagpoleStatus
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Sets up a capturing framework that repeatedly checks if all flags are captured. 
 * 
 * Parameter(s):
 * 0: None <Any>
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

private _side = _args select 0;
private _countSide = {_x isEqualTo _side} count GVAR(isFlagCaptured);

if (count GVAR(isFlagCaptured) isEqualTo _countSide) then {
	[_side] call FUNC(endMission);
	[_handlerID] call CBA_fnc_removePerFrameHandler;
};