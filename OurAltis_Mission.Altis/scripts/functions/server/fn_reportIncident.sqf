#include "macros.hpp"
/**
 * OurAltis_Mission - fn_reportIncident
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Creates db entry with a incident
 * 
 * Parameter(s):
 * 0: Incident <String>
 * 1: Killer <Object>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [	
	["_sortOfIncident", "", [""]],
	["_ecoType", "", [""]],
	["_killer", objNull, [objNull]]
];

CHECK_TRUE(isServer, Function can only be executed on the server!, {})
CHECK_TRUE(_success, Invalid parameter!, {})

private _side = if (_sortOfIncident isEqualTo "col") then {	
	if (side (group _killer) isEqualTo west) then {"west"} else {"ost"};
} else {	
	if (GVAR(defenderSide) isEqualTo west) then {"ost"} else {"west"};
};

private _bau = switch (_ecoType) do {
	case "factory": {"ind"};
	case "barracks": {"kas"};
	case "hangar": {"han"};
	default {""};
};

private _name = if (_killer isEqualTo objNull) then {""} else {name _killer};

_result = ["INSERT INTO ereignisse (runde, partei, gebiet, fall, bau, person, waffe) VALUES ('" + str(GVAR(round)) + "','" + _side + "','" + GVAR(targetAreaName) + "','" + _sortOfIncident + "','" + _bau + "','" + _name + "','" + "" + "')"] call FUNC(transferSQLRequestToDataBase);
CHECK_DB_RESULT(_result)

nil;
