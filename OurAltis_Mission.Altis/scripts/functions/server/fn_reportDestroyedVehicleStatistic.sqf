#include "macros.hpp"
/**
 * OurAltis_Mission - fn_reportDestroyedVehicleStatistic
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Send destroyed vehicles to database (statistic)
 * 
 * Parameter(s):
 * 0: Vehicle <Object>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_vehicle", objNull, [objNull]]
];

CHECK_TRUE(isServer, Function can only be executed on the server!, {})
CHECK_TRUE(_success, Invalid parameter!, {})

private _id = (_vehicle getVariable [VEHICLE_ID, "000"]) select [0, 3];

// report status to the DB
private _result = ["UPDATE statistik SET ger_verloren = CONCAT(ger_verloren,'" + _id + ",') WHERE mission_id = '" + str(GVAR(MissionID)) + "'"] call FUNC(transferSQLRequestToDataBase);
CHECK_DB_RESULT(_result)

nil;
