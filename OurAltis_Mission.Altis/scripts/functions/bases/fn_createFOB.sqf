#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createFOB
 * 
 * Author: Raven
 * 
 * Description:
 * Creates a FOB out of two spezial vehicles
 * 
 * Parameter(s):
 * 0: Target  <Object>
 * 1: Caller <Object>
 * 2: ID <Scalar>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_position", [2,3], [[]]],
	["_side", sideUnknown, [west]],
	["_id", 0, [0]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _objsArray = call compile preprocessfilelinenumbers (format["scripts\compositions\mobileCamp%1.sqf", _side]);
_objsArray = [_position, _baseDir, _objsArray, [FLAGPOLE]] call FUNC(objectsMapper);

{
	_x setFlagTexture ([_side] call FUNC(getFlagTexture));
	nil
} count _objsArray;

GVAR(markerFOB) = createMarker ["marker_FOB_" + str(_side) + str(_id), position (_objsArray select 0)];
GVAR(markerFOB) setMarkerShape "ELLIPSE";
GVAR(markerFOB) setMarkerSize [5,5];
GVAR(markerFOB) setMarkerColor "ColorRed";
GVAR(markerFOB) setMarkerAlpha 0;

if !(GVAR(defenderSide) isEqualTo sideUnknown) then {
	private _attackerSide = if (GVAR(defenderSide) isEqualTo west) then {east} else {west};
		
	[
		GVAR(defenderSide),
		"FOBDefender" + str(_side) + str(_id),
		[
			format [localize "OurA_str_BaseDefDescription", GVAR(targetAreaName)],
			localize "OurA_str_BaseDefTitle",
			""
		],
		GVAR(markerFOB),
		"Created",
		10,
		false,
		"defend",
		false
	] call BIS_fnc_taskCreate;

	[
		_attackerSide,
		"FOBAttacker" + str(_side) + str(_id),
		[
			format [localize "OurA_str_BaseAttDescription",	GVAR(targetAreaName)],
			localize "OurA_str_BaseAttTitle",
			""
		],
		GVAR(markerFOB),
		"Created",
		10,
		false,
		"attack",
		false
	] call BIS_fnc_taskCreate;
	
	if (_side isEqualTo GVAR(defenderSide)) then {
		private _handlerID = [
			FUNC(watchCapturingFOB),
			0.1,
			[_objsArray, count GVAR(isFlagCaptured)]
		] call CBA_fnc_addPerFrameHandler;
		
		GVAR(isFlagCaptured) pushBack GVAR(defenderSide);
	};
};

nil
