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

if (!PGVAR(retreat)) then {
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
		
		private _parameter = [name player, side group player, GVAR(shotCount), GVAR(grenadeCount), GVAR(rocketCount)];
		
		diag_log ("Statistic: " + str(_parameter));
		
		[_parameter] remoteExecCall [QFUNC(reportPlayerStatistic), 2, false];		
		
		nil;
	}
] call FUNC(addEventHandler);

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

[] call compile preprocessFileLineNumbers "scripts\slmd\fn_initClient.sqf";

[
	{
		diag_log "Fired Eventhandler added!";
		diag_log ("player is nil: " + str(isNil "player"));
		player addEventHandler [
			"Fired", {
				if ((_this select 1) isEqualTo "Throw") then {
					GVAR(grenadeCount) =  GVAR(grenadeCount) + 1;
				} else {
					if ((_this select 1) isEqualTo (primaryWeapon player) || (_this select 1) isEqualTo (handgunWeapon player)) then {
						GVAR(shotCount) =  GVAR(shotCount) + 1;
					};
					
					if ((_this select 1) isEqualTo (secondaryWeapon player)) then {
						GVAR(rocketCount) =  GVAR(rocketCount) + 1;
					};					
				};				
			}
		];
	},
	[],
	1
] call CBA_fnc_waitAndExecute;

nil;
