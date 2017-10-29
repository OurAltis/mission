#include "macros.hpp"
/**
 * OurAltis_Mission - fn_reportDeadUnitStatistic
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Sent amount of dead units to database
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
private _result = ["UPDATE statistik SET inf_verloren = '" + str(GVAR(deadUnits) select 0) + ";" + str(GVAR(deadUnits) select 1) + "' WHERE mission_id = '" + str(GVAR(MissionID)) + "'"] call FUNC(transferSQLRequestToDataBase);
CHECK_DB_RESULT(_result)

nil;
