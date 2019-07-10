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
diag_log ("EndMission: " + str(_this));

private _success = params [
	["_winnerSide", sideUnknown, [sideUnknown]]
];

CHECK_TRUE(_success, Invalid winner side!, {})

if (!isNil QGVAR(endMissionTriggered)) exitWith {NOTIFICATION_LOG(End mission is already fired!)};

GVAR(endMissionTriggered) = 1;

if (GVAR(defenderSide) isEqualTo sideUnknown) then {
	private _loserSide = if (_winnerSide isEqualTo west) then {east} else {west};
	
	["base" + str(_winnerSide), "SUCCEEDED"] spawn BIS_fnc_taskSetState;
	["base" + str(_loserSide), "FAILED"] spawn BIS_fnc_taskSetState;
} else {
	if (GVAR(defenderSide) isEqualTo _winnerSide) then {
		["baseDefender", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
		["baseAttacker", "FAILED"] spawn BIS_fnc_taskSetState;
	} else {
		["baseDefender", "FAILED"] spawn BIS_fnc_taskSetState;
		["baseAttacker", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
	};
	
	if ((PGVAR(countFOB) select 0) > 0) then {
		{
			if (["FOBDefender" + _x] call BIS_fnc_taskExists) then {
				if !(["FOBDefender" + _x] call BIS_fnc_taskCompleted) then {
					if !(["FOBAttacker" + _x] call BIS_fnc_taskCompleted) then {
						["FOBDefender", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
						["FOBAttacker", "FAILED"] spawn BIS_fnc_taskSetState;
					};
				};
			};
			nil			
		} count (GVAR(nameFOB) select 0);
	};
	
	if ((PGVAR(countFOB) select 1) > 0) then {
		{
			if (["FOBDefender" + _x] call BIS_fnc_taskExists) then {
				if !(["FOBDefender" + _x] call BIS_fnc_taskCompleted) then {
					if !(["FOBAttacker" + _x] call BIS_fnc_taskCompleted) then {
						["FOBDefender", "SUCCEEDED"] spawn BIS_fnc_taskSetState;
						["FOBAttacker", "FAILED"] spawn BIS_fnc_taskSetState;
					};
				};
			};
			nil			
		} count (GVAR(nameFOB) select 1);
	};
	
	if (["spyDefender"] call BIS_fnc_taskExists) then {
		if !(["spyDefender"] call BIS_fnc_taskCompleted) then {
			if !(["spyAttacker"] call BIS_fnc_taskCompleted) then {
				["spyDefender", "FAILED"] spawn BIS_fnc_taskSetState;
				["spyAttacker", "FAILED"] spawn BIS_fnc_taskSetState;
			};
		};
	};
	
	if (!isNil QGVAR(economy)) then {
		{
			_x params ["_ecoType", "_buildingCount", "_indexDB"];
			
			if (["ecoDefender_" + str(_indexDB)] call BIS_fnc_taskExists) then {
				if !(["ecoDefender_" + str(_indexDB)] call BIS_fnc_taskCompleted) then {
					if !(["ecoAttacker_" + str(_indexDB)] call BIS_fnc_taskCompleted) then {
						["ecoDefender_" + str(_indexDB), "SUCCEEDED"] spawn BIS_fnc_taskSetState;
						["ecoAttacker_" + str(_indexDB), "FAILED"] spawn BIS_fnc_taskSetState;				
					};
				};
			};
			
			nil
		} count GVAR(economy);
	}	
};

if (["resistance"] call BIS_fnc_taskExists) then {
	if !(["resistance"] call BIS_fnc_taskCompleted) then {
		["resistance", "FAILED"] spawn BIS_fnc_taskSetState;
	};
};

[GVAR(taskState)] call FUNC(reportStatusSideMissions);

[
	SEND_STATISTIC,
	[],
	true
] call FUNC(fireGlobalClientEvent);

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
// report status to the DB statistic
["UPDATE statistik SET sieger='" + _dataBaseWinner + "' WHERE mission_id='" + str GVAR(MissionID) + "'"] call FUNC(transferSQLRequestToDataBase);

// feed back the status of the remaining vehicles
{
	if (! (_x getVariable [VEHICLE_ID, ""] isEqualTo "")) then {
		[_x] call FUNC(reportVehicleStatus);
	};
	
	nil;
} count vehicles;

[] call FUNC(reportVehicleStatistic);
[] call FUNC(reportDeadUnitStatistic);
[] call FUNC(reportMissionDuration);

[
	{
		// end mission on Server
		["serverEnd", false, false, false] call BIS_fnc_endMission;
	
		nil
	},
	[],
	5
] call CBA_fnc_waitAndExecute;

nil;
