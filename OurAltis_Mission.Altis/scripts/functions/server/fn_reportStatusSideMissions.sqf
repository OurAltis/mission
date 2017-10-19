#include "macros.hpp"
/**
 * OurAltis_Mission - fn_reportStatusSideMissions
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Send side mission status to database
 * 
 * Parameter(s):
 * 0: Status Side Missions <Array>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_parameter", [], [[]]]
];

CHECK_TRUE(isServer, Function can only be executed on the server!, {})
CHECK_TRUE(_success, Invalid parameter!, {})

// report status to the DB
private _result = ["UPDATE statistik SET sitemission = '" + str(_parameter) + "' WHERE mission_id = '" + str(GVAR(MissionID)) + "'"] call FUNC(transferSQLRequestToDataBase);
CHECK_DB_RESULT(_result)

nil;
