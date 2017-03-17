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
	case localize "OurA_str_Rifleman": {_unit call LOADOUT_FUNC(Rifleman)};
	case localize "OurA_str_Grenadier": {_unit call LOADOUT_FUNC(Grenadier)};
	case localize "OurA_str_MG": {_unit call LOADOUT_FUNC(LMG)};
	case localize "OurA_str_AT": {_unit call LOADOUT_FUNC(AT)};
	case localize "OurA_str_AA": {_unit call LOADOUT_FUNC(AA)};
	case localize "OurA_str_Marksman": {_unit call LOADOUT_FUNC(Sniper)};
	case localize "OurA_str_Spotter": {_unit call LOADOUT_FUNC(Spotter)};
	case localize "OurA_str_Medic": {_unit call LOADOUT_FUNC(CombatMedic)};
	case localize "OurA_str_Engineer": {_unit call LOADOUT_FUNC(Engineer)};
	case localize "OurA_str_Pilot": {_unit call LOADOUT_FUNC(Pilot)};
	case localize "OurA_str_Driver": {_unit call LOADOUT_FUNC(Driver)};
	case localize "OurA_str_Crew": {_unit call LOADOUT_FUNC(Crew)};
	case localize "OurA_str_MGAssistant": {_unit call LOADOUT_FUNC(LMG_AS)};
	case localize "OurA_str_SQL": {_unit call LOADOUT_FUNC(Teamleader)};
	case localize "OurA_str_UAV": {_unit call LOADOUT_FUNC(UAV)};
	default {FORMAT_LOG(Unknown class %1!, _className)};
};

nil;
