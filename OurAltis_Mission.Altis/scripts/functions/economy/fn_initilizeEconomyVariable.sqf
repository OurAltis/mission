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
 * 0: Type <String>
 * 1: Count <Scalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */ 

private _success = params [
	["_type", "", [""]],
	["_count", -1, [0]]
];
 
CHECK_TRUE(_success, Invalid parameters!, {})

switch (_type) do {
	case "factory": {GVAR(factoryBuildings) = _count};
	case "barracks": {GVAR(barracksBuildings) = _count};
	case "hangar": {GVAR(hangarBuildings) = _count};
	default {NOTIFICATION_LOG(No economy type defined!)};
};

nil
