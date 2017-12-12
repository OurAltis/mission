#include "macros.hpp"
/**
 * OurAltis_Mission - fn_initializeEconomyVariable
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Initialize economy variable
 * 
 * Parameter(s):
 * 0: Eco Type <String>
 * 1: Building Count <Scalar>
 * 2: Index DB <Scalar>
 * 
 * Return Value:
 * Index <Scalar>
 * 
 */ 

private _success = params [
	["_ecoType", "", [""]],
	["_buildingCount", -1, [0]],
	["_indexDB", 0, [0]]
]; 

CHECK_TRUE(_success, Invalid parameters!, {})

private _index = if (isNil QGVAR(economy)) then {GVAR(economy) = [[_ecoType, _buildingCount, _indexDB]]; 0} else {GVAR(economy) pushBack [_ecoType, _buildingCount, _indexDB]; 1};

_index
