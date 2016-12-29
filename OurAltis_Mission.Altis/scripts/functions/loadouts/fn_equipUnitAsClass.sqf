#include "macros.hpp"
/**
 * OurAltis_Mission - fn_equipUnitAsClass
 * 
 * Author: Raven
 * 
 * Description:
 * Equips the given unit with the loadout of the gicen class
 * 
 * Parameter(s):
 * 0: The unit to equip <Object>
 * 1: The class name <String>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_unit", nil, [objNull]],
	["_className", nil, [""]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

switch (_className) do {
	case "Rifleman": {_unit call LOADOUT_FUNC(Rifleman)};
	case "Medic": {_unit call LOADOUT_FUNC(CombatMedic)};
	default {FORMAT_LOG(Unknown class %1!, _className)};
};

nil;
