#include "macros.hpp"
/**
 * OurAltis_Mission - fn_reportVehicleStatistic
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Send vehicle statistic to database
 * 
 * Parameter(s):
 * 0: Global Fuel Consumption <Skalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_fuelConsumption", 0, [0]]
];

CHECK_TRUE(isServer, Function can only be executed on the server!, {})
CHECK_TRUE(_success, Invalid parameter!, {})

// report status to the DB
private _result = ["UPDATE statistik SET spieler_stats = CONCAT(spieler_stats,'" + str(_parameter) + ",') WHERE mission_id = '" + str(GVAR(MissionID)) + "'"] call FUNC(transferSQLRequestToDataBase);
CHECK_DB_RESULT(_result)

nil;
