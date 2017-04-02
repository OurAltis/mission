#include "macros.hpp"
/**
 * OurAltis_Mission - fn_equipUnitAsClass
 * 
 * Author: Raven
 * 
 * Description:
 * Equips the given unit with the loadout of the given class
 * 
 * Parameter(s):
 * 0: The unit to equip <Object>
 * 1: The internal class name <String>
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
	case "Grenadier": {_unit call LOADOUT_FUNC(Grenadier)};
	case "MG": {_unit call LOADOUT_FUNC(LMG)};
	case "AT": {_unit call LOADOUT_FUNC(AT)};
	case "AA": {_unit call LOADOUT_FUNC(AA)};
	case "Marksman": {_unit call LOADOUT_FUNC(Sniper)};
	case "Spotter": {_unit call LOADOUT_FUNC(Spotter)};
	case "Medic": {_unit call LOADOUT_FUNC(CombatMedic)};
	case "Engineer": {_unit call LOADOUT_FUNC(Engineer)};
	case "Pilot": {_unit call LOADOUT_FUNC(Pilot)};
	case "Driver": {_unit call LOADOUT_FUNC(Driver)};
	case "Crew": {_unit call LOADOUT_FUNC(Crew)};
	case "MGAssistant": {_unit call LOADOUT_FUNC(LMG_AS)};
	case "SQL": {_unit call LOADOUT_FUNC(Teamleader)};
	case "UAV": {_unit call LOADOUT_FUNC(UAV)};
	default {FORMAT_LOG(Unknown class %1!, _className)};
};

nil;
