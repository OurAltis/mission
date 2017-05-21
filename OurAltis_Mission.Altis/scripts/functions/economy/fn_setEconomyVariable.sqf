#include "macros.hpp"
/**
 * OurAltis_Mission - fn_setEconomyVariable
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Set economy variable
 * 
 * Parameter(s):
 * 0: Type <String>
 * 
 * Return Value:
 * None <Any>
 * 
 */ 

private _success = params [
	["_type", "", [""]]
];
 
CHECK_TRUE(_success, Invalid parameters!, {})

switch (_type) do {
	case "factory": {GVAR(factoryBuildings) = GVAR(factoryBuildings) - 1};
	case "barracks": {GVAR(barracksBuildings) = GVAR(barracksBuildings) - 1};
	case "hangar": {GVAR(hangarBuildings) = GVAR(hangarBuildings) - 1};
	default {NOTIFICATION_LOG(No economy type defined!)};
};

nil
