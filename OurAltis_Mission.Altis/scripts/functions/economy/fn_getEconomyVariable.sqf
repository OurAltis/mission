#include "macros.hpp"
/**
 * OurAltis_Mission - fn_getEconomyVariable
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Return economy variable
 * 
 * Parameter(s):
 * 0: Index DB <Scalar>
 * 
 * Return Value:
 * Actual count <Scalar>
 * 
 */ 
 
private _success = params [
	["_index", 0, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _count = {	
	_x params ["_type", "_buildingCount", "_indexDB"];
	
	if (_index isEqualTo _indexDB) exitWith {_buildingCount};
} count GVAR(economy);

_count
