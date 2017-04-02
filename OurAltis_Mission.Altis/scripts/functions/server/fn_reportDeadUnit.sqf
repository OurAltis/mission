#include "macros.hpp"
/**
 * OurAltis_Mission - fn_reportDeadUnit
 * 
 * Author: Raven
 * 
 * Description:
 * Reports a unit that has died to the database
 * 
 * Parameter(s):
 * 0: The integer code representing the unit's class and side <Number>
 * 1: The base the unit hsa been deployed from <String>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_code", -1, [0]],
	["_base", "", [""]]
];

CHECK_TRUE(isServer, Function can only be executed on the server!, {})
CHECK_TRUE(_success, Invalid parameters!, {})

private _result = ["UPDATE armeen SET bestand = '0' WHERE code = '" + str _code + "' && gebiet = '" + _base + "' && einsatz = '" + GVAR(targetAreaName) + "' && bestand != '0' LIMIT 1"] call FUNC(transferSQLRequestToDatabase);

CHECK_DB_RESULT(_result)

nil;
