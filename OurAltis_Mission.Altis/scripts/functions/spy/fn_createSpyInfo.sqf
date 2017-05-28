#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createSpyInfo
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Create diary report
 * 
 * Parameter(s):
 * 0: Infantry list <Array>
 * 1: Vehicle list <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_infantryList", [], [[]]],
	["_vehicleList", [], [[]]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

diag_log _infantryList;
diag_log _vehicleList;