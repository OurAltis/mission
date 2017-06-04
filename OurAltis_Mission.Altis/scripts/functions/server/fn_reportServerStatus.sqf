#include "macros.hpp"
/**
 * OurAltis_Mission - fn_reportServerStatus
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Reports the serverstatus to the database
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

CHECK_TRUE(isServer, Function can only be executed on the server!, {})

private _result = ["UPDATE status SET game = 1 ORDER BY runde DESC LIMIT 1"] call FUNC(transferSQLRequestToDatabase);
CHECK_DB_RESULT(_result)

nil
