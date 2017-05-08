#include "macros.hpp"
/**
 * OurAltis_Mission - fn_reportEconomyStatus
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Reports the given economy building and it's current state to the database
 * 
 * Parameter(s):
 * 0: The building to report <Object>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_building", objNull, [objNull]]
];

CHECK_TRUE(isServer, Function can only be executed on the server!, {})
CHECK_TRUE(_success, Invalid parameter!, {})

private _typeOfEconomyA3 = _building getVariable [TYPE_OF_ECONOMY, ""];

private _typeOfEconomyDB = switch (_typeOfEconomyA3) do {
	case "factory": {"ind"};
	case "hangar": {"han"};
	case "barracks": {"kas"};
	default {""};
};

CHECK_FALSE(_typeOfEconomyDB isEqualTo "", No economy defined!, {})

// report status to the DB
private _result = ["UPDATE gebiete SET " + _typeOfEconomyDB + " =" + " '0'" + " WHERE gebiet = '" + GVAR(targetAreaName) + "'"] call FUNC(transferSQLRequestToDataBase);
CHECK_DB_RESULT(_result)

nil;