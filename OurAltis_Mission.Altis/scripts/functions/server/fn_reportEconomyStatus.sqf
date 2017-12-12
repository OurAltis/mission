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
	["_indexDB", -1, [0]]
];

CHECK_TRUE(isServer, Function can only be executed on the server!, {})
CHECK_TRUE(_success, Invalid parameter!, {})

// report status to the DB
private _result = ["UPDATE gebiete SET supply" + str(_indexDB) + "_typ =" + " '0'" + " WHERE gebiet = '" + GVAR(targetAreaName) + "'"] call FUNC(transferSQLRequestToDataBase);
CHECK_DB_RESULT(_result)

nil;
