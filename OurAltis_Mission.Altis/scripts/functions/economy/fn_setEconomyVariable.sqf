#include "macros.hpp"
/**
 * OurAltis_Mission - fn_setEconomyVariable
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Decreases the counter for the respective economy type by one
 * 
 * Parameter(s):
 * 0: Index DB <Scalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */ 

private _success = params [
	["_index", 0, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

{
	_x params ["_type", "_buildingCount", "_indexDB"];
	
	if (_index isEqualTo _indexDB) then {_x set [1, _buildingCount - 1]};
	
	nil
} count GVAR(economy);

nil
