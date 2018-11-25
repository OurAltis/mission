#include "macros.hpp"
/**
 * OurAltis_Mission - fn_clientInit
 * 
 * Author: Raven
 * 
 * Description:
 * Initializes OurAltis on the client
 * 
 * Parameter(s):
 * 0: None <Any>
 * 
 * Return Value:
 * None <Any>
 * 
 */

if (!hasInterface) exitWith {}; // server shouldn't execute this

GVAR(shotCount) = 0;
GVAR(grenadeCount) = 0;
GVAR(rocketCount) = 0;
GVAR(markerCamps) = [];

if (!(missionNamespace getVariable [QPGVAR(Retreat), false]) && side group player in GVAR(canRetreat)) then {
	GVAR(radioTrigger) = createTrigger ["EmptyDetector", [0,0,0], false];
	GVAR(radioTrigger) setTriggerActivation ["Alpha", "PRESENT", false];
	GVAR(radioTrigger) setTriggerStatements ["this", "[side group player, clientOwner] remoteExecCall ['OurA_fnc_retreat', 2]", ""];
	1 setRadioMsg (localize "OurA_str_Retreat");
};

if (!isNil QGVAR(markerBorderWar)) then {
	[
		FUNC(showUnitsOutsideMarker),
		1,
		[GVAR(markerBorderWar)]
	] call CBA_fnc_addPerFrameHandler;
};

diag_log ("clientInit PGVAR(markerCamps): " + str(PGVAR(markerCamps)));

if (side (group player) isEqualTo (PGVAR(markerCamps) select 0)) then {
	[] call FUNC(createMarkerCamps);
};

[] call FUNC(compileLoadouts);

// set up client EHs
[
	MISSION_ENDED,
	{
		private _success = params [
			["_clientID", 0, [0]],
			["_winnerSide", sideUnknown, [sideUnknown]]
		];
		
		CHECK_TRUE(_success, Invalid winner side!, {})
		
		// make sure the respawn menu is not opened when the mission ends
		[] call FUNC(hideRespawnMenu);
		// make sure there is no death fading in progress
		"respawnBlackScreen" cutFadeOut 0.00000001;
		// make sure sound is enabled
		0 fadeSound 1;
		
		// end the mission respectively
		["End1", side group player isEqualTo _winnerSide, true, true, true, false] call BIS_fnc_endMission;		
		
		nil;
	}
] call FUNC(addEventHandler);

[
	SEND_STATISTIC,
	{
		private _success = params [
			["_clientID", 0, [0]]
		];
		
		CHECK_TRUE(_success, Invalid client ID!, {})
		
		private _side = if ((side group player) isEqualTo east) then {"ost"} else {"west"};
		
		private _parameter = [name player, _side, GVAR(shotCount), GVAR(grenadeCount), GVAR(rocketCount)];
		
		[_parameter] remoteExecCall [QFUNC(reportPlayerStatistic), 2, false];		
		
		nil;
	}
] call FUNC(addEventHandler);

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

[] call compile preprocessFileLineNumbers "scripts\slmd\fn_initClient.sqf";

nil;
