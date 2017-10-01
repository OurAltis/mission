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
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

CHECK_TRUE(isServer, Function can only be executed on the server!, {})

// report status to the DB
private _result = ["UPDATE statistik SET treibstoff = '" + str(GVAR(fuelConsumption)) + "' WHERE mission_id = '" + str(GVAR(MissionID)) + "'"] call FUNC(transferSQLRequestToDataBase);
CHECK_DB_RESULT(_result)

nil;
