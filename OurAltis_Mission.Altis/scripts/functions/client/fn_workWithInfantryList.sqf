#include "macros.hpp"
/**
 * OurAltis_Mission - fn_workWithInfantryList
 * 
 * Author: Raven
 * 
 * Description:
 * Requests the infantry list from the server and passes it to the given code
 * 
 * Parameter(s):
 * 0: The code to execute that will get the base list as the first parameter <Code>
 * 1: The additional parameter to be passed to the code <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_code", nil, [{}]],
	["_parameter", [], [[]]]
];

CHECK_TRUE(_success, Invalid parameters!, {});

[2, EVENT_INFANTRY_LIST_REQUEST, EVENT_INFANTRY_LIST_RECEIVED, _code, _parameter] call FUNC(workWithRequest);

nil;
