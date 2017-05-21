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
 * 0: Type <String>
 * 
 * Return Value:
 * Actual count <Scalar>
 * 
 */ 

private _success = params [
	["_type", "", [""]]
];
 
CHECK_TRUE(_success, Invalid parameters!, {})

private _return = switch (_type) do {
	case "factory": {GVAR(factoryBuildings)};
	case "barracks": {GVAR(barracksBuildings)};
	case "hangar": {GVAR(hangarBuildings)};
	default {NOTIFICATION_LOG(No economy type defined!)};
};

_return
