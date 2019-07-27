#include "macros.hpp"
/**
 * OurAltis_Mission - fn_reportAidSupply
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Creates db entry with a incident
 * 
 * Parameter(s):
 * 0: Side <Side>
 * 1: Name <String>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [	
	["_side", sideUnknown, [west]],
	["_name", "unknown", [""]]
];

CHECK_TRUE(isServer, Function can only be executed on the server!, {})
CHECK_TRUE(_success, Invalid parameter!, {})

CHECK_FALSE(_side isEqualTo sideUnknown No side defined!, {})

private _sideDB = if (_side isEqualTo west) then {"west"} else {"ost"};

_result = ["INSERT INTO ereignisse (runde, partei, gebiet, fall, bau, person, waffe) VALUES ('" + str(GVAR(round)) + "','" + _sideDB + "','" + GVAR(targetAreaName) + "','sup','','" + _name + "','')"] call FUNC(transferSQLRequestToDataBase);
CHECK_DB_RESULT(_result)

nil
