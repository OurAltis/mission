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

[] call FUNC(markBases);
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

/*
[
	ADD_ACTION,
	{
		private _success = params [
			["_clientID", 0, [0]],
			["_object", objNull, [objNull]],
			["_actionVar", "", [""]],
			["_title", "", [""]],
			["_script", {}, [{}]],
			["_arguments", nil, []],
			["_priority", 1.5, [0]],
			["_showWindow", true, [true]],
			["_hideOnUse", true, [true]],
			["_shortcut", "", [""]],
			["_condition", "true", [""]]
		];
		
		CHECK_TRUE(_success, Invalid winner side!, {})
		
		if (!alive _object || isNull _object) exitWith {NOTIFICATION_LOG(Object is dead or do not exist!)};
		
		private _actionID = _object addAction [localize _title, _script, _arguments, _priority, _showWindow, _hideOnUse, _shortcut, _condition];
		_object setVariable [_actionVar, _actionID];
		
		nil;
	}	
] call FUNC(addEventHandler);
*/
nil;
