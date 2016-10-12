#include "macros.hpp"
/**
 * OurAltis_Mission - fn_workWithBaseList
 * 
 * Author: Raven
 * 
 * Description:
 * Requests the base list from the server and passes it to the given code
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

if(PGVAR(BASES_CHANGED)) then {
	_parameter pushBack _code;
	
	[
		2,
		EVENT_BASE_LIST_REQUEST,
		EVENT_BASE_LIST_RECEIVED,
		{
			// update local list
			GVAR(BaseList) = _this select 0;
			PGVAR(BASES_CHANGED) = false;
			
			// remove the code from the parameters
			private _code = _this deleteAt (count _this - 1);
			
			_this call _code;
		},
		_parameter,
		[]
	] call FUNC(workWithRequest);
} else {
	// the base list hasn't changed -> use local copy of the list
	([GVAR(BaseList)] + _parameter) call _code;
};

nil;
