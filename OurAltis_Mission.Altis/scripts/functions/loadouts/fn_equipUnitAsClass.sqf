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
	case localize "OurA_str_Schütze": {_unit call LOADOUT_FUNC(Rifleman)};
	case localize "OurA_str_Grenadier": {_unit call LOADOUT_FUNC(Grenadier)};
	case localize "OurA_str_MG-Schütze": {_unit call LOADOUT_FUNC(LMG)};
	case localize "OurA_str_Panzerabwehr": {_unit call LOADOUT_FUNC(AT)};
	case localize "OurA_str_Luftabwehr": {_unit call LOADOUT_FUNC(AA)};
	case localize "OurA_str_Scharfschütze": {_unit call LOADOUT_FUNC(Sniper)};
	case localize "OurA_str_Aufklärer": {_unit call LOADOUT_FUNC(Spotter)};
	case localize "OurA_str_Sanitäter": {_unit call LOADOUT_FUNC(CombatMedic)};
	case localize "OurA_str_Ingenieur": {_unit call LOADOUT_FUNC(Engineer)};
	case localize "OurA_str_Pilot": {_unit call LOADOUT_FUNC(Pilot)};
	case localize "OurA_str_Fahrer": {_unit call LOADOUT_FUNC(Driver)};
	case localize "OurA_str_Crew": {_unit call LOADOUT_FUNC(Crew)};
	case localize "OurA_str_MG-Assistent": {_unit call LOADOUT_FUNC(LMG_AS)};
	case localize "OurA_str_Truppführer": {_unit call LOADOUT_FUNC(Teamleader)};
	case localize "OurA_str_Drohnenoperator": {_unit call LOADOUT_FUNC(UAV)};
	default {FORMAT_LOG(Unknown class %1!, _className)};
};

nil;
