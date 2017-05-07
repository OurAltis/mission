#include "macros.hpp"
/**
 * OurAltis_Mission - fn_endMission
 * 
 * Author: Raven
 * 
 * Description:
 * Ends the mission on the server and all clients
 * 
 * Parameter(s):
 * 0: The side of the winner <Side>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_winnerSide", sideUnknown, [sideUnknown]]
];

CHECK_TRUE(_success, Invalid winner side!, {})

[
	MISSION_ENDED,
	[_winnerSide],
	true
] call FUNC(fireGlobalClientEvent);

private _dataBaseWinner = "Unknown";

switch(_winnerSide) do {
	case east: {_dataBaseWinner = "ost"};
	case west: {_dataBaseWinner =  "west"};
	default {FORMAT_LOG(Unexpected winner side %1, str _winnerSide)}
};

// report status to the DB
["UPDATE missionen SET sieger='" + _dataBaseWinner + "' WHERE mission_id='" + str GVAR(MissionID) + "'"] call FUNC(transferSQLRequestToDataBase);

diag_log "Transmitting vehicles...";

// feed back the status of the remaining vehicles
{
	if (! (_x getVariable [VEHICLE_ID, ""] isEqualTo "")) then {
		[_x] call FUNC(reportVehicleStatus);
	};
	
	nil;
} count vehicles;

// end mission on Server
["serverEnd", false, false, false] call BIS_fnc_endMission;

nil;
