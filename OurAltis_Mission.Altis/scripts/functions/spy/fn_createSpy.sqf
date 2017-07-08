#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createSpy
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Create the Spy
 * 
 * Parameter(s):
 * 0: Position <Array>
 * 1: Mood <Scalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */
 
private _success = params [
	["_position", nil, [[]], [2,3]],
	["_side", "", [""]],
	["_budget", -1, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

GVAR(spyInfantryList) = GVAR(Infantry);
GVAR(spyGroup) = createGroup [civilian, true];

GVAR(spyVehicle) = createVehicle [selectRandom VEHICLE_CIVIL_PKW, _position, [], 0, "NONE"];
GVAR(spyVehicle) lock 2;
GVAR(spyVehicle) setDir (random 360);

private _civTypes = [];

{
	if (_x isKindOf "C_man_1" && (_x find "_Driver_") isEqualTo -1 && (_x find "_VR_") isEqualTo -1) then {
		_civTypes pushBack _x;
	};
	nil
} count ((configFile >> "CfgVehicles") call BIS_fnc_getCfgSubClasses);

GVAR(spyUnit) = GVAR(spyGroup) createUnit [selectRandom _civTypes, [0, 0, 0], [], 0, "NONE"];
GVAR(spyUnit) moveInDriver GVAR(spyVehicle);
moveOut GVAR(spyUnit);
GVAR(spyUnit) disableAI "PATH";

GVAR(spyUnit) addMPEventHandler [
	"MPKilled", {
		params ["_unit", "_killer"];
		
		if (isServer) then {
			//[] remoteExecCall ["", QGVAR(createSpyActionJip)];
			if (side (group _killer) isEqualTo resistance || side (group _killer) isEqualTo civilian) exitWith {NOTIFICATION_LOG(Resistance unit not counted!)};
			[side (group _killer), VALUE_CIV] call FUNC(reportDeadCivilian);
		};
		
		if (hasInterface) then {
			//_unit removeAction GVAR(spyAddAction);
			_unit removeAction (_unit getVariable [QGVAR(askSpyAction), -1]);
			systemChat (localize "OurA_str_CivIsKilled");
		};
	}
];

[
	{
		GVAR(spyUnit) addEventHandler [
			"GetInMan", {
				if ((random 10) <= 2) then {					
					[
						{
							"Bo_GBU12_LGB" createVehicle getPos GVAR(spyVehicle);
							nil
						},
						[],
						1.5
					] call CBA_fnc_waitAndExecute;					
				};		
			}
		];
		
		nil;
	},
	[],
	1
] call CBA_fnc_waitAndExecute;

GVAR(spyUnit) setVariable [QGVAR(info), [_side, _budget]];

//[GVAR(spyUnit)] remoteExecCall [QFUNC(createAddAction), -2, QGVAR(createSpyActionJip)];

GVAR(markerSpy) = createMarker ["marker_spy", _position];
GVAR(markerSpy) setMarkerShape "ELLIPSE";
GVAR(markerSpy) setMarkerSize [5,5];
GVAR(markerSpy) setMarkerColor "ColorRed";
GVAR(markerSpy) setMarkerAlpha 0;

nil
 
