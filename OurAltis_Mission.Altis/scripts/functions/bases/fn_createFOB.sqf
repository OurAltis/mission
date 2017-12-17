#include "macros.hpp"
/**
 * OurAltis_Mission - fn_createFOB
 * 
 * Author: PhilipJFry
 * 
 * Description:
 * Creates a FOB out of two spezial vehicles
 * 
 * Parameter(s):
 * 0: Target  <Object>
 * 1: Caller <Object>
 * 
 * Return Value:
 * None <Any>
 * 
 */

private _success = params [
	["_object", objNull, [objNull]],
	["_side", sideUnknown, [west]]
];

CHECK_TRUE(_success, Invalid parameters!, {})

private _objsArray = call compile preprocessfilelinenumbers (format["scripts\compositions\mobileCamp%1.sqf", _side]);
_objsArray = [position _object, getDir _object, _objsArray, [FLAGPOLE]] call FUNC(objectsMapper);

private _index = if (_side isEqualTo west) then {0} else {1}; 

private _nameFOB = if (count (GVAR(nameFOB) select _index) > 0) then {
	private _nameFOBFirst = (GVAR(nameFOB) select _index) select 0;
	selectRandom (if (_index isEqualTo 0) then {ALPHABET_NATO - [_nameFOBFirst]} else {ALPHABET_RUSSIAN - [_nameFOBFirst]});
} else {
	selectRandom (if (_index isEqualTo 0) then {ALPHABET_NATO} else {ALPHABET_RUSSIAN});
};

(GVAR(nameFOB) select _index) pushBack _nameFOB;

private _marker = _objsArray deleteAt ((count _objsArray) - 1);
private _size = getMarkerSize _marker;
private _markerDir = markerDir _marker;
private _position = getMarkerPos _marker;

deleteMarker _marker;

private _marker = createMarker ["marker_FOB_" + _nameFOB, _position];
_marker setMarkerShape "RECTANGLE";
_marker setMarkerSize _size;
_marker setMarkerColor "ColorRed";
_marker setMarkerDir _markerDir;
_marker setMarkerAlpha 0;

[_side, _objsArray] call FUNC(setFlagTexture);

if (GVAR(defenderSide) != sideUnknown && _side isEqualTo GVAR(defenderSide)) then {
	private _attackerSide = if (GVAR(defenderSide) isEqualTo west) then {east} else {west};
		
	[
		GVAR(defenderSide),
		"FOBDefender" + _nameFOB,
		[
			format [localize "OurA_str_FOBDefDescription", _nameFOB],
			format [localize "OurA_str_FOBDefTitle", _nameFOB],
			""
		],
		_marker,
		"Created",
		10,
		false,
		"defend",
		false
	] call BIS_fnc_taskCreate;

	[
		_attackerSide,
		"FOBAttacker" + _nameFOB,
		[
			format [localize "OurA_str_FOBAttDescription",	_nameFOB],
			format [localize "OurA_str_FOBAttTitle", _nameFOB],
			""
		],
		_marker,
		"Created",
		10,
		false,
		"attack",
		false
	] call BIS_fnc_taskCreate;
		
	private _handlerID = [
		FUNC(watchCapturingFOB),
		0.1,
		[_objsArray, count GVAR(isFlagCaptured), "marker_FOB_" + _nameFOB]
	] call CBA_fnc_addPerFrameHandler;
	
	GVAR(isFlagCaptured) pushBack GVAR(defenderSide);	
};

nil
