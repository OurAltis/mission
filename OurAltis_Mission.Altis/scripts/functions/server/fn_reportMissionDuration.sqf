#include "macros.hpp"
/**
 * OurAltis_Mission - fn_reportMissionDuration
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Send duration of the mission to database
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
private _result = ["UPDATE statistik SET zeit_ist = '" + str(CBA_missionTime / 60) + "' WHERE mission_id = '" + str(GVAR(MissionID)) + "'"] call FUNC(transferSQLRequestToDataBase);
CHECK_DB_RESULT(_result)

nil;
