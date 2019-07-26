#include "macros.hpp"
/**
 * OurAltis_Mission - fn_checkAidSupply
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Checks if vehicle is IDAP vehicle and send a incidend to the database
 * 
 * Parameter(s):
 * 0: Trigger Object <Object>
 * 1: Side <Side>
 * 
 * Return Value:
 * None <Any>
 * 
 */
private _success = params [
	["_triggerObj", objNull, [objNull]],
	["_side", sideUnknown, [west]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _objInTrigger = list _triggerObj;

{
	if (typeOf (vehicle _x) in VEHICLE_IDAP && !((vehicle _x) getVariable [QGVAR(arrived), false]) && _side isEqualTo side (group (vehicle _x))) then {
		(vehicle _x) setVariable [QGVAR(arrived), true];
		[_side, name (vehicle _x)] remoteExecCall [QFUNC(reportAidSupply), 2, false];		
	};
	
	nil
} count _objInTrigger;

nil
