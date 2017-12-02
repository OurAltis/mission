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
 * 1:
 * 
 * Return Value:
 * None <Any>
 * 
 */

diag_log "Incident";
diag_log _this; 

private _success = params [	
	["_sortOfIncident", "", [""]],
	["_person", "", [objNull, ""]],
	["_weapon", "", [objNull, ""]]
];

CHECK_TRUE(isServer, Function can only be executed on the server!, {})
CHECK_TRUE(_success, Invalid parameter!, {})

private _side = if (_sortOfIncident isEqualTo "ecoDes") then {
	if (GVAR(defenderSide) isEqualTo west) then {"ost"} else {"west"};
} else {
	if (side (group _person) isEqualTo west) then {"west"} else {"ost"};
};

private _bau = switch (GVAR(economy)) do {
	case "factory": {"ind"};
	case "barracks": {"kas"};
	case "hangar": {"han"};
};

if (_weapon isEqualType objNull) then {
	_weapon = name _weapon;
};

private _name = "";
if (typeName _person isEqualTo typeName objNull) then {
	_name = name _person;
};

_result = ["INSERT INTO ereignisse (runde, partei, gebiet, fall, bau, person, waffe) VALUES ('" + str(GVAR(round)) + "','" + _side + "','" + GVAR(targetAreaName) + "','" + _sortOfIncident + "','" + _bau + "','" + _name + "','" + _weapon + "')"] call FUNC(transferSQLRequestToDataBase);
CHECK_DB_RESULT(_result)

nil;
