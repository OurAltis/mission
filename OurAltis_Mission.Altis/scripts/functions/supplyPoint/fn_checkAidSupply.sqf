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
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */
private _success = params [
	["_trigger", objNull, [objNull]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _objInTrigger = list _trigger;

{
	if (_x getVariable [QGVAR(isIDAPVehicle), false] && !(_x getVariable [QGVAR(arrived), false])) then {
		_x setVariable [QGVAR(arrived), true];
		[side (group (vehicle _x)), name (vehicle _x)] remoteExecCall [QFUNC(reportAidSupply), 2, false];		
	};
	
	nil
} count _objInTrigger;

nil
