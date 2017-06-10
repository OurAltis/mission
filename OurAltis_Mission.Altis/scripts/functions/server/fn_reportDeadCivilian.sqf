#include "macros.hpp"
/**
 * OurAltis_Mission - fn_reportDeadCivilian
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Reports dead civilian
 * 
 * Parameter(s):
 * 0: Side <Side>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_side", sideUnknown, [west]],
	["_unitValue", 0, [0]]
];

CHECK_TRUE(isServer, Function can only be executed on the server!, {})
CHECK_TRUE(_success, Invalid parameter!, {})

CHECK_FALSE(_side isEqualTo sideUnknown No side defined!, {})

private _value = if (_side isEqualTo east) then {"+ " + str(_unitValue)} else {"- " + str(_unitValue)};

// report status to the DB
private _result = ["UPDATE gebiete SET pol = pol " + _value + " WHERE gebiet = '" + GVAR(targetAreaName) + "'"] call FUNC(transferSQLRequestToDataBase);
CHECK_DB_RESULT(_result)

nil;