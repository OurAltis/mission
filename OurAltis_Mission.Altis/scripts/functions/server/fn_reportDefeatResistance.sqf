#include "macros.hpp"
/**
 * OurAltis_Mission - fn_reportDeadResistance
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Reports dead resistance
 * 
 * Parameter(s):
 * 0: Side <Side>
 * 
 * Return Value:
 * None <Any>
 * 
 */

CHECK_TRUE(isServer, Function can only be executed on the server!, {})
CHECK_FALSE(_side isEqualTo sideUnknown No side defined!, {})

// report status to the DB
private _result = ["UPDATE gebiete SET pol = 0  WHERE gebiet = '" + GVAR(targetAreaName) + "'"] call FUNC(transferSQLRequestToDataBase);
CHECK_DB_RESULT(_result)

nil;
