#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createDBEntryStatistic
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Creates DB entry
 * 
 * Parameter(s):
 * None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

CHECK_TRUE(isServer, Function can only be executed on the server!, {})

private _attacker = if (GVAR(defenderSide) isEqualTo east) then {"west"} else {"ost"};
private _time = str(date select 3) + ":" + str(date select 4);
private _parameter = "'" + str(GVAR(MissionID)) + "','" + GVAR(OperationName) + "','" + _attacker + "','" + GVAR(targetAreaName) + "','" + _time + "','','" + str(GVAR(timeLimit)) + "','','','','','',''";
diag_log _parameter;
private _result = ["INSERT INTO statistik (mission_id, operation, partei, gebiet, start, sieger, zeit_soll, zeit_ist, sitemission, ger_verloren, inf_verloren, spieler_stats, treibstoff) VALUES (" + _parameter + ")"] call FUNC(transferSQLRequestToDataBase);
CHECK_DB_RESULT(_result)

nil;
