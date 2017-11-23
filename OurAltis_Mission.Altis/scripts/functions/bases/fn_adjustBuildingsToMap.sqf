#include "macros.hpp"
/**
 * OurAltis_Mission - fn_adjustBuildingsToMap
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Change building types in relation to map
 * 
 * Parameter(s):
 * 0: Array of Objects <Array>
 * 
 * Return Value:
 * 0: Array of Objects <Array>
 * 
 */
 
private _success = params [
	["_objArray", [], [[]]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

{	
	_x params ["_className"];
	
	private _index = BASEBUILDINGS_SAM find _className;
	
	if (_index > -1) then {
		_x set [0, BASEBUILDINGS_T select _index];
	};
	
	nil
} count _objArray;

_objArray
